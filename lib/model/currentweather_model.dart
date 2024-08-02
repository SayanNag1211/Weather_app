class Currentweather {
  final int id;
  final String main;
  final String description;
  final String icon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int cloudsAll;
  final int visibility;
  final int dt;
  final String country;
  final int sunrise;
  final int sunset;
  final String cityName;

  const Currentweather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.cloudsAll,
    required this.visibility,
    required this.dt,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.cityName,
  });

  factory Currentweather.fromJson(Map<String, dynamic> json) {
    return Currentweather(
      id: json['weather'][0]['id'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      seaLevel: json['main']['sea_level'],
      grndLevel: json['main']['grnd_level'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDeg: json['wind']['deg'],
      windGust: (json['wind']['gust'] as num?)?.toDouble() ?? 0.0,
      cloudsAll: json['clouds']['all'],
      visibility: json['visibility'],
      dt: json['dt'],
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      cityName: json['name'],
    );
  }
}
