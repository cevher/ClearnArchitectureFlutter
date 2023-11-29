part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AdviceRequestedEvent extends AdvicerEvent {

}