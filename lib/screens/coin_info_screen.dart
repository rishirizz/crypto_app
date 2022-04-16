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
        // body: Text(cryptoCoin!['id']),
      ),
    );
  }
}
