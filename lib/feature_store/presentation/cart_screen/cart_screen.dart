import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumia_app/feature_store/presentation/cart_screen/bloc/cart_event.dart';

import '../../../core/commons/theme/app_colors.dart';
import '../../../core/commons/utils/toolbox.dart';
import '../../domain/model/cart_item.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      lazy: false,
      create: (_) => CartBloc(),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {

          final cartBloc = context.read<CartBloc>();

          double total = 0.0;

          for (final cartItem in state.cart) {
            final price = cartItem.product.price.toDouble();
            total += price;
          }


          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 67,
              backgroundColor: Colors.white,
              elevation: 3,
              shadowColor: Colors.grey.withOpacity(.3),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CART",
                    style: TextStyle(
                        color: AppColors.smoothChinaRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 26
                    ),
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.grey.withOpacity(.8),
                  )
                ],
              ),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.isLoading ? "loading your cart..." : "${state.cart.length} products",
                        style: TextStyle(
                          color: AppColors.bunnyBlack,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 4,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AppColors.sinCityRed.withOpacity(.5),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  state.isLoading ?
                  Container(
                    width: 1.sw,
                    height: 310,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ) :
                  Container(
                    width: 1.sw,
                    height: 310,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.cart.length,
                        itemBuilder: (context, index) {

                          final CartItem cartItem = state.cart[index];
                          return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 7),
                                    width: 1.sw - 20,
                                    padding: EdgeInsets.all(10),
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryText.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.14),  // Couleur de l'ombre
                                                  offset: Offset(0, 2),  // Décalage horizontal et vertical de l'ombre
                                                  blurRadius: 4,  // Rayon de flou de l'ombre
                                                  spreadRadius: 2,  // Étalement de l'ombre
                                                ),
                                              ],
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: cartItem.product.thumbnail,
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/images/placeholder.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/images/placeholder.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cartItem.product.title,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    truncateText(cartItem.product.description, 50),
                                                    style: TextStyle(
                                                        color: Colors.grey.withOpacity(.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      "${formatPrice(convertDollarsToFrancCFA(cartItem.product.price.toDouble()))} FCFA",
                                                      style: TextStyle(
                                                      color: AppColors.berryBlack,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "-",
                                                          style: TextStyle(
                                                            fontSize: 35,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        child: const Text(
                                                          "1",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "+",
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      cartBloc.add(RemoveFromCart(cartItem, context));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      height: 140,
                                      width: 75,
                                      child: Center(
                                        child: Icon(
                                            Icons.delete
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.sinCityRed.withOpacity(.3),
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                        }
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        "Sub total : ",
                      ),
                      Text(
                        "${formatPrice(convertDollarsToFrancCFA(total))} FCFA",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "The delivery fees are not included.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.withOpacity(.7)
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 1.sw,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.bunnyBlack,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text(
                        "Check out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 1.sw,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.bunnyBlack,
                          width: 1.0,
                        ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Check out with",
                            style: TextStyle(
                                color: AppColors.bunnyBlack,
                                fontSize: 18
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            child: Image.asset(
                                "assets/images/wave.png",
                            ),
                          )
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
