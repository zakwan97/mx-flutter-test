import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/controller/address_controller.dart';
import 'package:mx_flutter_test/model/address_model.dart';
import 'package:mx_flutter_test/shared/button_shared.dart';
import 'package:mx_flutter_test/util/preference.dart';
import 'package:sizer/sizer.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Preference.remove(Preference.address);
              addressController.loadAddresses();
            },
            child: const Text('My Addresses')),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              addressController.addresses.isEmpty
                  ? const Center(
                      child: Text('No addresses found'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: addressController.addresses.length,
                      itemBuilder: (context, index) {
                        Address address = addressController.addresses[index];
                        return ListTile(
                          title: Text(address.name),
                          subtitle: Text(
                              '${address.address} ${address.city}, ${address.state}, ${address.postcode}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await addressController
                                  .deleteAddress(address)
                                  .then((value) {
                                Get.snackbar(
                                  'Success',
                                  'Your Address has been deleted',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  borderRadius: 8,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4.2.w, vertical: 1.23.h),
                                  duration: const Duration(seconds: 3),
                                );
                              });
                            },
                          ),
                          leading: Checkbox(
                            value: address.isDefault,
                            onChanged: (bool? value) {
                              if (value == true) {
                                addressController.updateDefaultAddress(address);
                              }
                            },
                          ),
                        );
                      },
                    ),
              SharedButton(
                title: "+ Add Address",
                isFilled: true,
                onTap: () {
                  Get.toNamed('/addAddressPage')!
                      .then((value) => addressController.loadAddresses());
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
