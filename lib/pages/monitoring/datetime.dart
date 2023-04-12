import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class datetime extends StatefulWidget {
  const datetime({Key? key}) : super(key: key);

  @override
  State<datetime> createState() => _datetimeState();
}

class _datetimeState extends State<datetime> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion Flutter Charts',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Grouping'),
        ),
        body: Center(
          child: Container(
            child: _buildChart(),
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return SfCartesianChart(
      primaryXAxis: NumericAxis(),
      primaryYAxis: NumericAxis(),
      series: <LineSeries<DataPoint, num>>[
        LineSeries<DataPoint, num>(
          dataSource: _getData(),
          xValueMapper: (DataPoint data, _) => data.x,
          yValueMapper: (DataPoint data, _) => data.y,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  List<DataPoint> _getData() {
    List<DataPoint> data = [];

    for (int i = 0; i < 10000; i++) {
      data.add(DataPoint(i.toDouble(), i.toDouble()));
    }

    return data;
  }}

class DataPoint {
  final num x;
  final num y;

  DataPoint(this.x, this.y);
}
