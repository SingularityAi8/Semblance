import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatApp extends StatefulWidget {

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {

  // A controller for the text input field
  final TextEditingController _textController = TextEditingController();

  // A list of chat messages
  final List<String> _messages = [];

  // Adds the submitted message to the list of messages and clears the text input field
  void _handleSubmitted(String text) {
    setState(() {
      _messages.add(text);
      // Send a POST request with the text in the text field
      _sendPostRequest('http://leexingyang.pythonanywhere.com/user', _textController.text);
    });
  }

  // Sends a POST request to the specified URL with the text in the request body
  void _sendPostRequest(String url, String text) async {
    // Send a POST request to the specified URL with the text in the request body
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{'text': text}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    _textController.clear();
  }

  // Builds the text input field and submit button
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Hello,\nmy name is Semblance 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const Text(
                        'What can I help you with?',
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 30,
                        )
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        reverse: true,
                        itemCount: _messages.length,
                        itemBuilder: (_, int index) => _buildMessage(_messages[index]),
                      ),
                    ),
                    // The divider and text input field
                    const Divider(height: 1.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      child: _buildTextComposer(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(message,
        style: const TextStyle(
          color:Colors.white,
        ),),
    );
  }
}

