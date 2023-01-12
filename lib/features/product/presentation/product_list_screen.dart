import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foom/core/constants/constants.dart';

import 'package:foom/features/cart/presentation/bloc/cart_list_bloc.dart';
import 'package:foom/features/cart/presentation/cart_list_screen.dart';
import 'package:foom/features/chat/presentation/chat_screen.dart';
import 'package:foom/features/checkout/presentation/transaction_list_screen.dart';

import 'package:foom/features/product/domain/entities/product.dart';

import 'package:foom/features/category/presentation/category_card.dart';
import 'package:foom/features/product/presentation/components/product_list_card.dart';
import 'package:foom/features/product/presentation/product_detail_screen.dart';
import 'package:foom/features/profile/presentation/bloc/member_bloc.dart';
import 'package:foom/features/profile/presentation/profile_screen.dart';
import 'package:foom/service_locator.dart';

import '../domain/usecase/fetch_products_from_firestore.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back,",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Colors.grey.shade300,
                  ),
            ),
            BlocBuilder<MemberBloc, MemberState>(
              builder: (context, state) {
                if (!(state is MemberUpdateSuccess)) {
                  return const SizedBox.shrink();
                }
                return Text(
                  "${state.member.name}".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                );
              },
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: defaultPadding / 4),
            child: IconButton(
                onPressed: () async {
                  context.read<CartListBloc>().add(await CartLoad());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartListScreen()));
                },
                icon: Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: defaultPadding, bottom: defaultPadding / 2),
            child: Text(
              "Category",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(height: 45, child: CategoryCard()),
          const SizedBox(
            height: defaultPadding,
          ),
          Flexible(
              fit: FlexFit.tight,
              child: StreamBuilder<List<Product?>?>(
                  stream: sl<FetchProductsFromFirestore>().fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        if ((snapshot.data ?? []).isEmpty) {
                          return Center(
                            child: Text(
                              "Products not found",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          );
                        } else {
                          var products = snapshot.data;

                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            //mainAxisSpacing: 20,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: defaultPadding / 2,
                            children: products!.map((product) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => ProductDetailScreen(
                                                product: product)));
                                  },
                                  child: ProductListCard(product: product!));
                            }).toList(),
                          );
                        }
                      }
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: primaryColor, fontSize: 9),
          unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 9),
          showUnselectedLabels: true,
          onTap: (val) {
            if (val == 1) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => TransactionListScreen()));
            } else if (val == 2) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProfileScreen(),
                fullscreenDialog: true,
              ));
              //_signOut(context);
            } else if (val == 3) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChatScreen(),
                fullscreenDialog: true,
              ));
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_rounded), label: "TRANSACTION"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "CHAT"),
          ]),
    );
  }
}
