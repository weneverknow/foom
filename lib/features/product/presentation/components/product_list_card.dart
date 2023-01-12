import 'package:flutter/material.dart';
import 'package:foom/core/extensions/int_extension.dart';
import 'package:foom/core/widgets/image_network_wrapper.dart';
import 'package:foom/features/product/domain/entities/product.dart';

import '../../../../core/constants/constants.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({required this.product, super.key});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.4,
          height: size.width * 0.5,
          decoration: BoxDecoration(
              //color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.2))
              ]),
          child: Stack(
            children: [
              !product.isBestSeller!
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.only(
                          top: defaultPadding / 4,
                          right: defaultPadding / 4,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black87),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
              ImageNetworkWrapper(imageUrl: product.imageUrl!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 4, vertical: defaultPadding / 4),
          child: Text(
            product.name!,
            style: Theme.of(context).textTheme.button?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
          child: Text(
            product.price!.toIdr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                decoration:
                    product.haveDisc! ? TextDecoration.lineThrough : null),
          ),
        ),
        product.haveDisc!
            ? Text(
                (product.price! - ((product.price! * product.disc!).round()))
                    .toIdr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: primaryColor),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
