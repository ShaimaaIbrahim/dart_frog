import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/items/item_Repository.dart';
import 'package:tasklist_backend/lists/list_Reository.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<TaskListRepository>((context)=> TaskListRepository()))
      .use(provider<TaskItemRepository>((context)=> TaskItemRepository()));
}