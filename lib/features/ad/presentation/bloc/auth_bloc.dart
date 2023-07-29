import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/usecases/ad_usecase.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/auth_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  final DisplayAdsUsecase displayAdsUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  AdBloc({required this.displayAdsUsecase})
      : super(const AdInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreAdsEvent());
    });
    on<AdEvent>((event, emit) async {
      if (event is DisplayAdsEvent) {
        emit(const LoadingAdState(null, true, true));
        final failureOrads = await displayAdsUsecase(page);
        failureOrads.fold((failure) {
          emit(FailureAdState(null, true, true, message: globalMessage!));
        }, (ads) {
          emit(LoadedAdsState(ads, true, true, message: globalMessage!));
        });
      }
    });
    on<LoadMoreAdsEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedAdsState(state.ads, true, false, message: globalMessage!));
        page++;
        final failureOrads = await displayAdsUsecase(page);
        failureOrads.fold((failure) {
          page--;
          emit(FailureAdState(null, true, true, message: globalMessage!));
        }, (ads) {
          if (ads.isEmpty) {
            page--;
            emit(LoadedAdsState(state.ads!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedAdsState([...state.ads!, ...ads], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}
