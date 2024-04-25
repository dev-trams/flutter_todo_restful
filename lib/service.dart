import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_sample_by_iot/model.dart';
import 'package:http/http.dart' as http;

Future<void> createTodo({value}) async {
  var url = Uri.parse('http://echo.api.ctrls-studio.com/todos');

  try {
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': value}));

    if (response.statusCode == 200) {
      print('Todo successfully created');
    } else {
      print('Failed to create todo. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

Future<List<TodoModel>> readData() async {
  var url = Uri.parse('http://echo.api.ctrls-studio.com/todos');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      List<dynamic> jsonResponse = jsonDecode(body);
      List<TodoModel> todoModel =
          jsonResponse.map((e) => TodoModel.fromJson(e)).toList();
      print(body);

      return todoModel;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Error $e');
  }
}

Future<void> updateData({title, id, isCompleted}) async {
  var url = Uri.parse('http://echo.api.ctrls-studio.com/todos/$id');
  debugPrint(url.toString());
  try {
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'isCompleted': isCompleted}),
    );
    if (response.statusCode == 200) {
      debugPrint('업데이트 성공');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> deleteData({id}) async {
  var url = Uri.parse('http://echo.api.ctrls-studio.com/todos/$id');
  try {
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      print('삭제 성공');
    }
  } catch (e) {
    Exception(e);
  }
}
