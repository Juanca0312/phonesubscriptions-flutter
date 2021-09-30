import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phonesubscriptions/models/phone_subscription_model.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key, required this.phoneSubscription})
      : super(key: key);

  final PhoneSubscription phoneSubscription;

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  var f = NumberFormat('#,###,000');

  @override
  Widget build(BuildContext context) {
    String date = widget.phoneSubscription.month!.split("-")[0].toString()+'-' +widget.phoneSubscription.month!.split("-")[1].toString();
    const style = TextStyle(fontSize: 18, fontWeight: FontWeight.w300);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.phoneSubscription.networkTechnology.toString(), style: style,),
              Column(
                children: [
                  Text(date, style: style),
                  Text(widget.phoneSubscription.planType.toString(), style: style),
                ],
              ),
              Text(f.format(widget.phoneSubscription.subscriptions) + " subs", style: style),
            ],
          ),
        )
      ),
    );
  }
}
