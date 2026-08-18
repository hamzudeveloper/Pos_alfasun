// login_response_model.dart

class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponse({required this.success, required this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String userType;
  final UserModel user;
  final List<String> roles;
  final BranchModel? branch; // Made optional in case it returns null
  final String token;

  LoginData({
    required this.userType,
    required this.user,
    required this.roles,
    this.branch,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      userType: json['user_type'] ?? '',
      // Safe check: Ensure json['user'] is actually a Map before parsing
      user: json['user'] != null && json['user'] is Map<String, dynamic>
          ? UserModel.fromJson(json['user'])
          : UserModel.empty(),
      roles: json['roles'] != null ? List<String>.from(json['roles']) : [],
      // Safe check for branch
      branch: json['branch'] != null && json['branch'] is Map<String, dynamic>
          ? BranchModel.fromJson(json['branch'])
          : null,
      token: json['token'] ?? '',
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  factory UserModel.empty() => UserModel(id: 0, name: '', email: '');
}

class BranchModel {
  final int id;
  final String name;
  final String code;

  BranchModel({required this.id, required this.name, required this.code});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
