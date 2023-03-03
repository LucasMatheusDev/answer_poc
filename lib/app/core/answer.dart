abstract class Answer<F, S> {
  F get asFailure => (this as Failure<F, S>).failure;

  S get asSuccess => (this as Success<F, S>).data;

  bool get isSuccess => this is Success<F, S>;

  bool get isFailure => this is Failure<F, S>;
  
  R deal<R>({
    required R Function(F failure) onFail,
    required R Function(S success) onSuccess,
  }) {
    if (this is Failure<F, S>) {
      return onFail((this as Failure<F, S>).failure);
    } else {
      return onSuccess((this as Success<F, S>).data);
    }
  }
}

class Success<F, S> extends Answer<F, S> {
  final S data;

  Success(this.data);
}

class Failure<F, S> extends Answer<F, S> {
  final F failure;

  Failure(this.failure);
}
