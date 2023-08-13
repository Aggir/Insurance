part of 'internet_bloc.dart';

abstract class InternetEvent {}

class ConnectEvent extends InternetEvent {}

class DisconnectEvent extends InternetEvent {}
