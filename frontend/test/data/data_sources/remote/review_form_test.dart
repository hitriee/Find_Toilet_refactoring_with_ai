import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/data/datasources/remote/review_form_remote_data_source.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:mocktail/mocktail.dart';

class MockReviewForm extends Mock implements ReviewFormRemoteDataSource {}
