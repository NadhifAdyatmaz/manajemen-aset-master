import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/realtime_energy.dart';
import 'package:manajemen_aset/pages/monitoring/power_total/sf_chart_p.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PowerChartTotal extends StatefulWidget {
  final String idCluster;
  const PowerChartTotal({Key? key, required this.idCluster}) : super(key: key);

  @override
  _PowerChartTotalState createState() => _PowerChartTotalState();
}

class _PowerChartTotalState extends State<PowerChartTotal> {
  List<RealtimeEnergyWt> _dataWt = [];
  List<RealtimeEnergySp> _dataSp = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;
  late Future fetchFutureWt;
  late Future fetchFutureSp;
  DateTime? _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchFutureWt = fetchDataWt(
        DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
    fetchFutureSp = fetchDataSp(
        DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
      // maximumZoomLevel: 1,
    );
    Timer.periodic(const Duration(minutes: 2), (Timer t) => _updateData());
  }

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
        fetchFutureWt = fetchDataWt(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
        fetchFutureSp = fetchDataSp(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
      });
    });
  }

  // mangambil data wt
  Future fetchDataWt(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/wind-turbine/power-status");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> prodKwh = jsonData['prod_kwh'];

    List<RealtimeEnergyWt> dataWt = [];

    for (var i = 0; i < prodKwh.length; i++) {
      var dateUtc =
          DateFormat('HH:mm:ss').format(DateTime.parse(prodKwh[i]['date_utc']));
      var windSpeed = prodKwh[i]['wind_speed']?.toDouble() ?? 0.0;
      var powerWatt = prodKwh[i]['power_watt']?.toDouble() ?? 0.0;

      dataWt.add(RealtimeEnergyWt(
        dateUtc,
        windSpeed,
        powerWatt,
      ));
    }

    if (mounted) {
      setState(() {
        _dataWt = dataWt;
      });
    }
    // return _dataWt = dataReal;
  }

  // mangambil data sp
  Future fetchDataSp(String date, String id) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/solar-panel/power-status");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> prodKwh = jsonData['prod_kwh'];

    List<RealtimeEnergySp> dataSp = [];

    for (var i = 0; i < prodKwh.length; i++) {
      var dateUtc =
          DateFormat('HH:mm:ss').format(DateTime.parse(prodKwh[i]['date_utc']));
      var solarRad = prodKwh[i]['solar_rad']?.toDouble() ?? 0.0;
      var powerWatt = prodKwh[i]['power']?.toDouble() ?? 0.0;

      dataSp.add(RealtimeEnergySp(dateUtc, solarRad, powerWatt, 0, 0));
    }

    if (mounted) {
      setState(() {
        _dataSp = dataSp;
      });
    }
    // return _dataWt = dataReal;
  }

  void _updateData() {
    if (mounted) {
      setState(() {
        fetchFutureWt = fetchDataWt(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
        fetchFutureSp = fetchDataSp(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return (_dataWt.isNotEmpty)
    return FutureBuilder(
      // future: Future.delayed(
      //     const Duration(seconds: 2),
      //     () => fetchData(
      //         DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster)),
      future: fetchFutureWt,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return FutureBuilder(
                future: fetchFutureSp,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      //date
                      datePicker(),
                      const Divider(thickness: 1),
                      const SizedBox(
                        height: 8,
                      ),
                      SfChart(
                        tooltipBehavior: _tooltipBehavior,
                        zoomPanBehavior: _zoomPanBehavior,
                        trackballBehavior: _trackballBehavior,
                        dataWt: _dataWt,
                        dataSp: _dataSp,
                      ),
                    ],
                  );
                });
          }
        }
      },
    );
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Iconsax.calendar_1),
        const SizedBox(width: 16),
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
    );
  }
}
