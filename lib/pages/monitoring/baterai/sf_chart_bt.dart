import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/baterai.dart';
import 'package:manajemen_aset/models/inverter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChartBT extends StatelessWidget {
  const SfChartBT({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<BateraiData> dataBt,
    required List<InverterData> dataIv,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataBt = dataBt,
        _dataIv = dataIv,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<BateraiData> _dataBt;
  final List<InverterData> _dataIv;

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
          name: 'Power Baterai (W)',
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
          name: 'Power Inverter (W)',
          dataSource: _dataIv,
          enableTooltip: true,
          color: const Color.fromARGB(255, 130, 56, 248),
          xValueMapper: (dynamic data, _) => data.datetimeIv,
          yValueMapper: (dynamic data, _) => data.powerIv,
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
          name: 'Arus Baterai (A)',
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
          name: 'Arus Inverter (A)',
          dataSource: _dataIv,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 0, 212),
          xValueMapper: (dynamic data, _) => data.datetimeIv,
          yValueMapper: (dynamic data, _) => data.ampereIv,
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
