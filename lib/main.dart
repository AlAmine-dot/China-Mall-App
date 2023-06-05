import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumia_app/feature_store/di/locator.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_bloc.dart';

import 'feature_store/presentation/home/home_screen.dart';

void main() {
  setupStoreDependencies();
  runApp(const LumiaApp());
}

class LumiaApp extends StatelessWidget {
  const LumiaApp({super.key});

  //  getDataFromRepository() async {
  //    print("Launched");
  //    List<String> dataList = await locator.get<StoreRepositoryImpl>().getAllCategoriesFromRemote();
  //   // Maintenant, vous avez accès à la liste complète des données ici
  //   // Vous pouvez effectuer d'autres opérations avec la liste
  //   print(dataList);
  // }

  @override
  Widget build(BuildContext context) {
     // getDataFromRepository();
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
          ),
        ],
        child: ScreenUtilInit(
            builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                      color: Colors.purple
                  )
              )
          ),
          home: HomeScreen(),
        )
        )
    );
  }
}