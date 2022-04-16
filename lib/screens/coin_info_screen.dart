import 'package:crypto_app/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinInfoScreen extends StatefulWidget {
  final Map? cryptoCoin;
  const CoinInfoScreen(this.cryptoCoin);

  @override
  State<CoinInfoScreen> createState() => _CoinInfoScreenState();
}

class _CoinInfoScreenState extends State<CoinInfoScreen> {
  Map? cryptoCoin;

  @override
  void initState() {
    super.initState();
    cryptoCoin = widget.cryptoCoin;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cryptoCoin!['name'],
            style: appBarTitleStyle,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.network(
                cryptoCoin!['logo_url'],
                height: 30,
                errorBuilder: (context, error, stackTrace) =>
                    SvgPicture.network(
                  cryptoCoin!['logo_url'],
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cryptoCoin!['id'] + ' Details',
                  style: cardPrimaryTextStyle.copyWith(
                    color: Colors.teal[200],
                    fontSize: 22,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.teal,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rank',
                              style: descriptionTextStyle,
                            ),
                            Text(
                              '# ' + cryptoCoin!['rank'],
                              style: cardSecondaryTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: descriptionTextStyle,
                            ),
                            Text(
                              cryptoCoin!['status'],
                              style: cardSecondaryTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: descriptionTextStyle,
                            ),
                            Text(
                              '\$' +
                                  double.parse(cryptoCoin!['price'])
                                      .toStringAsFixed(2),
                              style: cardSecondaryTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Circulating Supply',
                              style: descriptionTextStyle,
                            ),
                            Text(
                              cryptoCoin!['circulating_supply'],
                              style: cardSecondaryTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Maximum Supply',
                              style: descriptionTextStyle,
                            ),
                            Text(
                              (cryptoCoin!['max_supply'] != null)
                                  ? cryptoCoin!['max_supply']
                                  : 'Unlimited',
                              style: cardSecondaryTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Numbers Exchanged',
                              style: descriptionTextStyle,
                            ),
                            Text(
                              cryptoCoin!['num_exchanges'],
                              style: cardSecondaryTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
