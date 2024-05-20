import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'KensakoumokuMasterPage.dart';
import 'Open_officeApp.dart';
import 'ChoukishomeiPage.dart';
import 'package:excel/excel.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'ToDoList.dart';
import 'ToiawaseListPage.dart';
import 'ShokuinMasterPage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:webview_windows/webview_windows.dart';
import 'BunshoOrderPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '電カル作業',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const MyHomePage(title: '電カル作業ハブ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //webview
  final _controller = WebviewController();
  
  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    await _controller.loadUrl(getAssetFileUrl('assets\\toilist3.html'));
    // await _controller.loadUrl('file://192.168.3.27/%E3%82%A2%E3%82%AF%E3%83%88%E5%BE%93%E6%A5%AD%E5%93%A1%E5%B0%82%E7%94%A8/%E2%98%86ACT%E3%83%95%E3%82%A9%E3%83%AB%E3%83%80/%E5%A4%AA%E7%94%B0/%E4%BD%9C%E6%88%90%E3%82%A2%E3%83%97%E3%83%AA/%E9%9B%BB%E3%82%AB%E3%83%AB%E3%82%88%E3%81%8F%E4%BD%BF%E3%81%84%E3%81%9D%E3%81%86%E3%81%AA%E3%82%84%E3%81%A4%E3%81%BE%E3%81%A8%E3%82%81/data/flutter_assets/assets/toilist2.html');
    
    // LISTEN DATA FROM HTML CONTENT
    _controller.webMessage.listen((event) {
      print(event);
    });
    if (!mounted) return;

    setState(() {});
  }

  Widget compositeView() {
    if (!_controller.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              Webview(_controller),
              StreamBuilder<LoadingState>(
                  stream: _controller.loadingState,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                      snapshot.data == LoadingState.loading) {
                      return LinearProgressIndicator();
                    } else {
                      return Container();
                    }
              }),
            ],
          ),
        ),
      );
    }
  }

  String getAssetFileUrl(String asset) {
    var assetsDirectory = p.join(p.dirname(Platform.resolvedExecutable),
        'data', 'flutter_assets', asset);
    
    if(Uri.file(assetsDirectory).toString().substring(0, 4) == 'UNC/'){
      var gaibupath = Uri.file(assetsDirectory).toString();
      gaibupath = gaibupath.replaceAll('UNC/', 'file://');
      return gaibupath;
    }
    // return Uri.decodeComponent(Uri.file(assetsDirectory).toString());
    return Uri.file(assetsDirectory).toString();
  }

  @override
  Widget build(BuildContext context) {
    My_Settings my_settings = My_Settings();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: compositeView(),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '項目',
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 239, 243, 239),
                ),
              ),
            ),
            ListTile(
              title: const Text('リモートデスクトップ'),
              onTap: () {
                OpenFile.open('C:\\WINDOWS\\system32\\mstsc.exe');
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('★電子カルテ問合せ対応表.xlsx'),
              onTap: () {
                //エクセル開く
                my_settings.openexcel('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\★電子カルテ問合せ対応表.xlsx');
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('電子カルテ問合せToDoリスト'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => ToDoListPage()
                ));
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('検査項目マスタ登録'),
               onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => KensakoumokuMasterPage()
                ));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('職員マスタメンテ'),
              onTap: () {
                // //エクセル開く
                // my_settings.openexcel('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\職員マスタメンテマニュアル.xlsx');
                Navigator.push(context, MaterialPageRoute(
                  // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => ShokuinMasterPage()
                ));
              },
            ),
            ListTile(
              title: const Text('文書オーダー'),
               onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => BunshoOrder()
                ));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('長期著名システム1日１回確認'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => CSMyHomePage()
                ));
                // Navigator.pop(context);
              },
            ),
            // ListTile(
            //   title: const Text('エクスプローラーテスト!'),
            //    onTap: () {
            //     Navigator.push(context, MaterialPageRoute(
            //       // （2） 実際に表示するページ(ウィジェット)を指定する
            //       builder: (context) => BunshoOrder()
            //     ));
            //     //Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

