import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => __Home_pageState();
}

class __Home_pageState extends State<Home_page> {
  final _mybox = Hive.box('mybox');
  TextEditingController controller = TextEditingController();

  void update_task(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.amber,
        content: SizedBox(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _mybox.putAt(index, controller.text);
                        controller.clear();
                      });
                    },
                    child: Icon(Icons.update),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.back_hand),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void new_task() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.amber,
        content: SizedBox(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _mybox.add(controller.text);
                        controller.clear();
                      });
                    },
                    child: Icon(Icons.insert_drive_file_rounded),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.back_hand),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todoapp"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _mybox.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_mybox.values.toList()[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              ElevatedButton(
                onPressed: () {
                 update_task(index);
                },
                child: Icon(Icons.update_disabled),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _mybox.deleteAt(index);
                  });
                },
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          new_task();
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}
