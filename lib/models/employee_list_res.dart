// To parse this JSON data, do
//
//     final employeeListRes = employeeListResFromJson(jsonString);

import 'dart:convert';

EmployeeListRes employeeListResFromJson(String str) => EmployeeListRes.fromJson(json.decode(str));

String employeeListResToJson(EmployeeListRes data) => json.encode(data.toJson());

class EmployeeListRes {
  String status;
  List<Employee> data;
  String message;

  EmployeeListRes({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EmployeeListRes.fromJson(Map<String, dynamic> json) => EmployeeListRes(
    status: json["status"],
    data: List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Employee {
  int? id;
  String employeeName;
  int employeeSalary;
  int employeeAge;
  String? profileImage;

  Employee({
    this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    this.profileImage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    employeeName: json["employee_name"],
    employeeSalary: json["employee_salary"],
    employeeAge: json["employee_age"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
    "employee_salary": employeeSalary,
    "employee_age": employeeAge,
    "profile_image": profileImage,
  };
}
