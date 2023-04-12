import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/realtime_energy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChart extends StatelessWidget {
  const SfChart({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<RealtimeEnergyWt> dataWt,
    required List<RealtimeEnergySp> dataSp,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataWt = dataWt,
        _dataSp = dataSp,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<RealtimeEnergyWt> _dataWt;
  final List<RealtimeEnergySp> _dataSp;

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
        zoomFactor: 0.2,
        zoomPosition: 0.4,
        visibleMinimum:
            ((_dataWt.length <= 30) ? 0 : ((_dataWt.length).toDouble() - 20)),
        visibleMaximum: ((_dataWt.length - 1).toDouble()),
      ),
      series: <ChartSeries<dynamic, dynamic>>[
        SplineSeries<RealtimeEnergyWt, dynamic>(
          name: 'Power PLTB (W)',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(255, 248, 56, 56),
          xValueMapper: (RealtimeEnergyWt data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergyWt data, _) => data.powerWatt,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergyWt, dynamic>(
          name: 'Wind Speed (m/s)',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(225, 0, 74, 173),
          xValueMapper: (RealtimeEnergyWt data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergyWt data, _) => data.windSpeed,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergySp, dynamic>(
          name: 'Power PLTS (W)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(224, 0, 173, 43),
          xValueMapper: (RealtimeEnergySp data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergySp data, _) => data.powerSp,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergySp, dynamic>(
          name: 'Solar Rad (W/m²)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(223, 230, 172, 14),
          xValueMapper: (RealtimeEnergySp data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergySp data, _) => data.solarRad,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergySp, dynamic>(
          name: 'Power PLTD (W)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(255, 19, 156, 190),
          xValueMapper: (RealtimeEnergySp data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergySp data, _) => data.powerDiesel,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergySp, dynamic>(
          name: 'BBM (liter)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(255, 109, 38, 34),
          xValueMapper: (RealtimeEnergySp data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergySp data, _) => data.bbm,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
      ],
    );
  }
}
