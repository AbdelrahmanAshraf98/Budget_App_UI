import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  const BarChart({this.expenses});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
              Text(
                'Nov 10, 2021 - Nov 16, 2021',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar('Su',expenses[0],200,context)  ,
              Bar('Mo',expenses[1],200,context)  ,
              Bar('Tu',expenses[2],200,context)  ,
              Bar('We',expenses[3],200,context)  ,
              Bar('Th',expenses[4],200,context)  ,
              Bar('Fr',expenses[5],200,context)  ,
              Bar('Sa',expenses[6],200,context)  ,
            ],
          ),
        ],
      ),
    );
  }
}

Widget Bar(String label,double amountSpent,double mostExpensive,context){
  double barHeight = (amountSpent/mostExpensive) * 250;
  return Column(
    children: [
      Text('\$${amountSpent.toStringAsFixed(2)}',style: TextStyle(fontSize: 14.0),),
      SizedBox(
        height: 5.0,
      ),
      Container(
        height: barHeight,
        width: 18.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Text(
        label,
        style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),)
    ],
  );
}