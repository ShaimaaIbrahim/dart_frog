// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_Repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      name: json['name'] as String,
      id: json['id'] as String?,
      description: json['description'] as String?,
      status: json['status'] as bool?,
      listId: json['listId'] as String?,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'listId': instance.listId,
    };
