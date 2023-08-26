import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/usecases/displayAds_usecase.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_event.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  final DisplayAdsUsecase displayAdsUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  AdBloc({required this.displayAdsUsecase})
      : super(const AdInitial(null, true, true, message: 'loading')) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreAdsEvent());
    });
    on<AdEvent>((event, emit) async {
      if (event is DisplayAdsEvent) {
        emit(const LoadingAdState(null, true, true, message: 'loading'));
        page = 1;
        final failureOrAds = await displayAdsUsecase(page);
        failureOrAds.fold((failure) {
          emit(switchFailure(failure));
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
        final failureOrAds = await displayAdsUsecase(page);
        failureOrAds.fold((failure) {
          page--;
          emit(switchFailure(failure));
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

AdState switchFailure(failure) {
  if (failure is OfflineFailure) {
    return const OfflineFailureAdState(null, true, true);
  } else if (failure is InternalServerErrorFailure) {
    return const InternalServerFailureAdState(null, true, true);
  } else if (failure is UnexpectedFailure) {
    return const UnexpectedFailureAdState(null, true, true);
  }
  return FailureAdState(null, true, true,
      message: globalMessage ?? "No any message");
}
