import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/data/datasources/remote/bookmark_folder_remote_data_source.dart';
import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:mocktail/mocktail.dart';

class MockBookmarkFolder extends Mock
    implements BookmarkFolderRemoteDataSource {}
