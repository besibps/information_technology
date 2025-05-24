import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:information_technology/models/wo_model.dart';
import 'package:information_technology/service/wo_firebase.dart';

class ListOfWorkOrder extends StatelessWidget {
  ListOfWorkOrder({super.key, required this.workOrder});
  // firebase service work order
  final WoFirebase _woFirebase = WoFirebase();

  // ignore: non_constant_identifier_names
  final List<Map<String, dynamic>> workOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

          child: StreamBuilder<List<WoModel>>(
            stream: _woFirebase.getAllWO(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Terjadi kesalahan'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData) {
                final workOrder = snapshot.data!;
                return ScrollConfiguration(
                  behavior: MaterialScrollBehavior().copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch,
                    },
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            width: 80,
                            child: Text(
                              'Department',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 100,
                            child: Text(
                              'Requestor',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 80,
                            child: Text(
                              'Req. Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 60,
                            child: Text(
                              'Classification',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 80,
                            child: Text(
                              'Device',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 120,
                            child: Text(
                              'Trouble',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 120,
                            child: Text(
                              'Treatment',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 50,
                            child: Text(
                              'Duration(menit)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 80,
                            child: Text(
                              'PIC',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 60,
                            child: Text(
                              'Status',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Text(
                              'Remarks',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Tambahkan kolom untuk tombol aksi
                        DataColumn(
                          label: SizedBox(
                            width: 100,
                            child: Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows:
                          workOrder.map((data) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(width: 80, child: Text(data.dept)),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 100,
                                    child: Text(data.requestor),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(width: 80, child: Text(data.date)),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 60,
                                    child: Text(data.classification),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(width: 80, child: Text(data.device)),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 120,
                                    child: Text(data.trouble, softWrap: true),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 120,
                                    child: Text(data.treatment, softWrap: true),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 50,
                                    child: Text('${data.duration}'),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(width: 80, child: Text(data.pic)),
                                ),
                                DataCell(
                                  SizedBox(width: 60, child: Text(data.status)),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 150,
                                    child: Text(data.remarks, softWrap: true),
                                  ),
                                ),
                                // Tambahkan DataCell untuk tombol Edit dan Delete
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                );
              }

              return const Center(child: Text('Tidak ada item.'));
            },
          ),
        ),
      ],
    );
  }
}
