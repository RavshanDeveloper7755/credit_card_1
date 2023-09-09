import 'package:flutter/material.dart';

class CardNumberWidget extends StatelessWidget {
  final String cardNumber;

  const CardNumberWidget({Key? key, required this.cardNumber}) : super(key: key);

  String getLogoImagePath() {
    if (cardNumber.startsWith('9860')) {
      return 'assets/images/humo.png';
    } else if (cardNumber.startsWith('4500')) {
      return 'assets/images/visa.png';
    } else {
      return 'assets/images/uzcard.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    String logoImagePath = getLogoImagePath();

    return Column(
      children: [
        Image.asset(
          logoImagePath,
          width: 25,
          height: 20,
        ),
      ],
    );
  }
}

