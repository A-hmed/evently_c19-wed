import 'package:flutter/material.dart';

class CategoryDM {
  final int id;
  final String nameEn;
  final String nameAr;
  final String imageLight;
  final String imageDark;
  final IconData icon;

  const CategoryDM({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imageLight,
    required this.imageDark,
    required this.icon,
  });

  static final List<CategoryDM> allCategories = [
    CategoryDM(
      id: 0,
      nameEn: 'All',
      nameAr: 'الكل',
      imageLight: '',
      imageDark: '',
      icon: Icons.grid_view_rounded,
    ),
    CategoryDM(
      id: 1,
      nameEn: 'Sport',
      nameAr: 'رياضة',
      imageLight: 'assets/images/light_images/Sport.png',
      imageDark: 'assets/images/dark_images/Sport.png',
      icon: Icons.sports_soccer,
    ),
    CategoryDM(
      id: 2,
      nameEn: 'Book Club',
      nameAr: 'نادي الكتاب',
      imageLight: 'assets/images/light_images/Book Club.png',
      imageDark: 'assets/images/dark_images/Book Club.png',
      icon: Icons.menu_book,
    ),
    CategoryDM(
      id: 3,
      nameEn: 'Birthday',
      nameAr: 'عيد ميلاد',
      imageLight: 'assets/images/light_images/Birthday.png',
      imageDark: 'assets/images/dark_images/Birthday.png',
      icon: Icons.cake,
    ),
    CategoryDM(
      id: 4,
      nameEn: 'Meeting',
      nameAr: 'اجتماع',
      imageLight: 'assets/images/light_images/Meeting.png',
      imageDark: 'assets/images/dark_images/Meeting.png',
      icon: Icons.meeting_room,
    ),
    CategoryDM(
      id: 5,
      nameEn: 'Exhibition',
      nameAr: 'معرض',
      imageLight: 'assets/images/light_images/Exhibition.png',
      imageDark: 'assets/images/dark_images/Exhibition.png',
      icon: Icons.museum,
    ),
  ];

  static final List<CategoryDM> categories = [
    CategoryDM(
      id: 1,
      nameEn: 'Sport',
      nameAr: 'رياضة',
      imageLight: 'assets/images/light_images/Sport.png',
      imageDark: 'assets/images/dark_images/Sport.png',
      icon: Icons.sports_soccer,
    ),
    CategoryDM(
      id: 2,
      nameEn: 'Book Club',
      nameAr: 'نادي الكتاب',
      imageLight: 'assets/images/light_images/Book Club.png',
      imageDark: 'assets/images/dark_images/Book Club.png',
      icon: Icons.menu_book,
    ),
    CategoryDM(
      id: 3,
      nameEn: 'Birthday',
      nameAr: 'عيد ميلاد',
      imageLight: 'assets/images/light_images/Birthday.png',
      imageDark: 'assets/images/dark_images/Birthday.png',
      icon: Icons.cake,
    ),
    CategoryDM(
      id: 4,
      nameEn: 'Meeting',
      nameAr: 'اجتماع',
      imageLight: 'assets/images/light_images/Meeting.png',
      imageDark: 'assets/images/dark_images/Meeting.png',
      icon: Icons.meeting_room,
    ),
    CategoryDM(
      id: 5,
      nameEn: 'Exhibition',
      nameAr: 'معرض',
      imageLight: 'assets/images/light_images/Exhibition.png',
      imageDark: 'assets/images/dark_images/Exhibition.png',
      icon: Icons.museum,
    ),
  ];

  static CategoryDM getCategoryById(int id) =>
      categories.firstWhere((category) => category.id == id);
}
