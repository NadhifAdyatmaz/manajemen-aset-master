import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/baterai.dart';
import 'package:manajemen_aset/models/inverter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChartBT2 extends StatelessWidget {
  const SfChartBT2({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<BateraiData> dataBt,
    required List<BateraiData2> dataBt2,
    required List<InverterData2> dataIv2,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataBt = dataBt,
        _dataBt2 = dataBt2,
         _dataIv2 = dataIv2,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<BateraiData> _dataBt;
  final List<BateraiData2> _dataBt2;
  final List<InverterData2> _dataIv2;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: _trackballBehavior,
      legend: Legend(
        isVisible: true,
        height: '50%',
        width: '100%',
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      axes: <ChartAxis>[
        NumericAxis(
          name: 'yAxis',
          // title: AxisTitle(
          //   text: 'm/s',
          //   textStyle: const TextStyle(fontSize: 12),
          // ),
          opposedPosition: true,
          interval: 5,
        )
      ],
      primaryXAxis: CategoryAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 10,
        zoomFactor: 0.95,
        visibleMinimum:
            ((_dataBt.length <= 30) ? 0 : ((_dataBt.length).toDouble() - 20)),
        visibleMaximum: ((_dataBt.length - 1).toDouble()),
      ),
      series: <ChartSeries<dynamic, dynamic>>[
        SplineSeries<dynamic, dynamic>(
          name: 'P8 (W)',
          dataSource: _dataBt,
          enableTooltip: true,
          color: const Color.fromARGB(255, 248, 56, 56),
          xValueMapper: (dynamic data, _) => data.datetimeBt,
          yValueMapper: (dynamic data, _) => data.powerBt,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<dynamic, dynamic>(
          name: 'P9 (W)',
          dataSource: _dataBt2,
          enableTooltip: true,
          color: const Color.fromARGB(255, 110, 248, 56),
          xValueMapper: (dynamic data, _) => data.datetimeBt2,
          yValueMapper: (dynamic data, _) => data.powerBt2,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<dynamic, dynamic>(
          name: 'P10 (W)',
          dataSource: _dataIv2,
          enableTooltip: true,
          color: const Color.fromARGB(255, 130, 56, 248),
          xValueMapper: (dynamic data, _) => data.datetimeIv2,
          yValueMapper: (dynamic data, _) => data.powerIv2,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<dynamic, dynamic>(
          name: 'Tegangan (V)',
          dataSource: _dataBt,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 136, 0),
          xValueMapper: (dynamic data, _) => data.datetimeBt,
          yValueMapper: (dynamic data, _) => data.voltBt,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<dynamic, dynamic>(
          name: 'I8 (A)',
          dataSource: _dataBt,
          enableTooltip: true,
          color: const Color.fromARGB(223, 0, 110, 255),
          xValueMapper: (dynamic data, _) => data.datetimeBt,
          yValueMapper: (dynamic data, _) => data.ampereBt,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<dynamic, dynamic>(
          name: 'I9 (A)',
          dataSource: _dataBt2,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 0, 212),
          xValueMapper: (dynamic data, _) => data.datetimeBt2,
          yValueMapper: (dynamic data, _) => data.ampereBt2,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<dynamic, dynamic>(
          name: 'I10 (A)',
          dataSource: _dataIv2,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 0, 212),
          xValueMapper: (dynamic data, _) => data.datetimeIv2,
          yValueMapper: (dynamic data, _) => data.ampereIv2,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
      ],
    );
  }
}
