import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/baterai.dart';
import 'package:manajemen_aset/models/inverter.dart';
import 'package:manajemen_aset/pages/monitoring/baterai/sf_chart_bt.dart';
import 'package:manajemen_aset/pages/monitoring/baterai/sf_chart_bt2.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BtChart extends StatefulWidget {
  final String idBt;
  const BtChart({Key? key, required this.idBt}) : super(key: key);

  @override
  _BtChartState createState() => _BtChartState();
}

class _BtChartState extends State<BtChart> {
  List<BateraiData> _dataBt = [];
  List<BateraiData2> _dataBt2 = [];
  List<InverterData> _dataIv = [];
  List<InverterData2> _dataIv2 = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;
  late Future fetchFutureBt;
  late Future fetchFutureBt2;
  late Future fetchFutureIv;
  late Future fetchFutureIv2;

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
        fetchFutureBt = fetchDataBt(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt);
        fetchFutureBt2 =
            fetchDataBt2(DateFormat('yyyy-MM-dd').format(_dateTime!));
        fetchFutureIv = fetchDataIv(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt);
        fetchFutureIv2 =
            fetchDataIv2(DateFormat('yyyy-MM-dd').format(_dateTime!));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFutureBt =
        fetchDataBt(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt);
    fetchFutureBt2 = fetchDataBt2(DateFormat('yyyy-MM-dd').format(_dateTime!));
    fetchFutureIv =
        fetchDataIv(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt);
    fetchFutureIv2 = fetchDataIv2(DateFormat('yyyy-MM-dd').format(_dateTime!));
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

    Timer.periodic(const Duration(seconds: 33), (Timer t) => _updateDataBt());
    Timer.periodic(const Duration(seconds: 33), (Timer t) => _updateDataBt2());
    Timer.periodic(const Duration(seconds: 33), (Timer t) => _updateDataIv());
    Timer.periodic(const Duration(seconds: 33), (Timer t) => _updateDataIv2());
  }

  // mangambil data realtime baterai
  Future fetchDataBt(String date, String id) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/battery/realtime");
    var response = await http.post(
      url,
      body: {"id": id, "date": date},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['data'];

    List<BateraiData> dataBt = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime = DateFormat('HH:mm:ss')
          .format(DateTime.parse(realData[i]['datetime']));
      var voltBt = realData[i]['volt']?.toDouble() ?? 0.0;
      var ampereBt = realData[i]['ampere']?.toDouble() ?? 0.0;
      var powerBt = realData[i]['power']?.toDouble() ?? 0.0;

      dataBt.add(BateraiData(
        dateTime,
        voltBt,
        ampereBt,
        powerBt,
      ));
    }
    return _dataBt = dataBt;
  }

  // mangambil data realtime baterai
  Future fetchDataBt2(String date) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/battery/realtime");
    var response = await http.post(
      url,
      body: {"id": "3", "date": date},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['data'];

    List<BateraiData2> dataBt2 = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime = DateFormat('HH:mm:ss')
          .format(DateTime.parse(realData[i]['datetime']));
      var voltBt = realData[i]['volt']?.toDouble() ?? 0.0;
      var ampereBt = realData[i]['ampere']?.toDouble() ?? 0.0;
      var powerBt = realData[i]['power']?.toDouble() ?? 0.0;

      dataBt2.add(BateraiData2(
        dateTime,
        voltBt,
        ampereBt,
        powerBt,
      ));
    }
    return _dataBt2 = dataBt2;
  }

  // mangambil data realtime inverter
  Future fetchDataIv(String date, String id) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/inverter/realtime");
    var response = await http.post(
      url,
      body: {"id": id, "date": date},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['data'];

    List<InverterData> dataIv = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime = DateFormat('HH:mm:ss')
          .format(DateTime.parse(realData[i]['datetime']));
      var voltIv = realData[i]['volt']?.toDouble() ?? 0.0;
      var ampereIv = realData[i]['ampere']?.toDouble() ?? 0.0;
      var powerIv = realData[i]['power']?.toDouble() ?? 0.0;

      dataIv.add(InverterData(
        dateTime,
        voltIv,
        ampereIv,
        powerIv,
      ));
    }
    return _dataIv = dataIv;
  }

  // mangambil data realtime inverter
  Future fetchDataIv2(String date) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/inverter/realtime");
    var response = await http.post(
      url,
      body: {"id": "3", "date": date},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['data'];

    List<InverterData2> dataIv2 = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime = DateFormat('HH:mm:ss')
          .format(DateTime.parse(realData[i]['datetime']));
      var voltIv = realData[i]['volt']?.toDouble() ?? 0.0;
      var ampereIv = realData[i]['ampere']?.toDouble() ?? 0.0;
      var powerIv = realData[i]['power']?.toDouble() ?? 0.0;

      dataIv2.add(InverterData2(
        dateTime,
        voltIv,
        ampereIv,
        powerIv,
      ));
    }
    return _dataIv2 = dataIv2;
  }

  void _updateDataBt() {
    if (mounted) {
      setState(() {
        fetchFutureBt = fetchDataBt(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt);
      });
    }
  }

  void _updateDataBt2() {
    if (mounted) {
      setState(() {
        fetchFutureBt2 =
            fetchDataBt2(DateFormat('yyyy-MM-dd').format(_dateTime!));
      });
    }
  }

  void _updateDataIv() {
    if (mounted) {
      setState(() {
        fetchFutureIv = fetchDataIv(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt);
      });
    }
  }

  void _updateDataIv2() {
    if (mounted) {
      setState(() {
        fetchFutureIv2 =
            fetchDataIv2(DateFormat('yyyy-MM-dd').format(_dateTime!));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.idBt;
    if (id == "2") {
      return Column(
        children: [
          //date
          datePicker(),
          const Divider(thickness: 1),
          const SizedBox(
            height: 8,
          ),
          FutureBuilder(
            // future: Future.delayed(
            //   const Duration(seconds: 2),
            //   () => fetchDataBt(
            //       DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt),
            // ),
            future: fetchFutureBt,
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
                  return FutureBuilder(
                      future: fetchFutureBt2,
                      builder: (context, snapshot) {
                        return FutureBuilder(
                            future: fetchFutureIv2,
                            builder: (context, snapshot) {
                              return SfChartBT2(
                                tooltipBehavior: _tooltipBehavior,
                                zoomPanBehavior: _zoomPanBehavior,
                                trackballBehavior: _trackballBehavior,
                                dataBt: _dataBt,
                                dataBt2: _dataBt2,
                                dataIv2: _dataIv2,
                              );
                            });
                      });
                }
              }
            },
          ),
        ],
      );
    } else {
      return Column(
        children: [
          //date
          datePicker(),
          const Divider(thickness: 1),
          const SizedBox(
            height: 8,
          ),
          FutureBuilder(
            // future: Future.delayed(
            //   const Duration(seconds: 2),
            //   () => fetchDataBt(
            //       DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idBt),
            // ),
            future: fetchFutureBt,
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
                  return FutureBuilder(
                      future: fetchFutureIv,
                      builder: (context, snapshot) {
                        return SfChartBT(
                          tooltipBehavior: _tooltipBehavior,
                          zoomPanBehavior: _zoomPanBehavior,
                          trackballBehavior: _trackballBehavior,
                          dataBt: _dataBt,
                          dataIv: _dataIv,
                        );
                      });
                }
              }
            },
          ),
        ],
      );
    }
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
