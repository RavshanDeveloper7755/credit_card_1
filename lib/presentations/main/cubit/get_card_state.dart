part of 'get_card_cubit.dart';

abstract class GetCardState {}

class GetCardsInitial extends GetCardState {}

class GetCardInLoading extends GetCardState {}

class GetCardInSuccess extends GetCardState {
  GetCardInSuccess({required this.card});

  final List<UserCard> card;
}
