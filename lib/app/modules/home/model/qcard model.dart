
import 'dart:convert';

QCardModel qCardModelFromJson(String str) => QCardModel.fromJson(json.decode(str));

String qCardModelToJson(QCardModel data) => json.encode(data.toJson());

class QCardModel {
  String isSuccess;
  String message;
  Data data;

  QCardModel({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  QCardModel copyWith({
    String? isSuccess,
    String? message,
    Data? data,
  }) =>
      QCardModel(
        isSuccess: isSuccess ?? this.isSuccess,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory QCardModel.fromJson(Map<String, dynamic> json) => QCardModel(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String sqid;
  String firstName;
  String lastName;
  String email;
  String phone;
  String designation;
  String department;
  String gender;
  String officeCode;
  String webLink;
  bool webLinkVisibility;
  String linkedInLink;
  bool linkedInLinkVisibility;
  String officeAddress;

  Data({
    required this.id,
    required this.sqid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
    required this.gender,
    required this.officeCode,
    required this.webLink,
    required this.webLinkVisibility,
    required this.linkedInLink,
    required this.linkedInLinkVisibility,
    required this.officeAddress,
  });

  Data copyWith({
    int? id,
    String? sqid,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? designation,
    String? department,
    String? gender,
    String? officeCode,
    String? webLink,
    bool? webLinkVisibility,
    String? linkedInLink,
    bool? linkedInLinkVisibility,
    String? officeAddress,
  }) =>
      Data(
        id: id ?? this.id,
        sqid: sqid ?? this.sqid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        designation: designation ?? this.designation,
        department: department ?? this.department,
        gender: gender ?? this.gender,
        officeCode: officeCode ?? this.officeCode,
        webLink: webLink ?? this.webLink,
        webLinkVisibility: webLinkVisibility ?? this.webLinkVisibility,
        linkedInLink: linkedInLink ?? this.linkedInLink,
        linkedInLinkVisibility: linkedInLinkVisibility ?? this.linkedInLinkVisibility,
        officeAddress: officeAddress ?? this.officeAddress,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    sqid: json["SQID"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    email: json["Email"],
    phone: json["Phone"],
    designation: json["Designation"],
    department: json["Department"],
    gender: json["Gender"],
    officeCode: json["OfficeCode"],
    webLink: json["WebLink"],
    webLinkVisibility: json["WebLinkVisibility"],
    linkedInLink: json["LinkedInLink"],
    linkedInLinkVisibility: json["LinkedInLinkVisibility"],
    officeAddress: json["OfficeAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "SQID": sqid,
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "Phone": phone,
    "Designation": designation,
    "Department": department,
    "Gender": gender,
    "OfficeCode": officeCode,
    "WebLink": webLink,
    "WebLinkVisibility": webLinkVisibility,
    "LinkedInLink": linkedInLink,
    "LinkedInLinkVisibility": linkedInLinkVisibility,
    "OfficeAddress": officeAddress,
  };
}
