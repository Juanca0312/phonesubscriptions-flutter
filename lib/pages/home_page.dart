import 'package:flutter/material.dart';
import 'package:phonesubscriptions/models/phone_subscription_model.dart';
import 'package:phonesubscriptions/services/phone_subscription_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  PhoneSubscriptionService service = new PhoneSubscriptionService();
  List<PhoneSubscription> subscriptions = [];
  bool loading = true;

  void getData() async{
    await service.getData();
    assignData();

  }

  void assignData(){
    loading=false;
    setState(() {
      subscriptions = service.phoneSubscriptionList;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text("Mobile Phone Subscriptions", style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.sort, color: Colors.black, size: 30,),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: subscriptions.length,
          itemBuilder: (BuildContext context, int i){
            return ListTile(
              title: Text(subscriptions[i].networkTechnology.toString(), style: TextStyle(color: Colors.black),),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.green,
        child: Icon(Icons.add, size: 40, color: Colors.white,),
      ),
    );
  }
}
