import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double spent = 0;
    widget.category.expenses.forEach((Expense e) {spent += e.cost;});
    final double amountLeft = widget.category.maxAmount - spent;
    final double percent = amountLeft / widget.category.maxAmount;
    Color getColor(double percent){
      if(percent >= 0.50)
        return Colors.green;
      else if(percent >= 0.25)
        return Colors.orange;
      else
        return Colors.red;
    }
    buildExpenses(){
      List<Widget>expensesList = [];
      widget.category.expenses.forEach((element) {
        expensesList.add(Container(
          alignment: Alignment.center ,
          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          height: 80.0,
          width: double.infinity,
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
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(element.name, style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),),
              Text('\$${element.cost.toStringAsFixed(2)}',style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),),
            ],),
          ),
        ));
      });
      return Column(children: expensesList,);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.name),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 250.0,
              width: double.infinity,
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
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(percent),
                  percent: percent,
                  width: 15.0
                ),
                child: Center(
                  child: Text(
                      '\$${amountLeft.toStringAsFixed(2)}/\$${widget.category.maxAmount}',
                    style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            buildExpenses(),
          ],
        ),
      ),
    );
  }
}
