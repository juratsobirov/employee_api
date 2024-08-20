import 'package:employee_again/models/employee_list_res.dart';
import 'package:employee_again/services/http_service.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  bool isLoading = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _ageController = TextEditingController();


  _createEmployee(Employee employee) async{
    setState(() {
      isLoading = true;
    });
    var response = await Network.POST(Network.API_EMPLOYEE_CREATE, Network.paramsCreate(employee));
    setState(() {
      isLoading = false;
    });
    if(response != null){
      var status = Network.parseCreateEmployee(response!);
      if(status == "success"){
        _backToFinish();
      }
    }else{
      _backToFinish();
    }
    }

  _backToFinish(){
    Navigator.of(context).pop(true);
  }

  _createNewEmployee(){
    String name = _nameController.text.toString().trim();
    String salaryStr = _salaryController.text.toString().trim();
    String ageStr = _ageController.text.toString().trim();

    int salary = int.parse(salaryStr);
    int age = int.parse(ageStr);

Employee employee = Employee(employeeName: name, employeeSalary: salary, employeeAge: age);
  _createEmployee(employee);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Create Page"),
      ),
      body:Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child:Column(
              children:[
                TextField(
                  controller: _nameController,
                  decoration:InputDecoration(
                    hintText:"Input Name",
                  ),
                ),

                TextField(
                  controller: _salaryController,
                  decoration:InputDecoration(
                    hintText:"Input Salary",
                  ),
                ),

                TextField(
                  controller: _ageController,
                  decoration:InputDecoration(
                    hintText:"Input Age",
                  ),
                ),

                Container(
                  width:double.infinity,
                  child: MaterialButton(
                    onPressed:(){
                       _createNewEmployee();
                    },
                    color: Colors.blue,
                    child:Text("Create"),
                  ),
                ),
              ],
            ),
          ),

          isLoading ? Center(child:CircularProgressIndicator()):SizedBox.shrink(),
        ],
      ),
    );
  }
}
