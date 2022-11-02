import 'dart:convert';

import 'package:brainworld/services/auth_service.dart';

class AdminCourseService {
  Future<List> getAllPosts() async {
    var user = await AuthService().getuserFromStorage();
    var data = {
      'token': user.token,
    };
    var response = await AuthService().postData(data, 'admin/getCategories');
    var responseData = json.decode(response.body);
    var postMap = responseData['categories'];
    List categories = [];
    for (var data in postMap) {
      categories.add(data);
      // postsController.allPost.add(PostsModel.fromJson(data));
    }

    return categories;
  }
}
