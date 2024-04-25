import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sample_by_iot/input_todos.dart';
import 'package:flutter_sample_by_iot/service.dart' as service;

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: DefaultAppBar(),
        body: Column(
          children: [
            const FirstSection(),
            Expanded(
                child: FutureBuilder(
              future: service.readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final todo = snapshot.data![index];
                      return ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Row(
                            children: [
                              Checkbox(
                                value: todo.isCompleted,
                                onChanged: (value) {
                                  service.updateData(
                                    id: todo.id,
                                    title: todo.title,
                                    isCompleted: !todo.isCompleted,
                                  );
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    service.deleteData(id: todo.id);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ))
          ],
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputTodos(),
              ),
            );
          });
        }),
      ),
    );
  }
}

class FirstSection extends StatelessWidget {
  const FirstSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.0,
                spreadRadius: 0.5,
                blurStyle: BlurStyle.outer,
              )
            ]),
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '경복대학교 소프트웨어융합과',
              style: _textStyle(),
              textAlign: TextAlign.start,
            ),
            Text(
              '2459007 이재규',
              style: _textStyle(),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _textStyle() => const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
AppBar DefaultAppBar() {
  return AppBar(
    title: const Text(
      '플루터란 무엇인가?',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blue,
  );
}
