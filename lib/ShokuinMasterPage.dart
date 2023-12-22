import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:side_navigation/side_navigation.dart';
import 'Open_officeApp.dart';

class ShokuinMasterPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ShokuinMaster();
  }

}

class ShokuinMaster extends StatefulWidget {
  const ShokuinMaster({Key? key}) : super(key: key);

  @override
  _ShokuinMasterState createState() => _ShokuinMasterState();
}


class _ShokuinMasterState extends State<ShokuinMaster> {
  late PdfViewerController _pdfViewerController;
  My_Settings my_settings = My_Settings();

  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  int _actualPageNumber = 1, _allPagesCount = 0;

  double _Pagesize = 1.0;


  @override
  Widget build(BuildContext context) {
    double screenWidthO = MediaQuery.of(context).size.width;
    double appbarheight = AppBar().preferredSize.height;

    return Scaffold(
      backgroundColor:Colors.grey,
      appBar: AppBar(
        // 以下の2つが無いと、サイズオーバーのエラーになる
        // leadingWidth: screenWidthO * 0.1,
        // titleSpacing: 0.0,

        centerTitle: true,
        title : Column(
          children: [
            Text("職員マスタ作業"),
            Text(
              '$_actualPageNumber/${_allPagesCount}',
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
        // actions: <Widget>[
        //   IconButton(
        //     padding:EdgeInsets.fromLTRB(20, 0, 20, 0),
        //     icon: Icon(
        //       Icons.connected_tv,
        //       color: Colors.white,
        //       size: appbarheight * 0.8
        //     ),
        //     onPressed: () {
        //       OpenFile.open('C:\\WINDOWS\\system32\\mstsc.exe');
        //     },
        //   ),
        //   IconButton(
        //     padding:EdgeInsets.fromLTRB(20, 0, 20, 0),
        //     icon: Icon(
        //       Icons.zoom_in,
        //       color: Colors.white,
        //       size: appbarheight * 0.8
        //     ),
        //     onPressed: () {
        //       if(_Pagesize < 3.0)_Pagesize = _Pagesize + 0.1;
        //       _pdfViewerController.zoomLevel = _Pagesize;
        //     },
        //   ),
        //   IconButton(
        //     padding:EdgeInsets.fromLTRB(20, 0, 20, 0),
        //     icon: Icon(
        //       Icons.zoom_out,
        //       color: Colors.white,
        //       size: appbarheight * 0.8
        //     ),
        //     onPressed: () {
        //       if(_Pagesize > 1.0)_Pagesize = _Pagesize - 0.1;
        //       _pdfViewerController.zoomLevel = _Pagesize;
        //     },
        //   ),
        // ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: SfPdfViewer.asset(
                'assets/staff_master_maintenance.pdf',
                controller: _pdfViewerController,
                enableDoubleTapZooming: true,
                canShowPaginationDialog: true,
                onPageChanged: (page) {
                  setState(() {
                  _actualPageNumber = page.newPageNumber;
                  });
                },
                onDocumentLoaded: (PdfDocumentLoadedDetails details){
                  setState(() {
                    _allPagesCount = _pdfViewerController.pageCount;
                  });
                }
              ),
            ),
          ),
          SideNavigationBar(
            selectedIndex: 0,
            items: const [
              SideNavigationBarItem(
                icon: Icons.connected_tv,
                label: 'リモート接続',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: '新着者登録リストまとめ.xlsx',
              ),
              SideNavigationBarItem(
                icon: Icons.settings,
                label: '移動・変更者登録チェック表.xlsx',
              ),
              SideNavigationBarItem(
                icon: Icons.zoom_in,
                label: '拡大',
              ),
              SideNavigationBarItem(
                icon: Icons.zoom_out,
                label: '縮小',
              ),
              SideNavigationBarItem(
                icon: Icons.north,
                label: '前のページ',
              ),
              SideNavigationBarItem(
                icon: Icons.south,
                label: '次のページ',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  OpenFile.open('C:\\WINDOWS\\system32\\mstsc.exe');
                  break;
                case 1:
                  // my_settings.openexcel('\\\\192.168.3.25\\Share\\ICカードリーダー出入口登録\ICカード職員データ移行\\ICカード職員データ移行\\2020.11.18以降追加職員分\\新着登録資料　Art\\新着者登録リストまとめ.xlsx');
                  OpenFile.open('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\新着者登録リストまとめ.xlsx - ショートカット.lnk');
                  break;
                case 2:
                  my_settings.openexcel('\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\移動・変更者登録チェック表.xlsx');
                  break;
                case 3:
                  if(_Pagesize < 3.0)_Pagesize = _Pagesize + 0.1;
                  _pdfViewerController.zoomLevel = _Pagesize;
                  break;
                case 4:
                  if(_Pagesize > 1.0)_Pagesize = _Pagesize - 0.1;
                  _pdfViewerController.zoomLevel = _Pagesize;
                  break;
                case 5:
                  _pdfViewerController.previousPage();
                  break;
                case 6:
                 _pdfViewerController.nextPage();
                  break;
                default:
                  
              }
              // setState(() {});
            },
            theme: SideNavigationBarTheme(
              backgroundColor: Colors.blue,
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              itemTheme: SideNavigationBarItemTheme(
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                iconSize: 35,
                labelTextStyle: TextStyle(
                  fontSize: 20,
                )
              ),
              dividerTheme: SideNavigationBarDividerTheme.standard(),
            ),
          ),
        ],
      ), 
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     FloatingActionButton(
      //       heroTag: 'prepage',
      //       onPressed: () async {
      //         _pdfViewerController.previousPage();
      //       },
      //       child: Icon(
      //         Icons.north,
      //         color: Colors.white,
      //         ),
      //     ),
      //     SizedBox(height: 30),
      //     FloatingActionButton(
      //       heroTag: 'nxtpage',
      //       child: Icon(
      //         Icons.south,
      //         color: Colors.white,
      //         ),
      //       onPressed: () async {
      //         _pdfViewerController.nextPage();
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
