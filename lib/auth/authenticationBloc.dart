import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/auth/authenticationEvent.dart';
import 'package:flutter_bloc_back4app/auth/authenticationState.dart';
import 'package:flutter_bloc_back4app/repositories/userRepository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{

  final BaseRepository userRepository;

  AuthenticationBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if (event is AppStarted) {
      var user = await userRepository.currentUser();
      if (user != null) {
        yield AuthenticationAuthenticated();
      } else{
        yield AuthenticationUnauthenticated();
      }
    }


    if (event is LoggedIn){
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationUnauthenticated();

    }
  }
}