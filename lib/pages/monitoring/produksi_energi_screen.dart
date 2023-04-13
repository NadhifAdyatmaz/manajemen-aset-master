import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/produksi_energi_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'sales_data.dart';

class ProduksiEnergiScreen extends StatefulWidget {
  final String idCluster;
  const ProduksiEnergiScreen({Key? key, required this.idCluster})
      : super(key: key);

  @override
  State<ProduksiEnergiScreen> createState() => _ProduksiEnergiScreenState();
}

class _ProduksiEnergiScreenState extends State<ProduksiEnergiScreen> {
  final data = [
    SalesData(0, 1500000),
    SalesData(1, 1735000),
    SalesData(2, 1678000),
    SalesData(3, 1890000),
    SalesData(4, 1907000),
    SalesData(5, 2300000),
    SalesData(6, 2360000),
    SalesData(7, 1980000),
    SalesData(8, 2654000),
    SalesData(9, 2789070),
    SalesData(10, 3020000),
    SalesData(11, 3245900),
    SalesData(12, 4098500),
    SalesData(13, 4500000),
    SalesData(14, 4456500),
    SalesData(15, 3900500),
    SalesData(16, 5123400),
    SalesData(17, 5589000),
    SalesData(18, 5940000),
    SalesData(19, 6367000),
  ];

  _getSeriesData() {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (SalesData series, _) => series.year,
          measureFn: (SalesData series, _) => series.sales,
          colorFn: (SalesData series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 12, 144, 124), //change your color here
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        title: const Text(
          'Produksi Energi (kWh) - Tuban',
          style: TextStyle(color: Color.fromARGB(255, 12, 144, 124)),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Harian',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Bulanan',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Tahunan',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ProduksiEnergiChart(
                idCluster: widget.idCluster,
              ),
              Row(
                children: [
                  const Expanded(child: Icon(Icons.show_chart)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("PLTB"),
                      ],
                    ),
                  ),
                  const Expanded(child: Icon(Icons.insights)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("PLTS"),
                      ],
                    ),
                  ),
                  const Expanded(child: Icon(Icons.stacked_line_chart)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("Diesel"),
                      ],
                    ),
                  ),
                  const Expanded(child: Icon(Icons.legend_toggle)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("Load"),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: charts.LineChart(
                  _getSeriesData(),
                  animate: true,
                ),
              )
            ],
          )),
    );
  }
}
