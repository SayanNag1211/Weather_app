import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget fiveDayCart(BuildContext context,String icon, double temp,dynamic date,double lwtemp,int index,bool internet) {
    double tempC=(temp - 273.15);
    double lowtemp=(lwtemp-273.15);
    List<String> parts = icon.split('_');
    String iconT = parts[1] + parts[2].toLowerCase();
    String day = DateFormat('EEE').format(date);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container( 
          // height: 120.h,
          padding: EdgeInsets.all(8.h),
          width: 130.w,
          decoration: BoxDecoration(
            color:index==0?Colors.grey.shade200.withOpacity(0.3):Colors.grey.shade200.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.dg),
          ),
          child:  Column(
            mainAxisAlignment: internet==false?MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
            children: [
              Text(day,style: TextStyle(fontSize: 18.sp,color: const Color(0xffffffff))),
               internet==false ? Image.asset('assets/imgs/clouds.png',height: 45.h,width: 50.w,):
                Image.network("https://openweathermap.org/img/wn/$iconT@2x.png",height: 65.h,),
              RichText(
                  text: TextSpan(
                    // style: TextStyle(
                    //   fontSize: 150.sp,
                    //   color: const Color(0xffffffff),
                    // ),
                    children: [
                    TextSpan(
                      text:"${tempC.truncate()}° ",style: TextStyle(fontSize: 14.sp,color: const Color(0xffffffff)),
                    ),
                  TextSpan(
                      text: "${lowtemp.truncate()}°",
                      style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffffffff).withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                ),
            ],
          ),
        ),
      ),
    );
}
