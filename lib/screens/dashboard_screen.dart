import 'package:crypto_app/api_services/crypto_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List cryptoCoins = [];
  bool isApiCallProcess = false;

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
            padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
            child: (isApiCallProcess == true)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/crypto_loading.json'),
                      const Text('Hold Up, Loading...'),
                    ],
                  )
                : RefreshIndicator(
                    color: Colors.teal,
                    onRefresh: () {
                      return Future.delayed(const Duration(seconds: 1), () {
                        getMyCryptoCurrency();
                      });
                    },
                    child: ListView.builder(
                      cacheExtent: 2500,
                      itemCount: cryptoCoins.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Image.network(
                                    cryptoCoins[index]['logo_url'],
                                    height: 90,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            SvgPicture.network(
                                      cryptoCoins[index]['logo_url'],
                                      height: 90,
                                    ),
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
                                        Text('(' +
                                            cryptoCoins[index]['symbol'] +
                                            ')'),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        if (index == 0)
                                          Lottie.asset(
                                            'assets/gold-badge.json',
                                            height: 30,
                                          ),
                                        if (index == 1)
                                          Lottie.asset(
                                            'assets/silver-badge.json',
                                            height: 30,
                                          ),
                                        if (index == 2)
                                          Lottie.asset(
                                            'assets/bronze-badge.json',
                                            height: 30,
                                          ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Price :  \$',
                                        ),
                                        Text(
                                          double.parse(
                                                  cryptoCoins[index]['price'])
                                              .toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Market Capital :  \$${cryptoCoins[index]['market_cap']}',
                                    ),
                                    Text(
                                      'Rank : ${cryptoCoins[index]['rank']}',
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Market Dominance : ',
                                        ),
                                        Text(
                                          (double.parse(cryptoCoins[index][
                                                          'market_cap_dominance']) *
                                                      100)
                                                  .toStringAsFixed(2) +
                                              ' %',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }

  Future getMyCryptoCurrency() async {
    setState(() {
      isApiCallProcess = true;
    });
    getCryptoCurrency().then((reponse) {
      setState(() {
        isApiCallProcess = false;
        cryptoCoins = reponse;
        debugPrint('CRYPTOCOINS=====> $cryptoCoins');
      });
    });
  }
}
