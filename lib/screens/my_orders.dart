import 'package:elhasnaa/data_model/my_orders_model.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/add_cart_repo.dart';
import 'package:elhasnaa/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tabedButton = 0;
  List<MyOrders> myOrdersList = [];

  fetchMyOrders() async {
    var ordersResponse = await CartRepo().getMyOrders();
    myOrdersList.addAll(ordersResponse!);



    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    var _statusBarheight = MediaQuery.of(context).padding.top;
    // fetchAll();
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: _statusBarheight),
          child: Column(
            children: [
              buildTopAppBar(context),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Divider(
                  height: 2,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(237, 244, 247, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: buildBottomBar(context),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    is_logged_in.$
                        ? myOrdersList.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: MyTheme.dark_grey,
                                ),
                              )
                            : (_tabedButton == 0)
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: myOrdersList.length,
                                        itemBuilder: (context, index) {
                                          if (myOrdersList.isEmpty) {
                                            return customText(
                                                txt: "${AppLocalizations.of(context)!.my_order_no_order_pending}",
                                                fw: FontWeight.bold,
                                                fs: 16);
                                          } else {
                                            if (myOrdersList[index]
                                                    .orderSet ==
                                                "0") {
                                              return buildOrderCard(
                                                  orderId:
                                                      myOrdersList[index].id!,
                                                  orderTime: myOrdersList[index]
                                                          .orderDate! +
                                                      "  " +
                                                      myOrdersList[index]
                                                          .orderTime!,
                                                  totalPrice:
                                                      myOrdersList[index]
                                                          .total!,
                                                  currency: "  " +
                                                      myOrdersList[index]
                                                          .orderCurency!,
                                                  notes: myOrdersList[index]
                                                      .notes!);
                                            } else {
                                              return SizedBox();
                                            }
                                          }
                                        }),
                                  )
                                : (_tabedButton == 1)
                                    ? Expanded(
                                        child: ListView.builder(
                                            itemCount: myOrdersList.length,
                                            itemBuilder: (context, index) {
                                              if (myOrdersList.isEmpty) {
                                                return customText(
                                                    txt:"${AppLocalizations.of(context)!.my_order_no_progress_orders}", 
                                                    fw: FontWeight.bold,
                                                    fs: 16);
                                              } else {
                                                if (myOrdersList[index]
                                                        .orderSet ==
                                                    "1") {
                                                  return buildOrderCard(
                                                      orderId:
                                                          myOrdersList[index]
                                                              .id!,
                                                      orderTime: myOrdersList[
                                                                  index]
                                                              .orderDate! +
                                                          "  " +
                                                          myOrdersList[index]
                                                              .orderTime!,
                                                      totalPrice:
                                                          myOrdersList[index]
                                                              .total!,
                                                      currency: "  " +
                                                          myOrdersList[index]
                                                              .orderCurency!,
                                                      notes: myOrdersList[index]
                                                          .notes!);
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                            }),
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                            itemCount: myOrdersList.length,
                                            itemBuilder: (context, index) {
                                              if (myOrdersList.isEmpty) {
                                                return customText(
                                                    txt:"${AppLocalizations.of(context)!.my_order_no_delivered_orders}", 
                                                    fw: FontWeight.bold,
                                                    fs: 16);
                                              } else {
                                                if (myOrdersList[index]
                                                        .orderSet ==
                                                    "2") {
                                                  return buildOrderCard(
                                                      orderId:
                                                          myOrdersList[index]
                                                              .id!,
                                                      orderTime: myOrdersList[
                                                                  index]
                                                              .orderDate! +
                                                          "  " +
                                                          myOrdersList[index]
                                                              .orderTime!,
                                                      totalPrice:
                                                          myOrdersList[index]
                                                              .total!,
                                                      currency: "  " +
                                                          myOrdersList[index]
                                                              .orderCurency!,
                                                      notes: myOrdersList[index]
                                                          .notes!);
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                            }),
                                      )
                        : Center(
                            child: customText(
                                txt: "${AppLocalizations.of(context)!.common_login_warning}",
                                fw: FontWeight.bold,
                                fs: 16),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildRegisterNav(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }, //todo navig to login register screen
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.03,
              backgroundColor: Colors.lightGreen,
              foregroundImage:
                  const AssetImage('assets/profile_placeholder.jpg'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.1),
            ),
            //margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(7),
            child: Text(
              //'Creat New Account / Login',
              AppLocalizations.of(context)!.creat_new_account_myorders +
                  ' / ' +
                  AppLocalizations.of(context)!.login_myorders,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTopAppBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          !is_logged_in.$ ? buildRegisterNav(context) : const SizedBox(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
      ),
    );
  }

  buildBottomBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //'My Orders',
          AppLocalizations.of(context)!.my_orders,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: buildIconsButtons(context),
        ),
      ],
    );
  }

  buildIconsButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _tabedButton = 0;
                  });
                },
                icon: Image.asset(
                  'assets/schedule.png',
                  color: _tabedButton == 0 ? MyTheme.golden : MyTheme.dark_grey,
                  //fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                //'under confirmation',
                AppLocalizations.of(context)!.under_confirmation_my_orders,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _tabedButton = 1;
                  });
                },
                icon: Image.asset(
                  'assets/product.png',
                  color: _tabedButton == 1 ? MyTheme.golden : MyTheme.dark_grey,
                  //fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                // 'Being processed',
                AppLocalizations.of(context)!.being_processed_myorder,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _tabedButton = 2;
                  });
                },
                icon: Image.asset(
                  'assets/delivery-truck.png',
                  color: _tabedButton == 2 ? MyTheme.golden : MyTheme.dark_grey,
                  //fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                //'Delivered',
                AppLocalizations.of(context)!.delivered_my_order,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.2,
        //   child: Column(
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           setState(() {
        //             _tabedButton=3;
        //           });
        //         },
        //         icon: Image.asset(
        //           'assets/evaluate.png',
        //           color: _tabedButton==3? MyTheme.golden:MyTheme.dark_grey,
        //           //fit: BoxFit.cover,
        //         ),
        //       ),
        //       const SizedBox(height: 5),
        //        Text(
        //         //'evaluation',
        //         AppLocalizations.of(context)!.evaluation_my_order,
        //         maxLines: 2,
        //         textAlign: TextAlign.center,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  buildOrderCard(
      {required String orderId,
      required String orderTime,
      required String totalPrice,
      required String currency,
      required String notes}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BuildListTile(title: "OrderID ", trailing: "${orderId}"),
            SizedBox(
              height: 6,
            ),
            BuildListTile(title: "Order Time ", trailing: "${orderTime}"),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                BuildListTile(title: "Total Price ", trailing: "${totalPrice}"),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${currency}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            BuildListTile(title: "Notes ", trailing: "${notes}"),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }

  BuildListTile({required String title, required String trailing}) {
    return Row(
      children: [
        customText(txt: "$title", fw: FontWeight.bold, fs: 16),
        SizedBox(
          width: 6,
        ),
        customText(txt: ": ", fw: FontWeight.bold, fs: 16),
        customText(txt: "$trailing", fw: FontWeight.normal, fs: 16),
      ],
    );
  }

  customText(
      {required String txt, required FontWeight fw, required double fs}) {
    return Text(
      '$txt',
      style: TextStyle(
          fontWeight: fw, fontSize: fs, overflow: TextOverflow.ellipsis),
    );
  }
}
