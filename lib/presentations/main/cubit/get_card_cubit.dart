import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/user_card.dart';
import '../data/repository/user_card_repository.dart';

part 'get_card_state.dart';

class GetCardsCubit extends Cubit<GetCardState> {
  final UserCardsRepository cardsRepository;

  GetCardsCubit({required this.cardsRepository})
      : super(GetCardsInitial()) {
    fetchAllCards();
  }

  fetchAllCards() {
    emit(GetCardInLoading());
    cardsRepository.getAllCards().listen(
          (List<UserCard> cards) {
        emit(
          GetCardInSuccess(card: cards),
        );
      },
    );
  }
}
