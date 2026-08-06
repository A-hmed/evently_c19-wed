import 'package:evently_c19/model/category_dm.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  final List<CategoryDM> categories;
  final Function(CategoryDM) onTap;

  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  late ThemeData themeData = Theme.of(context);
  late CategoryDM selectedCategory = widget.categories[0];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        onTap: (index) {
          selectedCategory = widget.categories[index];
          widget.onTap(selectedCategory);
          setState(() {});
        },
        tabs: widget.categories
            .map((categoryDm) => buildTabItem(categoryDm, categoryDm == selectedCategory))
            .toList(),
      ),
    );
  }

  Widget buildTabItem(CategoryDM category, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? themeData.colorScheme.primary
            : themeData.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            category.icon,
            color: isSelected
                ? themeData.colorScheme.surface
                : themeData.colorScheme.primary,
          ),
          SizedBox(width: 8),
          Text(
            category.nameEn,
            style: TextStyle(
              color: isSelected
                  ? themeData.colorScheme.surface
                  : themeData.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
