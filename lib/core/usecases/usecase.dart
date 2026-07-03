abstract interface class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract interface class StreamUseCase<T, Params> {
  Stream<T> call(Params params);
}

class NoParams {
  const NoParams();
}
