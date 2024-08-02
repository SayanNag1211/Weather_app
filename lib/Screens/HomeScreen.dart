import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_weather/Services/API/bloc/api_service_bloc.dart';
import 'package:your_weather/Widgets/WeatherCart.dart';
import 'package:your_weather/Widgets/fivedayCart.dart';
import 'package:your_weather/const/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller=TextEditingController();
    void _SearchAction()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? prevcity= prefs.getString('city');
      prefs.setString('prevcity', prevcity.toString());
      prefs.setString('city', _controller.text.trim());
      // ignore: use_build_context_synchronously
      BlocProvider.of<ApiServiceBloc>(context).add(ApiServiceEvent());
      _controller.clear();
    }
    return Scaffold(
      body: BlocBuilder<ApiServiceBloc, ApiServiceState>(
        builder: (context, state) {
          switch (state.status) {
            case Apistatus.initial:
              return Consts.Loading();
            case Apistatus.failed:
              return Consts.error(context);
            case Apistatus.succes:
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                //CurrentLocation
                currentLocation(state.city),
                //SearchBar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffE1EDF2),
                      borderRadius: BorderRadius.circular(15.dg),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Center(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onEditingComplete: _SearchAction,
                        // focusNode: _focusNode,
                        controller: _controller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on_rounded,
                              size: 18.h,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Search Location...',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //TodaysWeatherCart
                SizedBox(
                  height: 18.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: weathercart(
                    context,state.tweather.humidity,state.tweather.windSpeed,
                    state.tweather.feelsLike,state.tweather.icon,state.tweather.temp,
                    state.tweather.main,state.internet
                    ),
                  //  child: Weathercart(cheight: 350.h, cwidth: 350.w,),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    height: 120.h,
                    child: ListView.builder(
                      itemCount: state.fweather.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final e = state.fweather[index];
                        // print(e.weather[0].id);
                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: fiveDayCart(context,e.weather[0].icon.name,e.main.temp,e.dtTxt,e.main.tempMin,index,state.internet),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
          }
        },
      ),
    );
  }
}

Widget currentLocation(String city) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.h),
    child: Row(
      children: [
        Icon(
          Icons.location_on_sharp,
          size: 18.h,
          color: const Color(0xffffffff).withOpacity(0.5),
        ),
        Text(
          city,
          style: TextStyle(fontSize: 22.sp, color: const Color(0xffffffff)),
        )
      ],
    ),
  );
}
