import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/models/cart.dart';
import 'package:food_app/models/item.dart';
import 'package:get/get.dart';
import '../Util.dart';
import '../sharedPreferences/current_user_shared_prefs_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class CartScreen extends StatefulWidget {

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  // This is to get the user details from shared preferences
  final currentUserData = Get.put(CurrentUserData());
  final cartListController = Get.put(CartListController());


  getCartItems() async

  {
    List<Cart> cartListofUser = [];

    try {
      var res = await http.post(
        Uri.parse(Util.getCartItems),
        body: {
          // user id we are getting from shared preferences
          "user_id": currentUserData.user.user_id.toString(),

        },

      );

      if (res.statusCode == 200) //from flutter app the connection with api to server - success
          {
        var resBodyOfGetCartItems = jsonDecode(res.body);

        if (resBodyOfGetCartItems['success'] == true)
        {
          for (var eachCartItem in (resBodyOfGetCartItems['cartData'] as List)) {
            cartListofUser.add(Cart.fromJson(eachCartItem));
          }

        }
        else {
          Fluttertoast.showToast(
              msg: "Error Occur.");
        }

        cartListController.setList(cartListofUser);

      }
      else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    }

    catch (errorMsg) {
      Fluttertoast.showToast(msg: errorMsg.toString());
    }

    calculateTotalAmount();
  }

  calculateTotalAmount()
  {
    cartListController.setTotal(0);

    if(cartListController.selectedItemList.length > 0)
    {
      cartListController.cartList.forEach((itemInCart)
      {
        if(cartListController.selectedItemList.contains(itemInCart.item_id))
        {
          double eachItemTotalAmount = (itemInCart.item_total_price); //* (double.parse(itemInCart.item_quantity.toString()));

          cartListController.setTotal(cartListController.total + eachItemTotalAmount);
        }
      });
    }
  }


// my previous method
 /* calculateTotalAmount() {
    cartListController.setTotal(0);

      cartListController.cartList.forEach((itemInCart) {

          cartListController.setTotal(
              cartListController.total + itemInCart.item_total_price);

      });

  }

  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItems();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Obx(()=>
      cartListController.cartList.length > 0
          ? ListView.builder(
        itemCount: cartListController.cartList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index)
        {
          Cart cartModel = cartListController.cartList[index];

        /*  Item itemModel = Item(
              cartModel.item_id,
              cartModel.item_name,
              cartModel.item_rating,
              cartModel.item_tags,
              cartModel.item_prices,
              cartModel.item_total_price as List<String>,
              cartModel.item_sizes,
              cartModel.item_description,
              cartModel.item_image);
*/
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [

                //check box
                GetBuilder(
                  init: CartListController(),
                  builder: (c)
                  {
                    return IconButton(
                      onPressed: ()
                      {

                          cartListController.addSelectedItem(cartModel.item_id!);


                        calculateTotalAmount();
                      },
                      icon: Icon(
                        cartListController.selectedItemList.contains(cartModel.item_id)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: cartListController.isSelectedAll
                            ? Colors.white
                            : Colors.grey,
                      ),
                    );
                  },
                ),

                //name
                //color size + price
                //+ 2 -
                //image
                Expanded(
                  child: GestureDetector(
                    onTap: ()
                    {

                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                        0,
                        index == 0 ? 16 : 8,
                        16,
                        index == cartListController.cartList.length - 1 ? 16 : 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                        boxShadow:
                        const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          //name
                          //color size + price
                          //+ 2 -
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  //name
                                  Text(cartModel.item_name.toString(),

                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //color size + price
                                  Row(
                                    children: [

                                      //size
                                      Expanded(
                                        child: Text(
                                          "Size: ${cartModel.item_size.toString()}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ),

                                      //price
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 12.0
                                        ),
                                        child: Text(
                                          "\$" + cartModel.item_total_price.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.purpleAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  //+ 2 -
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      //-
                                      IconButton(
                                        onPressed: ()
                                        {

                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ),

                                      const SizedBox(width: 10,),

                                      Text(
                                        cartModel.item_quantity.toString(),
                                        style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(width: 10,),

                                      //+
                                      IconButton(
                                        onPressed: ()
                                        {

                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //item image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                            child: FadeInImage(
                              height: 185,
                              width: 150,
                              fit: BoxFit.cover,
                              placeholder: const AssetImage("images/place_holder.png"),
                              image: NetworkImage(
                                cartModel.item_image!,
                              ),
                              imageErrorBuilder: (context, error, stackTraceError)
                              {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );


        },
      )
          : const Center(
        child: Text("Cart is Empty"),
      ),
      ),
      bottomNavigationBar: GetBuilder(
        init: CartListController(),
        builder: (c)
        {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -3),
                  color: Colors.white24,
                  blurRadius: 6,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [

                //total amount
                const Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Obx(()=>
                    Text(
                      "\$ " + cartListController.total.toStringAsFixed(2),
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),

                const Spacer(),

                //order now btn
                Material(
                  color: cartListController.selectedItemList.length > 0
                      ? Colors.purpleAccent
                      : Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: ()
                    {

                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
