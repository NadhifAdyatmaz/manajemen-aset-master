import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/weather_station.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChartWs extends StatelessWidget {
  const SfChartWs({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<WsData> dataWs,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataWs = dataWs,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<WsData> _dataWs;

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
            ((_dataWs.length <= 30) ? 0 : ((_dataWs.length).toDouble() - 20)),
        visibleMaximum: ((_dataWs.length - 1).toDouble()),
      ),
      series: <ChartSeries<WsData, dynamic>>[
        SplineSeries<WsData, dynamic>(
          name: 'Wind Speed (m/s)',
          dataSource: _dataWs,
          enableTooltip: true,
          color: const Color.fromARGB(225, 0, 74, 173),
          xValueMapper: (WsData data, _) => data.dateUtc,
          yValueMapper: (WsData data, _) => data.windSpeed,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WsData, dynamic>(
          name: 'Temp (C)',
          dataSource: _dataWs,
          enableTooltip: true,
          color: const Color.fromARGB(255, 27, 223, 102),
          xValueMapper: (WsData data, _) => data.dateUtc,
          yValueMapper: (WsData data, _) => data.temp,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WsData, dynamic>(
          name: 'Uv Index',
          dataSource: _dataWs,
          enableTooltip: true,
          color: const Color.fromARGB(255, 248, 56, 56),
          xValueMapper: (WsData data, _) => data.dateUtc,
          yValueMapper: (WsData data, _) => data.uvIndex,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WsData, dynamic>(
          name: 'Solar Rad',
          dataSource: _dataWs,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 136, 0),
          xValueMapper: (WsData data, _) => data.dateUtc,
          yValueMapper: (WsData data, _) => data.solarRad,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WsData, dynamic>(
          name: 'Curah Hujan',
          dataSource: _dataWs,
          enableTooltip: true,
          color: const Color.fromARGB(224, 190, 27, 223),
          xValueMapper: (WsData data, _) => data.dateUtc,
          yValueMapper: (WsData data, _) => data.curahHujan,
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
