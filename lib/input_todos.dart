import 'package:flutter/material.dart';
import 'package:flutter_sample_by_iot/main.dart';
import 'package:flutter_sample_by_iot/service.dart' as service;

class InputTodos extends StatelessWidget {
  InputTodos({super.key});
  final _TextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey.shade300),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '할일 작성',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      controller: _TextEditingController,
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  service
                      .createTodo(value: _TextEditingController.text)
                      .then((value) {
                    print('등록 성공');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const App(),
                        ));
                  });
                },
                child: const Text(
                  '등록',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
