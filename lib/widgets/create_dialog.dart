import 'package:flutter/material.dart';
import 'package:phonesubscriptions/colors/colors.dart';
import 'package:phonesubscriptions/models/phone_subscription_model.dart';
import 'package:phonesubscriptions/services/phone_subscription_service.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final items = <String>['01','02','03','04','05','06','07','08','09','10','11','12'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  final plans = <String>['pre-paid','post-paid'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  final techs = <String>['2G','3G', '4G'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  String mes = '01';
  String tech = '2G';
  String plan = 'pre-paid';
  final TextEditingController _year = TextEditingController();
  final TextEditingController _subs = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneSubscriptionService service = new PhoneSubscriptionService();


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Text(
                'Crear Subscripción',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seleccione el año', style: TextStyle(fontSize: 18),),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _year,
                              validator: (value){
                                return value!.isNotEmpty && int.parse(value) > 0 ? null : 'Campos invalidos';
                              },
                              decoration: InputDecoration(labelText: 'Año'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Seleccione el mes', style: TextStyle(fontSize: 18),),
                            DropdownButton<String>(
                              value: mes,
                              onChanged: (String? newValue) {
                                setState(() {
                                  mes = newValue!;
                                });

                              },
                              items: items,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Seleccione el tipo de tecnologia', style: TextStyle(fontSize: 18),),
                            DropdownButton<String>(
                              value: tech,
                              onChanged: (String? newValue) {
                                setState(() {
                                  tech = newValue!;
                                });

                              },
                              items: techs,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Seleccione el plan', style: TextStyle(fontSize: 18),),
                            DropdownButton<String>(
                              value: plan,
                              onChanged: (String? newValue) {
                                setState(() {
                                  plan = newValue!;
                                });

                              },
                              items: plans,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Ingrese las subscripciones', style: TextStyle(fontSize: 18),),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _subs,
                              validator: (value){
                                return value!.isNotEmpty && int.parse(value) > 0 ? null : 'Campos invalidos';
                              },
                              decoration: InputDecoration(labelText: 'Subscripciones'),
                            ),
                          ],
                        ),

                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {Navigator.of(context).pop(false);}, child: Text('Cancelar')),

                  ElevatedButton(onPressed: () {
                    if(_formKey.currentState!.validate()){
                      final createdData = new PhoneSubscription(id: null, month: _year.text+'-'+mes+'-'+'01', networkTechnology: tech, planType: plan, subscriptions: int.parse(_subs.text));

                      service.createData(createdData);
                      Navigator.of(context).pop();
                    }
                  }, child: Text('Crear')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
