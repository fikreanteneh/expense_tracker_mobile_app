import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
        ),
        bottom: const TabBar(tabs: [
          Tab(
            text: "Expense",
          ),
          Tab(
            text: "Income",
          ),
        ]),
      ),
      body: const TabBarView(children: [
        CategoryComponent(type: "groupByDay"),
        CategoryComponent(type: "groupByMonth"),
      ]),
    );
  }
}

class CategoryComponent extends StatefulWidget {
  final String type;
  const CategoryComponent({Key? key, required this.type}) : super(key: key);

  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  @override
  Widget build(BuildContext context) {}
}
