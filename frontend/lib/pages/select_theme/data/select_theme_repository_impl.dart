import 'package:find_toilet/datasources/local/select_theme_local_data_source.dart';
import 'package:find_toilet/pages/select_theme/domain/select_theme_repository.dart';

class SelectThemeRepositoryImpl implements SelectThemeRepository {
  final SelectThemeLocalDataSource local;

  SelectThemeRepositoryImpl({required this.local});

  @override
  Future<void> saveTheme(bool isLargeFont) async {
    try {
      await local.saveTheme(isLargeFont);
    } catch (e) {
      throw Exception('테마 저장에 실패했습니다.');
    }
  }
}
