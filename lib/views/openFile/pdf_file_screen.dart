// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/services/conectivity/conecetivity_service.dart';
import 'package:fseg_sousse/utilities/connectivity_status_enum.dart';
import 'package:fseg_sousse/viewModel/file/open_pdf_file_view_model.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:fseg_sousse/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:fseg_sousse/views/openFile/edit_file_screen.dart';
import 'package:fseg_sousse/widgets/error_page.dart';

class PdfFileScreen extends StatelessWidget {
  static const id = "Pdf screen";
  String? url;
  String? fileName;
  final selectedFile;

  PdfFileScreen({
    Key? key,
    required this.selectedFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "************************** build open pdf file screen *********************************");
    final model = Provider.of<OpenPdfViewModel>(context, listen: false);

    final FireAuth _fireAuth = locator<FireAuth>();
    final user = _fireAuth.currentUser;

    return Scaffold(
      appBar: AppBar(
          // title: Text("${selectedFile.name}",
          //     style: Theme.of(context).textTheme.bodyText1),
          actions: [
            (user!.uid == selectedFile.userUid)
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditFileScreen(
                                    selectedFile: selectedFile,
                                  )));
                    },
                    icon: const Icon(Icons.edit),
                    iconSize: 30,
                  )
                : const SizedBox(),
            (user.uid == selectedFile.userUid)
                ? IconButton(
                    onPressed: () {
                      model.deleteFile(context,
                          fileUrl: selectedFile.fileUrl, uid: selectedFile.id);
                    },
                    icon: const Icon(Icons.delete),
                    iconSize: 30,
                  )
                : const SizedBox(),
            IconButton(
              onPressed: () async {
                if (await ConnectivityService().checkInternetConnection() ==
                    ConnectivityStatus.offline) {
                  AppSnackBar.normalSnackBar(context,
                      content: "No internet connection");
                } else {
                  await model.downloadPdfFile(context,
                      url: selectedFile.fileUrl, fileName: selectedFile.name);
                  AppAlert.loadingProgressIndicator(context,
                      message: Selector<OpenPdfViewModel, double>(
                        selector: (_, fileVM) => fileVM.downloadProgress,
                        builder: (_, downloadProgress, __) {
                          print(
                              "----------------------in Selector  download pdf progress ---------------------");
                          return Text(
                            "Downloading File: ${downloadProgress.toStringAsFixed(0)}%",
                            style: Theme.of(context).textTheme.bodyText1,
                          );
                        },
                      ));
                }
                //             await model.downloadPdfFile(context,
                //                 url: selectedFile.fileUrl, fileName: selectedFile.name);
                //             AppAlert.loadingProgressIndicator(context,
                //                 message: Selector<OpenPdfViewModel, double>(
                //                   selector: (_, fileVM) => fileVM.downloadProgress,
                //                   builder: (_, downloadProgress, __) {
                //                     print(
                //                         "----------------------in Selector  download pdf progress ---------------------");
                //                     return Text(
                //                       "Downloading File: ${downloadProgress.toStringAsFixed(0)}%",
                //                       style: Theme.of(context).textTheme.bodyText1,
                //                     );
                //                   },
                //                 ));
              },
              icon: const Icon(Icons.download_sharp), iconSize: 30,
              // iconSize: 35.0,
            ),
          ]),
      body: Container(
        padding: AppSize.symetricPadding,
        child: const PDF(
          enableSwipe: true,
          swipeHorizontal: true,
          fitPolicy: FitPolicy.BOTH,
        ).fromUrl(selectedFile.fileUrl,
        placeholder: (progress) => Center(
                  child: Text("$progress%"),
                ),
            errorWidget: (error) {
              if (error is SocketException) {
                return const NoInternetWidget();
              }
              return const ErrorScreen();
            },
            ),

        // .cachedFromUrl(selectedFile.fileUrl,
        //     placeholder: (progress) => Center(
        //           child: Text("$progress%"),
        //         ),
        //     errorWidget: (error) {
        //       if (error is SocketException) {
        //         return const NoInternetWidget();
        //       }
        //       return const ErrorScreen();
        //     },
        //     maxAgeCacheObject: const Duration(days: 15),
        //     maxNrOfCacheObjects: 5),
      ),
    );
  }
}
