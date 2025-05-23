import 'package:flutter/material.dart';
import 'package:information_technology/const.dart';
import 'package:information_technology/pages/dashboard_page.dart';
import 'package:information_technology/pages/work_order/work_order_page.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectedPage = 0;
  Widget _currentPage = WorkOrderPage();

  void _changeDisplayPage(int index, Widget content) {
    setState(() {
      _selectedPage = index;
      _currentPage = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 70,
              color: primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      _changeDisplayPage(0, DashboardPage());
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedPage == 0 ? aksenColor : Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _changeDisplayPage(1, WorkOrderPage());
                    },
                    icon: Icon(
                      Icons.assessment,
                      color: _selectedPage == 1 ? aksenColor : Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart_sharp, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.receipt_long, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.inventory, color: Colors.white),
                  ),
                ],
              ),
            ),

            // container utama
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _currentPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
