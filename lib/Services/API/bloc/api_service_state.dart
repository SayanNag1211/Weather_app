// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'api_service_bloc.dart';

enum Apistatus{initial, succes, failed}
class ApiServiceState extends Equatable {
  final Apistatus status;
  final  Currentweather tweather;
  // final ForecastWeather fweather;
  final List<ListElement> fweather;
  final bool internet;
  final String city;
  const ApiServiceState({
    this.status=Apistatus.initial,
    this.fweather=const<ListElement>[],
    this.internet=false,
    this.city='',
    this.tweather = const Currentweather(
      id: 0,
      main: '',
      description: '',
      icon: '',
      temp: 0.0,
      feelsLike: 0.0,
      tempMin: 0.0,
      tempMax: 0.0,
      pressure: 0,
      humidity: 0,
      seaLevel: 0,
      grndLevel: 0,
      windSpeed: 0.0,
      windDeg: 0,
      windGust: 0.0,
      cloudsAll: 0,
      visibility: 0,
      dt: 0,
      country: '',
      sunrise: 0,
      sunset: 0,
      cityName: '',
    ),
  });
  ApiServiceState copyWith({
    Apistatus? status,
    Currentweather? tweather,
    List<ListElement>? fweather,
    bool? internet,
    String? city,
  }) {
    return ApiServiceState(
      status: status ?? this.status,
      tweather: tweather ?? this.tweather,
      fweather: fweather ?? this.fweather,
      internet: internet ?? this.internet,
      city: city ?? this.city,
    );
  }
  @override
  List<Object> get props => [status,tweather,fweather,internet,city];
}

