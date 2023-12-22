import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:csv/csv.dart';

class ToDoListPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Todo();
  }

}

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}



class _TodoState extends State<Todo> {
  //final List<String> _todoList = ['HelloA', 'HelloB', 'HelloC'];//テストアイテム

  final TextEditingController editingController = TextEditingController();
  
  int listflag = 1;//1：全件・2：済・3：未

  String searchstr = "";//検索文字

  //常にスクロールバー出すのに使う
  final _scrollController = ScrollController();

  bool updownFlag = true;//昇順降順のフラグ

  // Import a csv flie
  Future<List<Widget>> csvList() async {
    final File importFile = new File("\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\太田\\電子カルテ問合せ対応表.csv");
    List<List> importList = [];
    final List<Widget> _todoWidgets = <Widget>[];
    
    Stream fread = importFile.openRead();

    // Read lines one by one, and split each ','
    await fread.transform(utf8.decoder).transform(LineSplitter()).listen(
      (String line) {
        importList.add(line.split(','));
      },
    ).asFuture();

    //最初の2行分削除
    importList.removeAt(0);
    importList.removeAt(0);
    if(!updownFlag) importList = importList.reversed.toList();
    for(List rowdata in importList){
      //検索に合うものだけwidget化
      var check = "";
      check = rowdata.firstWhere((element) => element.contains(searchstr), orElse: () => "");
      if(check == "") continue;

      if(rowdata[5].isNotEmpty && rowdata[6].isNotEmpty){
        _todoWidgets.add(
          Visibility(
            visible: caselistflag(rowdata[9]), 
            child:
              Card(
              margin: const EdgeInsets.all(7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    trailing: Text(
                      rowdata[9],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    leading: Text(
                      "No." + rowdata[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      )
                    ),//rowdata[9] != "済" ? Icon(Icons.report_problem) : Icon(Icons.thumb_up),
                    title: Padding(padding: const EdgeInsets.only(bottom: 15.0),
                    child : Text(
                        rowdata[1]+"　部署："+rowdata[3]+"　依頼者："+rowdata[4]+"　対応者："+rowdata[5],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      rowdata[6],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        //fontWeight: FontWeight.w600,
                      ),
                    ),
                    tileColor: rowdata[9] != "済" ? Colors.red[200] : Colors.green[50],
                    dense: true,
                    onTap: () => {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('対応状況'),
                            content: Text(rowdata[8]),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('OK')),
                            ],
                          );
                        }
                      )
                    },//onTap
                  ),
                ],
              ),
            ),
          ),
        );        
      }//if end

    }
    return _todoWidgets;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('電子カルテ問合せToDoリスト'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  // labelText: "検索",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: updownFlag ? const Text("⇅昇順") : const Text("⇅降順"),
                  onPressed: () => {
                    setState(() {
                      updownFlag = !updownFlag;
                    })
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: Text("全"),
                        onPressed: (){
                          setState(() {
                            listflag = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: listflag == 1 ? Colors.black : Colors.blue, //ボタンの背景色
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: Text("済"),
                        onPressed: (){
                          setState(() {
                            listflag = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: listflag == 2 ? Colors.black : Colors.blue, //ボタンの背景色
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: Text("未"),
                        onPressed: (){
                          setState(() {
                            listflag = 3;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: listflag == 3 ? Colors.black : Colors.blue, //ボタンの背景色
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
          Expanded(
            child: Container(
              //decoration: BoxDecoration(color: Colors.lightGreen),//背景色
              padding: EdgeInsets.only(top: 5, right: 20, bottom: 20, left: 20),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: FutureBuilder(
                  future: csvList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return
                      RawScrollbar(
                        thumbColor: Colors.blue,
                        thumbVisibility: true,
                        radius: const Radius.circular(60),
                        // thickness: 6,
                        controller: _scrollController,
                        child: ListView(
                          controller: _scrollController,
                          children: snapshot.data,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  //ビジブル真偽設定
  bool caselistflag(String liststatus) {
    switch (listflag) {
      case 1:
        return true;
      case 2:
        if(liststatus == "済"){return true;}else{return false;}
      case 3:
        if(liststatus != "済"){return true;}else{return false;}
    }
    return true;
  }

  //検索結果返す query:検索文字
  void filterSearchResults(String query) {
    setState(() {
      searchstr = query;
    });
  }

}//class _TodoState
