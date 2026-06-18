part of 'navigation_bar_cubit.dart';

@immutable
sealed class NavigationBarState {}

final class NavigationBarInitial extends NavigationBarState {}

final class NavigationBarLoading extends NavigationBarState {}

final class NavigationBarLogout extends NavigationBarState {}

final class NavigationBarFailed extends NavigationBarState {
  final String message;

  NavigationBarFailed(this.message);
}
