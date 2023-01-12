import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foom/core/constants/constants.dart';
import 'package:foom/core/cubit/button_pressed_cubit.dart';
import 'package:foom/core/extensions/int_extension.dart';
import 'package:foom/core/widgets/dialog_widget.dart';
import 'package:foom/core/widgets/image_network_wrapper.dart';
import 'package:foom/features/cart/domain/entities/cart.dart';
import 'package:foom/features/cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:foom/features/product/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/domain/entities/login.dart';
import '../../authentication/presentation/bloc/authentication_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void dispose() {
    Fluttertoast.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Login? login = context.select<AuthenticationBloc, Login?>((bloc) =>
        (bloc.state is AuthenticationSuccess)
            ? (bloc.state as AuthenticationSuccess).login
            : null);
    return BlocListener<AddToCartCubit, AddToCartState>(
      listener: (context, state) async {
        if (state is AddToCartFailed) {
          await showErrorDialog(context,
              title: "Failed", message: (state).message);
        } else {
          //context.read<CartListBloc>().add(await CartLoad());
          await Fluttertoast.showToast(
            msg: "Added to cart successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
          );
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.4,
              child: Stack(
                children: [
                  ImageNetworkWrapper(imageUrl: widget.product.imageUrl!),
                  Positioned(
                      top: defaultPadding * 1.5,
                      left: defaultPadding / 2,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded)))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  defaultPadding, defaultPadding, 0, 0),
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              color: primaryColor.withOpacity(0.3),
              child: Text(
                widget.product.getType.toUpperCase(),
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              child: Text(
                widget.product.name!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: Row(
                children: [
                  Text(
                    widget.product.price!.toIdr(),
                    style: Theme.of(context).textTheme.button?.copyWith(
                          decoration: widget.product.haveDisc!
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                  !widget.product.haveDisc!
                      ? const SizedBox.shrink()
                      : Text(
                          " ${(widget.product.price! - ((widget.product.price! * widget.product.disc!).round())).toIdr()}",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: primaryColor),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              child: Text(
                widget.product.desc!,
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<ButtonPressedCubit, bool>(
            builder: (context, state) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          state ? Colors.grey.shade300 : primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding / 2)),
                  onPressed: state
                      ? null
                      : () async {
                          context.read<ButtonPressedCubit>().update();
                          Cart cart = Cart(
                            product: widget.product,
                            productId: widget.product.id,
                            qty: 1,
                            modifiedDate: DateTime.now(),
                            checkout: false,
                          );
                          await context
                              .read<AddToCartCubit>()
                              .add(cart, userId: login?.token);

                          context.read<ButtonPressedCubit>().update();
                        },
                  child: Text("ADD TO CART"));
            },
          ),
        ),
      ),
    );
  }
}
