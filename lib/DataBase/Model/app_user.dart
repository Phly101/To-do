
class AppUser {
  String? authId;
  String? fullName;
  String? email;

  AppUser({required this.authId, required this.fullName, required this.email});

  AppUser.fromFireStore(Map<String, dynamic>? data) {
    authId = data?['authId'];
    fullName = data?['fullName'];
    email = data?['email'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'authId': authId,
      'fullName': fullName,
      'email': email,
    };
  }
}
