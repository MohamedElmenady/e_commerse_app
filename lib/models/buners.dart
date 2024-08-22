class BannerModel {
  int? id;
  String? image;

  BannerModel.formJson({required Map<String, dynamic> data}) {
    id = data['id'];
    image = data['image'];
  }
}
