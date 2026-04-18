import 'package:find_toilet/presentation/view_models/bookmark_view_model.dart';
import 'package:find_toilet/shared/utils/icon_image.dart';
import 'package:find_toilet/shared/utils/style.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:find_toilet/shared/widgets/button.dart';
import 'package:find_toilet/shared/widgets/box_container.dart';
import 'package:find_toilet/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 폴더 내 즐겨찾기 목록
class BookmarkView extends StatefulWidget {
  const BookmarkView({
    super.key,
  });

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) {
      return;
    }
    final viewModel = context.read<BookmarkViewModel>();
    if (_controller.position.pixels >= _controller.position.maxScrollExtent * 0.9) {
      viewModel.loadMore();
    }
  }

  FutureVoid _refresh() async {
    await context.read<BookmarkViewModel>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final folderName = context.select<BookmarkViewModel, String>(
      (viewModel) => viewModel.folderName,
    );
    final bookmarkCnt = context.select<BookmarkViewModel, int>(
      (viewModel) => viewModel.bookmarkCnt,
    );
    final bookmarkList = context.select<BookmarkViewModel, ToiletList>(
      (viewModel) => viewModel.bookmarkList,
    );
    final isLoading = context.select<BookmarkViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );
    final isLoadingMore = context.select<BookmarkViewModel, bool>(
      (viewModel) => viewModel.isLoadingMore,
    );
    final errorMessage = context.select<BookmarkViewModel, String?>(
      (viewModel) => viewModel.errorMessage,
    );

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CustomIconButton(
          icon: exitIcon,
          color: CustomColors.whiteColor,
          onPressed: () => Navigator.pop(context),
          iconSize: 45,
          padding: EdgeInsets.zero,
        ),
        title: CustomText(
          title: folderName,
          fontSize: FontSize.titleSize,
          color: CustomColors.whiteColor,
          font: kimm,
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CustomText(
                title: '$bookmarkCnt',
                fontSize: FontSize.defaultSize,
                color: CustomColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null && bookmarkList.isEmpty
                ? Center(
                    child: CustomText(
                      title: errorMessage,
                      color: CustomColors.whiteColor,
                    ),
                  )
                : ListView.builder(
                    controller: _controller,
                    itemCount: bookmarkList.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == bookmarkList.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListItem(
                          showReview: false,
                          isMain: false,
                          toiletModel: bookmarkList[index],
                          index: index,
                          refreshPage: () {
                            context.read<BookmarkViewModel>().refresh();
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
