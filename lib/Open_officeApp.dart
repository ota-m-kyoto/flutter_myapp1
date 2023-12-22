import 'package:flutter/material.dart';
import 'package:flutter_myapp1/main.dart';
import 'package:excel/excel.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';
//追加
class My_Settings {
  String denkarupath = '\\\\192.168.3.27\\アクト従業員専用\\☆ACTフォルダ\\東山電子カルテ\\';

  void openexcel(String excelpath){
    String win10Path = 'C:\\Program Files\\Microsoft\ Office\\Office16\\EXCEL.EXE';
    //String win7Path = 'C:\\progra~2\\micros~1\\Office14\\EXCEL.EXE';
    try {
      Process.run(win10Path, [excelpath]).then((ProcessResult results) {
        print(results.stdout);
      });
    } catch (e) {
      print(e);
    }
  }

  void openpdf(String pdfpath){
    // String testeAcrobat = 'C:\\Program Files (x86)\\Adobe\\Acrobat Reader DC\\Reader\\AcroRd32.exe';
    String testeAcrobat = 'C:\\Program Files\\Adobe\\Acrobat DC\\Acrobat\\Acrobat.exe';
    try {

      ///path of the pdf file to be opened.
      Process.run(testeAcrobat, [pdfpath]).then((ProcessResult results) {
        print(results.stdout);
      });
    } catch (e) {
      print(e);
    }
  }

  void openppt(String pptpath){
    String testeAcrobat = 'C:\\Program Files\\Microsoft Office\\Office16\\POWERPNT.EXE';
    try {

      ///path of the pdf file to be opened.
      Process.run(testeAcrobat, [pptpath]).then((ProcessResult results) {
        print(results.stdout);
      });
    } catch (e) {
      print(e);
    }
  }

  void opendoc(String pptpath){
    String testeAcrobat = 'C:\\Program Files\\Microsoft Office\\Office16\\WINWORD.EXE';
    try {

      ///path of the pdf file to be opened.
      Process.run(testeAcrobat, [pptpath]).then((ProcessResult results) {
        print(results.stdout);
      });
    } catch (e) {
      print(e);
    }
  }

}