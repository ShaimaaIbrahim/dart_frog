import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';

Future<Response> onRequest(RequestContext context) {
   return switch (context.request.method){
      HttpMethod.post => _createUser(context),
      _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
   };
}

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

// curl --request GET \
// --url http://localhost:8080/authentication/basic/205f6d61222ba99a981db2faabaacd26f45b4ec6826b42087b20348de7f68a11 \
// --header 'Authorization: Basic c3RlZmY6MTIzNA=='

// curl --request PATCH \
// --url http://localhost:8080/authentication/basic/205f6d61222ba99a981db2faabaacd26f45b4ec6826b42087b20348de7f68a11 \
// --header 'Authorization: Basic c3RlZmY6MTIzNA==' \
// --data '{
// "name": "ssssssss",
// "username": "steff",
// "password": "1234"
// }'

// curl --request POST \
// --url http://localhost:8080/authentication/basic \
// --header 'Content-Type: application/json' \
// --data '{
// "name": "steff jone",
// "username": "steff",
// "password": "1234"
// }'

//6da8373e9199f0f9d28db9c5cd7b1d77ceb93c271efd5a97cd55d66eebd005f2