import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? _dateTime = DateTime.now();
  // menampilkan date picker
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        _dateTime = _dateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // id asset
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text(
                  '0604001',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(225, 18, 149, 117),
                  ),
                ),
              ),
            ),

            // spek dasar mekanik
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Spek Dasar Mekanik',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(225, 18, 149, 117),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "SPD 1.1: Bilah",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "SPD 1.2: Anonim",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "SPD 1.3: 1.5 m",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // spek dasar elektrik
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Spek Dasar Elektrik',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(225, 18, 149, 117),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "SPD 2.1: Generator",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "SPD 2.2: 400W",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // spek dasar sipil
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Spek Dasar Sipil',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(225, 18, 149, 117),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "SPD 3.1: Tower",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "SPD 3.2: 7m",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // datetime picker
            datePicker(),

            // table
            Table(
              // textDirection: TextDirection.LTR,
              // border: TableBorder.all(),
              // columnWidths: {
              //   0: FractionColumnWidth(.4),
              // },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('RPM Generator Max (rpm)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('RPM Bilah Max (rpm)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [Text('Prod kwh (kWh)'), Text('500')],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Daya (P) Max (Watt)'),
                          Text('50')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Tegangan Max (Volt)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Arus Max (Ampere)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('RPM Bilah Max (rpm)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Wind Sped Max (m/s)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Wind Speed Avg (m/s)'),
                          Text('500')
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),

            // DataTable(columns: <DataColumn>[
            //   DataColumn(label: Text("Dessert (100g serving)")),
            //   DataColumn(label: Text("Calories")),
            //   DataColumn(label: Text("Fat (g)")),
            //   DataColumn(label: Text("Protein (g)")),
            // ], rows: rows)
          ],
        ),
      ),
    );
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Iconsax.calendar_1),
            const SizedBox(
              width: 16,
            ),
            Text(
              _dateTime == null
                  ? DateFormat('dd/MM/yyyy').format(DateTime.now())
                  : DateFormat('dd/MM/yyyy').format(_dateTime!),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () async {
                _showDatePicker();
              },
              icon: const Icon(Iconsax.arrow_down_1),
            ),
          ],
        ),
      ],
    );
  }
}
