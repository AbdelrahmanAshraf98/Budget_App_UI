import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';

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
    widget.category.expenses.forEach((Expense e) {
      spent += e.cost;
    });
    final double amountLeft = widget.category.maxAmount - spent;
    final double percent = amountLeft / widget.category.maxAmount;
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
              child: Text(
                  '\$${amountLeft.toStringAsFixed(2)}/\$${widget.category.maxAmount}',
                style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
