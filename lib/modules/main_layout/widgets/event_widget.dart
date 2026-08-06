import 'package:evently_c19/model/event_dm.dart';
import 'package:flutter/material.dart';

import '../../../model/category_dm.dart';

class EventWidget extends StatelessWidget {
  final EventDM eventDM;

  const EventWidget({super.key, required this.eventDM});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var category = CategoryDM.getCategoryById(eventDM.categoryId);
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      height: MediaQuery.of(context).size.height * .23,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(category.imageLight),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${eventDM.date.day} Aug",
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${eventDM.title}",
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 16),
                ),
                Icon(Icons.favorite),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
