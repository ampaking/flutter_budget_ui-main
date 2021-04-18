import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helper/color_helper.dart';
import '../widget/bar_chat.dart';
import '../models/category_model.dart';
import '../models/expense_model.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountspenth) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryScreen(category: category),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountspenth).toStringAsFixed(2)}/\$${(category.maxAmount).toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent =
                    (category.maxAmount - totalAmountspenth) /
                        category.maxAmount;
                final barWidth = percent * maxBarWidth;

                return Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 21,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            forceElevated: true,
            // pinned: true,
            expandedHeight: 100,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                size: 30.0,
              ),
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('My Budget App'),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Expanded(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 0.6,
                          )
                        ],
                      ),
                      child: BarChat(weeklySpending),
                    );
                  } else {
                    final Category category = categories[index - 1];
                    double totalAmountExpenses = 0;
                    category.expenses.forEach((Expense expense) {
                      totalAmountExpenses += expense.cost;
                    });
                    return _buildCategory(category, totalAmountExpenses);
                  }
                },
                childCount: 1 + categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
