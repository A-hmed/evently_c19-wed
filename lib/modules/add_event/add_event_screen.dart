import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/widgets/categories_tab_bar.dart';
import 'package:evently_c19/core/widgets/custom_back_btn.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/custom_btn.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoryDM selectedCategory = CategoryDM.getCategoryById(1);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


  bool isDateChosen = false;
  bool isTimeChosen = false;
  bool isLoading = false;
  late ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: CustomBackBtn()),
        title: Text("Add event"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                ///Fills the screen height, and scrolls when there is no room

                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              selectedCategory.imageLight,
                              height: MediaQuery.of(context).size.height * .23,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16),
                          CategoriesTabBar(
                            categories: CategoryDM.categories,
                            initialIndex: CategoryDM.categories.indexOf(
                              selectedCategory,
                            ),
                            labelPadding: EdgeInsetsDirectional.only(end: 8),
                            onTap: (category) {
                              selectedCategory = category;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 16),
                          Text("Title", style: theme.textTheme.bodyLarge),
                          SizedBox(height: 6),
                          CustomTextField(
                            hintText: "Event Title",
                            controller: titleController,
                            compact: true,
                          ),
                          SizedBox(height: 16),
                          Text("Description", style: theme.textTheme.bodyLarge),
                          SizedBox(height: 6),


                          Expanded(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 80),
                              child: CustomTextField(
                                hintText: "Event Description....",
                                controller: descriptionController,
                                expands: true,
                                compact: true,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          buildDateRow(),
                          SizedBox(height: 16),
                          buildTimeRow(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              buildAddEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildDateRow() {
    return Row(
      children: [
        Icon(Icons.calendar_month_outlined, color: theme.primaryColor),
        SizedBox(width: 8),
        Text("Event Date", style: theme.textTheme.bodyLarge),
        Spacer(),
        InkWell(
          onTap: () async {
            var date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: selectedDate,
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (date != null) {
              selectedDate = date;
              isDateChosen = true;
              setState(() {});
            }
          },
          child: Text(
            isDateChosen
                ? DateFormat("MMM d, yyyy").format(selectedDate)
                : "Choose date",
            style: TextStyle(
              color: theme.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  buildTimeRow() {
    return Row(
      children: [
        Icon(Icons.access_time, color: theme.primaryColor),
        SizedBox(width: 8),
        Text("Event Time", style: theme.textTheme.bodyLarge),
        Spacer(),
        InkWell(
          onTap: () async {
            var time = await showTimePicker(
              context: context,
              initialTime: selectedTime,
            );
            if (time != null) {
              selectedTime = time;
              isTimeChosen = true;
              setState(() {});
            }
          },
          child: Text(
            isTimeChosen ? selectedTime.format(context) : "Choose time",
            style: TextStyle(
              color: theme.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  buildAddEventButton() => CustomBtn(
    isLoading: isLoading,
    text: "Add event",
    onTap: () async{
      isLoading = true;
      setState(() {});
      var event = EventDM(
        id: '',
        ownerId: UserDM.currentUser.id,
        title: titleController.text,
        description: descriptionController.text,
        categoryId: selectedCategory.id,
        date: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        ),
      );
      await createEventInFirestore(event);
      Navigator.pop(context);
      isLoading = false;
    },
  );
}
