import 'package:find_toilet/datasources/remote/toilet_remote_data_source.dart';
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