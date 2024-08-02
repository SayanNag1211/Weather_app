import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_weather/Services/API/bloc/api_service_bloc.dart';

class Consts{
   static Widget Loading(){
     return Center(
      child:ClipRRect(
        child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
        width: 70.w,
        height: 65.h,
        decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.dg),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: const CircularProgressIndicator(color: Colors.white,strokeWidth: 6,),
        ))),
      ),);
    }
    static error(BuildContext context){
      return Center(
        child: Padding(
          padding:EdgeInsets.only(left: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 270.w,
                height: 150.h,
                child: const Image(image: AssetImage('assets/imgs/server.png')),
              ),
              SizedBox(height: 20.h,),
              IconButton(onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                // String getcity= await getCityName();
                // if (getcity=='') {
                //     prefs.setString('city', getcity.toLowerCase());
                //     BlocProvider.of<ApiServiceBloc>(context).add(ApiServiceEvent());
                // }
                String? prevcity= prefs.getString('prevcity');
                prefs.setString('city', prevcity.toString());
                // ignore: use_build_context_synchronously
                BlocProvider.of<ApiServiceBloc>(context).add(ApiServiceEvent());
              }, icon: Icon(Icons.restart_alt_outlined,size: 40.h,color: Colors.white,))
            ],
          ),
        ),
      );
    }

    static Future<bool> isInternetAvailable() async {
          final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
          // return connectivityResult != ConnectivityResult.none;
          if (connectivityResult.contains(ConnectivityResult.mobile)|| connectivityResult.contains(ConnectivityResult.wifi)) {
            return true;
          }
          else{
            return false;
          }
    }
}
//  Future<String> getCityName() async {
//     try {
//       bool isOnline = await Consts.isInternetAvailable();
//       // Check if location services are enabled
//       // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       // Check for location permissions
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//             // "Location permissions are denied.";
//           await Permission.location.request();
//           return '';
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         await Permission.location.request();
//         return '';
//       }

//       // Get the current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Perform reverse geocoding to get the city name
//       if (isOnline) {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       // Extract the city name from the placemarks
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//          return  place.locality??'';
//       }else{
//         return "";
//       }
//       }
//       return '';
//     } catch (e) {
//        return  "";
//     }
//   }