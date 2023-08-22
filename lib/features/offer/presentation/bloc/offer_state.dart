import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';

abstract class OfferState extends Equatable {
  final List<Offer>? offer;
  final bool hasMore;
  final bool loaded;
  final String message;
  const OfferState(this.offer, this.hasMore, this.loaded,
      {required this.message});

  @override
  List<Object> get props => [offer??[], hasMore, loaded, message];
}

class OfferInitial extends OfferState {
  const OfferInitial(super.offer, super.hasMore, super.loaded,
      {required super.message});
}

class LoadingOfferState extends OfferState {
  const LoadingOfferState(super.offer, super.hasMore, super.loaded,
      {required super.message});
}

class FailureOfferState extends OfferState {
  const FailureOfferState(super.offer, super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureOfferState extends OfferState {
  const InternalServerFailureOfferState(
      super.offer, super.hasMore, super.loaded,
      {super.message = AppMessages.internalServerError});
}

class UnexpectedFailureOfferState extends OfferState {
  const UnexpectedFailureOfferState(super.offer, super.hasMore, super.loaded,
      {super.message = AppMessages.unexpectedException});
}

class OfflineFailureOfferState extends OfferState {
  const OfflineFailureOfferState(super.offer, super.hasMore, super.loaded,
      {super.message = AppMessages.offline});
}

class LoadedOffersState extends OfferState {
  const LoadedOffersState(super.offer, super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props => [offer!, hasMore, loaded, message];
}
