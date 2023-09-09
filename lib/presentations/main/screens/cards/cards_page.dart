import 'package:credit_card_1/presentations/main/screens/add_cards/add_cards.dart';
import 'package:credit_card_1/presentations/main/screens/widgets/card_number_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/card_bloc.dart';
import '../../cubit/get_card_cubit.dart';
import '../edit_card/edit_card.dart';
import '../helpers/helpers.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout_outlined, color: Colors.red,),
            ),
          )
        ],
        backgroundColor: Color(0xFF417BEA),
        title: const Text('All Credit Cards', style: TextStyle(color: Colors.white),),
      ),
      body: BlocBuilder<GetCardsCubit, GetCardState>(
        builder: (context, state) {
          return state is GetCardInSuccess
              ? ListView.separated(
            itemCount: state.card.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 205,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.94, -0.35),
                      end: Alignment(-0.94, 0.35),
                      colors: [Color(0xBA3E58AD), Color(0xFF1B4B98), Color(
                          0xFF6785CC)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_balance, size: 30,
                              color: Colors.white,),
                            Spacer(),
                            IconButton(onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditCardPage(
                                          card: state.card[index],
                                        ),
                                  )
                              );
                            },
                                icon: Icon(
                                  Icons.edit, size: 20, color: Colors.white,)),
                            IconButton(onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Delete'),
                                      content: Text(
                                          'Do you really want to delete?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              context.read<CardBloc>().add(
                                                DeleteCardEvent(
                                                  cardId: state.card[index]
                                                      .cardId,
                                                ),
                                              );
                                            },
                                            child: Text('Yes')),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); //close Dialog
                                          },
                                          child: Text('Close'),
                                        )
                                      ],
                                    );
                                  });
                            },
                                icon: const Icon(Icons.delete, size: 20,
                                  color: Colors.white,)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hideCardNumber(state.card[index].cardNumber),
                                style: const TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,),),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 21,
                              child: Text(
                                'VALID THRU',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 6,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 44.50,
                              child: Text(
                                state.card[index].expiry.substring(0,2)+'/'+ state.card[index].expiry.substring(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 150),
                              child: SizedBox(
                                width: 90,
                                child: Text(
                                  "CVV " + state.card[index].cvv,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                state.card[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              
                              CardNumberWidget(cardNumber: state.card[index].cardNumber)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(),
              );
            },
          )
              : const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCardsPage(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

//  state.card[index].cardNumber