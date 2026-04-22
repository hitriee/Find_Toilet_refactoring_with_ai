import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/data/datasources/remote/bookmark_folder_remote_data_source.dart';
import 'package:find_toilet/data/datasources/remote/bookmark_remote_data_source.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:mocktail/mocktail.dart';

class MockBookmark extends Mock implements BookmarkRemoteDataSource {}
