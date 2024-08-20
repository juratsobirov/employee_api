
import 'dart:convert';

import 'package:employee_again/models/create_employee_res.dart';
import 'package:http/http.dart';

import '../models/employee_list_res.dart';

class Network{
  static bool isTester = true;
  static String SERVER_DEV = "dummy.restapiexample.com";
  static String SERVER_PROD = "dummy.restapiexample.com";

  static String getServer(){
    if(isTester){
      return SERVER_DEV;
    }
    return SERVER_PROD;
  }

  static Map<String, String> headers = {'Context-Type': 'application/json; charset=UTF-8'};

  /* Http Requests */

  static Future<String?> GET(String api,Map<String, String> params)async{
    var url = Uri.https(getServer(), api, params);
    var response = await get(url, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params)async{
    var url = Uri.https(getServer(), api);
    var response = await post(url, headers: headers, body:jsonEncode(params));
    if(response.statusCode == 200 || response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  /* Http Apis */
static String API_EMPLOYEE_LIST = "/api/v1/employees";
static String API_EMPLOYEE_CREATE = "/api/v1/create";
static String API_EMPLOYEE_UPDATE = "/api/v1/update/"; //{id}
static String API_EMPLOYEE_DELTE = "/api/v1/delete/";  //{id}


/* Http Params */
static Map<String, String> paramsEmpty(){
  Map<String, String> params = Map();
  return params;
}

static Map<String, String> paramsCreate(Employee employee){
  Map<String,String> params = {};
  params.addAll({
    "name":employee.employeeName,
    "salary":employee.employeeSalary.toString(),
    "age":employee.employeeAge.toString(),
  });
  return params;
}


/* Http Parsing */
static List<Employee> parseEmployeeList(String response){
  dynamic json = jsonDecode(response);
  var employeeListRes = EmployeeListRes.fromJson(json);
  return employeeListRes.data;
}

static String parseCreateEmployee(String response){
  dynamic json = jsonDecode(response);
  var res = CreateEmployeeRes.fromJson(json);
  return res.status;
}
}