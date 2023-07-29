import 'package:equatable/equatable.dart';

abstract class AdEvent extends Equatable {
  const AdEvent();

  @override
  List<Object> get props => [];
}

class DisplayAdsEvent extends AdEvent {
  const DisplayAdsEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreAdsEvent extends AdEvent {
  const LoadMoreAdsEvent();

  @override
  List<Object> get props => [];
}
