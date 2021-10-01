import 'package:flutter/material.dart';
import 'package:phonesubscriptions/colors/colors.dart';
import 'package:phonesubscriptions/models/phone_subscription_model.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({Key? key, required this.subscription}) : super(key: key);
  final PhoneSubscription subscription;

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final items = <String>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  final TextEditingController _year = TextEditingController();
  final TextEditingController _tech = TextEditingController();
  final TextEditingController _plan = TextEditingController();
  final TextEditingController _subs = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  setControllersData(PhoneSubscription subscription){
    setState(() {
      _year.text = subscription.month!.split('-')[0];
      _tech.text = subscription.networkTechnology!;
      _plan.text = subscription.planType!;
      _subs.text = subscription.subscriptions!.toString();
    });
  }

  String mes = '01';


  @override
  Widget build(BuildContext context) {
    setControllersData(widget.subscription);
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
                'Actualizar Subscripción',
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
                          controller: _year,
                          validator: (value){
                            return value!.isNotEmpty ? null : 'Campos invalidos';
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
                            print(mes);
                          },
                          items: items,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Seleccione el tipo de tecnologia', style: TextStyle(fontSize: 18),),
                        TextFormField(
                          controller: _tech,
                          validator: (value){
                            return value!.isNotEmpty ? null : 'Campos invalidos';
                          },
                          decoration: InputDecoration(labelText: 'Tecnología'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Seleccione el plan', style: TextStyle(fontSize: 18),),
                        TextFormField(
                          controller: _plan,
                          validator: (value){
                            return value!.isNotEmpty ? null : 'Campos invalidos';
                          },
                          decoration: InputDecoration(labelText: 'Plan'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Ingrese las subscripciones', style: TextStyle(fontSize: 18),),
                        TextFormField(
                          controller: _subs,
                          validator: (value){
                            return value!.isNotEmpty ? null : 'Campos invalidos';
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
                  ElevatedButton(onPressed: () {}, child: Text('Cancelar')),

                  ElevatedButton(onPressed: () {}, child: Text('Actualizar')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}