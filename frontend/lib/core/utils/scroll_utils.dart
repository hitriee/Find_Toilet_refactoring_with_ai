import 'package:find_toilet/core/config/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 총 페이지 수
int? getTotal(BuildContext context) =>
    context.read<ScrollProvider>().totalPages;
void setTotal(BuildContext context, int? newTotal) =>
    context.read<ScrollProvider>().setTotal(newTotal);

//* scroll
bool readLoading(BuildContext context) =>
    context.read<ScrollProvider>().loading;

bool getLoading(BuildContext context) =>
    context.watch<ScrollProvider>().loading;

void setLoading(BuildContext context, bool value) =>
    context.read<ScrollProvider>().setLoading(value);

int getPage(BuildContext context) => context.read<ScrollProvider>().page;

void increasePage(BuildContext context) =>
    context.read<ScrollProvider>().increasePage();

void initPage(BuildContext context) =>
    context.read<ScrollProvider>().initPage();

bool getWorking(BuildContext context) => context.read<ScrollProvider>().working;

void setWorking(BuildContext context, bool value) =>
    context.read<ScrollProvider>().setWorking(value);

bool getAdditional(BuildContext context) =>
    context.read<ScrollProvider>().additional;

void setAdditional(BuildContext context, bool value) =>
    context.read<ScrollProvider>().setAdditional(value);
