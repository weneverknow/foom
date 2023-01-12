part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  // const ProductListState();

  // @override
  // List<Object> get props => [];
}

class ProductListInitial extends ProductListState {
  @override
  List<Object?> get props => [];
}

class ProductListLoaded extends ProductListState {
  final List<Product> products;
  ProductListLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductListLoading extends ProductListState {
  @override
  List<Object?> get props => [];
}

class ProductListFailed extends ProductListState {
  final String message;
  ProductListFailed(this.message);
  @override
  List<Object?> get props => [];
}
