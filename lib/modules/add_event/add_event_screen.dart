import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/widgets/categories_tab_bar.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_btn.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoryDM selectedCategory = CategoryDM.categories[0];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isLoading = false;
  late ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                selectedCategory.imageLight,
                height: MediaQuery.of(context).size.height * .23,
              ),
              SizedBox(height: 12),
              CategoriesTabBar(
                categories: CategoryDM.categories,
                onTap: (category) {
                  selectedCategory = category;
                  setState(() {});
                },
              ),
              SizedBox(height: 12),
              Text("Title", style: theme.textTheme.bodyLarge),
              SizedBox(height: 6),
              CustomTextField(
                hintText: "Event Title",
                controller: titleController,
              ),
              SizedBox(height: 12),
              Text("Description", style: theme.textTheme.bodyLarge),
              SizedBox(height: 6),
              CustomTextField(
                hintText: "Event Description",
                controller: descriptionController,
                lines: 6,
              ),
              SizedBox(height: 12),
              buildDateRow(),
              SizedBox(height: 12),
              buildTimeRow(),
              SizedBox(height: 12),
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
        Icon(Icons.calendar_month, color: theme.primaryColor),
        SizedBox(width: 6),
        Text(
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
          style: theme.textTheme.bodyLarge,
        ),
        Spacer(),
        InkWell(
          onTap: () async {
            selectedDate =
                (await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  initialDate: selectedDate,
                  lastDate: DateTime.now().add(Duration(days: 365)),
                )) ??
                selectedDate;
            setState(() {});
          },
          child: Text(
            "Choose date",
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
        Icon(Icons.calendar_month, color: theme.primaryColor),
        SizedBox(width: 6),
        Text(selectedTime.format(context), style: theme.textTheme.bodyLarge),
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
            "Choose time",
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
    text: "Add",
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
