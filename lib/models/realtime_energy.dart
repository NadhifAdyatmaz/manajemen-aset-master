class RealtimeEnergyWt {
  String dateUtc;
  double windSpeed;
  double powerWatt;

  RealtimeEnergyWt(
    this.dateUtc,
    this.windSpeed,
    this.powerWatt,
  );
}

class RealtimeEnergySp {
  String dateUtc;
  double solarRad;
  double powerSp;
  double bbm;
  double powerDiesel;

  RealtimeEnergySp(
    this.dateUtc,
    this.solarRad,
    this.powerSp,
    this.bbm,
    this.powerDiesel,
  );
}
