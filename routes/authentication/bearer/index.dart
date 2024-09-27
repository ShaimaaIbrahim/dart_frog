import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/session/session_repository.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';

Future<Response> onRequest(RequestContext context) {
  return switch(context.request.method){
    HttpMethod.post => _createUser(context),
    HttpMethod.get =>  _autheticateUser(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

//as register request (name- username- password)..
Future<Response> _createUser(RequestContext context) async{
  final body = await context.request.json() as Map<String, dynamic>;

  final name = body['name'] as String?;
  final username = body['username'] as String?;
  final password = body['password'] as String?;

  final userRepository = context.read<UserRepository>();
  if(name!=null && username!=null && password!=null){
    final id = await userRepository.createNewUser(name, username, password);
    return Response.json(body: {'id': id});
  }else{
    return Response(statusCode: HttpStatus.badRequest);
  }
}

//use it as login request.. (username- password)..
Future<Response> _autheticateUser(RequestContext context) async{
  final body = await context.request.json() as Map<String, dynamic>;
  
  final username = body['username'] as String?;
  final password = body['password'] as String?;
  
  if(username!=null && password!=null){
    final user = await context.read<UserRepository>().userFromCredential(username, password);
    if(user==null){
      return Response(statusCode: HttpStatus.unauthorized); 
    }else{
      final session = await context.read<SessionRepository>().createSession(user.id);
      return Response.json(body: {'token': session.token});
    }
  }else{
    return Response(statusCode: HttpStatus.badRequest);
  }
}


// curl --request POST \
// --url http://localhost:8080/authentication/bearer \
// --header 'Content-Type: application/json' \
// --data '{
// "name": "john john",
// "username": "john",
// "password": "1234"
// }'
//response: 96d9632f363564cc3032521409cf22a852f2032eec099ed5967c0d000cec607a


// curl --request GET \
// --url http://localhost:8080/authentication/bearer \
// --header 'Content-Type: application/json' \
// --data '{
// "username": "john",
// "password": "1234"
// }'

//response : {"token":"311db55b9672f7c9831470e8bb1986975702a02efa85924fe46e3108213249fa"}% 


