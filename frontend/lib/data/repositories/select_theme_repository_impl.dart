import 'package:find_toilet/data/datasources/remote/select_theme_remote_data_source.dart';
import 'package:find_toilet/domain/repositories/select_theme_repository.dart';

class SelectThemeRepositoryImpl implements SelectThemeRepository {
  final SelectThemeRemoteDataSource remote;

  SelectThemeRepositoryImpl({required this.remote});

  @override
  Future<void> saveTheme(bool isLargeFont) async {
    try {
      await remote.saveTheme(isLargeFont);
    } catch (e) {
      throw Exception('테마 저장에 실패했습니다.');
    }
  }
}
