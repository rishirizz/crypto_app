import 'package:crypto_app/api_services/crypto_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List cryptoCoins = [];
  @override
  void initState() {
    super.initState();
    getMyCryptoCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Crypto Tracker',
          ),
          elevation: 3,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: cryptoCoins.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      // child: SvgPicture.network(
                      //   cryptoCoins[index]['logo_url'],
                      //   height: 90,
                      // ),
                      child: Image.network(
                        cryptoCoins[index]['logo_url'],
                        height: 90,
                        errorBuilder: (context, error, stackTrace) =>
                            SvgPicture.network(
                          cryptoCoins[index]['logo_url'],
                          height: 90,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cryptoCoins[index]['name'],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text('(' + cryptoCoins[index]['symbol'] + ')'),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Text(
                            'Price : \$ ${cryptoCoins[index]['price']}',
                          ),
                          Text(
                            'Market Capital : \$ ${cryptoCoins[index]['market_cap']}',
                          ),
                          Text(
                            'Rank : ${cryptoCoins[index]['rank']}',
                          ),
                          Text(
                            'Market Dominance : ${cryptoCoins[index]['market_cap_dominance']}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getMyCryptoCurrency() async {
    getCryptoCurrency().then((reponse) {
      setState(() {
        cryptoCoins = reponse;
        debugPrint('CRYPTOCOINS=====> $cryptoCoins');
      });
    });
  }
}
