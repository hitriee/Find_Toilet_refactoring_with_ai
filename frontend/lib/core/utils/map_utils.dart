import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/network/toilet_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 필터
void setFilter(BuildContext context, int index, bool value) =>
    context.read<MapStateProvider>().setFilter(index, value);

bool readFilter(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.read<MapStateProvider>().diaper;
    case 1:
      return context.read<MapStateProvider>().kids;
    case 2:
      return context.read<MapStateProvider>().disabled;
    default:
      return context.read<MapStateProvider>().allDay;
  }
}

bool getFilter(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.watch<MapStateProvider>().diaper;
    case 1:
      return context.watch<MapStateProvider>().kids;
    case 2:
      return context.watch<MapStateProvider>().disabled;
    default:
      return context.watch<MapStateProvider>().allDay;
  }
}

//* 정렬
void setSortIdx(BuildContext context, int index) =>
    context.read<MapStateProvider>().setSortIdx(index);
int getSortIdx(BuildContext context) =>
    context.read<MapStateProvider>().sortIdx;

//* 현위치
double? readLat(BuildContext context) => context.read<MapStateProvider>().lat;
double? readLng(BuildContext context) => context.read<MapStateProvider>().lng;
void setLatLng(BuildContext context, double newLat, double newLng) =>
    context.read<MapStateProvider>().setLatLng(newLat, newLng);

//* main touch
void changeShow(BuildContext context) =>
    context.read<MapStateProvider>().changeShow();
bool showAll(BuildContext context) => context.watch<MapStateProvider>().showAll;

//* main toilet list
void setRadius(BuildContext context) => context
    .read<MapStateProvider>()
    .setRadius(context.read<SettingsProvider>().radius);

void addToiletList(BuildContext context, ToiletList toiletList) =>
    context.read<MapStateProvider>().addToiletList(toiletList);

DynamicMap mainToiletData(BuildContext context) =>
    context.read<MapStateProvider>().mainToiletData;

ToiletList mainToiletList(BuildContext context) =>
    context.read<MapStateProvider>().mainToiletList;

FutureToiletList getMainToiletList(BuildContext context) async {
  final query = Map<String, dynamic>.from(MapStateProvider().mainToiletData);
  query['page'] = ScrollProvider().page;
  query['size'] = 20;
  final list = await ToiletProvider().getNearToilet(query);
  addToiletList(context, list);
  return list;
}

void initToiletList(BuildContext context) =>
    context.read<MapStateProvider>().initToiletList();

void setMainPage(BuildContext context, int newVal) =>
    context.read<MapStateProvider>().setMainPage(newVal);

//* key
void setKey(BuildContext context, GlobalKey<ScaffoldState> key) =>
    context.read<MapStateProvider>().setKey(key);
GlobalKey? getKey(BuildContext context) =>
    context.read<MapStateProvider>().globalKey;

//* map marker
void setMarker(BuildContext context, int i) =>
    context.read<MapStateProvider>().setMarker(i);

void removeMarker(BuildContext context) =>
    context.read<MapStateProvider>().removeMarker();

int? getSelectedMarker(BuildContext context) =>
    context.read<MapStateProvider>().selectedMarker;
