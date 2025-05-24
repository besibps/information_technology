import 'package:flutter/material.dart';
import 'package:information_technology/const.dart';
import 'package:information_technology/models/wo_model.dart';
import 'package:information_technology/service/wo_firebase.dart';
import 'package:intl/intl.dart';

class InputOfWorkOrder extends StatefulWidget {
  const InputOfWorkOrder({super.key});

  @override
  State<InputOfWorkOrder> createState() => _InputOfWorkOrderState();
}

class _InputOfWorkOrderState extends State<InputOfWorkOrder> {
  //firebase service
  final WoFirebase _woFirebase = WoFirebase();

  //controller
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _requestorController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedClass;
  final TextEditingController _deviceController = TextEditingController();
  final TextEditingController _troubleController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _picController = TextEditingController();
  String? _selectedStatus;
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
      lastDate: DateTime(2040),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final List<String> _statuses = ['DONE', 'ON PROGRESS', 'OTHERS'];

  @override
  void dispose() {
    _deptController.dispose();
    _requestorController.dispose();
    _deviceController.dispose();
    _troubleController.dispose();
    _treatmentController.dispose();
    _durationController.dispose();
    _picController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          Container(
            height: 50,
            color: aksenColor,
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
            child: SizedBox(
              width: width * 0.5,
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
                    controller: _picController,
                    decoration: InputDecoration(labelText: 'PIC'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Status',
                    ),
                    items:
                        _statuses.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedStatus = newValue;
                      });
                    },
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
                      // menangkap nilai field dan mengirimkan ke fungsi simpan ke firestore
                      final String dept = _deptController.text.trim();
                      final String requestor = _requestorController.text.trim();
                      final String? date =
                          _selectedDate
                              ?.toIso8601String(); // Simpan sebagai String ISO 8601
                      final String? classification = _selectedClass;
                      final String device = _deviceController.text.trim();
                      final String trouble = _troubleController.text.trim();
                      final String treatment = _treatmentController.text.trim();
                      final int duration =
                          int.tryParse(_durationController.text.trim()) ?? 0;
                      final String pic = _picController.text.trim();
                      final String? status = _selectedStatus;
                      final String remarks = _remarksController.text.trim();

                      if (dept.isNotEmpty) {
                        final newWorkOrder = WoModel(
                          dept: dept,
                          requestor: requestor,
                          date: date!,
                          classification: classification!,
                          device: device,
                          trouble: trouble,
                          treatment: treatment,
                          duration: duration,
                          pic: pic,
                          status: status!,
                          remarks: remarks,
                        );
                        _woFirebase.addWO(newWorkOrder);
                      }
                      // Reset form setelah berhasil menyimpan (opsional)
                      _deptController.clear();
                      _requestorController.clear();
                      setState(() {
                        _selectedDate = null;
                      });
                      _selectedClass = null;
                      _deviceController.clear();
                      _troubleController.clear();
                      _treatmentController.clear();
                      _durationController.clear();
                      _picController.clear();
                      _selectedStatus = null;
                      _remarksController.clear();
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
          ),
        ],
      ),
    );
  }
}
