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
      print(response.statusCode);

    }
    catch(e){
      print('aaaa caught error $e');
      error = true;
    }
  }

  Future<void> updateData(PhoneSubscription phoneSubscription) async{
    try{
      final subscriptionId = phoneSubscription.id;
      final body = {
        'month' : phoneSubscription.month,
        'network_technology': phoneSubscription.networkTechnology,
        'plan_type':phoneSubscription.planType,
        'subscriptions':phoneSubscription.subscriptions
      };

      Response response = await put(Uri.parse('https://phonesubcriptions-api.azurewebsites.net/api/phoneSubscriptions/$subscriptionId'),body: jsonEncode(body), headers: <String, String>{
        'Content-Type': 'application/json'
      }, );
      print(response.statusCode);
    }catch(e){
      print('aaaa caught error $e');
      error = true;
    }
  }

  Future<void> createData(PhoneSubscription phoneSubscription) async{
    try{
      final body = {
        'month' : phoneSubscription.month,
        'network_technology': phoneSubscription.networkTechnology,
        'plan_type':phoneSubscription.planType,
        'subscriptions':phoneSubscription.subscriptions
      };
      Response response = await post(Uri.parse('https://phonesubcriptions-api.azurewebsites.net/api/phoneSubscriptions'),body: jsonEncode(body), headers: <String, String>{
        'Content-Type': 'application/json'
      }, );
      print(response.statusCode);
    }
    catch(e){

    }
  }
}