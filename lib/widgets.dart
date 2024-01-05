import 'package:flutter/material.dart';
import 'coin_model.dart';

class CoinLogoWidget extends StatelessWidget {
  final CryptoCurrency coin;

  CoinLogoWidget({
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    var imageUrl = "assets/coins/" + coin.symbol.toLowerCase() + ".png";
    // var imageUrl ="https://github.com/spothq/cryptocurrency-icons/blob/master/128/color/${coin.symbol.toLowerCase()}.png";

    print(imageUrl);

    return Image.asset(
      imageUrl,
      height: 100,
    );
  }
}
