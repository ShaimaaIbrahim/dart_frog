import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch(context.request.method){
    HttpMethod.get => _getUser(context, id),
    HttpMethod.patch => _updateUser(context, id),
    HttpMethod.delete => _deleteUser(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _updateUser(RequestContext context, String id) async{
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if(name!=null && username!=null && password!=null){
    await context.read<UserRepository>().updateUser(id, name, username, password);
    return Response(statusCode: HttpStatus.noContent);
  }else{
    return Response(statusCode: HttpStatus.badRequest);
  }
}

Future<Response> _deleteUser(RequestContext context, String id) async{
  final user = context.read<UserRepository>().userFromId(id);
  if(user==null){
    return Response(statusCode: HttpStatus.forbidden);
  }else {
    if(user.id != id){
      return Response(statusCode: HttpStatus.forbidden);
    }
    await context.read<UserRepository>().deleteUser(id);
    return Response(statusCode: HttpStatus.noContent);
  }
}
Future<Response> _getUser(RequestContext context, String id) async{
  final user = context.read<UserRepository>().userFromId(id);
  if(user?.id != id){
    return Response(statusCode: HttpStatus.forbidden);
  }
  return Response.json(body: {'id': user!.id, 'name': user.name, 'username': user.username, 'password': user.password});
}

// curl --request PATCH \
// --url http://localhost:8080/authentication/bearer/96d9632f363564cc3032521409cf22a852f2032eec099ed5967c0d000cec607a \
// --header 'Content-Type: application/json' \
// --header 'Authorization: Bearer 311db55b9672f7c9831470e8bb1986975702a02efa85924fe46e3108213249fa' \
// --data '{
// "name": "john john",
// "username": "john",
// "password": "1234"
// }'
//response: 96d9632f363564cc3032521409cf22a852f2032eec099ed5967c0d000cec607a

// curl --request DELETE \
// --url http://localhost:8080/authentication/bearer/96d9632f363564cc3032521409cf22a852f2032eec099ed5967c0d000cec607a \
// --header 'Content-Type: application/json' \
// --header 'Authorization: Bearer 311db55b9672f7c9831470e8bb1986975702a02efa85924fe46e3108213249fa' 
