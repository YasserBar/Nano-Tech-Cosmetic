import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/usecases/show_offers_usecase.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/bloc/offer_event.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/bloc/offer_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final ShowOffersUsecase showOffersUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  int? prodectId;
  bool isLoadingMore = false;

  OfferBloc({required this.showOffersUsecase})
      : super(const OfferInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(LoadMoreOffersEvent(prodectId: prodectId));
    });
    on<ShowOffersEvent>((event, emit) async {
      emit(const LoadingOfferState(null, true, true));
      final failureOrOffer = await showOffersUsecase(page);
      failureOrOffer.fold((failure) {
        emit(FailureOfferState(null, true, true, message: globalMessage!));
      }, (offers) {
        emit(LoadedOffersState(offers, true, true, message: globalMessage!));
      });
    });
    on<LoadMoreOffersEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedOffersState(state.offer, true, false,
            message: globalMessage!));
        page++;
        final failureOrOffer = await showOffersUsecase(page);
        failureOrOffer.fold((failure) {
          page--;
          emit(LoadedOffersState(null, true, true, message: globalMessage!));
        }, (offer) {
          if (offer.isEmpty) {
            page--;
            emit(LoadedOffersState(state.offer!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedOffersState([...state.offer!, ...offer], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}
