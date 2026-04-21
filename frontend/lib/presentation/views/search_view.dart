// ignore_for_file: use_build_context_synchronously

import 'package:find_toilet/presentation/view_models/search_view_model.dart';
import 'package:find_toilet/pages/main_page.dart';
import 'package:find_toilet/shared/utils/global_utils.dart';
import 'package:find_toilet/shared/utils/style.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:find_toilet/shared/widgets/box_container.dart';
import 'package:find_toilet/shared/widgets/list_view.dart';
import 'package:find_toilet/shared/widgets/search_bar.dart';
import 'package:find_toilet/shared/widgets/silvers.dart';
import 'package:find_toilet/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ScrollController _scrollController = ScrollController();
  bool _expandSearch = false;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setKey(context, _globalKey);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels < position.maxScrollExtent * 0.9) return;
    context.read<SearchViewModel>().loadMore();
  }

  void _changeExpandSearch() {
    setState(() {
      _expandSearch = !_expandSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyword = context.select<SearchViewModel, String>(
      (vm) => vm.keyword,
    );
    final isLoading = context.select<SearchViewModel, bool>(
      (vm) => vm.isLoading,
    );
    final isLoadingMore = context.select<SearchViewModel, bool>(
      (vm) => vm.isLoadingMore,
    );
    final toiletList = context.select<SearchViewModel, ToiletList>(
      (vm) => vm.toiletList,
    );
    final errorMessage = context.select<SearchViewModel, String?>(
      (vm) => vm.errorMessage,
    );

    return WillPopScope(
      onWillPop: () {
        removedRouterPush(context, page: const MainPage(needNear: true));
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: _globalKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: mainColor,
          body: Padding(
            padding: EdgeInsets.only(top: statusBarHeight(context)),
            child: CustomBoxWithScrollView(
              toolbarHeight: _expandSearch
                  ? isDefaultTheme(context)
                      ? 400
                      : 430
                  : isDefaultTheme(context)
                      ? 115
                      : 120,
              listScroll: _scrollController,
              flexibleSpace: Column(
                children: [
                  CustomSearchBar(
                    isMain: false,
                    query: keyword,
                    onSearchMode: _changeExpandSearch,
                    refreshPage: () {
                      context.read<SearchViewModel>().refresh();
                    },
                  ),
                  _topOfAppBar(),
                ],
              ),
              silverChild: [
                CustomBox(
                  color: mainColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: isLoading && toiletList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : errorMessage != null && toiletList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Center(
                                  child: CustomText(
                                    title: errorMessage,
                                    color: CustomColors.whiteColor,
                                  ),
                                ),
                              )
                            : toiletList.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Center(
                                      child: CustomText(
                                        title: '조건에 맞는 화장실이 없습니다.',
                                        color: CustomColors.whiteColor,
                                      ),
                                    ),
                                  )
                                : CustomListView(
                                    itemCount: toiletList.length +
                                        (isLoadingMore ? 1 : 0),
                                    itemBuilder: (context, i) {
                                      if (i == toiletList.length) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 40,
                                          ),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: ListItem(
                                          showReview: false,
                                          isMain: false,
                                          toiletModel: toiletList[i],
                                          index: i,
                                          refreshPage: () {
                                            context
                                                .read<SearchViewModel>()
                                                .refresh();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _topOfAppBar() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomText(
              title: '검색 결과',
              fontSize: FontSize.largeSize,
              color: CustomColors.whiteColor,
              font: kimm,
            ),
          ),
        ],
      ),
    );
  }
}
