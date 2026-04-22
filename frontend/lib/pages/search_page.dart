import 'package:find_toilet/data/datasources/remote/toilet_remote_data_source.dart';
import 'package:find_toilet/data/repositories/toilet_repository_impl.dart';
import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:find_toilet/presentation/view_models/search_view_model.dart';
import 'package:find_toilet/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  final String query;
  final double latitude;
  final double longitude;
  final int sortIdx;
  final bool diaper;
  final bool kids;
  final bool disabled;
  final bool allDay;

  const SearchPage({
    super.key,
    required this.query,
    required this.latitude,
    required this.longitude,
    required this.sortIdx,
    required this.diaper,
    required this.kids,
    required this.disabled,
    required this.allDay,
  });

  @override
  Widget build(BuildContext context) {
    final ToiletRepository repository = ToiletRepositoryImpl(
      remote: ToiletRemoteDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(
        toiletRepository: repository,
        keyword: query,
        latitude: latitude,
        longitude: longitude,
        sortIdx: sortIdx,
        diaper: diaper,
        kids: kids,
        disabled: disabled,
        allDay: allDay,
      )..loadInitial(),
      child: const SearchView(),
    );
  }
}
