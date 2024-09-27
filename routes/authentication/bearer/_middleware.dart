// routes/admin/_middleware.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';

Handler middleware(Handler handler) {
  final userRepository = UserRepository();
  return handler.use(requestLogger()).use(
    bearerAuthentication<User>(authenticator: (context, token) {
      final userRepository = context.read<UserRepository>();
      return userRepository.fetchFromAccessToken(token);
    },),
  );
}
