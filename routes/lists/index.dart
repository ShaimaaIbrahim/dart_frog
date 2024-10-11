import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/lists/list_Reository.dart';

Future<Response> onRequest(RequestContext context) async{
  
  return switch(context.request.method){
    HttpMethod.post => _createNewList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _createNewList(RequestContext context) async{
  final listRepo = context.read<TaskListRepository>();
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;

  if (name != null) {
    final id = listRepo.createList(name: name);

    return Response.json(body: {'id': id});
  } else {
    return Response(statusCode: HttpStatus.badRequest);
  }
}

