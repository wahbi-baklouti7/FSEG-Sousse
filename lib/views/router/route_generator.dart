import 'package:flutter/material.dart';
import 'package:fseg_sousse/views/Courses/courses.dart';
import 'package:fseg_sousse/widgets/error_page.dart';
import 'package:fseg_sousse/models/menu_choice_model.dart';
import 'package:fseg_sousse/root_widget.dart';
import 'package:fseg_sousse/views/auth/reset_password_view.dart';
import 'package:fseg_sousse/views/auth/sign_in_view.dart';
import 'package:fseg_sousse/views/auth/sign_up_view.dart';
import 'package:fseg_sousse/views/auth/verify_email_view.dart';
import 'package:fseg_sousse/views/books/books.dart';
import 'package:fseg_sousse/views/exams/exams.dart';
import 'package:fseg_sousse/views/files/add_file_view.dart';
import 'package:fseg_sousse/views/files/files_view.dart';
import 'package:fseg_sousse/views/lectures/lectures_screen.dart';
import 'package:fseg_sousse/views/home/home_screen.dart';
import 'package:fseg_sousse/views/openFile/pdf_file_screen.dart';
import 'package:fseg_sousse/views/subjects/add_subject.dart';
import 'package:fseg_sousse/views/subjects/subject_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const RootWidget());
      case SignInScreen.id:
        return MaterialPageRoute(builder: (_) => const SignInScreen());

      case SignUpScreen.id:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case VerifyEmailScreen.id:
        return MaterialPageRoute(builder: (_) => const VerifyEmailScreen());

      case ForgetPasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case HomeView.id:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case LecturesScreen.id:
        final args = settings.arguments as MenuChoiceModel;
        return MaterialPageRoute(
            builder: (_) => LecturesScreen(selectedMenuChoice: args));

      case CoursesScreen.id:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());

      case ExamsScreen.id:
        final args = settings.arguments as MenuChoiceModel;
        return MaterialPageRoute(
            builder: (_) => ExamsScreen(
                  selectedMenuChoice: args,
                ));

      case BooksScreen.id:
        return MaterialPageRoute(builder: (_) => const BooksScreen());

      case SubjectScreen.id:
        return MaterialPageRoute(builder: (_) => const SubjectScreen());
      case AddSubject.id:
        return MaterialPageRoute(builder: (_) => AddSubject());

      case FileScreen.id:
        return MaterialPageRoute(builder: (_) => const FileScreen());

      case AddFileScreen.id:
        return MaterialPageRoute(builder: (_) => const AddFileScreen());

      case PdfFileScreen.id:
        final args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PdfFileScreen(
                  selectedFile: args,
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}

class Arguments {
  final String url;
  final String fileName;

  Arguments(this.url, this.fileName);
}
