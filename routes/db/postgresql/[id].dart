import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch(context.request.method){
    
    HttpMethod.delete => _deleteList(context, id),
    HttpMethod.patch => _updateList(context, id),
   _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
Future<Response> _updateList(RequestContext context, String id) async{
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;

  if(name!=null){
    try{
      final result = await context.read<Connection>().execute(
        r'UPDATE lists SET name = $1 WHERE id = $2',
        parameters: [name, id], 
      );
      if(result.affectedRows==1) {
        return Response.json(body: {'success': true});
      }else{
        return Response.json(body: {'success': false});
      }
    }catch(e){
      return Response(statusCode: HttpStatus.connectionClosedWithoutResponse);
    }
  }else{
    return Response(statusCode: HttpStatus.badRequest);
  }
}

Future<Response> _deleteList(RequestContext context, String id) async {
  try{
    final result = await context.read<Connection>().execute(
      r'DELETE FROM lists WHERE id = $1',
      parameters: [id],
    );
    if(result.affectedRows==1) {
      return Response.json(body: {'success': true});
    }else{
      return Response.json(body: {'success': false});
    }
  }catch(e){
    return Response(statusCode: HttpStatus.connectionClosedWithoutResponse);
  }
}
