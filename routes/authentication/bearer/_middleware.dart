// routes/admin/_middleware.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:tasklist_backend/repository/session/session_repository.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';

Handler middleware(Handler handler) {
  final userRepository = UserRepository();
  final sessionRepository = SessionRepository();
  
  return handler.use(requestLogger())
      .use(bearerAuthentication<User>(authenticator: (context, token) async{
    final _sessionRepo = context.read<SessionRepository>();
    final _userRepo =    context.read<UserRepository>();
    
    final session=  _sessionRepo.sessionFromToken(token);
    return session!=null ? _userRepo.userFromId(session.userId) : null;
    },
      applies: (RequestContext context) async =>
      context.request.method != HttpMethod.post &&
      context.request.method != HttpMethod.get
  ),
  ).use(provider<UserRepository>((_) => UserRepository()))
   .use(provider<SessionRepository>((_) => SessionRepository()));
}
