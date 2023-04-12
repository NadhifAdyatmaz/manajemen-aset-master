import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/weather_station.dart';
import 'package:manajemen_aset/pages/monitoring/weather_station/sf_chart_ws.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class WsChart extends StatefulWidget {
  final String idWs;
  const WsChart({Key? key, required this.idWs}) : super(key: key);

  @override
  _WsChartState createState() => _WsChartState();
}

class _WsChartState extends State<WsChart> {
  List<WsData> _dataWs = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;
  late Future fetchFuture;
  late Future fetchDailyProd;

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
        fetchFuture =
            fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFuture =
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
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
    );
    Timer.periodic(const Duration(minutes: 3), (Timer t) => _updateData());
  }

  // mangambil data weather station
  Future fetchData(String date, String id) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/weather-station/status");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['real_data'];

    List<WsData> dataWs = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime =
          DateFormat('HH:mm:ss').format(DateTime.parse(realData[i]['date']));
      var windSpeed = realData[i]['wind_speed']?.toDouble() ?? 0.0;
      var curahHujan = realData[i]['curah_hujan']?.toDouble() ?? 0.0;
      var windDir = realData[i]['wind_dir']?.toDouble() ?? 0.0;
      var temp = realData[i]['temp']?.toDouble() ?? 0.0;
      var uvIndex = realData[i]['uv_index']?.toDouble() ?? 0.0;
      var solarRad = realData[i]['solar_rad']?.toDouble() ?? 0.0;

      dataWs.add(WsData(
        dateTime,
        windSpeed,
        curahHujan,
        windDir,
        temp,
        uvIndex,
        solarRad,
      ));
    }
    return _dataWs = dataWs;
  }

  void _updateData() {
    if (mounted) {
      setState(() {
        fetchFuture =
            fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //date
        datePicker(),
        const Divider(thickness: 1),
        const SizedBox(
          height: 8,
        ),
        FutureBuilder(
          future: fetchFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                // height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SfChartWs(
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  dataWs: _dataWs,
                );
              }
            }
          },
        ),
      ],
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
