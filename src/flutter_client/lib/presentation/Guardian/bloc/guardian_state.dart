part of 'guardian_bloc.dart';

abstract class GuardianState extends Equatable {
  const GuardianState();
  
  @override
  List<Object> get props => [];
}

class GuardianInitial extends GuardianState {}
