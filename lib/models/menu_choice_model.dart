import 'package:fseg_sousse/constants/app_images.dart';

class MenuChoiceModel {
  final String title;
  final String icon;

  MenuChoiceModel({required this.title, required this.icon});

  
}

List<MenuChoiceModel> menuChoices = [
    MenuChoiceModel(title: "Lectures", icon: AppImages.lectures),
    MenuChoiceModel(title: "Exams", icon: AppImages.exams),
    MenuChoiceModel(title: "Courses", icon: AppImages.onlineCourse),
    MenuChoiceModel(title: "Books", icon: AppImages.books),
  ];
