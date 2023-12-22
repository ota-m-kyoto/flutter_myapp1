import 'package:flutter/material.dart';

import 'Open_officeApp.dart';

class KensakoumokuMasterPage extends StatelessWidget{

  My_Settings my_settings = My_Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("検査項目マスタ作業")
      ),
      body : 
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  my_settings.openppt('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\MIRAIsマスタ_検査項目マニュアル\\MIRAIsマスタメンテナンス_検査項目マニュアル.pptx');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("MIRAIsマスタメンテナンス_検査項目マニュアル.pptx",style: TextStyle(fontSize: 30.0),)
              ),

              const SizedBox(height: 30),//隙間

              TextButton(
                onPressed: () {
                  my_settings.openppt('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\MIRAIsマスタ_検査項目マニュアル\\MIRAIsマスタメンテナンス_検査セットマニュアル.pptx');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("MIRAIsマスタメンテナンス_検査セットマニュアル.pptx",style: TextStyle(fontSize: 30.0),)
              ),

              const SizedBox(height: 30),//隙間

              TextButton(
                onPressed: () {
                  my_settings.openpdf('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\MIRAIsマスタ_検査項目マニュアル\\ファルコ2022検査項目の本.pdf');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("ファルコ2022検査項目の本.pdf",style: TextStyle(fontSize: 30.0),)
              ),

              const SizedBox(height: 30),//隙間

              TextButton(
                onPressed: () {
                  my_settings.openexcel('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\MIRAIsマスタ_検査項目マニュアル\\項目マスタ.xls');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("項目マスタ.xls",style: TextStyle(fontSize: 30.0),)
              ),

              const SizedBox(height: 30),//隙間

              TextButton(
                onPressed: () {
                  my_settings.openexcel('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\MIRAIsマスタ_検査項目マニュアル\\項目マスタ_20221022');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("項目マスタ_20221022",style: TextStyle(fontSize: 30.0),)
              ),
            ],
            
            
          ),
        ),
      
    );
  }
}

