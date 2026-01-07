class Result<T> {
  final T? data;
  final String? message;
  final bool success;

  const Result.success(this.data) : success = true, message = null;

  const Result.error(this.message) : success = false, data = null;
}
