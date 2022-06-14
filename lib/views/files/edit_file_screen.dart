import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fseg_sousse/utilities/connectivity_utility.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/widgets/file_picker.dart';
import 'package:fseg_sousse/widgets/no_internet.dart';
import 'package:fseg_sousse/viewModel/file/edit_file_view_model.dart';
import 'package:provider/provider.dart';

class EditFileScreen extends StatelessWidget {
  static const id = "Edit File";

  final selectedFile;
  const EditFileScreen({Key? key, required this.selectedFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: AppSize.lrtpPadding,
      child: NetworkSensitiveWidget(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  BackButton(),
                ],
              ),
              const Spacer(),
              Selector<EditFileViewModel, String?>(
                  selector: (_, editFileVM) => editFileVM.fileName,
                  builder: (_, fileName, __) {
                    return FilePickerWidget(
                      onTap: () =>
                          context.read<EditFileViewModel>().selectFile(context),
                      fileName: fileName,
                      selectedFileName: selectedFile.name,
                    );
                  }),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("*Max file size: 5MB",
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Selector<EditFileViewModel, File?>(
                selector: (_, editFileVM) => editFileVM.file,
                builder: (context, fileName, child) {
                  return AppIconButton(
                    textButton: "Upload  File",
                    onPressed: fileName != null
                        ? () async {
                            if (await ConnectivityUtility.checkInternet(
                                context)) {
                              context.read<EditFileViewModel>().editFile(
                                  context,
                                  fileId: selectedFile.id,
                                  url: selectedFile.fileUrl);
                              AppAlert.loadingProgressIndicator(
                                context,
                                message: Selector<EditFileViewModel, int?>(
                                    selector: (context, addFile) =>
                                        addFile.progressIndicator,
                                    builder: (context, progress, _) {
                                      return Text(
                                        "Uploading File: $progress%",
                                      );
                                    }),
                              );
                            }
                          }
                        : null,
                    icon: Icons.upload,
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ));
  }
}
