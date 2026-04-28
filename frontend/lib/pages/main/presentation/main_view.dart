import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/utils/global_utils.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/core/widgets/bottom_sheet.dart';
import 'package:find_toilet/core/widgets/box_container.dart';
import 'package:find_toilet/core/widgets/map_widget.dart';
import 'package:find_toilet/core/widgets/search_bar.dart';
import 'package:find_toilet/core/widgets/text_widget.dart';
import 'package:find_toilet/pages/main/presentation/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  final bool showReview, needNear;
  final ReturnVoid? refreshPage;
  final String? beforePage;
  const MainView({
    super.key,
    this.showReview = false,
    this.refreshPage,
    this.needNear = true,
    this.beforePage,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final globalKey = GlobalKey<ScaffoldState>();
  double paddingTop = 0;
  bool refreshState = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<MainViewModel>().setScaffoldKey(globalKey);
        if (widget.showReview && !context.read<MapStateProvider>().showAll) {
          changeShow(context);
        }
        setState(() {
          paddingTop = statusBarHeight(context);
        });
      },
    );
  }

  void _refreshMain(int index) {
    context.read<MainViewModel>().refreshMain(index, widget.showReview);
  }

  @override
  Widget build(BuildContext context) {
    if (refreshState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          context.read<MainViewModel>().loadInitial(widget.showReview);
          setState(() {
            refreshState = false;
          });
        },
      );
    }
    return PopScope(
        canPop: widget.showReview ? false : exitApp(context),
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (widget.showReview) {
            removeMarker(context);
            routerPop(context)();
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: globalKey,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(top: paddingTop),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth(context),
                        height: screenHeight(context) - paddingTop,
                        child: MapScreen(
                          showReview: widget.showReview,
                          refreshPage: widget.refreshPage,
                          needNear: widget.needNear,
                        ),
                      ),
                    ],
                  ),
                  if (!widget.showReview && showAll(context))
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        children: [
                          FilterBox(
                            onPressed: _refreshMain,
                            applyLong: !isDefaultTheme(context),
                            isMain: true,
                          ),
                        ],
                      ),
                    ),
                  if (showAll(context))
                    ToiletBottomSheet(
                        showReview: widget.showReview,
                        refreshPage: () {
                          if (widget.refreshPage != null) {
                            widget.refreshPage!();
                          }
                          setState(() {
                            refreshState = true;
                          });
                        }),
                  if (showAll(context))
                    CustomSearchBar(
                        isMain: true,
                        showReview: widget.showReview,
                        refreshPage: () {
                          if (widget.refreshPage != null) {
                            widget.refreshPage!();
                          }
                          setState(() {
                            refreshState = true;
                          });
                        }),
                  if (watchPressed(context))
                    Center(
                      child: CustomBox(
                        height: 80,
                        width: isDefaultTheme(context) ? 300 : 350,
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                        child: const Center(
                          child: CustomText(
                            title: '뒤로 가기 버튼을 한 번 더\n누르시면 앱이 종료됩니다',
                            isCentered: true,
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ));
  }
}
