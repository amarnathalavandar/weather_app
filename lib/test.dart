import 'package:credentialtool_web/config/themes/theme.dart';
import 'package:credentialtool_web/data/datasources/remote/api/hid_origo_api.dart';
import 'package:credentialtool_web/data/datasources/zct_hid_origo_datasource.dart';
import 'package:credentialtool_web/domain/repositories/user_management_repository.dart';
import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/user_management/user_management_screen.dart';

void main() {
  runApp(MyApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ZctHidIOrigoApi>(
          create: (context) => ZctHidIOrigoApi(Dio()),
        ),
        RepositoryProvider<OZUserRemoteDataSourceImpl>(
          create: (context) => OZUserRemoteDataSourceImpl(api: RepositoryProvider.of<ZctHidIOrigoApi>(context)),
        ),
        RepositoryProvider(
          create: (context) => UserManagementRepository(remoteDataSource: RepositoryProvider.of<OZUserRemoteDataSourceImpl>(context)),
        )
       
      ],
      child:  MyApp(),
    )

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ZCTTheme.standardTheme,
      home:  UserManagementScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
