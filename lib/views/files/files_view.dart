// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/utilities/connectivity_utility.dart';
import 'package:fseg_sousse/viewModel/file/add_file_view_model.dart';
import 'package:fseg_sousse/widgets/app_drawer.dart';
import 'package:fseg_sousse/widgets/empty_page.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/viewModel/file/file_view_model.dart';
import 'package:fseg_sousse/views/files/add_file_view.dart';
import 'package:fseg_sousse/views/files/widgets/file_local_widget.dart';
import 'package:fseg_sousse/widgets/no_internet.dart';
import 'package:provider/provider.dart';

class FileScreen extends StatefulWidget {
  static const id = "Files ";
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final scrollController = ScrollController();
  late FileViewModel fileViewModel;
  late AddFileViewModel addFileViewModel;

  @override
  void initState() {
    super.initState();

    fileViewModel = Provider.of<FileViewModel>(context, listen: false);
    fileViewModel.downloadListener();

    fileViewModel.init();
    fileViewModel.getPdfFiles(context);

    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fileViewModel.loadMore(context);
    }
  }

  @override
  void dispose() {
    fileViewModel.cancelStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FileViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              if (await ConnectivityUtility.checkInternet(context)) {
                Navigator.pushNamed(context, AddFileScreen.id);
              }
            },
            icon: const Icon(
              Icons.add,
              size: 32,
            ))
      ], title: const Text("Files")),
      drawer: const AppDrawer(),
      body: NetworkSensitiveWidget(
        child: Padding(
          padding: AppSize.symmetricPadding,
          child: SafeArea(
            child: Selector<FileViewModel, List<PdfFileModel>>(
                selector: (_, file) => file.listOfPdfModel,
                shouldRebuild: (previous, next) => true,
                builder: (_, listOfPdfModel, __) {
                  if (viewModel.loadData) {
                    return const SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return SizedBox(
                        child: FileList(
                            listPdfFile: listOfPdfModel,
                            scrollContro: scrollController));
                  }
                }),
          ),
        ),
      ),
    );
  }
}

// build file list
class FileList extends StatefulWidget {
  List<PdfFileModel> listPdfFile;
  ScrollController scrollContro;
  FileList({Key? key, required this.listPdfFile, required this.scrollContro})
      : super(key: key);

  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return widget.listPdfFile.isEmpty
        ? const EmptyScreen(
            image: AppImages.noFile,
            message: "tap the '+' button to add files",
            title: "There are no files here!")
        : RefreshIndicator(
            onRefresh: () => context.read<FileViewModel>().refresh(context),
            color: AppColors.secondaryColor,
            child: Selector<FileViewModel, bool>(
              selector: ((context, viewModel) => viewModel.hasNext),
              builder: (context, isLoading, _) {
                return ListView.builder(
                  controller: widget.scrollContro,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemExtent: 100,
                  itemCount: widget.listPdfFile.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.listPdfFile.length) {
                      return FileCard(
                        onDownloadPressed: (() => downloadButton(
                            fileName: widget.listPdfFile[index].name!,
                            fileUrl: widget.listPdfFile[index].fileUrl!)),
                        onPopUpMenuItem: (ff) {
                          context.read<FileViewModel>().actionPopUpMenuItem(
                              context,
                              value: ff,
                              pdfFileModel: widget.listPdfFile[index]);
                        },
                        pdfFileModel: widget.listPdfFile[index],
                      );
                    } else if (isLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (index > 9) {
                      return Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        child: const Center(
                          child: Text('No more Files'),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            ),
          );
  }

  Future<void> downloadButton(
      {required String fileUrl, required String fileName}) async {
    if (await ConnectivityUtility.checkInternet(context)) {
      await context
          .read<FileViewModel>()
          .downloadPdfFile(context, url: fileUrl, fileName: fileName);
    }
  }
}
