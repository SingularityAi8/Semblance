import 'dart:convert';
import 'package:http/http.dart' as http;

final url = Uri.parse('https://example.com/api/endpoint');

// Define the data to be sent in the request body
final data = {
  'username': 'john_doe',
  'password': 'secret123',
};

// Encode the data as JSON
final body = jsonEncode(data);

// Define the request headers
final headers = {
  'Content-Type': 'application/json',
};

// Send the HTTP POST request
final response = await http.post(url, body: body, headers: headers);

// Print the response status code and body
print('Status code: ${response.statusCode}');
print('Response body: ${response.body}');
