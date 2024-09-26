import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extensions.dart';

part 'list_Repository.g.dart';

@visibleForTesting
Map<String, TaskList> listDb ={};

@immutable
@JsonSerializable()
class TaskList extends Equatable {
  TaskList({
    required this.name, this.id
  }) : assert(id == null || id.isNotEmpty, 'id cannot be empty');

  final String? id;

  final String name;
  
  
  TaskList copyWith({
    String? id,
    String? name
  }) {
    return TaskList(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }

  static TaskList fromJson(Map<String, dynamic> json) => _$TaskListFromJson(json);

  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  @override
  List<Object?> get props => [id, name];
}


class TaskListRepository {
  
  Future<TaskList?> listById(String id) async{
    return listDb[id];
  }
  
  
  Map<String, dynamic> getAllList (){
    var formattedList = <String, dynamic>{};
    
    listDb.forEach((String id) {
     final currentList = listDb[id];
     formattedList[id] = currentList?.toJson();
    } as void Function(String key, TaskList value));
    return formattedList;
  }
  
  String createList({required String name}){
    String id = name.hashValue;
    listDb[id] = TaskList(name: name, id: id);
    return id;
  }
  
  void deleteTask(String id){
    listDb.remove(id);
  }

  Future<void> updateList({required String id, required String name})async{
    final currentList = listDb[id];
    if(currentList==null){
      return Future.error(Exception('list not found.'));
    }
    final list = TaskList(name: name ?? currentList.name, id: id);
    listDb[id] = list;
  }
}
