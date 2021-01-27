import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/login/login_page.dart';

import 'anfragen/bloc/anfragen_bloc.dart';
import 'bloc/data_bloc.dart';
import 'entwuerfe/bloc/entwuerfe_bloc.dart';
import 'grobplanung/bloc/grobplanung_bloc.dart';
import 'home/presentation/bloc/home_bloc.dart';
import 'home/presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // LocalDataSource().getAllCustomer();
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
            create: (context) => DataBloc()..add(LoadData())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<GrobplanungBloc>(create: (context) => GrobplanungBloc()),
        BlocProvider<EntwuerfeBloc>(create: (context) => EntwuerfeBloc()),
        BlocProvider<AnfragenBloc>(create: (context) => AnfragenBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PackLog',
        theme: ThemeData(
          accentColor: Color(0xff43425D),
          canvasColor: Color(0xffF0F0F7),
        ),
        home: LoginPage(),
      ),
    );
  }
}
