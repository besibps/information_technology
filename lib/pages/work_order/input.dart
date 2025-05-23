import 'package:flutter/material.dart';
import 'package:information_technology/const.dart';
import 'package:intl/intl.dart';

class InputOfWorkOrder extends StatefulWidget {
  const InputOfWorkOrder({super.key});

  @override
  State<InputOfWorkOrder> createState() => _InputOfWorkOrderState();
}

class _InputOfWorkOrderState extends State<InputOfWorkOrder> {
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _requestorController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedClass;
  final TextEditingController _deviceController = TextEditingController();
  final TextEditingController _troubleController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  final List<String> _classes = [
    'SUPPORT',
    'DESIGN',
    'ADMIN',
    'OTHERS',
  ]; // Contoh pilihan dropdown

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            height: 50,
            color: primaryColor,
            child: Center(
              child: Text(
                "INPUT WORK ORDER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: <Widget>[
                TextField(
                  controller: _deptController,
                  decoration: const InputDecoration(labelText: 'Dept'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _requestorController,
                  decoration: const InputDecoration(labelText: 'Requestor'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : DateFormat(
                                  'yyyy-MM-dd',
                                ).format(_selectedDate!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Class',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedClass,
                  items:
                      _classes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedClass = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _deviceController,
                  decoration: const InputDecoration(labelText: 'Device'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _troubleController,
                  decoration: const InputDecoration(labelText: 'Trouble'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _treatmentController,
                  decoration: const InputDecoration(labelText: 'Treatment'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Duration (minutes)',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _remarksController,
                  decoration: const InputDecoration(labelText: 'Remarks'),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  minWidth: 200,
                  height: 50,
                  color: aksenColor,
                  onPressed: () {
                    // Lakukan sesuatu dengan data yang diinput
                    print('Dept: ${_deptController.text}');
                    print('Requestor: ${_requestorController.text}');
                    print('Date: $_selectedDate');
                    print('Class: $_selectedClass');
                    print('Device: ${_deviceController.text}');
                    print('Trouble: ${_troubleController.text}');
                    print('Treatment: ${_treatmentController.text}');
                    print('Duration: ${_durationController.text}');
                    print('Remarks: ${_remarksController.text}');
                  },
                  child: Center(
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
