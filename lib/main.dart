import 'package:flutter/material.dart';
import 'package:tiktaktoie/Game%20Page/gamepage.dart';

void main(){
  runApp(TicktackToie());
}

class TicktackToie extends StatelessWidget {
  const TicktackToie({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Tick Tack Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Tick Tack Toe')),
        ),
        body: Gamepage(screenSize: screenSize),
      ),
    );
  }
}