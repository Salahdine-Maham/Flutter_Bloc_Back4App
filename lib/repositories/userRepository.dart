import 'package:meta/meta.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class BaseRepository {
  Future<ParseUser> signup({@required String username,@required String email ,@required String password});
  Future<ParseUser> authentication({@required String username,@required String email ,@required String password});
  Future<ParseUser> currentUser();
  Future<bool> logout();
  Future<bool> verificationEmail();
  Future<bool> requestPasswordReset();
}

class UserRepository extends BaseRepository{
  UserRepository();

  /// Signup [username], [email], [password]
  ///
  /// Return [ParseUser]
  ///
  Future<ParseUser> authentication({
    @required String username,
    @required String email ,
    @required String password,
                          }) async {
    var user = ParseUser(username,password,email);
    var response = await user.login();
    if(response.success)
      return response.result;
    return null;
  }

  Future<bool> requestPasswordReset() async {
    ParseUser user = await ParseUser.currentUser();
    var response = await user.requestPasswordReset();
    if(response.success)
      return response.result;
    return null;
  }

  Future<bool> verificationEmail() async {
    ParseUser user = await ParseUser.currentUser();
    var result = await user.verificationEmailRequest();
    return result.success;
  }

  /// Signup [username], [email], [password]
  ///
  /// Return [ParseUser]

  Future<ParseUser> signup({
    @required String username,
    @required String email ,
    @required String password}) async {
    var user = ParseUser(username,email,password);
    var result = await user.save();
    if (result.success) {
      return user;
    }
    return null;

  }

  Future<ParseUser> currentUser() async{
    return await ParseUser.currentUser();
  }

  Future<bool> logout() async {
    ParseUser user = await ParseUser.currentUser();
    var result = await user.logout();
    return result.success;
  }






  }


