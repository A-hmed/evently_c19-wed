import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/widgets/categories_tab_bar.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:evently_c19/modules/main_layout/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  ///Lazy initialization
  late ThemeData theme = Theme.of(context);
  CategoryDM selectedCategory = CategoryDM.allCategories[0];
  late Stream<List<EventDM>> eventsStream;

  @override
  void initState() {
    super.initState();

    eventsStream = getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<EventDM>>(
          stream: eventsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            } else if (snapshot.hasData) {
              var events = snapshot.requireData;
              if (selectedCategory != CategoryDM.allCategories[0]) {
                events = events
                    .where((event) => event.categoryId == selectedCategory.id)
                    .toList();
              }
              return Column(
                children: [
                  buildAppBarRow(),
                  CategoriesTabBar(
                    categories: CategoryDM.allCategories,
                    onTap: (category) {
                      selectedCategory = category;
                      setState(() {});
                    },
                  ),
                  buildEventsList(events),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildEventsList(List<EventDM> events) {
    if (events.isEmpty) {
      return Expanded(child: Center(child: Text("No events found")));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => EventWidget(eventDM: events[index]),
      ),
    );
  }

  Row buildAppBarRow() {
    return Row(
      children: [
        Column(
          children: [
            Text("Welcome Back ✨", style: theme.textTheme.labelLarge),
            Text(UserDM.currentUser.name, style: theme.textTheme.titleMedium),
          ],
        ),
        Spacer(),
        Icon(Icons.sunny),
        SizedBox(width: 10),
        Icon(Icons.language),
      ],
    );
  }
}
