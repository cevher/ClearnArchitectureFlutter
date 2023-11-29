// ignore_for_file: unused_import

import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

const generalFailureMessage = "Something gone wrong, please try again!";
const serverFailureMessage = "Server failure happened!";
const cacheFailureMessage = "Something gone wrong! cache failure!";

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdviceUseCases adviceUseCases;

  AdvicerBloc({required this.adviceUseCases}) : super(AdvicerInitial()) {
    // could also use other usecases

    on<AdvicerEvent>((event, emit) async {
      
      emit(AdvicerStateLoading());
      // execute bussiness logic
      // for example get and advice
      debugPrint("Fake get advice triggered");
      
      final failureOrAdvice  = await adviceUseCases.getAdvice();  
      await Future.delayed(const Duration(seconds: 2), () {});
      failureOrAdvice.fold(
        (failure) => emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice))
        );
      debugPrint("Got advice, be wise");
      // emit(AdvicerStateLoaded(advice: advice.advice));

      // emit(AdvicerStateError(message: "Error message is emitted"));
    });

    // more events can be added if needed
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
        case CacheFailure:
          return cacheFailureMessage;
        default:
          return generalFailureMessage;
    }
  }
}
