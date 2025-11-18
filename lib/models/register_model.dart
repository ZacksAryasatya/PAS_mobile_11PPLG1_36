class RegisterModel {
  bool status;
  String message;

  RegisterModel({required this.status, required this.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'] == true || json['status'] == 'success',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'message': message};
}
