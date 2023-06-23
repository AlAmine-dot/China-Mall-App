import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/commons/theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "16 products",
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
            Container(
              width: 1.sw,
              height: 310,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 6,
                  itemBuilder: (context, index) {
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
                                          imageUrl: "https://images.unsplash.com/photo-1686753411868-eb97975b7863?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
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
                                              "Leather chair",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "A very good furniture for an easy peasy price",
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
                                              "200.000 FCFA",
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
                            Container(
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
                  "400.000 FCFA",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
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
}
