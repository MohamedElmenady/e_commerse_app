import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_cubit.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_state.dart';
import 'package:e_commerse_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  final pageController = PageController();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                onChanged: (value) {
                  cubit.filterProduct(data: value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'search',
                  hintStyle: const TextStyle(fontSize: 18),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: const Icon(Icons.clear, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 125,
              width: double.infinity,
              child: cubit.banners.isEmpty
                  ? const Center(
                      child: Text(
                        'Loding...',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: 3,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Image.network(
                                cubit.banners[index].image!,
                                fit: BoxFit.fill,
                              ),
                            );
                          }),
                    ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                axisDirection: Axis.horizontal,
                effect: const SlideEffect(
                    spacing: 8.0,
                    radius: 24,
                    dotWidth: 8,
                    dotHeight: 8,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 2,
                    dotColor: secondColor,
                    activeDotColor: mainColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                        color: secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: state is CategoryLodingState
                  ? const Center(
                      child: Text(
                        'Loding...',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.category.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(cubit.category[index].image!),
                              ),
                            );
                          }),
                    ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                          color: secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ]),
            ),
            state is ProductLodingState
                ? const Center(child: Text('Loding...'))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.filterproduct.isEmpty
                          ? cubit.product.length
                          : cubit.filterproduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.7),
                      itemBuilder: (context, index) {
                        return _productItem(
                            cubit: cubit,
                            model: cubit.filterproduct.isEmpty
                                ? cubit.product[index]
                                : cubit.filterproduct[index]);
                      },
                    ),
                  ),
          ]),
        );
      },
    );
  }
}

Widget _productItem({required ProductModel model, required LayoutCubit cubit}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Colors.grey.withOpacity(0.2),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Image.network(
          model.image!,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        model.name!,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            overflow: TextOverflow.ellipsis),
      ),
      const SizedBox(
        height: 2,
      ),
      Row(
        children: [
          Expanded(
            child: Row(children: [
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${model.price!} LE",
                    style: const TextStyle(fontSize: 13),
                  )),
              const SizedBox(
                width: 5,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${model.oldprice!} LE",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.5,
                      decoration: TextDecoration.lineThrough),
                ),
              )
            ]),
          ),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(
          child: Icon(
            Icons.favorite,
            size: 20,
            color: cubit.favoriteId.contains(model.id.toString())
                ? Colors.red
                : Colors.grey,
          ),
          onTap: () {
            cubit.addOrRemoveFavorite(productId: model.id.toString());
          },
        ),
        GestureDetector(
          child: Icon(
            Icons.shopping_cart,
            size: 20,
            color: cubit.cartId.contains(model.id.toString())
                ? Colors.red
                : Colors.grey,
          ),
          onTap: () {
            cubit.addOrRemoveCarts(id: model.id.toString());
          },
        )
      ]),
    ]),
  );
}
