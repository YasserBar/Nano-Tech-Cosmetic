import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';

abstract class AdState extends Equatable {
  final List<Ad>? ads;
  final bool hasMore;
  final bool loaded;
  final String message;

  const AdState(this.ads, this.hasMore, this.loaded, {required this.message});

  @override
  List<Object> get props => [ads??[], hasMore, loaded, message];
}

class AdInitial extends AdState {
  const AdInitial(super.ads, super.hasMore, super.loaded,
      {required super.message});
}

class LoadingAdState extends AdState {
  const LoadingAdState(super.ads, super.hasMore, super.loaded,
      {required super.message});
}

class FailureAdState extends AdState {
  const FailureAdState(super.ads, super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureAdState extends AdState {
  const InternalServerFailureAdState(super.ads, super.hasMore, super.loaded,
      {super.message = AppMessages.InternalServerError});
}

class UnexpectedFailureAdState extends AdState {
  const UnexpectedFailureAdState(super.ads, super.hasMore, super.loaded,
      {super.message = AppMessages.UnexpectedException});
}

class OfflineFailureAdState extends AdState {
  const OfflineFailureAdState(super.ads, super.hasMore, super.loaded,
      {super.message = AppMessages.Offline});
}

class LoadedAdsState extends AdState {
  const LoadedAdsState(super.ads, super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props => [ads!, hasMore, loaded, message];
}
