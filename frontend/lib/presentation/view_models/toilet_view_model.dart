//* main, search
import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:flutter/material.dart';

class ToiletViewModel with ChangeNotifier {
  final ToiletRepository _toiletRepository;

  ToiletViewModel({required ToiletRepository toiletRepository})
      : _toiletRepository = toiletRepository;

  FutureToiletList _getMainToiletList(int page) async {
    final toiletData = await _toiletRepository.getNearToilet(_mainToiletData);
    _setMainPage(page + 1);
    _addToiletList(toiletData);
    notifyListeners();
    return toiletData;
  }

  FutureToiletList _getSearchList(int page) async {
    final toiletData = await _toiletRepository.searchToilet(_searchData);
    _setSearchPage(page + 1);
    _searchToiletList.addAll(toiletData);
    notifyListeners();
    return toiletData;
  }
}
