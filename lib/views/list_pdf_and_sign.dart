import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
//import package files

/*
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPDFList(), //call MyPDF List file
    );
  }
}
*/

//apply this class on home: attribute at MaterialApp()
class MyPDFList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyPDFList(); //create state
  }
}

class _MyPDFList extends State<MyPDFList>{
  var files;

  void getFiles() async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["pdf"] //optional, to filter files, list only pdf files
    );
    setState(() {}); //update the UI
  }
  void myInitState()async{
    if (await Permission.storage.request().isGranted){
      // Either the permission was already granted before or the user just granted it.
      getFiles(); //call getFiles() function on initial state.
    }
  }

  Future<void> initPlatformState() async {

    // Platform messages may fail, so we use a try/catch PlatformException.

    PdftronFlutter.initialize("Insert commercial license key here after purchase");

  }


  @override
  void initState() {
    myInitState();
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text("Fichiers PDF"),
            backgroundColor: Colors.blue
        ),
        body:files == null? Center(child: Text("Recherche des fichiers...")):
        ListView.builder(  //if file/folder list is grabbed, then show here
          itemCount: files?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
                child:ListTile(
                  title: Text(files[index].path.split('/').last),
                  leading: CircleAvatar(child: Image.asset("assets/index.png"),radius: 30,backgroundColor: Colors.white,),
                  trailing: Icon(Icons.arrow_forward, color: Colors.blue,),
                  onTap: (){
                    PdftronFlutter.openDocument(files[index].path.toString());
                    /*  Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ViewPDF(pathPDF:files[index].path.toString());
                      //open viewPDF page on click
                    }));*/
                  },
                )
            );
          },
        )
    );
  }
}

/*
class ViewPDF extends StatelessWidget {
  String pathPDF = "";
  ViewPDF({this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold( //view PDF
        appBar: AppBar(
          title: Text("Document"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        path: pathPDF
    );
  }
}*/
