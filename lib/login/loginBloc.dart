import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/repositories/userRepository.dart';
import 'package:flutter_bloc_back4app/login/loginState.dart';
import 'package:flutter_bloc_back4app/login/loginEvent.dart';
import 'package:flutter_bloc_back4app/auth/authenticationBloc.dart';
import 'package:flutter_bloc_back4app/auth/authenticationEvent.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.userRepository,this.authenticationBloc}) : assert(userRepository !=null),
  assert(authenticationBloc !=null);
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginButtonPressed){
      yield LoginLoading();
      try {
        final user = await userRepository.authentication(
            username: event.username,
            email: event.email,
            password: event.password
        );
        if (user != null) {
          authenticationBloc.dispatch(LoggedIn(user: user));
        } else {
          yield LoginFailure(error: 'Login Failed');
        }

      } catch(error){
        yield LoginFailure(error: error.toString());
      }
    }
  }
}