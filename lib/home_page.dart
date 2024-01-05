import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'coin_model.dart';
import 'widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CryptoCurrency> cryptoList = [];

  @override
  void initState() {
    super.initState();
    fetchCryptoData();
  }

  Future<void> fetchCryptoData() async {
    final apiKey = '029b2f35-ccfa-442e-ab70-796ad3386ee2';

    final apiUrl =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-CMC_PRO_API_KEY': apiKey},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> cryptoDataList = data['data'];

      setState(() {
        cryptoList = cryptoDataList.map((cryptoData) {
          return CryptoCurrency.fromMap(cryptoData);
        }).toList();
      });
    } else {
      throw Exception('Failed to load crypto data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Crypto Currency App'),
      ),
      body: GridView.builder(
        itemCount: cryptoList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 220,
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        // total number of items
        itemBuilder: (context, index) {
          Widget coinLogo = CoinLogoWidget(coin: cryptoList[index]);
          String coinName = (cryptoList[index].name);
          String coinSymbol = (cryptoList[index].symbol);
          String coinPrice =
              ('\$${cryptoList[index].price.toStringAsFixed(2)}');
          return Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$coinName",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      coinSymbol,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        coinLogo,
                      ],
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          coinPrice,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
