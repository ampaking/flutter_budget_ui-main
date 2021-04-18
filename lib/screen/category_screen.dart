import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helper/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/widget/radial_printer.dart';
import '../models/expense_model.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen({this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpances(){
    List<Widget> expancesList =[];
    widget.category.expenses.forEach((Expense expense){
    expancesList.add(Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0,2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(expense.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,),),
            Text(expense.cost.toStringAsFixed(2),style: TextStyle( fontSize: 20, fontWeight: FontWeight.w600),),
            
          ],
        ),
      ),

    ));
    });
    return Column(
      children: expancesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpanth = 0;
    widget.category.expenses.forEach((Expense element) {
      totalAmountSpanth += element.cost;
    });
    final totalAmountLeft = widget.category.maxAmount - totalAmountSpanth;
    final percent = totalAmountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    bgColor: Colors.grey[200],
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15.0),
                child: Center(
                  child: Text(
                    '\$${totalAmountLeft.toStringAsFixed(2)}/\$${widget.category.maxAmount}',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            _buildExpances(),
          ],
        ),
      ),
    );
  }
}
