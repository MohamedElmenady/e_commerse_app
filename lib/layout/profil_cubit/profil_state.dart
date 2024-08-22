abstract class LayoutState {}

class IntialState extends LayoutState {}

class LayoutSuccess extends LayoutState {}

class LodingState extends LayoutState {}

class SuccessState extends LayoutState {}

class FailureState extends LayoutState {
  final String error;
  FailureState({required this.error});
}

class BunnerSuccess extends LayoutState {}

class BunerLodingState extends LayoutState {}

class BunnerFailurState extends LayoutState {
  final String error;

  BunnerFailurState({required this.error});
}

class CategorySuccess extends LayoutState {}

class CategoryLodingState extends LayoutState {}

class CategoryFailurState extends LayoutState {
  final String error;

  CategoryFailurState({required this.error});
}

class ProductSuccess extends LayoutState {}

class ProductLodingState extends LayoutState {}

class ProductFailurState extends LayoutState {
  final String error;

  ProductFailurState({required this.error});
}

class FilterSuccessState extends LayoutState {}

class FavoritesSuccess extends LayoutState {}

class FavoritesLodingState extends LayoutState {}

class FavoritesFailurState extends LayoutState {
  final String error;

  FavoritesFailurState({required this.error});
}

class AddOrRemoveFavoritesSuccess extends LayoutState {}

class AddOrRemoveFavoritesLodingState extends LayoutState {}

class AddOrRemoveFavoritesFailurState extends LayoutState {
  final String error;

  AddOrRemoveFavoritesFailurState({required this.error});
}

class CartSuccessState extends LayoutState {}

class CartLodingState extends LayoutState {}

class CartFailurState extends LayoutState {
  final String error;
  CartFailurState({required this.error});
}

class AddOrRemoveCartsSuccess extends LayoutState {}

class AddOrRemoveCartsLodingState extends LayoutState {}

class AddOrRemoveCartsFailurState extends LayoutState {
  final String error;

  AddOrRemoveCartsFailurState({required this.error});
}

class ChangePassSuccess extends LayoutState {}

class ChangePassLodingState extends LayoutState {}

class ChangePassFailurState extends LayoutState {
  final String error;

  ChangePassFailurState({required this.error});
}
