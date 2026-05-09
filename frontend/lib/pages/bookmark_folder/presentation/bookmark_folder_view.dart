import 'package:find_toilet/core/theme/style.dart';
import 'package:find_toilet/core/utils/global_utils.dart';
import 'package:find_toilet/core/utils/icon_image.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/core/widgets/box_container.dart';
import 'package:find_toilet/core/widgets/button.dart';
import 'package:find_toilet/core/widgets/text_widget.dart';
import 'package:find_toilet/pages/bookmark/domain/bookmark_model.dart';
import 'package:find_toilet/pages/bookmark_folder/presentation/bookmark_folder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkFolderView extends StatelessWidget {
  const BookmarkFolderView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookmarkFolderViewModel>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        toolbarHeight: isDefaultTheme(context) ? 65 : 75,
        flexibleSpace: Padding(
          padding:
              EdgeInsets.fromLTRB(20, statusBarHeight(context) + 15, 20, 0),
          child: Row(
            children: [
              Flexible(
                child: CustomIconButton(
                  icon: exitIcon,
                  color: CustomColors.whiteColor,
                  onPressed: routerPop(context),
                  iconSize: 45,
                  padding: EdgeInsets.zero,
                ),
              ),
              Flexible(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 5),
                    CustomText(
                      title: '${getName(context)}님의\n즐겨 찾기 폴더',
                      fontSize: FontSize.largeSize,
                      color: CustomColors.whiteColor,
                      font: kimm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : vm.error != null
                ? Center(
                    child: CustomText(
                      title: vm.error!,
                      color: CustomColors.whiteColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: _folderListView(vm.folders, vm),
                  ),
      ),
    );
  }

  ListView _folderListView(FolderList folders, BookmarkFolderViewModel vm) {
    final length = folders.length;
    final quot = length ~/ 2;
    final remain = length % 2;

    Widget folderBox(FolderModel folder) => FolderBox(
          folderInfo: folder,
          onEdit: (newName) => vm.renameFolder(folder.folderId, newName),
          onDelete: () => vm.deleteFolder(folder.folderId),
        );

    Row folderRow(int index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int di = 0; di < 2; di += 1) folderBox(folders[2 * index + di]),
        ],
      );
    }

    Widget addRow(int index) {
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;
      late final WidgetList children;
      if (length >= 10) {
        if (index >= 5) {
          return const SizedBox();
        }
        children = [
          for (int di = 0; di < 2; di += 1) folderBox(folders[2 * index + di]),
        ];
      } else if (remain == 0) {
        mainAxisAlignment = MainAxisAlignment.start;
        children = [AddBox(onCreate: vm.createFolder)];
      } else {
        children = [
          FolderBox(
            folderInfo: folders[2 * index],
            onlyOne: length == 1,
            onEdit: (newName) =>
                vm.renameFolder(folders[2 * index].folderId, newName),
            onDelete: () => vm.deleteFolder(folders[2 * index].folderId),
          ),
          AddBox(onCreate: vm.createFolder),
        ];
      }

      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          index < quot ? folderRow(index) : addRow(index),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: quot + 1,
    );
  }
}
