import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/prod_energi_jam.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../models/weather_station.dart';

class ProduksiEnergiChart extends StatefulWidget {
  final String idCluster;
  const ProduksiEnergiChart({Key? key, required this.idCluster})
      : super(key: key);

  @override
  _ProduksiEnergiChartState createState() => _ProduksiEnergiChartState();
}

class _ProduksiEnergiChartState extends State<ProduksiEnergiChart> {
  List<ProdEnergiWtData> _data = [];
  List<ProdEnergiSpData> _dataSp = [];
  List<ProdEnergiDsData> _dataDs = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

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
        fetchData(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
  }

  // mangambil data produksi energi dan load
  Future<void> fetchData(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/cluster/power-production-daily");
    var response = await http.post(
      url,
      body: {"id": id, "date_day": date},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> wtData = jsonData['wind_turbine']["detail"];
    List<dynamic> spData = jsonData['solar_panel']["detail"];
    List<dynamic> dsData = jsonData['diesel']["detail"];

    List<ProdEnergiWtData> dataWt = [];
    List<ProdEnergiSpData> dataSp = [];
    List<ProdEnergiDsData> dataDs = [];

    for (var i = 0; i < wtData.length; i++) {
      if (wtData[i]['power_kwh'] != null) {
        var hours = wtData[i]['hours'];
        var powerKwh = wtData[i]['power_kwh']?.toDouble() ?? 0.0;
        dataWt.add(ProdEnergiWtData(
          hours,
          powerKwh,
        ));
      }
    }

    for (var i = 0; i < spData.length; i++) {
      if (spData[i]['power_kwh'] != null) {
        var hours = spData[i]['hours'];
        var powerKwh = spData[i]['power_kwh']?.toDouble() ?? 0.0;
        dataSp.add(ProdEnergiSpData(
          hours,
          powerKwh,
        ));
      }
    }

    for (var i = 0; i < dsData.length; i++) {
      if (dsData[i]['power_kwh'] != null) {
        var hours = dsData[i]['hours'];
        var powerKwh = dsData[i]['power_kwh']?.toDouble() ?? 0.0;
        dataDs.add(ProdEnergiDsData(
          hours,
          powerKwh,
        ));
      }
    }
    _data = dataWt;
    _dataSp = dataSp;
    _dataDs = dataDs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(
          DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                //date
                datePicker(),
                const Divider(thickness: 1),
                const SizedBox(
                  height: 8,
                ),
                // SfCartesianChart(
                //   tooltipBehavior: _tooltipBehavior,
                //   zoomPanBehavior: _zoomPanBehavior,
                //   trackballBehavior: _trackballBehavior,
                //   legend: Legend(
                //     isVisible: true,
                //     height: '50%',
                //     width: '100%',
                //     position: LegendPosition.bottom,
                //     overflowMode: LegendItemOverflowMode.wrap,
                //   ),
                //   primaryXAxis: CategoryAxis(),
                //   series: <ChartSeries<dynamic, dynamic>>[
                //     StackedColumnSeries<ProdEnergiWtData, dynamic>(
                //       name: 'PLTB',
                //       groupName: 'Produksi Energi',
                //       dataSource: _data,
                //       width: 1.0,
                //       spacing: 0.2,
                //       color: const Color.fromARGB(255, 42, 73, 247),
                //       xValueMapper: (ProdEnergiWtData data, _) => data.hours,
                //       yValueMapper: (ProdEnergiWtData data, _) => data.powerKwh,
                //     ),
                //     StackedColumnSeries<ProdEnergiSpData, dynamic>(
                //       name: 'PLTS',
                //       groupName: 'Produksi Energi',
                //       dataSource: _dataSp,
                //       width: 1.0,
                //       spacing: 0.2,
                //       color: const Color.fromARGB(255, 240, 66, 35),
                //       xValueMapper: (ProdEnergiSpData data, _) => data.hours,
                //       yValueMapper: (ProdEnergiSpData data, _) => data.powerKwh,
                //     ),
                //     StackedColumnSeries<ProdEnergiDsData, dynamic>(
                //       name: 'Diesel',
                //       groupName: 'Produksi Energi',
                //       dataSource: _dataDs,
                //       width: 1.0,
                //       spacing: 0.2,
                //       color: const Color.fromARGB(255, 255, 241, 39),
                //       xValueMapper: (ProdEnergiDsData data, _) => data.hours,
                //       yValueMapper: (ProdEnergiDsData data, _) => data.powerKwh,
                //     ),
                //     // StackedColumnSeries<WsData, dynamic>(
                //     //   name: 'Load',
                //     //   groupName: 'Load',
                //     //   dataSource: _data,
                //     //   width: 1.0,
                //     //   spacing: 0.2,
                //     //   // dataLabelSettings: const DataLabelSettings(
                //     //   //     isVisible: true, showCumulativeValues: true),
                //     //   color: const Color.fromARGB(255, 96, 218, 48),
                //     //   xValueMapper: (WsData data, _) => data.dateUtc,
                //     //   yValueMapper: (WsData data, _) => data.windDir,
                //     // ),
                //   ],
                // ),
              ],
            );
          }
        }
      },
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
