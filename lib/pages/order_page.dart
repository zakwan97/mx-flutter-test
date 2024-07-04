import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/controller/order_controller.dart';
import 'package:mx_flutter_test/model/order_model.dart';
import 'package:mx_flutter_test/shared/cart_button_shared.dart';
import 'package:mx_flutter_test/util/preference.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> orders = [];
  OrderController o = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    List<String>? orderStrings = Preference.getStringList(Preference.order);
    if (orderStrings != null) {
      List<Order> loadedOrders = [];
      for (String orderString in orderStrings) {
        Map<String, dynamic> orderJson = json.decode(orderString);
        loadedOrders.add(Order.fromJson(orderJson));
      }
      setState(() {
        orders = loadedOrders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: GestureDetector(
            onTap: () {
              Preference.remove(Preference.order);
            },
            child: const Text('Orders')),
        actions: const [CardButtonShared()],
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text('No orders found'),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                Order order = orders[index];
                return ListTile(
                  title: Text('Order ID: ${order.orderId}'),
                  subtitle: Text(
                    order.productList
                            ?.map((product) => product.title)
                            .join(', ') ??
                        '',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        'RM${order.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy').format(order.orderDate),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      o.orderId = order.orderId;
                    });
                    Get.toNamed('/historyDetails');
                  },
                );
              },
            ),
    );
  }
}
