// To parse this JSON data, do
//
//     final createEmployeeRes = createEmployeeResFromJson(jsonString);

import 'dart:convert';

CreateEmployeeRes createEmployeeResFromJson(String str) => CreateEmployeeRes.fromJson(json.decode(str));

String createEmployeeResToJson(CreateEmployeeRes data) => json.encode(data.toJson());

class CreateEmployeeRes {
  String status;
  Data data;

  CreateEmployeeRes({
    required this.status,
    required this.data,
  });

  factory CreateEmployeeRes.fromJson(Map<String, dynamic> json) => CreateEmployeeRes(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  String name;
  String salary;
  String age;
  int id;

  Data({
    required this.name,
    required this.salary,
    required this.age,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    salary: json["salary"],
    age: json["age"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "salary": salary,
    "age": age,
    "id": id,
  };
}
