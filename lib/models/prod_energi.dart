// model
class ProdEnergi {
  final dynamic totalPowerKwhWindTurbine;
  final dynamic totalPowerKwhSolarPanel;
  final dynamic totalPowerKwhDiesel;
  final dynamic totalPowerKwhAll;

  ProdEnergi({
    required this.totalPowerKwhWindTurbine,
    required this.totalPowerKwhSolarPanel,
    required this.totalPowerKwhDiesel,
    required this.totalPowerKwhAll,
  });

  factory ProdEnergi.fromJson(Map<String, dynamic> json) {
    return ProdEnergi(
      totalPowerKwhWindTurbine: json['wind_turbine']['power_kwh'],
      totalPowerKwhSolarPanel: json['solar_panel']['power_kwh'],
      totalPowerKwhDiesel: json['diesel']['power_kwh'],
      totalPowerKwhAll: json['all']['total_power_kwh'],
    );
  }
}
