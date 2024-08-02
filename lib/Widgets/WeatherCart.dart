import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


  Widget weathercart(BuildContext context,int humidity, double wind,double feelslike,String icon, double temp,String main,bool internet) {
    double feelsC=(feelslike - 273.15);
    double tempC=(temp-273.15);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container( 
          // padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.dg),
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Padding(
                padding:  EdgeInsets.only(left: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${tempC.truncate().toString()}",style: TextStyle(fontSize: 150.sp,color: const Color(0xffffffff),),),
                    Text("°C",style: TextStyle(fontSize: 40.sp,color: const Color(0xffffffff).withOpacity(0.5),),),
                  ],
                ),
              ),
             Text(main,style: TextStyle(fontSize: 40.sp,color: const Color(0xffffffff)),),

              SizedBox(
                child:internet==false ? Image.asset('assets/imgs/clouds.png',height: 45.h,width: 50.w,):
                Image.network("https://openweathermap.org/img/wn/$icon@2x.png",)
               
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subcart("temp","${feelsC.truncate()}°C","Feels like"),
                    subcart("humidity","$humidity","Humidity"),
                    subcart("wind","$wind","Wind"),
                  ],
                ),
              ),
              SizedBox(height: 8.h,),
            ],
          ),
        ),
      ),
    );
  }

Widget subcart(String img, String speed, String des){
  return  Column(
    children: [
      Image(image: AssetImage("assets/imgs/$img.png",),height: 18.h,color: const Color(0xffffffff),),
      Text(speed,style: TextStyle(fontSize: 12.sp,color: const Color(0xffffffff))),
      Text(des,style: TextStyle(fontSize: 12.sp,color: const Color(0xffffffff).withOpacity(0.6))),
      // Icon(Icons.wind)
    ],
  );
}