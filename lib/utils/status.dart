class Status<T> {
	 dynamic when(
    {dynamic Function()? onIdle,
    required dynamic Function() onLoading,
    required dynamic Function(T data) onSuccess,
    required dynamic Function(String message) onError,}
  ) {
    if (this is Loading) {
      return onLoading();
    } else if (this is Success) {
      return onSuccess((this as Success).data);
    } else if (this is Error) {
      return onError((this as Error).message);
    } else {
      return onIdle == null ? null : onIdle();
    }
  }
}

class Idle<T> extends Status<T> {}

class Loading<T> extends Status<T> {}

class Success<T> extends Status<T> {
  final T data;
  Success({required this.data});
}

class Error<T> extends Status<T> {
  final String message;
  Error({required this.message});
}


