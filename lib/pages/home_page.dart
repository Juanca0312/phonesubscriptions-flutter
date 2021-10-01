import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phonesubscriptions/colors/colors.dart';
import 'package:phonesubscriptions/models/phone_subscription_model.dart';
import 'package:phonesubscriptions/services/phone_subscription_service.dart';
import 'package:phonesubscriptions/widgets/card_widget.dart';

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
        backgroundColor: IColors.steel,
        shadowColor: Colors.transparent,
        title: Text("Mobile Phone Subscriptions", style: TextStyle(color: IColors.rich_black, fontSize: 22),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.sort, color: Colors.black, size: 30,),
          ),
        ],
      ),
      body: Container(
        color: IColors.light_blue,
        child: subscriptions.length == 0 ? SpinKitDoubleBounce(size: 70, color: Colors.blue,) : ListView.builder(
          itemCount: subscriptions.length,
          itemBuilder: (BuildContext context, int i){
            return Dismissible(
                key: Key(subscriptions[i].id.toString()),
                confirmDismiss: (DismissDirection direction) async {
                  if(direction == DismissDirection.endToStart){
                    return await showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Estas seguro que deseas eliminar?"),
                        actions: [
                          ElevatedButton(onPressed: (){Navigator.of(context).pop(true);}, child: Text('Eliminar')),
                          ElevatedButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text('Cancelar'))

                        ],
                      );
                    });
                  } else{
                    return await showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Estas seguro que deseas editar?"),
                        actions: [
                          ElevatedButton(onPressed: (){Navigator.of(context).pop(true);}, child: Text('Eliminar')),
                          ElevatedButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text('Cancelar'))

                        ],
                      );
                    });
                  }
                },
                onDismissed: (DismissDirection direction){
                  if(direction == DismissDirection.endToStart){
                    service.deleteData(subscriptions[i].id);
                    setState(() {
                      subscriptions.removeAt(i);
                    });
                  }
                },
                background: Container(
                  color: IColors.indian_yellow,
                  child: Icon(Icons.edit),
                ),
                secondaryBackground:Container(
                  color: IColors.red,
                  child: Icon(Icons.delete),

                ),
                child: CardWidget(phoneSubscription: subscriptions[i]));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: IColors.russian_green,
        child: Icon(Icons.add, size: 40, color: Colors.white,),
      ),
    );
  }
}
