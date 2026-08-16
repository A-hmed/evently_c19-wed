import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/widgets/categories_tab_bar.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_btn.dart';

class EditEventScreen extends StatefulWidget {
  final EventDM event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late CategoryDM selectedCategory;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    selectedCategory = CategoryDM.getCategoryById(widget.event.categoryId);

    titleController = TextEditingController(text: widget.event.title);

    descriptionController = TextEditingController(
      text: widget.event.description,
    );

    selectedDate = widget.event.date;
    selectedTime = TimeOfDay.fromDateTime(widget.event.date);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: theme.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .23,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayColor.withValues(alpha: .08),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                selectedCategory.imageLight,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 18),

            CategoriesTabBar(
              categories: CategoryDM.categories,
              onTap: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),

            const SizedBox(height: 18),

            Text(
              "Title",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            CustomTextField(
              hintText: "Event Title",
              controller: titleController,
            ),

            const SizedBox(height: 16),

            Text(
              "Description",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            CustomTextField(
              hintText: "Event Description",
              controller: descriptionController,
              lines: 6,
            ),

            const SizedBox(height: 20),

            _buildDateRow(theme),

            const SizedBox(height: 18),

            _buildTimeRow(theme),

            const SizedBox(height: 24),

            buildEditEventButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month_outlined,
          color: theme.primaryColor,
          size: 25,
        ),

        const SizedBox(width: 10),

        Text(
          "Event Date",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        InkWell(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              initialDate: selectedDate,
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );

            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
          child: Text(
            _formatDate(selectedDate),
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRow(ThemeData theme) {
    return Row(
      children: [
        Icon(Icons.access_time_outlined, color: theme.primaryColor, size: 25),

        const SizedBox(width: 10),

        Text(
          "Event Time",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        InkWell(
          onTap: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime,
            );

            if (pickedTime != null) {
              setState(() {
                selectedTime = pickedTime;
              });
            }
          },
          child: Text(
            selectedTime.format(context),
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return "${months[date.month - 1].substring(0, 3)} ${date.day}, ${date.year}";
  }

  Widget buildEditEventButton() {
    return CustomBtn(
      isLoading: isLoading,
      text: "Update event",
      onTap: () async {
        isLoading = true;
        setState(() {});

        final event = EventDM(
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

        try {
          await updateEventInFirestore(event);

          if (mounted) {
            Navigator.pop(context, event);
          }
        } finally {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
    );
  }
}
