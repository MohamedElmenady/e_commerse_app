import 'dart:convert';

import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_state.dart';
import 'package:e_commerse_app/models/buners.dart';
import 'package:e_commerse_app/models/category.dart';
import 'package:e_commerse_app/models/product_model.dart';
import 'package:e_commerse_app/models/user_model.dart';
import 'package:e_commerse_app/modules/screens/cart.dart';
import 'package:e_commerse_app/modules/screens/category.dart';
import 'package:e_commerse_app/modules/screens/favorit.dart';
import 'package:e_commerse_app/modules/screens/home.dart';
import 'package:e_commerse_app/modules/screens/profile.dart';
import 'package:e_commerse_app/modules/sheard/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(IntialState());

  int indexCubit = 0;
  List<Widget> layoutScreen = [
    HomePage(),
    const CategryScreen(),
    const FevoritScreen(),
    const CartScreen(),
    const Profile()
  ];
  void getValue({required int index}) {
    indexCubit = index;
    emit(LayoutSuccess());
  }

  List<BannerModel> banners = [];
  getBanner() async {
    emit(BunerLodingState());
    Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/banners'),
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannerModel.formJson(data: item));
        emit(
          BunnerSuccess(),
        );
      }
      emit(
        BunnerSuccess(),
      );
    } else {
      emit(
        BunnerFailurState(error: responseBody['message']),
      );
    }
  }

  UserModel? userModel;

  getProfile() async {
    emit(LodingState());

    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/profile'),
        headers: {'Authorization': token!});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      userModel = UserModel.fromJson(data: responseBody['data']);
      debugPrint(responseBody['message']);
      emit(SuccessState());
    } else {
      debugPrint(responseBody['message']);
      emit(
        FailureState(error: responseBody['message']),
      );
    }
  }

  List<CategoryModel> category = [];
  getCategory() async {
    emit(CategoryLodingState());
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/categories'),
        headers: {'lang': 'en'});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        category.add(CategoryModel.formJson(data: item));
        emit(
          CategorySuccess(),
        );
      }
      emit(
        CategorySuccess(),
      );
    } else {
      emit(CategoryFailurState(error: responseBody['message']));
    }
  }

  List<ProductModel> product = [];
  getProduct() async {
    emit(ProductLodingState());
    Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/home'),
      headers: {'Authorization': token!, 'lang': 'en'},
    );
    var responseBody = jsonDecode(response.body);
    debugPrint('products : $responseBody');
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        product.add(ProductModel.formJson(data: item));
        emit(
          ProductSuccess(),
        );
      }
      emit(
        CategorySuccess(),
      );
    } else {
      emit(
        ProductFailurState(
          error: responseBody['message'],
        ),
      );
    }
  }

  List<ProductModel> filterproduct = [];

  void filterProduct({required String data}) {
    filterproduct = product
        .where((element) =>
            element.name!.toLowerCase().startsWith(data.toLowerCase()) ||
            element.id!.toString().startsWith(data))
        .toList();
    emit(FilterSuccessState());
  }

  List<ProductModel> favorite = [];
  Set<String> favoriteId = {};

  Future<void> getFavorite() async {
    favorite.clear();
    emit(FavoritesLodingState());
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {'Authorization': token!, 'lang': 'en'});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var element in responseBody['data']['data']) {
        favorite.add(ProductModel.formJson(data: element['product']));
        favoriteId.add(element['product']['id'].toString());
      }
      print("Favorites number is : ${favorite.length}");
      emit(FavoritesSuccess());
    } else {
      emit(FavoritesFailurState(error: responseBody['message']));
    }
  }

  void addOrRemoveFavorite({required String productId}) async {
    emit(AddOrRemoveFavoritesLodingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        body: {'product_id': productId},
        headers: {'Authorization': token!, 'lang': 'en'});

    var responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      if (favoriteId.contains(productId) == true) {
        favoriteId.remove(productId);
      } else {
        favoriteId.add(productId);
      }
      await getFavorite();
      emit(AddOrRemoveFavoritesSuccess());
    } else {
      emit(AddOrRemoveFavoritesFailurState(error: responseBody['message']));
    }
  }

  List<ProductModel> cartList = [];
  int totalPrice = 0;
  Set<String> cartId = {};
  Future<void> getCart() async {
    cartList.clear();
    emit(CartLodingState());
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {'Authorization': token!, 'lang': 'en'});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var element in responseBody['data']['cart_items']) {
        cartList.add(ProductModel.formJson(data: element['product']));
        cartId.add(element['product']['id'].toString());
      }
      totalPrice = responseBody['data']['sub_total'].toInt();
      print("Cart(s) number is : ${cartList.length}");
      emit(CartSuccessState());
    } else {
      emit(CartFailurState(error: responseBody['message']));
    }
  }

  void addOrRemoveCarts({required String id}) async {
    emit(AddOrRemoveCartsLodingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        body: {'product_id': id},
        headers: {'Authorization': token!, 'lang': 'en'});

    var responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      if (cartId.contains(id) == true) {
        cartId.remove(id);
      } else {
        cartId.add(id);
      }
      await getCart();
      emit(AddOrRemoveCartsSuccess());
    } else {
      emit(AddOrRemoveCartsFailurState(error: responseBody['message']));
    }
  }

  void changePass(
      {required String currentPassword, required String newPassword}) async {
    emit(ChangePassLodingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/change-password'),
        headers: {
          'Authorization': token!,
          'lang': 'en'
        },
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
        });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      await CashNetwork.set(key: 'pass', value: newPassword);
      myPassword = newPassword;
      emit(ChangePassSuccess());
    } else {
      emit(ChangePassFailurState(error: responseBody['message']));
    }
  }
}
