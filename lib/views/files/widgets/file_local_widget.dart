import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/views/openFile/pdf_file_screen.dart';

class FileCard extends StatelessWidget {
  final PdfFileModel pdfFilemodel;
  const FileCard({Key? key, required this.pdfFilemodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 40, //TODO: fix this size image raster
              width: 40,
              child: Image.asset(AppImages.pdfFile,
                  cacheHeight: 120,
                  cacheWidth: 120,
                  filterQuality: FilterQuality.high),
            ),
            // Image.asset(AppImages.pdfFile,cacheHeight:40 ,cacheWidth: 40,filterQuality: FilterQuality.high),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(pdfFilemodel.name!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        )),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, PdfFileScreen.id,
                    arguments: pdfFilemodel);
              },
              icon: const Icon(Icons.arrow_forward_sharp),
            )
          ])),
    );
  }
}
