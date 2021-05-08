import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/screens/category_screen.dart';
import 'package:flutter_budget_ui/widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color getColor(double percent){
    if(percent >= 0.50)
      return Colors.green;
    else if(percent >= 0.25)
      return Colors.orange;
    else
      return Colors.red;
  }
  _buildCategory(Category category, double spent) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoryScreen(category),));
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${(category.maxAmount - spent).toStringAsFixed(2)}/\$${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - spent)/category.maxAmount;
                double barWidth = percent * maxWidth;
                print(barWidth);
                if(barWidth < 0){barWidth = 0;}
                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      width: barWidth,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: getColor(percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backwardsCompatibility: false,
            forceElevated: true,
            // floating: true,
            pinned: true,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Simple Budget',
                style: TextStyle(fontSize: 18.0),
              ),
              centerTitle: true,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == 0)
                return Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ]),
                  child: BarChart(
                    expenses: weeklySpending,
                  ),
                );
              else {
                final Category category = categories[index - 1];
                double totalAmountSpent = 0;
                category.expenses.forEach((Expense e) {
                  totalAmountSpent += e.cost;
                });
                return _buildCategory(category, totalAmountSpent);
              }
            },
            childCount: 1 + categories.length,
          )),
        ],
      ),
    );
  }
}
