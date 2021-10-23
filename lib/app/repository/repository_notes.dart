import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/dio.dart';

class RepositoryNotes {
  Future<List<ModelNotes>> getNotes() async {
    List<ModelNotes> list = [];
    final response = await dio.get("/notation");
    
    (response.data["notations"] as List).forEach((e) {
      list.add(ModelNotes.fromJson(e));
    });

    return list;
  }
}
