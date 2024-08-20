import 'package:employee_again/models/employee_list_res.dart';
import 'package:employee_again/services/http_service.dart';
import 'package:flutter/material.dart';

import 'create_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Employee> items = [];

  _loadEmployeeList() async {
    setState((){
      isLoading = true;
    });
    var response = await Network.GET(Network.API_EMPLOYEE_LIST, Network.paramsEmpty());
    if(response != null){
      List<Employee> employees = Network.parseEmployeeList(response);
      setState(() {
        isLoading = false;
        items = employees;
      });
    }else{
      setState((){
        items.add(Employee(employeeName: "Yunus", employeeSalary: 2000, employeeAge: 24));
        items.add(Employee(employeeName: "Zubayr", employeeSalary: 3000, employeeAge: 25));
      });
      }
    print(items.length);
  }

  _openCreatePage() async{
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
      return CreatePost();
    }));

    if(result){
      _loadEmployeeList();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Employee List"),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemOfListEmployee(items[index]);
              }),
          isLoading ? Center(child:CircularProgressIndicator()): SizedBox.shrink(),
        ],
      ),

      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed:(){
         _openCreatePage();
        },
        child:Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget itemOfListEmployee(Employee employee) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      height: 100,
      color: Colors.cyan,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                employee.employeeName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                employee.employeeAge.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(
            employee.employeeSalary.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
