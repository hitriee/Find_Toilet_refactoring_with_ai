import 'package:find_toilet/data/datasources/remote/intro_remote_data_source.dart';
import 'package:find_toilet/domain/repositories/intro_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';

class IntroRepositoryImpl extends IntroRepository {
  final IntroRemoteDataSource remote;

  IntroRepositoryImpl({required this.remote});

  @override
  FutureVoid getPermission() async {
    try {
      return await remote.getPermission();
    } catch (error) {
      throw Exception('Failed to get permission');
    }
  }

  @override
  Future<Position> getPosition(
      {required LocationAccuracy locationAccuracy}) async {
    try {
      return await remote.getPosition(locationAccuracy: locationAccuracy);
    } catch (error) {
      throw Exception('Fail to get current position');
    }
  }
}
