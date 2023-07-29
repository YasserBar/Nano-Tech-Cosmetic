import 'package:equatable/equatable.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class ShowOffersEvent extends OfferEvent {
  int? prodectId;
  ShowOffersEvent({this.prodectId});

  @override
  List<Object> get props => [prodectId!];
}

class LoadMoreOffersEvent extends OfferEvent {
  int? prodectId;
  LoadMoreOffersEvent({this.prodectId});

  @override
  List<Object> get props => [prodectId!];
}
