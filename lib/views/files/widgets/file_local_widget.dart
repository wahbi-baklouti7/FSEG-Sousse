// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/services/localStorage/local_storage.dart';

class FileCard extends StatelessWidget {
  final PdfFileModel pdfFileModel;
  VoidCallback onDownloadPressed;
  Function(String) onPopUpMenuItem;
  FileCard(
      {Key? key,
      required this.pdfFileModel,
      required this.onPopUpMenuItem,
      required this.onDownloadPressed})
      : super(key: key);
  final userId = LocalStorage.getUserId;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(AppImages.pdfFile,
                  cacheHeight: 120,
                  cacheWidth: 120,
                  filterQuality: FilterQuality.high),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(pdfFileModel.name!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        )),
              ),
            ),
            IconButton(
                onPressed: onDownloadPressed, icon: const Icon(Icons.download)),
            userId == pdfFileModel.userUid
                ? PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text("Edit"),
                          value: "Edit",
                        ),
                        const PopupMenuItem(
                          child: Text("Delete"),
                          value: "Delete",
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      onPopUpMenuItem(value);
                    },
                  )
                : const SizedBox()
          ])),
    );
  }
}
