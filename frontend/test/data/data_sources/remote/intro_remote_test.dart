import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/data/datasources/remote/intro_remote_data_source.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';

class MockIntro extends Mock implements IntroRemoteDataSource {}
