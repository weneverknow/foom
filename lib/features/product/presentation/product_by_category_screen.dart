import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/core/constants/constants.dart';
import 'package:foom/features/product/presentation/bloc/product_list_bloc.dart';
import 'package:foom/features/product/presentation/product_detail_screen.dart';

import '../domain/entities/product.dart';
import 'components/product_list_card.dart';

class ProductByCategoryScreen extends StatelessWidget {
  const ProductByCategoryScreen({required this.category, super.key});

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text("${category['value']}"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
            if (state is ProductListLoaded) {
              List<Product> products = state.products
                  .where((product) => product.getType == category['code'])
                  .toList();

              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                //mainAxisSpacing: 20,
                childAspectRatio: 0.6,
                crossAxisSpacing: defaultPadding / 2,
                children: products.map((product) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: product)));
                      },
                      child: ProductListCard(product: product));
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
