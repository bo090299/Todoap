import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => __Home_pageState();
}

class __Home_pageState extends State<Home_page> {
  final _mybox = Hive.box('mybox');
  int index1 = 0;

  bool islendi = true;
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
                  labelText: data[index]['text'],
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
                        if (controller.text.trim().isEmpty) {
                          setState(() {
                            Bosluk();
                          });
                        } else {
                          _mybox.putAt(
                              index, {'text': controller.text, 'done': false});
                          controller.clear();
                          Navigator.pop(context);
                        }
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

  void Bosluk() {
    Get.dialog(AlertDialog(
      title: Text('Yalnyslyk?'),
      content: Text('Boslugy dolduryn!'),
      actions: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Ok',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              )),
        ),
      ],
    ));
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
                        if (controller.text.trim().isEmpty) {
                          setState(() {
                            Bosluk();
                          });
                        } else {
                          _mybox.add({'text': controller.text, 'done': false});
                          controller.clear();
                        }
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
  void sheet(int index){
    Get.bottomSheet(Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 177, 185, 155),
                          width: 4),
                    ),
                    child: Image.network(
                        'https://t4.ftcdn.net/jpg/01/05/90/77/360_F_105907729_4RzHYsHJ2UFt5koUI19fc6VzyFPEjeXe.jpg'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data[index]['text'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('''            Before serving, consider offering the
        customer some recommended additions'''),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              data[index]['done'] = true;
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Active',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              data[index]['done'] = false;
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Disactive',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ));
  }
  @override
  void getdialog() {
    Get.dialog(AlertDialog(
      title: Text('Are you sure?'),
      content: Text('''Do you realy want to delete 
        your information? You will not be
        able to undo this action'''),
      actions: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mybox.deleteAt(index1);
                  Navigator.pop(context);
                });
              },
              child: Text('Yes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue))),
        )
      ],
    ));
  }
List data = [];
void getdata(){
  data =_mybox.values.toList();
  for (var i in data) {
    if (islendi == true) {
      if (i['done']==true) {
     data.add(i); 
    }
    }
  }
   islendi = !islendi;
  setState(() {
    
  });
}
@override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todoapp"),
        actions: [
          Checkbox(
              value: islendi,
              onChanged: (bool? newValue) {
                
                 
                
             
             getdata(); })
        ],
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(color: Colors.yellow, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: 
          ListTile(
            onTap: () {
              setState(() {
                sheet(index);
              });
            },
            title: Text(
              data[index]['text'],
              style: TextStyle(
                  decoration: data[index]['done']
                      ? TextDecoration.lineThrough
                      : null),
            ),
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
                      index1 = index;
                      getdialog();
                    });
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
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
