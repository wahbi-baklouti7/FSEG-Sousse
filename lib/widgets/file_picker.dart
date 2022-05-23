// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/constants/app_size.dart';

class FilePickerWidget extends StatelessWidget {
  Function() onTap;
  String? selectedFileName;

  String? fileName;
  FilePickerWidget({
    this.selectedFileName,
    required this.onTap,
    required this.fileName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 220,
      padding: AppSize.paddingAll,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                onTap();
              },
              child: (fileName == null)
                  ? SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.asset(
                        AppImages.addPdf,
                        cacheWidth: 200,
                        cacheHeight: 200,
                        filterQuality: FilterQuality.high,
                      ))
                  : SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        AppImages.pdfFile,
                        cacheWidth: 210,
                        cacheHeight: 210,
                        filterQuality: FilterQuality.high,
                      ))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: fileName != null
                  ? Text(
                      fileName!,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(selectedFileName ?? "Choose file",
                      style: Theme.of(context).textTheme.bodyText1)),
        ],
      ),
    );
  }
}
