# Learning how use  

## Base

The Answer<F, S> class is an abstract class that represents an answer that can be either a success or a failure. It has two generic types, F and S, which respectively represent the type of failure and the type of success that can be returned.




## Getters

The Answer<F, S> class has four methods:

get asFailure: Returns the failure object if the response is a failure.

get asSuccess: returns the success object if the response is a success.

bool get isSuccess: returns true if the response is a success.

bool get isFailure: returns true if the response is a failure.

## Deal
The Answer<F, S> class also has a deal method that takes two functions as parameters: onFail and onSuccess. The onFail function runs if the response is a failure and returns the failure object. The onSuccess function runs if the response is a success and returns the success object. The deal method can be used as void or returning the result of the executed function.
    

The Success<F, S> class is a subclass of Answer<F, S> that represents a successful answer. It has a data field that contains the returned success object.

The Failure<F, S> class is a subclass of Answer<F, S> that represents a failure response. It has a failure field that contains the returned failure object.

# Example 

## With Deal 
```dart
    final userAnswer = await viewModel.getUser(id);

    userAnswer.deal(
      onFail: (error) {
        state.value = StateDefaultError(error);
      },
      onSuccess: (user) {
        state.value = StateSuccess(user);
      },
    );
 ```

 ## With Getters
```dart
    final userAnswer = await viewModel.getUser(id);

   if (userAnswer.isSuccess) {
        state.value = StateSuccess(userAnswer.asSuccess);
      } else {
        state.value = StateDefaultError(userAnswer.asFailure)
    }
```


## Answering

```dart

  Future<Answer<UserException, User>> getUser(String id) async {
    try {
      final user = await dataSource.getUser(id);
      return Success(user);
    } on RestClientException catch (e) {
      if (e.code == 404) {
        return Failure(
          UserNotFoundException(
            message: 'User not found',
            code: e.code,
          ),
        );
      } else {
        return Failure(
          UserDefaultException(
            message: 'Something went wrong',
            code: e.code,
          ),
        );
      }
    }
  }

```


