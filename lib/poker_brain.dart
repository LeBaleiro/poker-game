import 'dart:math';

import 'package:poker/regras.dart';

class PokerBrain {
  int num;
  bool isEqual;
  Map resultadoPlayer1;
  Map resultadoPlayer2;
  List<int> cartasPlayer1 = [];
  List<int> cartasPlayer2 = [];
  String resultado = '';

  /*
 listas usadas para testes em grandes remessas:
   List<int> listaTestePlayer1Cartas = [];
   List<int> listaTestePlayer1Naipe = [];
  */
  static const Map<int, Map<String, int>> cardsOptions = {
    //copas = 1, espadas = 2, ouros = 3, paus = 4
    1: {"numero": 1, "naipe": 1}, //A
    2: {'numero': 2, "naipe": 1},
    3: {'numero': 3, "naipe": 1},
    4: {'numero': 4, "naipe": 1},
    5: {'numero': 5, "naipe": 1},
    6: {'numero': 6, "naipe": 1},
    7: {'numero': 7, "naipe": 1},
    8: {'numero': 8, "naipe": 1},
    9: {'numero': 9, "naipe": 1},
    10: {'numero': 10, "naipe": 1},
    11: {'numero': 11, "naipe": 1}, //J
    12: {'numero': 12, "naipe": 1}, //Q
    13: {'numero': 13, "naipe": 1}, //K
    14: {"numero": 1, "naipe": 2}, //A
    15: {'numero': 2, "naipe": 2},
    16: {'numero': 3, "naipe": 2},
    17: {'numero': 4, "naipe": 2},
    18: {'numero': 5, "naipe": 2},
    19: {'numero': 6, "naipe": 2},
    20: {'numero': 7, "naipe": 2},
    21: {'numero': 8, "naipe": 2},
    22: {'numero': 9, "naipe": 2},
    23: {'numero': 10, "naipe": 2},
    24: {'numero': 11, "naipe": 2}, //J
    25: {'numero': 12, "naipe": 2}, //Q
    26: {'numero': 13, "naipe": 2}, //K
    27: {"numero": 1, "naipe": 3}, //A
    28: {'numero': 2, "naipe": 3},
    29: {'numero': 3, "naipe": 3},
    30: {'numero': 4, "naipe": 3},
    31: {'numero': 5, "naipe": 3},
    32: {'numero': 6, "naipe": 3},
    33: {'numero': 7, "naipe": 3},
    34: {'numero': 8, "naipe": 3},
    35: {'numero': 9, "naipe": 3},
    36: {'numero': 10, "naipe": 3},
    37: {'numero': 11, "naipe": 3}, //J
    38: {'numero': 12, "naipe": 3}, //Q
    39: {'numero': 13, "naipe": 3}, //K
    40: {"numero": 1, "naipe": 4}, //A
    41: {'numero': 2, "naipe": 4},
    42: {'numero': 3, "naipe": 4},
    43: {'numero': 4, "naipe": 4},
    44: {'numero': 5, "naipe": 4},
    45: {'numero': 6, "naipe": 4},
    46: {'numero': 7, "naipe": 4},
    47: {'numero': 8, "naipe": 4},
    48: {'numero': 9, "naipe": 4},
    49: {'numero': 10, "naipe": 4},
    50: {'numero': 11, "naipe": 4}, //J
    51: {'numero': 12, "naipe": 4}, //Q
    52: {'numero': 13, "naipe": 4}, //K
  };

  Map<String, dynamic> gerarAleatorio() {
    cartasPlayer1.clear();
    cartasPlayer2.clear();
    /*
    listas usadas para testes em grandes remessas:
      listaTestePlayer1Cartas.clear();
      listaTestePlayer1Naipe.clear();
    */
    for (int n = 0; n < 2; n++) {
      for (int i = 0; i < 5; i++) {
        num = Random().nextInt(52) + 1;
        bool numeroRepetido = eRepetido(num);
        while (numeroRepetido) {
          num = Random().nextInt(52) + 1;
          numeroRepetido = eRepetido(num);
        }
        if (n == 0) {
          cartasPlayer1.add(num);
        } else if (n == 1) {
          cartasPlayer2.add(num);
        }
      }
    }
    /*
   usado para testes:
    for (int cartas in cartasPlayer1) {
     listaTestePlayer1Cartas.add(cardsOptions[cartas]['numero']);
     listaTestePlayer1Naipe.add(cardsOptions[cartas]['naipe']);
  }
*/
    resultadoPlayer1 = Regras().regras(cartasPlayer1);
    resultadoPlayer2 = Regras().regras(cartasPlayer2);
    print('Resultado player 1: $resultadoPlayer1');
    print('Resultado player 2: $resultadoPlayer2');
    resultadoFinal();
    print(resultado);

    Map<String, dynamic> retorno = {
      'cartasPlayer1': cartasPlayer1,
      'cartasPlayer2': cartasPlayer2,
      'resultado': resultado,
    };

////uniao das duas listas para facilitar o retorno para a poker_screen para a geracao de imagens
//    List<int> listaDuasJuntas = cartasPlayer1 + cartasPlayer2;

    return retorno;
  }

  //funcao que retorna se um numero ja foi gerado na sequencia (usada para nao repetir as cartas)
  bool eRepetido(int numero) {
    bool isEqual = false;
    for (int cartas1 in cartasPlayer1) {
      for (int cartas2 in cartasPlayer2) {
        if (numero == cartas2 || numero == cartas1) {
          isEqual = true;
        }
      }
    }
    return isEqual;
  }

  //verifica quem ganhou
  String resultadoFinal() {
    String resultPlayer2 = resultadoPlayer2['resposta'];
    switch (resultadoPlayer1['resposta']) {
      case 'Royal Flush':
        if (resultPlayer2 == 'Royal Flush') {
          resultado = 'Empate';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;

      case 'Straight Flush':
        if (resultPlayer2 == 'Straight Flush') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Quadra':
        if (resultPlayer2 == 'Quadra') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' || resultPlayer2 == 'Straight Flush') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Full house':
        if (resultPlayer2 == 'Full house') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' || resultPlayer2 == 'Straight Flush' || resultPlayer2 == 'Quadra') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Flush':
        if (resultPlayer2 == 'Flush') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' ||
            resultPlayer2 == 'Straight Flush' ||
            resultPlayer2 == 'Quadra' ||
            resultPlayer2 == 'Full house') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Straight':
        if (resultPlayer2 == 'Straight') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' ||
            resultPlayer2 == 'Straight Flush' ||
            resultPlayer2 == 'Quadra' ||
            resultPlayer2 == 'Full house' ||
            resultPlayer2 == 'Flush') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Trinca':
        if (resultPlayer2 == 'Trinca') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' ||
            resultPlayer2 == 'Straight Flush' ||
            resultPlayer2 == 'Quadra' ||
            resultPlayer2 == 'Full house' ||
            resultPlayer2 == 'Flush' ||
            resultPlayer2 == 'Straight') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Dois pares':
        if (resultPlayer2 == 'Dois pares') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' ||
            resultPlayer2 == 'Straight Flush' ||
            resultPlayer2 == 'Quadra' ||
            resultPlayer2 == 'Full house' ||
            resultPlayer2 == 'Flush' ||
            resultPlayer2 == 'Straight' ||
            resultPlayer2 == 'Trinca') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Um par':
        if (resultPlayer2 == 'Um par') {
          resultado = 'Empate';
        } else if (resultPlayer2 == 'Royal Flush' ||
            resultPlayer2 == 'Straight Flush' ||
            resultPlayer2 == 'Quadra' ||
            resultPlayer2 == 'Full house' ||
            resultPlayer2 == 'Flush' ||
            resultPlayer2 == 'Straight' ||
            resultPlayer2 == 'Trinca' ||
            resultPlayer2 == 'Dois pares') {
          resultado = 'O Player 2 ganhou!';
        } else {
          resultado = 'O Player 1 ganhou!';
        }
        break;
      case 'Nenhum par':
        if (resultPlayer2 == 'Nenhum par') {
          if (resultadoPlayer1['maior'] > resultadoPlayer2['maior']) {
            resultado = 'O Player 1 ganhou!';
          } else if (resultadoPlayer1['maior'] == resultadoPlayer2['maior']) {
            resultado = 'Empate';
          } else {
            resultado = 'O Player 2 ganhou!';
          }
        } else {
          resultado = 'O Player 2 ganhou!';
        }
        break;
    }
    return resultado;
  }

  /*
    usado para testes:
    void gerarTeste() {
      for (int numerovezes = 0; numerovezes < 1000000; numerovezes++) {
      gerarAleatorio();
    }
  }
   */

}
