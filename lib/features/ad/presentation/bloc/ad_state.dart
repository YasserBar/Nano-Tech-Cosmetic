import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';

abstract class AdState extends Equatable {
  final List<Ad>? ads;
  final bool hasMore;
  final bool loaded;
  const AdState(this.ads, this.hasMore, this.loaded);

  @override
  List<Object> get props => [ads!, hasMore, loaded];
}

class AdInitial extends AdState {
  const AdInitial(super.ads, super.hasMore, super.loaded);
}

class LoadingAdState extends AdState {
  const LoadingAdState(super.ads, super.hasMore, super.loaded);
}

class FailureAdState extends AdState {
  final String message;

  const FailureAdState(super.ads, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedAdsState extends AdState {
  final String message;
  const LoadedAdsState(super.ads, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [ads!, hasMore, loaded, message];
}
