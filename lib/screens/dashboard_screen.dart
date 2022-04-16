import 'package:crypto_app/api_services/crypto_api.dart';
import 'package:crypto_app/constants/textstyles.dart';
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
          title: Text(
            'Crypto Tracker',
            style: appBarTitleStyle,
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
                      Text(
                        'Hold Up, Loading...',
                        style: contentTextStyle.copyWith(
                          color: Colors.teal,
                        ),
                      ),
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
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/coinInfo',
                            arguments: Map<String, dynamic>.from(
                              cryptoCoins[
                                  index], //passing as Map as each particular index is a Map
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            cryptoCoins[index]['name'],
                                            style: cardHeaderTextStyle,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '(' +
                                                cryptoCoins[index]['symbol'] +
                                                ')',
                                            style: cardPrimaryTextStyle,
                                          ),
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
                                          Text(
                                            'Price : ',
                                            style: descriptionTextStyle,
                                          ),
                                          Text(
                                            '\$' +
                                                double.parse(cryptoCoins[index]
                                                        ['price'])
                                                    .toStringAsFixed(2),
                                            style: cardSecondaryTextStyle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Market Capital : ',
                                            style: descriptionTextStyle,
                                          ),
                                          Text(
                                            '\$' +
                                                cryptoCoins[index]
                                                    ['market_cap'],
                                            style: cardSecondaryTextStyle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Rank : ',
                                            style: descriptionTextStyle,
                                          ),
                                          Text(
                                            cryptoCoins[index]['rank'],
                                            style: cardSecondaryTextStyle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Market Dominance : ',
                                            style: descriptionTextStyle,
                                          ),
                                          Text(
                                            (double.parse(cryptoCoins[index][
                                                            'market_cap_dominance']) *
                                                        100)
                                                    .toStringAsFixed(2) +
                                                ' %',
                                            style: cardSecondaryTextStyle,
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
