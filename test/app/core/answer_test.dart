
import 'package:answer_poc/app/core/answer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class _UseCase {
  Future<Answer<Exception, String>> getValue();
}

class MockUserCase extends Mock implements _UseCase {
  @override
  Future<Answer<Exception, String>> getValue() {
    return super.noSuchMethod(
      Invocation.method(#getValue, null),
      returnValue: Future.value(Success<Exception, String>('value')),
    );
  }
}

void main() {
  late MockUserCase mockUserCase;

  setUp(() {
    mockUserCase = MockUserCase();
  });
  group('Answer ...', () {
    test('when call useCase, should return a Success', () async {
      when(mockUserCase.getValue()).thenAnswer((_) async => Success('value'));
      final result = await mockUserCase.getValue();
      expect(result.isSuccess, true);
      final value = result.asSuccess;
      expect(value, 'value');
    });
    test('when call useCase, should return a Failure', () async {
      when(mockUserCase.getValue())
          .thenAnswer((_) async => Failure(Exception()));
      final result = await mockUserCase.getValue();
      expect(result.isFailure, true);
      final exception = result.asFailure;
      expect(exception, isA<Exception>());
    });

    test('when call deal, should return a failure', () async {
      when(mockUserCase.getValue())
          .thenAnswer((_) async => Failure(Exception()));
      final result = await mockUserCase.getValue();
      final failure = result.deal(onFail: (e) => e, onSuccess: (s) => s);
      expect(failure, isA<Exception>());
    });

    test('when call deal, should return a success', () async {
      when(mockUserCase.getValue()).thenAnswer((_) async => Success('value'));
      final result = await mockUserCase.getValue();
      final success = result.deal(onFail: (e) => e, onSuccess: (s) => s);
      expect(success, 'value');
    });
  });
}
