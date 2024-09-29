import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Handler onRequest(RequestContext context) {
  final handler =  webSocketHandler((channel, protocol){
     print("connected 🌱");
     
     //receive messages from websocket.
     channel.stream.listen((message) {
       print('message: $message🌱');

       //send messages to websocket.
       channel.sink.add('echo => $message🌱');
     },
     onDone: () => print("disconnected 🌱")
    );
  });
  return handler;
}
