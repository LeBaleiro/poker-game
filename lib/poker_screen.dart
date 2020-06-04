import 'package:flutter/material.dart';
import 'package:poker/constants.dart';
import 'package:poker/poker_brain.dart';

class PokerScreen extends StatefulWidget {
  @override
  _PokerScreenState createState() => _PokerScreenState();
}

class _PokerScreenState extends State<PokerScreen> {
  Map retorno;
  List<int> cartasPlayer1 = [];
  List<int> cartasPlayer2 = [];
  String resultado = '';
  void aleatorio() {
    setState(() {
      retorno = PokerBrain().gerarAleatorio();
      cartasPlayer1 = retorno['cartasPlayer1'];
      cartasPlayer2 = retorno['cartasPlayer2'];
      resultado = retorno['resultado'];
    });
  }

  @override
  void initState() {
    super.initState();
    aleatorio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Poker game',
          style: TextStyle(
            color: Color(0xFF1B9642),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Player 1',
              style: kPlayerTextStyle,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Image.asset(
                  'images/card${cartasPlayer1[0]}.jpg',
                  scale: 2,
                ),
                Positioned(
                  right: -30,
                  bottom: -5,
                  child: Image.asset(
                    'images/card${cartasPlayer1[1]}.jpg',
                    scale: 2,
                  ),
                ),
                Positioned(
                  right: -60,
                  bottom: -10,
                  child: Image.asset(
                    'images/card${cartasPlayer1[2]}.jpg',
                    scale: 2,
                  ),
                ),
                Positioned(
                  right: -90,
                  bottom: -15,
                  child: Image.asset(
                    'images/card${cartasPlayer1[3]}.jpg',
                    scale: 2,
                  ),
                ),
                Positioned(
                  right: -120,
                  bottom: -20,
                  child: Image.asset(
                    'images/card${cartasPlayer1[4]}.jpg',
                    scale: 2,
                  ),
                ),
              ],
              overflow: Overflow.visible,
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Card(
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Color(0xFFFE0603),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: Text(
                    resultado,
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF1B9642),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Player 2',
              style: kPlayerTextStyle,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Image.asset(
                  'images/card${cartasPlayer2[0]}.jpg',
                  scale: 2,
                ),
                Positioned(
                  right: -30,
                  bottom: -5,
                  child: Image.asset(
                    'images/card${cartasPlayer2[1]}.jpg',
                    scale: 2,
                  ),
                ),
                Positioned(
                  right: -60,
                  bottom: -10,
                  child: Image.asset(
                    'images/card${cartasPlayer2[2]}.jpg',
                    scale: 2,
                  ),
                ),
                Positioned(
                  right: -90,
                  bottom: -15,
                  child: Image.asset(
                    'images/card${cartasPlayer2[3]}.jpg',
                    scale: 2,
                  ),
                ),
                Positioned(
                  right: -120,
                  bottom: -20,
                  child: Image.asset(
                    'images/card${cartasPlayer2[4]}.jpg',
                    scale: 2,
                  ),
                ),
              ],
              overflow: Overflow.visible,
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFF1B9642),
              onPressed: () {
                aleatorio();
                //para gerar testes:
                //PokerBrain().gerarTeste();
              },
              child: Text(
                'Jogar novamente',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
