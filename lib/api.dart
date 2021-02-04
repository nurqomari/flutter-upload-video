import 'package:dio/dio.dart';
import 'package:flutter_upload_video/video_info.dart';

class api{
  static Future<List<VideoInfo>> listenToVideos() async {
  try{
    Dio dio = new Dio();
    Response response = await dio.post(
        'https://favorestodevapi.azurewebsites.net/v.1/sbtiktok/post/feed', data:{
      "page": 1,
      "page_size": 10
    });
    print("video list : $response");
    var responseJson = response.data;
    return (responseJson['data'] as List)
        .map((p) => VideoInfo.fromJson(p))
        .toList();
  } on DioError catch(e) {
    print("Exception Caught:");
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if(e.response != null) {
    print(e.response.data);
    print(e.response.headers);
    print(e.response.request);
    } else{
    // Something happened in setting up or sending the request that triggered an Error
      print(e.request);
      print(e.message);
      }
    }
  }
}