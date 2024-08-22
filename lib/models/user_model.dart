class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;

  UserModel.fromJson({required Map<String, dynamic> data}) {
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
  }
}
