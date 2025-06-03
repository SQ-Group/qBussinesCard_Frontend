import 'dart:convert';

class QCardModel {
  String? isSuccess;
  String? message;
  Data? data;

  QCardModel({
    this.isSuccess,
    this.message,
    this.data,
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

  factory QCardModel.fromRawJson(String str) => QCardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QCardModel.fromJson(Map<String, dynamic> json) => QCardModel(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? sqid;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? designation;
  String? department;
  String? gender;
  String? webLink;
  bool? webLinkVisibility;
  String? linkedInLink;
  bool? linkedInLinkVisibility;

  Data({
    this.id,
    this.sqid,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.designation,
    this.department,
    this.gender,
    this.webLink,
    this.webLinkVisibility,
    this.linkedInLink,
    this.linkedInLinkVisibility,
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
    String? webLink,
    bool? webLinkVisibility,
    String? linkedInLink,
    bool? linkedInLinkVisibility,
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
        webLink: webLink ?? this.webLink,
        webLinkVisibility: webLinkVisibility ?? this.webLinkVisibility,
        linkedInLink: linkedInLink ?? this.linkedInLink,
        linkedInLinkVisibility: linkedInLinkVisibility ?? this.linkedInLinkVisibility,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
    webLink: json["WebLink"],
    webLinkVisibility: json["WebLinkVisibility"],
    linkedInLink: json["LinkedInLink"],
    linkedInLinkVisibility: json["LinkedInLinkVisibility"],
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
    "WebLink": webLink,
    "WebLinkVisibility": webLinkVisibility,
    "LinkedInLink": linkedInLink,
    "LinkedInLinkVisibility": linkedInLinkVisibility,
  };
}
