import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:phonesubscriptions/models/phone_subscription_model.dart';

class PhoneSubscriptionService{
  List<PhoneSubscription> phoneSubscriptionList = [];
  bool error = false;
  
  Future<void> getData() async{
    try{
      Response response = await get(Uri.parse('https://phonesubcriptions-api.azurewebsites.net/api/phoneSubscriptions'),);
      Iterable data = jsonDecode(utf8.decode(response.bodyBytes));

      phoneSubscriptionList = List<PhoneSubscription>.from(data.map((e) => PhoneSubscription.fromJson(e)));
      error = false;
    }
    catch(e){
      print('aaaa caught error $e');
      error = true;
    }
  }

  Future<void> deleteData(int? id) async{
    try{
      Response response = await delete(Uri.parse('https://phonesubcriptions-api.azurewebsites.net/api/phoneSubscriptions/$id'),);

    }
    catch(e){
      print('aaaa caught error $e');
      error = true;
    }
  }
}