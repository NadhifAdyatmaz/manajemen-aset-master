import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/prod_energi.dart';
import 'package:manajemen_aset/pages/monitoring/power_total/power_screen_total.dart';
import 'package:manajemen_aset/pages/monitoring/produksi_energi_screen.dart';
import 'package:manajemen_aset/pages/perangkat/perangkat_list_page.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BottomSheetMap extends StatefulWidget {
  const BottomSheetMap({
    Key? key,
    required this.namaCluster,
    required this.idCluster,
    required this.documentId,
  }) : super(key: key);

  final String namaCluster;
  final String idCluster;
  final String documentId;

  @override
  State<BottomSheetMap> createState() => _BottomSheetMapState();
}

class _BottomSheetMapState extends State<BottomSheetMap> {
  late String _date;
  final DateTime? _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
    _date = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(minutes: 1), (Timer t) => _getTime());
  }

  Future<ProdEnergi> fetchData(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/cluster/power-production-daily");
    var response = await http.post(
      url,
      body: {"id": id, "date_day": date},
    );
    if (response.statusCode == 200) {
      return ProdEnergi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load power data');
    }
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        _date = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // nama cluster
            Text(
              widget.namaCluster,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // datetime
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.calendar_month),
                Text(
                  _date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // produksi energi
            const SizedBox(height: 16),
            FutureBuilder<ProdEnergi>(
              future: fetchData(
                DateFormat('yyyy-MM-dd').format(_dateTime!),
                widget.idCluster,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final prodEnergiData = snapshot.data!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // kwh pltb
                        Column(
                          children: [
                            const Image(
                              image: AssetImage('img/pltb.png'),
                              width: 50,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'PLTB',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              prodEnergiData.totalPowerKwhWindTurbine
                                  .toStringAsFixed(3),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(225, 18, 149, 117),
                              ),
                            ),
                          ],
                        ),
                        // kwh plts
                        Column(
                          children: [
                            const Image(
                              image: AssetImage('img/plts.png'),
                              width: 50,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'PLTS',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              prodEnergiData.totalPowerKwhSolarPanel
                                  .toStringAsFixed(3),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(225, 18, 149, 117),
                              ),
                            ),
                          ],
                        ),
                        // kwh pltd
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            const Image(
                              image: AssetImage('img/pltd.png'),
                              width: 50,
                            ),
                            const Text(
                              'Diesel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              prodEnergiData.totalPowerKwhDiesel
                                  .toStringAsFixed(3),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(225, 18, 149, 117),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        // kwh total
                        Column(
                          children: [
                            const Image(
                              image: AssetImage('img/energy.png'),
                              width: 50,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              prodEnergiData.totalPowerKwhAll
                                  .toStringAsFixed(3),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(225, 18, 149, 117),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 8),

            // produksi energi (load)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Produksi Energi (kWh)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // bar chart produksi energi
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProduksiEnergiScreen(
                          idCluster: widget.idCluster,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Iconsax.chart_1),
                )
              ],
            ),

            // chart realtime monitoring produksi energi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text(
                      'Realtime Monitoring',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PowerScreenTotal(
                          idCluster: widget.idCluster,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Iconsax.diagram),
                )
              ],
            ),
            // tombol detail
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Detail',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPerangkat(
                        docClusterId: widget.documentId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: const Color.fromARGB(225, 18, 149, 117),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
