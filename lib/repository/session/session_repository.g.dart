// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      token: json['token'] as String,
      userId: json['userId'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'expirationDate': instance.expirationDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
