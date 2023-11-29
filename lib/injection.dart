import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/repositories/advice_repo_imlementation.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http; 
// service locator
final sl = GetIt.I;

Future<void> init() async {
  // Application Layer - Blocs
  // Factory = every time a new instance of that class
  sl.registerFactory(() => AdvicerBloc(adviceUseCases: sl()));

  // Domain Layer -
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));


  // Data Layer
  sl.registerFactory<AdviceRepo>(() => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(() => AdviceRemoteDatasourceImpl(client: sl()));


  // Externs -- For http like packages
  sl.registerFactory(() => http.Client());

}
