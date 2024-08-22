import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_cubit.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FevoritScreen extends StatelessWidget {
  const FevoritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.favorite.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: cubit.favorite.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: fourthColor,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              cubit.favorite[index].image!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${cubit.favorite[index].name}',
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${cubit.favorite[index].price}LE',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      " ${cubit.favorite[index].oldprice}LE",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    cubit.addOrRemoveFavorite(
                                        productId: cubit.favorite[index].id
                                            .toString());
                                  },
                                  child: cubit.favorite.isEmpty
                                      ? const CircularProgressIndicator()
                                      : const Text('Remove'),
                                  color: mainColor,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
