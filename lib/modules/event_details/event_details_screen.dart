import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventDM event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventDM event;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    final category = CategoryDM.getCategoryById(event.categoryId);
    final isOwner = event.ownerId == UserDM.currentUser.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.primaryColor,
            size: 22,
          ),
        ),
        actions: isOwner
            ? [
                IconButton(
                  onPressed: () => _navigateToEdit(context),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: theme.primaryColor,
                    size: 27,
                  ),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 27,
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayColor.withValues(alpha: .08),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(category.imageLight, fit: BoxFit.cover),
            ),

            const SizedBox(height: 20),

            /// Title
            Text(
              event.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayColor.withValues(alpha: .12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildInfoIcon(Icons.calendar_month_outlined),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(event.date),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            TimeOfDay.fromDateTime(event.date).format(context),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Description",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayColor.withValues(alpha: .12),
                ),
              ),
              child: Text(
                event.description.isNotEmpty
                    ? event.description
                    : "No description provided.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grayColor,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: theme.primaryColor, size: 25),
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

    return "${date.day} ${months[date.month - 1]}";
  }

  Future<void> _navigateToEdit(BuildContext context) async {
    final updated = await Navigator.push(context, AppRoutes.editEvent(event));

    if (updated != null && updated is EventDM && mounted) {
      setState(() {
        event = updated;
      });

      Fluttertoast.showToast(
        msg: "Event updated successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Event"),
        content: const Text(
          "Are you sure you want to delete this event? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              await _deleteEvent();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteEvent() async {
    try {
      await deleteEventFromFirestore(event.id);

      Fluttertoast.showToast(
        msg: "Event deleted successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to delete event: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
