import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:macros/macros.dart';
import 'package:flutter/material.dart';

void main(){
  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));
  channel.stream.listen(print);

  channel.sink.add('__increment__');
  channel.sink.add('__decrement__');

  channel.sink.close();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text("center"),
      )
    );
  }
}

