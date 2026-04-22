import 'package:dio/dio.dart';
import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/data/datasources/remote/toilet_remote_data_source.dart';
import 'package:find_toilet/data/repositories/toilet_repository_impl.dart';
import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockToilet extends Mock implements ToiletRemoteDataSource {}
  // void main() {
  //   late ToiletRepository toiletRepository;

  //   test('주변 화장실 검색', () {
  //     ToiletRemoteDatasource mockToilet = MockToilet();
  //     toiletRepository = ToiletRepositoryImpl(remote: mockToilet);
  //     when(() => mockToilet.getNearToilet({}).then((invocation) async => Mock))

  //     expect(toiletRepository.getNearToilet({{}}), isA<Future<void>(),)
  //   });
  // }