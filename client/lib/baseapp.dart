import 'package:flutter/material.dart';

class BaseApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Choose bot',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
            AssetImage('assets/space.jpg'),
            fit:BoxFit.cover,
          ),
        ),
        child: Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:[
                  Colors.black87,
                  Colors.black12,
                  Colors.black87,
                ]
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ChatApp');
                  },
                  child: const Text('Go to Chatbot'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/VocalApp');
                  },
                  child: const Text('Go to Listener'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

