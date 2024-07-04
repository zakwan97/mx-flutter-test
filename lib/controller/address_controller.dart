import 'dart:convert';
import 'package:get/get.dart';
import 'package:mx_flutter_test/model/address_model.dart';
import 'package:mx_flutter_test/util/preference.dart';

class AddressController extends GetxController {
  var addresses = <Address>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    List<String>? encodedAddresses = Preference.getStringList('address');
    if (encodedAddresses != null) {
      List<Address> loadedAddresses = [];
      for (String encodedAddress in encodedAddresses) {
        Map<String, dynamic> decodedAddress = json.decode(encodedAddress);
        loadedAddresses.add(Address.fromJson(decodedAddress));
      }
      addresses.value = loadedAddresses;
    }
  }

  Future<void> deleteAddress(Address addressToDelete) async {
    List<String>? encodedAddresses = Preference.getStringList('address');
    if (encodedAddresses != null) {
      List<Address> updatedAddresses = encodedAddresses
          .map(
              (encodedAddress) => Address.fromJson(json.decode(encodedAddress)))
          .toList();

      updatedAddresses
          .removeWhere((address) => address.id == addressToDelete.id);
      List<String> updatedEncodedAddresses = updatedAddresses
          .map((address) => json.encode(address.toJson()))
          .toList();

      await Preference.setStringList('address', updatedEncodedAddresses);
      addresses.value = updatedAddresses;
    }
  }

  Future<void> saveAddresses() async {
    List<String> encodedAddresses =
        addresses.map((address) => json.encode(address.toJson())).toList();
    await Preference.setStringList('address', encodedAddresses);
  }

  void updateDefaultAddress(Address changedAddress) {
    for (var address in addresses) {
      address.isDefault = (address == changedAddress);
    }
    saveAddresses();
    addresses.refresh();
  }
}
