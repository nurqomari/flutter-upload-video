class VideoInfo {
  String description;
  String media_url;

  VideoInfo({this.description, this.media_url});
  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return new VideoInfo(
      description: json['description'].toString(),
      media_url: json['media_url'].toString(),
    );
  }
}