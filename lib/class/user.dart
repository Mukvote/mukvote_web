// class User{
//   final String uid;
//   final String upw;
//   User({this.uid, this.upw});
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       uid: json['id'],
//       upw: json['title'],
//     );
//   }
// }

class UserResult{
  final String result;
  UserResult({this.result});
  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      result: json['result'],
    );
  }
}