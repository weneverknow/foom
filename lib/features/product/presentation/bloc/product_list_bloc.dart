import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/product/domain/entities/product.dart';
import 'package:foom/features/product/domain/usecase/fetch_products.dart';
import 'package:foom/features/product/domain/usecase/fetch_products_from_firestore.dart';
import 'package:foom/service_locator.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<ProductListLoad>(_onLoad);
  }

  final FetchProducts fetchProducts = sl<FetchProducts>();
  final FetchProductsFromFirestore fetchProductsFromFirestore =
      sl<FetchProductsFromFirestore>();

  Future<void> _onLoad(
      ProductListLoad event, Emitter<ProductListState> state) async {
    print("[ProductListBloc] onLoad executed");
    emit(ProductListLoading());
    //final result2 = await fetchProductsFromFirestore.fetch();
    final result = await fetchProducts.call(NoParam());

    result.fold((l) => emit(ProductListFailed(l.message)),
        (r) => emit(ProductListLoaded(r)));
  }
}
