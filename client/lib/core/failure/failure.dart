class AppFailure {
  final String message;

  AppFailure([this.message = "Some Error Occurred!!"]);

  @override
  String toString() => 'AppFailure(message: $message)';
}
