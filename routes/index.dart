import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/lists/list_Reository.dart';

Future<Response> onRequest(RequestContext context) {
  return switch(context.request.method){
    HttpMethod.get => _getLists(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getLists(RequestContext context) async {
  final lists = context.read<TaskListRepository>().getAllList();
  return Response.json(body: lists);
}