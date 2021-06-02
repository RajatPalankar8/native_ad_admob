import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> images = ['images/img1.jpg','images/img2.jpg','images/img3.jpeg','images/img4.jpg','images/img5.jpg'];

  List<Object> dataads;


  @override
  void initState() {
    super.initState();
    setState(() {
      dataads = List.from(images);

      for(int i = 0;i<2;i++){
        var min = 1;
        var rm = new Random();

        //generate a random number from 2 to 4 (+ 1)
        var rannumpos = min + rm.nextInt(4);

        //and add the banner ad to particular index of arraylist
        dataads.insert(rannumpos, nativeAdWidget());
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dataads.length,itemBuilder: (context,index){
                if(dataads[index] is String)
                  {
                    return  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(dataads[index])
                  );

                  }else{
                  return  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: dataads[index] as nativeAdWidget
                  );
                }

          }),
        )
    );
  }
}

class nativeAdWidget extends StatelessWidget {

  final _controller = NativeAdmobController();
  @override
  Widget build(BuildContext context) {
    return NativeAdmob(
      adUnitID: "ca-app-pub-3940256099942544/2247696110",
      loading: Center(child: CircularProgressIndicator()),
      error: Text("Failed to load the ad"),
      controller: _controller,
      type: NativeAdmobType.full,
      options: NativeAdmobOptions(
        ratingColor: Colors.red,
        showMediaContent: true,
        callToActionStyle: NativeTextStyle(
            color: Colors.red,
            backgroundColor: Colors.black
        ),
        headlineTextStyle: NativeTextStyle(
          color: Colors.blue,

        ),

        // Others ...
      ),
    );
  }
}


