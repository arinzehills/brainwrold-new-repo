import 'dart:convert';

import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/upload/course/model/course.dart';
import 'package:brainworld/services/auth_service.dart';
import 'package:http/http.dart' as http;

class CourseService {
  addCourse(Course course) async {
    print('abeg');
    var user = await AuthService().getuserFromStorage();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$generalUrl/course/uploadCourse'));
    var filemultipart;
    var videosmultipart;
    if (course.files != []) {
      for (var file in course.files) {
        //loop tru all files
        filemultipart = await http.MultipartFile.fromPath(
          'file',
          file.path,
        );
        request.files.add(filemultipart);
      }
    }
    print('course.videos');
    if (course.videos != []) {
      print(course.videos);
      for (var file in course.videos) {
        //loop tru all files
        videosmultipart = await http.MultipartFile.fromPath(
          'videos',
          file.path,
        );
        request.files.add(videosmultipart);
      }
    }
    var videomultipart = await http.MultipartFile.fromPath(
      'video',
      course.video.path,
    );

    request.files.add(videomultipart);

    request.fields['title'] = course.courseTitle;
    request.fields['caption'] = course.description!;
    request.fields['price'] = course.price;
    request.fields['category'] = course.category!;
    request.headers['x-access-token'] = user.token!;
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    // var responseData = json.decode(response.body);
    // print('responseData');
    print(response.body);
    return response;
  }
}
