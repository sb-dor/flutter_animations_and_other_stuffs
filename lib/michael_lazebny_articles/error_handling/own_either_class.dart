import 'package:flutter/cupertino.dart';

abstract class Either<L, R> {
  //
  T when<T extends Object?>({
    required T Function(L left) left,
    required T Function(R right) right,
  });
}

class Left<L, R> extends Either<L, R> {
  final L left;

  Left(this.left);

  @override
  T when<T extends Object?>({
    required T Function(L left) left,
    required T Function(R right) right,
  }) {
    return left(this.left);
  }
}

class Right<L, R> extends Either<L, R> {
  final R right;

  Right(this.right);

  @override
  T when<T extends Object?>({
    required T Function(L left) left,
    required T Function(R right) right,
  }) {
    return right(this.right);
  }
}

class MockHttpResponse {
  //
  void getSomethingFromResponse(String type) async {
    final getData = await _somethingInFunction(type);

    getData.when(
      left: (left) {
        debugPrint("coming exception: $left");
      },
      right: (right) {
        debugPrint(right);
      },
    );
  }

  Future<Either<Exception, String>> _somethingInFunction(String type) async {
    if (type.isEmpty) {
      return Left(Exception("Error occurred"));
    } else {
      return Right("Successful response");
    }
  }
}
