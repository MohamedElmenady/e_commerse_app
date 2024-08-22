class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel.formJson({required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
  }
}
