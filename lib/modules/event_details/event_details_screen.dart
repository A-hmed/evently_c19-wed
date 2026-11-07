import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_back_btn.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventDM event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventDM event = widget.event;
  late ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    var category = CategoryDM.getCategoryById(event.categoryId);


    var isOwner = event.ownerId == UserDM.currentUser.id;
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: CustomBackBtn()),
        title: Text("Event Details"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: isOwner
            ? [
                IconButton(
                  onPressed: () async {
                    var updatedEvent = await Navigator.push(
                      context,
                      AppRoutes.editEvent(event),
                    );
                    if (updatedEvent != null) {
                      event = updatedEvent;
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.edit_note, color: theme.primaryColor),
                ),
                IconButton(
                  onPressed: () {
                    showDeleteDialog();
                  },
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  category.imageLight,
                  height: MediaQuery.of(context).size.height * .23,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(event.title, style: theme.textTheme.titleMedium),
              SizedBox(height: 16),
              buildDateContainer(),
              SizedBox(height: 16),
              Text("Description", style: theme.textTheme.bodyLarge),
              SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.calendar_month, color: theme.primaryColor),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("d MMMM").format(event.date),
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                TimeOfDay.fromDateTime(event.date).format(context),
                style: theme.textTheme.labelLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("Delete Event"),
        content: Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await deleteEventFromFirestore(event.id);
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
