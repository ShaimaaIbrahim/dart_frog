
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extensions.dart';

part 'session_repository.g.dart';

@visibleForTesting
Map<String, Session> sessionDb ={};

@immutable
@JsonSerializable()
class Session extends Equatable{
  final String token;
  final String userId;
  final DateTime expirationDate;
  final DateTime createdAt;

  Session({
    required this.token,
    required this.userId,
    required this.expirationDate,
    required this.createdAt
});

  /// Deserializes the given `Map<String, dynamic>` into a [Todo].
  static Session fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  /// Converts this [Todo] into a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$SessionToJson(this);
  
  @override
  List<Object?> get props => [token, userId, expirationDate, createdAt];
  
}

class SessionRepository {
  
  Future<Session> createSession(String userId){
    final session = Session(
        token: generateToken(userId), 
        userId: userId, 
        expirationDate: DateTime.now().add(const Duration(hours: 24)),
        createdAt: DateTime.now());
    
    sessionDb[session.token] = session;
    return Future.value(session);
  }
  
  String generateToken(String userId){
    return '${userId}_${DateTime.now().toIso8601String()}'.hashValue;
  }
  
  Session? sessionFromToken(String token){
    final session =  sessionDb[token];
    if(session!=null && session.expirationDate.isAfter(DateTime.now())){
      return session;
    }
    return null;
  }
}