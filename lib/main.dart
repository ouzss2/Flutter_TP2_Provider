import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>ToDoModel(),
  child: MyApp(),));
}
class ToDoModel extends ChangeNotifier{
  List<String> _items = [];
  List<String> get _list => _items;


  _AddElement(String task){
    _items.add(task);
    print(_items);
    notifyListeners();
  }

  _DeleteElement(int index){
    _items.removeAt(index);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ToDoHome(),
    );
  }
}


class ToDoHome extends StatelessWidget{

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
   appBar: AppBar(title: Text('"ToDo List'),
   backgroundColor: Colors.green,),
    body: Column(
      children: [
        ToDoinput(),
        ToDoCount(),
        ToDoList()
      ]
    )
    );
  }
}

class ToDoinput extends StatelessWidget{
TextEditingController  controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
         Padding(padding: EdgeInsets.all(15),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Enter Task ",
        border: OutlineInputBorder()
      ),
    ),
    
    ),
    ElevatedButton(onPressed: (){
   if (controller.text.isNotEmpty){
    Provider.of<ToDoModel>(context,listen: false)._AddElement(controller.text);
   }

    }, child: Text("Add Task"))
      ],
    );
  }
}

class ToDoCount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<ToDoModel>(context)._list.length;
    return Text("$counter Elements",
    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),);
  }
}

class ToDoList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final lst = Provider.of<ToDoModel>(context)._list;
    // TODO: implement build
    return Expanded(child: ListView.builder(
      itemCount: lst.length,
      itemBuilder: (context,index){
        return ListTile(
          title: Text(lst[index]),
          onLongPress: (){
            Provider.of<ToDoModel>(context,listen: false)._DeleteElement(index);
          },
        );
    }))
;  }
}
