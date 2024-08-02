import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_weather/Screens/HomeScreen.dart';
import 'package:your_weather/Services/API/bloc/api_service_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  // prefs.setString('city', 'Delhi');
    await _initializeCityPreference();
  // print(city);
  runApp(const MyApp());
}

Future<void> _initializeCityPreference() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('city')) {
    await prefs.setString('city', 'Delhi');
    // print("Default city set to Delhi");
  } else {
    // print("City already set: ${prefs.getString('city')}");
    return;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ApiServiceBloc()..add(ApiServiceEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffffff)),
            scaffoldBackgroundColor: const Color(0xff4A838D),
            // textTheme: GoogleFonts.poppinsTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}