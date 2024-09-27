import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';

Handler middleware(Handler handler) {
  final userRepository = UserRepository();
  
  return handler.use(
    basicAuthentication<User>(authenticator: (context, username, password) async{
      final repository = context.read<UserRepository>();
        //check if user exist inside database or not?
        return  repository.userFromCredential(username, password);
    },
    applies: (RequestContext context) async =>
      context.request.method != HttpMethod.post
    )
  ).use(
      provider<UserRepository>((_) => userRepository)
  );
}
