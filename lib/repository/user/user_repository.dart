import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extensions.dart';

part 'user_repository.g.dart';

@visibleForTesting
Map<String, User> usersDb ={};

@immutable
@JsonSerializable()
class User extends Equatable{
  final String id;
  final String name;
  final String username;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password
  });

  /// Deserializes the given `Map<String, dynamic>` into a [Todo].
  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts this [Todo] into a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, name, username, password];

}

class UserRepository{
  
  //check if user in database of not 
  Future<User?> userFromCredential(String username, String password) async{
    final users = usersDb.values.where((user) => user.username==username && user.password==password);
    if(users.isNotEmpty){
      return Future.value(users.first);
    }
    return null;
  }
  
  User? userFromId(String id){
    return usersDb[id];
  }
  
  Future<String> createNewUser(String name, String username, String password) async{
     final id = username.hashValue;   
     final user = User(id: id, name: name, username: username, password: password);
     usersDb[id] = user; 
     return Future.value(id);
  }

  Future<void> deleteUser(String id) async{
    usersDb.remove(id);
  }
  
  Future<String> updateUser(
      String id,
      String? name, 
      String? username, 
      String? password) async{
    
    final currentUser = usersDb[id];
    if(currentUser==null){
      return Future.value('User not found.');
    }
    if(password!=null){
       password = password.hashValue;
    }
    final user = User(
        id: id, 
        name: name ?? currentUser.name, 
        username: username??currentUser.username, 
        password: password ?? currentUser.password);
    
    usersDb[id] = user;
    return Future.value(id);
  }
}






