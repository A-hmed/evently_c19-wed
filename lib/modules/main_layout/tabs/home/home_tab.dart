import 'package:evently_c19/core/widgets/categories_tab_bar.dart';
import 'package:evently_c19/model/category_dm.dart';
import 'package:evently_c19/model/event_dm.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildAppBarRow(),
            CategoriesTabBar(
              categories: CategoryDM.allCategories,
              onTap: (category) {},
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => EventWidget(
                  eventDM: EventDM(
                    id: "12",
                    ownerId: "ownerId",
                    title: "This is a Birthday Party ",
                    description: "",
                    categoryId: 1,
                    date: DateTime.now(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildAppBarRow() {
    return Row(
      children: [
        Column(
          children: [
            Text("Welcome Back ✨", style: theme.textTheme.labelLarge),
            Text("Ahmed Nabil", style: theme.textTheme.titleMedium),
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
