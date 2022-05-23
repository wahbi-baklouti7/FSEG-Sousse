import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fseg_sousse/utilities/connectivity_status_enum.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/services/conectivity/conecetivity_service.dart';
import 'package:fseg_sousse/services/localStorage/local_storage.dart';
import 'package:fseg_sousse/utilities/app_theme.dart';
import 'package:fseg_sousse/viewModel/auth/verify_email_view_model.dart';
import 'package:fseg_sousse/viewModel/file/add_file_view_model.dart';
import 'package:fseg_sousse/viewModel/file/edit_file_view_model.dart';
import 'package:fseg_sousse/viewModel/file/file_view_model.dart';
import 'package:fseg_sousse/viewModel/auth/sign_in_view_model.dart';
import 'package:fseg_sousse/viewModel/file/open_pdf_file_view_model.dart';
import 'package:fseg_sousse/viewModel/subject/add_subject_view_model.dart';
import 'package:fseg_sousse/views/router/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await LocalStorage.initialize();

  // Start Locator
  setupLocator();

  // Setting the orientation of the app to portrait.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VerifyEmailViewModel>(
            create: (_) => VerifyEmailViewModel()),
        ChangeNotifierProvider<AddFileViewModel>(
            create: (_) => AddFileViewModel()),
        ChangeNotifierProvider<EditFileViewModel>(
            create: (_) => EditFileViewModel()),
        ChangeNotifierProvider<FileViewModel>(create: (_) => FileViewModel()),
        ChangeNotifierProvider<AddSubjectViewModel>(
            create: (_) => AddSubjectViewModel()),
        ChangeNotifierProvider<OpenPdfViewModel>(
            create: (_) => OpenPdfViewModel()),
        ChangeNotifierProvider<SignInViewModel>(
            create: (_) => SignInViewModel()),
        StreamProvider<ConnectivityStatus>(
            create: (_) =>
                ConnectivityService().connectionStatusController.stream,
            initialData: ConnectivityStatus.online)
      ],
      child: Sizer(builder: (context, orietation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppThemeUtils.buildTheme(),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }),
    );
  }
}
