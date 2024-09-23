class FirebaseResult<T> {
  const FirebaseResult();
  factory FirebaseResult.success(T data) = FirebaseSuccess<T>;
  factory FirebaseResult.failure(T data) = FirebaseFailure<T>;
}

class FirebaseSuccess<T> extends FirebaseResult<T> {
  final T data;
  const FirebaseSuccess(this.data);
}

class FirebaseFailure<T> extends FirebaseResult<T> {
  final T data;
  const FirebaseFailure(this.data);
}
