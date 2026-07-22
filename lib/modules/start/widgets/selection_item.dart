import 'package:flutter/material.dart';


class SelectionItem extends StatelessWidget {
  void Function()? onTap;
  String? text;
  String? icon;
  bool isSelected;
  SelectionItem({
    super.key,
    this.onTap,
    this.text,
    this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),

      child: Container(
        height: 32,
        padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.scaffoldBackgroundColor.withValues(alpha: 0.8),
          border: Border.all(
            color: theme.primaryColor
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: text == null
              ? Image.asset(
                  icon!,
                  color: isSelected
                      ? theme.scaffoldBackgroundColor
                      : theme.primaryColor,
                  width: 24,
                  height: 24,
                )
              : Text(
                  text!,
                  style: TextStyle(
                    color: isSelected
                        ? theme.scaffoldBackgroundColor
                        : theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
