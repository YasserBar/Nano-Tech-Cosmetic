import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';

abstract class OfferState extends Equatable {
  final List<Offer>? offer;
  final bool hasMore;
  final bool loaded;
  const OfferState(this.offer, this.hasMore, this.loaded);

  @override
  List<Object> get props => [offer!, hasMore, loaded];
}

class OfferInitial extends OfferState {
  const OfferInitial(super.offer, super.hasMore, super.loaded);
}

class LoadingOfferState extends OfferState {
  const LoadingOfferState(super.offer, super.hasMore, super.loaded);
}

class FailureOfferState extends OfferState {
  final String message;

  const FailureOfferState(super.offer, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedOffersState extends OfferState {
  final String message;
  const LoadedOffersState(super.offer, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [offer!, hasMore, loaded, message];
}
