import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_cubit.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: cubit.cartList.isEmpty
                ? const Center(child: Text('Loding...'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: cubit.cartList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: fourthColor,
                                ),
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      cubit.cartList[index].image!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          '${cubit.cartList[index].name}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${cubit.cartList[index].price}LE',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              " ${cubit.cartList[index].oldprice}LE",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  cubit.addOrRemoveFavorite(
                                                      productId: cubit
                                                          .cartList[index].id
                                                          .toString());
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: cubit.favoriteId
                                                          .contains(cubit
                                                              .cartList[index]
                                                              .id
                                                              .toString())
                                                      ? Colors.red
                                                      : Colors.grey,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  cubit.addOrRemoveCarts(
                                                      id: cubit
                                                          .cartList[index].id
                                                          .toString());
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                              );
                            }),
                      ),
                      Container(
                        child: Text(
                          'Total Price : ${cubit.totalPrice} LE',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mainColor),
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
