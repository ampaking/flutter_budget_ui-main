import 'package:flutter/material.dart';

class BarChat extends StatelessWidget {
  final List<double> expansesList;

  BarChat(this.expansesList);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expansesList.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Container(padding: EdgeInsets.all(10),
      child:Column(
        children: [
          Text(
            'Weekly Expanses',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
              Text(
                '27-jan-2021 - 02-feb-2021',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: 'SU',
                amountSpent: expansesList[0],
                mostExpensive: mostExpensive,
              ),Bar(
                label: 'MA',
                amountSpent: expansesList[1],
                mostExpensive: mostExpensive,
              ),Bar(
                label: 'WT',
                amountSpent: expansesList[2],
                mostExpensive: mostExpensive,
              ),Bar(
                label: 'TU',
                amountSpent: expansesList[3],
                mostExpensive: mostExpensive,
              ),Bar(
                label: 'TH',
                amountSpent: expansesList[4],
                mostExpensive: mostExpensive,
              ),Bar(
                label: 'FR',
                amountSpent: expansesList[5],
                mostExpensive: mostExpensive,
              ),Bar(
                label: 'SA',
                amountSpent: expansesList[6],
                mostExpensive: mostExpensive,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight = 150.0;

  Bar({this.label, this.amountSpent, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
