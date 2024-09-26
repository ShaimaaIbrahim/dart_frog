import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extensions.dart';

part 'item_Repository.g.dart';

@visibleForTesting
Map<String, TaskItem> itemDb ={};

@immutable
@JsonSerializable()
class TaskItem extends Equatable {
  TaskItem({
    required this.name, this.id, this.description, this.status, this.listId
  }) : assert(id == null || id.isNotEmpty, 'id cannot be empty');

  final String? id;

  final String name;
  
  final String? description;

  final bool? status;

  final String? listId;
  
  TaskItem copyWith({
    String? id,
    String? name,
    String? listId,
    bool? status,
    String? description,
  }) {
    return TaskItem(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        listId: listId ?? this.listId,
        status: status ?? this.status
    );
  }

  static TaskItem fromJson(Map<String, dynamic> json) => _$TaskItemFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  @override
  List<Object?> get props => [id, listId, name, description, status];
}
class TaskItemRepository {

  Future<TaskItem?> itemById(String id) async{
    return itemDb[id];
  }


  Map<String, dynamic> getAllItems (){
    var formattedList = <String, dynamic>{};

    itemDb.forEach((String id) {
      final currentList = itemDb[id];
      formattedList[id] = currentList?.toJson();
    } as void Function(String key, TaskItem value));
    return formattedList;
  }

  String createItem(
      {required String name, 
       required String description,
       required String listId,
       required bool status}){
    String id = name.hashValue;
    itemDb[id] = TaskItem(name: name, id: id, description: description, listId: listId, status: status);
    return id;
  }

  void deleteItem(String id){
    itemDb.remove(id);
  }

  Future<void> updateItem({
    required String id, 
    required String? name,
    required String description,
    required String listId,
    required bool status
  })async{
    final currentItem = itemDb[id];
    if(currentItem==null){
      return Future.error(Exception('item not found.'));
    }
    final item = TaskItem(
        name: name ?? currentItem.name, 
        id: id, 
        description: description, 
        listId: listId, 
        status: status);
    
    itemDb[id] = item;
  }
}

