import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:flutter/material.dart';

import '../../../model/category_dm.dart';

class EventWidget extends StatefulWidget {
  final EventDM eventDM;

  const EventWidget({super.key, required this.eventDM});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var category = CategoryDM.getCategoryById(widget.eventDM.categoryId);
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
              "${widget.eventDM.date.day} Aug",
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
                  "${widget.eventDM.title}",
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 16),
                ),
                buildFavoriteIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFavoriteIcon() {
    var isFavorite = UserDM.currentUser.favorites.contains(widget.eventDM.id);
    return InkWell(
      onTap: () {
        if (isFavorite) {
          removeEventFromFavorites(widget.eventDM.id);
        } else {
          addEventToUserFavorites(widget.eventDM.id);
        }
        setState(() {});
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
