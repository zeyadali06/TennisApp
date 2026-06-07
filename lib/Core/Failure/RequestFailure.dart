class RequestResult<S, F> {
  const RequestResult();
  factory RequestResult.success(S data) = RequestSuccess<S, F>;
  factory RequestResult.failure(F data) = RequestFailed<S, F>;
}

class RequestSuccess<S, F> extends RequestResult<S, F> {
  final S data;
  const RequestSuccess(this.data);
}

class RequestFailed<S, F> extends RequestResult<S, F> {
  final F data;
  const RequestFailed(this.data);
}
