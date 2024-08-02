import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_weather/Services/localDataStore.dart';
import 'package:your_weather/const/const.dart';
import 'package:your_weather/model/currentweather_model.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart'as http;
import 'package:your_weather/model/weather_model.dart';
part 'api_service_event.dart';
part 'api_service_state.dart';

class ApiServiceBloc extends Bloc<ApiServiceEvent, ApiServiceState> {
  ApiServiceBloc() : super(const ApiServiceState()) {

    on<ApiServiceEvent>((event, emit) async{
        final prefs = await SharedPreferences.getInstance();
        final city= prefs.getString('city');
        String baseurl =await dotenv.get('API_URL');
        String apikey =await dotenv.get('API_KEY');
        const String dbName = 'today_weather.db';
        const String dbName2 = 'five_day_weather.db';
        final dbHelper=WeatherDatabaseHelper();
        bool isOnline = await Consts.isInternetAvailable();
        // bool dbExist = await dbHelper.doesDatabaseExist();
        // List<Fivedaymodel> fweather=[];
        try {
           if(isOnline) {
            print("?Yes");
            final response=await http.get(Uri.parse('$baseurl/weather?q=$city&appid=$apikey'));
            final response2=await http.get(Uri.parse('$baseurl/forecast?q=$city&appid=$apikey'));
            if (response.statusCode==200 && response2.statusCode==200) {

            Map<String,dynamic> lst1=jsonDecode(response.body);
            final Currentweather weather = Currentweather.fromJson(lst1);
            final fivedaymodel = fivedaymodelFromJson(response2.body);
            final List<ListElement> listElements = fivedaymodel.list;
            
            if (await dbHelper.doesDatabaseExist(dbName)) {
                await dbHelper.insertWeather(dbName, response.body);
            }
            if (await dbHelper.doesDatabaseExist(dbName2)) {
                await dbHelper.insertWeather(dbName2, response2.body);
            }
            

            emit(state.copyWith(status: Apistatus.succes,tweather: weather,fweather: listElements,internet: true,city: city));
          }
          else{
            print("===========>>");

            emit(state.copyWith(status: Apistatus.failed,internet: true,city: city));
          }
        }
        else{
            print("No");
            dynamic res = await dbHelper.getWeatherResponse(dbName);
            dynamic res2 = await dbHelper.getWeatherResponse(dbName2);
            Map<String,dynamic> lst1=jsonDecode(res);
            final Currentweather weather = Currentweather.fromJson(lst1);
            final fivedaymodel = fivedaymodelFromJson(res2);
            final List<ListElement> listElements = fivedaymodel.list;
            emit(state.copyWith(status: Apistatus.succes,tweather: weather,fweather: listElements,internet: false,city: city));
           }
        } 
        catch (e) {
          print("===========>>${e.toString()}");
           emit(state.copyWith(status: Apistatus.failed));
        }
       
      }
    );
  }
}
