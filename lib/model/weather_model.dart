// class ForecastWeather {
//   final int dt;
//   final double temp;
//   final double feelsLike;
//   final double tempMin;
//   final double tempMax;
//   final int pressure;
//   final int humidity;
//   final int seaLevel;
//   final int grndLevel;
//   final double windSpeed;
//   final int windDeg;
//   final double windGust;
//   final int cloudsAll;
//   final int visibility;
//   final double pop;
//   final double rain3h;
//   final String weatherMain;
//   final String weatherDescription;
//   final String weatherIcon;
//   final String pod;
//   final String cityName;
//   final String country;
//   final int sunrise;
//   final int sunset;

//   const ForecastWeather({
//     required this.dt,
//     required this.temp,
//     required this.feelsLike,
//     required this.tempMin,
//     required this.tempMax,
//     required this.pressure,
//     required this.humidity,
//     required this.seaLevel,
//     required this.grndLevel,
//     required this.windSpeed,
//     required this.windDeg,
//     required this.windGust,
//     required this.cloudsAll,
//     required this.visibility,
//     required this.pop,
//     required this.rain3h,
//     required this.weatherMain,
//     required this.weatherDescription,
//     required this.weatherIcon,
//     required this.pod,
//     required this.cityName,
//     required this.country,
//     required this.sunrise,
//     required this.sunset,
//   });

//   factory ForecastWeather.fromJson(Map<String, dynamic> json) {
//     return ForecastWeather(
//       dt: json['dt'] ?? 0,
//       temp: _getDouble(json['main'], 'temp'),
//       feelsLike: _getDouble(json['main'], 'feels_like'),
//       tempMin: _getDouble(json['main'], 'temp_min'),
//       tempMax: _getDouble(json['main'], 'temp_max'),
//       pressure: json['main']?['pressure'] ?? 0,
//       humidity: json['main']?['humidity'] ?? 0,
//       seaLevel: json['main']?['sea_level'] ?? 0,
//       grndLevel: json['main']?['grnd_level'] ?? 0,
//       windSpeed: _getDouble(json['wind'], 'speed'),
//       windDeg: json['wind']?['deg'] ?? 0,
//       windGust: _getDouble(json['wind'], 'gust'),
//       cloudsAll: json['clouds']?['all'] ?? 0,
//       visibility: json['visibility'] ?? 0,
//       pop: _getDouble(json, 'pop'),
//       rain3h: _getDouble(json['rain'], '3h'),
//       weatherMain: json['weather']?[0]?['main'] ?? '',
//       weatherDescription: json['weather']?[0]?['description'] ?? '',
//       weatherIcon: json['weather']?[0]?['icon'] ?? '',
//       pod: json['sys']?['pod'] ?? '',
//       cityName: json['city']?['name'] ?? '',
//       country: json['city']?['country'] ?? '',
//       sunrise: json['city']?['sunrise'] ?? 0,
//       sunset: json['city']?['sunset'] ?? 0,
//     );
//   }

//   static double _getDouble(Map<String, dynamic>? map, String key) {
//     return (map?[key] as num?)?.toDouble() ?? 0.0;
//   }
// }
// To parse this JSON data, do
//
//     final fivedaymodel = fivedaymodelFromJson(jsonString);

import 'dart:convert';

Fivedaymodel fivedaymodelFromJson(String str) => Fivedaymodel.fromJson(json.decode(str));

String fivedaymodelToJson(Fivedaymodel data) => json.encode(data.toJson());

class Fivedaymodel {
    String cod;
    int message;
    int cnt;
    List<ListElement> list;
    City city;

    Fivedaymodel({
        required this.cod,
        required this.message,
        required this.cnt,
        required this.list,
        required this.city,
    });

    factory Fivedaymodel.fromJson(Map<String, dynamic> json) => Fivedaymodel(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]),
    );

    Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "city": city.toJson(),
    };
}

class City {
    int id;
    String name;
    Coord coord;
    String country;
    int population;
    int timezone;
    int sunrise;
    int sunset;

    City({
        required this.id,
        required this.name,
        required this.coord,
        required this.country,
        required this.population,
        required this.timezone,
        required this.sunrise,
        required this.sunset,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Coord {
    double lat;
    double lon;

    Coord({
        required this.lat,
        required this.lon,
    });

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
    };
}

class ListElement {
    int dt;
    MainClass main;
    List<Weather> weather;
    Clouds clouds;
    Wind wind;
    int visibility;
    double pop;
    Rain? rain;
    Sys sys;
    DateTime dtTxt;

    ListElement({
        required this.dt,
        required this.main,
        required this.weather,
        required this.clouds,
        required this.wind,
        required this.visibility,
        required this.pop,
        this.rain,
        required this.sys,
        required this.dtTxt,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble(),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds.toJson(),
        "wind": wind.toJson(),
        "visibility": visibility,
        "pop": pop,
        "rain": rain?.toJson(),
        "sys": sys.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
    };
}

class Clouds {
    int all;

    Clouds({
        required this.all,
    });

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class MainClass {
    double temp;
    double feelsLike;
    double tempMin;
    double tempMax;
    int pressure;
    int seaLevel;
    int grndLevel;
    int humidity;
    double tempKf;

    MainClass({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.seaLevel,
        required this.grndLevel,
        required this.humidity,
        required this.tempKf,
    });

    factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
    };
}

class Rain {
    double the3H;

    Rain({
        required this.the3H,
    });

    factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "3h": the3H,
    };
}

class Sys {
    Pod pod;

    Sys({
        required this.pod,
    });

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: podValues.map[json["pod"]]!,
    );

    Map<String, dynamic> toJson() => {
        "pod": podValues.reverse[pod],
    };
}

enum Pod {
    D,
    N
}

final podValues = EnumValues({
    "d": Pod.D,
    "n": Pod.N
});

class Weather {
    int id;
    MainEnum main;
    Description description;
    Icon icon;

    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });
    
    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainEnumValues.map[json["main"]]??MainEnum.CLOUDS,
        description: descriptionValues.map[json["description"]]?? Description.LIGHT_RAIN,
        icon: iconValues.map[json["icon"]]??Icon.THE_04_D,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": iconValues.reverse[icon],
    };
}

enum Description {
    LIGHT_RAIN,
    MODERATE_RAIN,
    OVERCAST_CLOUDS
}

final descriptionValues = EnumValues({
    "light rain": Description.LIGHT_RAIN,
    "moderate rain": Description.MODERATE_RAIN,
    "overcast clouds": Description.OVERCAST_CLOUDS
});

enum Icon {
    THE_04_D,
    THE_04_N,
    THE_10_D,
    THE_10_N
}

final iconValues = EnumValues({
    "04d": Icon.THE_04_D,
    "04n": Icon.THE_04_N,
    "10d": Icon.THE_10_D,
    "10n": Icon.THE_10_N
});

enum MainEnum {
    CLOUDS,
    RAIN
}

final mainEnumValues = EnumValues({
    "Clouds": MainEnum.CLOUDS,
    "Rain": MainEnum.RAIN
});

class Wind {
    double speed;
    int deg;
    double gust;

    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
