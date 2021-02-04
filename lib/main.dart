import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_upload_video/video_info.dart';
import 'package:flutter_upload_video/api.dart';
import 'package:flutter_upload_video/chewie_player.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter SB Tiktok'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<VideoInfo> _videos = <VideoInfo>[];
  int _counter = 0;
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldstate =
  new GlobalKey<ScaffoldState>();

  @override
  void initState() {
//    var newVideos = await api.listenToVideos(_videos);
//    setState(() {
//      if(newVideos!=null) {
//        _videos = newVideos;
//      }
//    });
    super.initState();
  }

  Future _imgFromCamera() async {
    final _picker = ImagePicker();
    var image = await _picker.getVideo(source: ImageSource.camera);
    _uploadFile(image);

    setState(() {
      _image = File(image.path);
    });
  }

  Future _imgFromGallery() async {
    final _picker = ImagePicker();
    var image = await _picker.getVideo(source: ImageSource.gallery);
    _uploadFile(image);

    setState(() {
      _image = File(image.path);
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  // Methode for file upload
  void _uploadFile(PickedFile filePath) async {
    // Get base file name
    String fileName = basename(filePath.path);
    print("File base name: $fileName");

    try {
//      FormData formData =
//      new FormData.from({"file": new UploadFileInfo(filePath, fileName)});

//      FormData formData = FormData.fromMap({
//        "file": await MultipartFile.fromFile(
//          filePath.path,
//          filename: fileName,
//        ),
//      });
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath.path.toString(),filename: fileName)
      });
      print("uploading " + filePath.path);
      Dio dio = new Dio();
      var token = "kOJv9J1Vshrl6DetWxMoHt0LzGOr_g7VyEwwthzOcBBOR3Uosv3EbD2uM8ugka1HIeptkB5RuylHDCR_pYCzav8L8madITOCHDoaiji3XpDKBPBAywinYD3xAgAf9d7gljds99t7FiT0R0A-3i8ICWG0FSJzyFLi6StBbdOq2SYTSA50V3EXNLtw_5jI3njpIMwyEGu71WCFzUzEoWVaMxpcJ-rHUSYHNXm5GOqDs_GXaqlhfZWPmo7mKagwuav9FoHvdeQUylfH4vkplERfm9zPLr-Aj3vNoRCSQND6i86MridkzkpwqDNOJ7mVEzV-DOsLjioOecuGvprX4bnHse1gb9XyRFAGHsRJjiwa_Y_CF3aSV3YoqndTWJoT41kTpgsGKHKi7oO9eIAafSUmR8eS-Cpk8dyIg0fiaaC74rHymOEHPwZ2Nf_kZVp89J20EchkF1nP1CcGT641nYUH7kUBhDZgzvTANwJfl6yEPcodoYxQuwkWEVzjN4QRXkqamhH1N2y7pto-h2ouTRwvGjOJ0GwV72b4QE27-n42fvdPE1QeZPxOFdQXxjeGLP-M0du_adQJ27aotvz8zx_Xmjnlxlb2uc5Mbk1oMBehD6xOnnXBnz3qc7Bas7OuADJ_S9TFCEL8igV1HjryuBhNfDlqlmi5SU1Rkf4SywUPgPEhSjbeVCAeLQVuqkOBMCxCDxlMTlKWOwGY4nCwokU4tubFnrqWHQ0UVXqzFutkDIE";
      dio.options.headers["Authorization"] = "Bearer ${token}";
      Response response =
      await dio.post("https://favorestodevapi.azurewebsites.net/v.1/sbtiktok/upload", data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar
//      _showSnakBarMsg(response.data['message']);
      Dio dio2 = new Dio();
//      var token = "kOJv9J1Vshrl6DetWxMoHt0LzGOr_g7VyEwwthzOcBBOR3Uosv3EbD2uM8ugka1HIeptkB5RuylHDCR_pYCzav8L8madITOCHDoaiji3XpDKBPBAywinYD3xAgAf9d7gljds99t7FiT0R0A-3i8ICWG0FSJzyFLi6StBbdOq2SYTSA50V3EXNLtw_5jI3njpIMwyEGu71WCFzUzEoWVaMxpcJ-rHUSYHNXm5GOqDs_GXaqlhfZWPmo7mKagwuav9FoHvdeQUylfH4vkplERfm9zPLr-Aj3vNoRCSQND6i86MridkzkpwqDNOJ7mVEzV-DOsLjioOecuGvprX4bnHse1gb9XyRFAGHsRJjiwa_Y_CF3aSV3YoqndTWJoT41kTpgsGKHKi7oO9eIAafSUmR8eS-Cpk8dyIg0fiaaC74rHymOEHPwZ2Nf_kZVp89J20EchkF1nP1CcGT641nYUH7kUBhDZgzvTANwJfl6yEPcodoYxQuwkWEVzjN4QRXkqamhH1N2y7pto-h2ouTRwvGjOJ0GwV72b4QE27-n42fvdPE1QeZPxOFdQXxjeGLP-M0du_adQJ27aotvz8zx_Xmjnlxlb2uc5Mbk1oMBehD6xOnnXBnz3qc7Bas7OuADJ_S9TFCEL8igV1HjryuBhNfDlqlmi5SU1Rkf4SywUPgPEhSjbeVCAeLQVuqkOBMCxCDxlMTlKWOwGY4nCwokU4tubFnrqWHQ0UVXqzFutkDIE";
      dio2.options.headers["Content-Type"] = 'application/json';
      dio2.options.headers["Authorization"] = "Bearer ${token}";
      var media_url = response.data['data'];
      Response postresponse = await dio2.post("https://favorestodevapi.azurewebsites.net/v.1/sbtiktok/post", data: {"description": "test","media_type_id": 0,"media_url": media_url,"mute": true,"location_name": "string","latitude": 0,"longitude": 0});
      print("Post video response: $postresponse");
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

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _videos.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChewiePlayer(
                            video: _videos[index],
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    child: new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Center(child: CircularProgressIndicator()),
                              Center(
                                child: ClipRRect(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: "https://cdn-2.tstatic.net/surabaya/foto/bank/images/sosok-dayana-cewek-kazakhstan-yang-viral-karena-mengajak-youtuber-fiki-naki-menikah.jpg",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          ListTile(
                            title: Text(_videos[index].description),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(
                  Icons.refresh
              ),
              onPressed: () async {
                var newVideos = await api.listenToVideos();
                setState(() {
                  if(newVideos!=null) {
                    _videos = newVideos;
                  }
                });
                  },
              heroTag: null,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: Icon(
                  Icons.add
              ),
              onPressed: () => _showPicker(context),
              heroTag: null,
            )
          ]
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }
}
