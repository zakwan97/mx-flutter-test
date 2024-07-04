import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/controller/address_controller.dart';
import 'package:mx_flutter_test/model/address_model.dart';
import 'package:mx_flutter_test/shared/button_shared.dart';
import 'package:mx_flutter_test/util/preference.dart';

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
                              await addressController.deleteAddress(address);
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
