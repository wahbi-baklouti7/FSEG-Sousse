import 'package:flutter/material.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/widgets/file_picker.dart';
import 'package:fseg_sousse/widgets/no_internet.dart';
import 'package:fseg_sousse/viewModel/file/add_file_view_model.dart';
import 'package:provider/provider.dart';

class AddFileScreen extends StatelessWidget {
  static const id = "Add File";

  const AddFileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "**************************build add file screen *********************************");
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: NetworkSensitiveWidget(
        child: Padding(
          padding: AppSize.lrtpPadding,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Selector<AddFileViewModel, String?>(
                    selector: (_, addFileVM) => addFileVM.fileName,
                    builder: (_, fileName, __) {
                      print(
                          "----------------------in Selector choose file: ---------------------");
                      return FilePickerWidget(
                        fileName: fileName,
                        onTap: () => context
                            .read<AddFileViewModel>()
                            .chooseFile(context),
                      );
                    }),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("*Max file size: 5MB",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                const SizedBox(height: 32),
                Selector<AddFileViewModel, String?>(
                  selector: (_, addFileVM) => addFileVM.fileName,
                  builder: (_, fileName, __) {
                    print(
                        "----------------------in Selector upload  pdf ---------------------");
                    return AppIconButton(
                        textButton: "UPLOAD",
                        onPressed: fileName != null
                            ? () {
                                context
                                    .read<AddFileViewModel>()
                                    .addFile(context: context);

                                AppAlert.loadingProgressIndicator(
                                  context,
                                  message: Selector<AddFileViewModel, int?>(
                                      selector: (context, addFile) =>
                                          addFile.progressIndicator,
                                      builder: (context, progress, _) {
                                        return Text(
                                          "Uploading File: $progress%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        );
                                      }),
                                );
                              }
                            : null,
                        icon: Icons.upload);
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
