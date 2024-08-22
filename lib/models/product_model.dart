class ProductModel {
  int? id;
  int? price;
  int? oldprice;
  int? discount;
  String? image;
  String? name;
  String? description;

  ProductModel.formJson({required Map<String, dynamic> data}) {
    id = data['id'].toInt();
    price = data['price'].toInt();
    oldprice = data['old_price'].toInt();
    discount = data['discount'].toInt();
    image = data['image'].toString();
    name = data['name'].toString();
    description = data['description'].toString();
  }
}
