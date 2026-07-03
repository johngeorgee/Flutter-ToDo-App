sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to access local storage']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

final class DuplicateFailure extends Failure {
  const DuplicateFailure(super.message);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Item not found']);
}
