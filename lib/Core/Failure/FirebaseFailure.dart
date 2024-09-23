class FirebaseResult<S, F> {
  const FirebaseResult();
  factory FirebaseResult.success(S data) = FirebaseSuccess<S, F>;
  factory FirebaseResult.failure(F data) = FirebaseFailure<S, F>;
}

class FirebaseSuccess<S, F> extends FirebaseResult<S, F> {
  final S data;
  const FirebaseSuccess(this.data);
}

class FirebaseFailure<S, F> extends FirebaseResult<S, F> {
  final F data;
  const FirebaseFailure(this.data);
}
