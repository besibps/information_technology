import 'package:flutter/material.dart';
import 'package:information_technology/const.dart';
import 'package:information_technology/pages/work_order/input.dart';
import 'package:information_technology/pages/work_order/list.dart';

class WorkOrderPage extends StatefulWidget {
  const WorkOrderPage({super.key});

  @override
  State<WorkOrderPage> createState() => _WorkOrderPageState();
}

class _WorkOrderPageState extends State<WorkOrderPage> {
  // ignore: unused_field
  int _selectedPage = 0;
  Widget _currentPage = ListOfWorkOrder(workOrder: []);

  void _workOrderContent(int index, Widget content) {
    setState(() {
      _selectedPage = index;
      _currentPage = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 100,

            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/mount.png'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 50,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  color: aksenColor,

                  child: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _workOrderContent(1, InputOfWorkOrder());
                  },
                ),
                SizedBox(width: 10),
                MaterialButton(
                  minWidth: 50,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  color: aksenColor,

                  child: Icon(Icons.list, color: Colors.white),
                  onPressed: () {
                    _workOrderContent(0, ListOfWorkOrder(workOrder: []));
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(child: Container(color: Colors.white, child: _currentPage)),
        ],
      ),
    );
  }
}
