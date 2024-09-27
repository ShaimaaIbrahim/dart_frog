import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:http/http.dart' as http;

Future<Response> onRequest(RequestContext context) {
  return switch(context.request.method){
    HttpMethod.get => _getRecipie(),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getRecipie() async{
   final response = await http.get(
       Uri.parse("https://rapidapi.com/dfskGT/api/low-carb-recipes"),
       headers: {
         'X-RapidAPI-Key': '',
         'X-RapidAPI-Host': ''
       }
   );
  if(response.statusCode==200){
    return Response.json(body: response.body);
  }else{
    return Response(statusCode: HttpStatus.badRequest);
  }
}
