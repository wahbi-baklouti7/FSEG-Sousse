import 'package:fseg_sousse/constants/app_images.dart';

class MenuChoiceModel {
  final String title;
  final String icon;

  MenuChoiceModel({required this.title, required this.icon});

  
}

List<MenuChoiceModel> menuChoices = [
    MenuChoiceModel(title: "Lectures", icon: AppImages.Lectures),
    MenuChoiceModel(title: "Exams", icon: AppImages.EXAMS),
    MenuChoiceModel(title: "Online Courses", icon: AppImages.ONINE_COURSE),
    MenuChoiceModel(title: "Books", icon: AppImages.BOOKS),
  ];
