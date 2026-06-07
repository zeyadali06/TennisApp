part of 'splash_view_cubit.dart';

@immutable
sealed class SplashViewState {}

final class SplashViewInitial extends SplashViewState {}

final class SplashViewLoading extends SplashViewState {}

final class SplashViewSuccess extends SplashViewState {}

final class SplashViewFailed extends SplashViewState {}
