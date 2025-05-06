sealed class Result<T> {
  const Result();
  factory Result.ok(T value) => Ok(value);
  factory Result.error(Exception error) => Error(error);

}

/// This is a wrapper class that contains a [T] object
final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}


/// This is a wrapper class that contains an [Exception]
final class Error<T> extends Result<T> {
  const Error(this.error);
  final Exception error;
}