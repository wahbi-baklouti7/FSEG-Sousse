import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/services/database/database.dart';
import 'package:fseg_sousse/utilities/global_data.dart';
import 'package:fseg_sousse/viewModel/auth/reset_password_view_model.dart';
import 'package:fseg_sousse/viewModel/auth/sign_in_view_model.dart';
import 'package:fseg_sousse/viewModel/auth/sign_up_view_model.dart';
import 'package:fseg_sousse/viewModel/auth/verify_email_view_model.dart';
import 'package:fseg_sousse/viewModel/file/add_file_view_model.dart';
import 'package:fseg_sousse/viewModel/file/edit_file_view_model.dart';
import 'package:fseg_sousse/viewModel/file/file_view_model.dart';
import 'package:fseg_sousse/viewModel/subject/subject_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

 void setupLocator() {

  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => FireAuth());
  locator.registerLazySingleton(() => GlobalData());


  locator.registerFactory(() => SignInViewModel());
  locator.registerFactory(() => SignUpViewModel());
  locator.registerFactory(() => ResetPasswordViewModel());
  locator.registerFactory(() => VerifyEmailViewModel());
  locator.registerFactory(() => AddFileViewModel());
  locator.registerFactory(() => EditFileViewModel());
  locator.registerFactory(() => FileViewModel());
  locator.registerFactory(() => SubjectViewModel());
}
