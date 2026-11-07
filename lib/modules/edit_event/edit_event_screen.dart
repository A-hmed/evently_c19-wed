import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/widgets/categories_tab_bar.dart';
import 'package:evently_c19/core/widgets/custom_back_btn.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/custom_btn.dart';

class EditEventScreen extends StatefulWidget {
  final EventDM event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {

  late CategoryDM selectedCategory = CategoryDM.getCategoryById(
    widget.event.categoryId,
  );
  late TextEditingController titleController = TextEditingController(
    text: widget.event.title,
  );
  late TextEditingController descriptionController = TextEditingController(
    text: widget.event.description,
  );
  late DateTime selectedDate = widget.event.date;
  late TimeOfDay selectedTime = TimeOfDay.fromDateTime(widget.event.date);
  bool isLoading = false;
  late ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: CustomBackBtn()),
        title: Text("Edit event"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(

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
              buildUpdateEventButton(),
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
            selectedDate =
                (await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  initialDate: selectedDate.isBefore(DateTime.now())
                      ? DateTime.now()
                      : selectedDate,
                  lastDate: DateTime.now().add(Duration(days: 365)),
                )) ??
                selectedDate;
            setState(() {});
          },
          child: Text(
            DateFormat("MMM d, yyyy").format(selectedDate),
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
            selectedTime =
                (await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                )) ??
                selectedTime;
            setState(() {});
          },
          child: Text(
            selectedTime.format(context),
            style: TextStyle(
              color: theme.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  buildUpdateEventButton() => CustomBtn(
    isLoading: isLoading,
    text: "Update event",
    onTap: () async {
      isLoading = true;
      setState(() {});


      var event = EventDM(
        id: widget.event.id,
        ownerId: widget.event.ownerId,
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
      await updateEventInFirestore(event);
      isLoading = false;
      Navigator.pop(context, event);
    },
  );
}
