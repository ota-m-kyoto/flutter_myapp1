import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:path/path.dart';

import 'Open_officeApp.dart';


class BunshoOrderPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BunshoOrder();
  }

}

class BunshoOrder extends StatefulWidget {
  const BunshoOrder({Key? key}) : super(key: key);

  @override
  _BunshoOrderState createState() => _BunshoOrderState();
}


class _BunshoOrderState extends State<BunshoOrder> {
  final String basepath = '\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\文書オーダー';
  late String pathstr = basepath;
  List file = [];
  final My_Settings my_settings = My_Settings();
  
  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  void _listofFiles() async {
    setState(() {
      String viewpath = pathstr;
      file = io.Directory(viewpath).listSync().toList()..sort((l, r) => l.statSync().toString().compareTo(r.statSync().toString()));
    });
  }


  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:Colors.white,
      appBar: AppBar(
        title : const Text('文書オーダー'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {OpenFile.open(pathstr);},
            style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.yellow,
                    elevation: 16,
                    padding:const EdgeInsets.all(5),
                  ),
            child: const Text(
              'OPEN\nEXPLORER',
              textAlign:TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            _buildDirPathButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _buildGridList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildGridList() {
    return ResponsiveGridList(
        rowMainAxisAlignment: MainAxisAlignment.start,
        desiredItemWidth: 150,
        minSpacing: 30,
        children: file.map((value) {
          return
          GestureDetector(
            child: Container(
              height: 150,
              alignment: const Alignment(0, 0),
              color: Colors.grey[300],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  value.runtimeType.toString() == '_Directory' ? Icon(Icons.folder, size: 50,) : Icon(Icons.task, size: 50,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                    basename(value.path.toString()),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
                  ),
                  ),
                ],
              ),
            ),
            onDoubleTap: () {
              switch(p.extension(value.path.toString())){
                case '.pdf':
                  my_settings.openpdf(value.path.toString());
                break;
                case '.ppt':
                  my_settings.openppt(value.path.toString());
                break;
                case '.xlsx':
                  my_settings.openexcel(value.path.toString());
                break;
                case '.xlsm':
                  my_settings.openexcel(value.path.toString());
                break;
                case '.doc':
                  my_settings.opendoc(value.path.toString());
                break;
                case '.docm':
                  my_settings.opendoc(value.path.toString());
                break;
                default:
                  
                break;
              }
              if(value.runtimeType.toString() == '_Directory'){
                setState(() {
                  pathstr = value.path.toString();
                  _listofFiles();
                });
              }
            },
          ); 
        }).toList());
  }

  Widget _buildDirPathButton(){
    List pathlist = pathstr.split('\\');
    int bunshoindex = pathlist.indexWhere((element) => element == '文書オーダー');
    String linkstr = basepath;
    return Row(
      children: [
        for(int i = bunshoindex; i <= pathlist.length-1; i++)...{
          TextButton(
            style: ButtonStyle(
              //ボタンのスタイル
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              setState(() {
                if(pathlist[i] != '文書オーダー'){
                  for(int j = bunshoindex+1; j <= i; j++){
                    linkstr = linkstr + '\\' + pathlist[j];
                  }
                }
                pathstr = linkstr;
                _listofFiles();
              });
            },
            child: Text(
              bunshoindex == pathlist.length-1 ? '\\'+pathlist[i] : '\\'+pathlist[i]+' ▶',
              style: TextStyle(
                color: Colors.black
              ),
            ),
          )
        }
      ],
    );
  }

}//_BunshoOrderState