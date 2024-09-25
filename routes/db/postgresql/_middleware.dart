import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Handler middleware(Handler handler) {
  return (context) async{
    final conn = await Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'tasklist',
        username: 'postgres',
        password: '123456',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    
    final response = await handler
        .use(provider<Connection>((_)=> conn))
        .call(context);
    
    await conn.close();
    
    return response;
  };
}
