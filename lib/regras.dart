import 'package:poker/poker_brain.dart';

class Regras {
  Map<String, dynamic> regras(List<int> lista) {
    int maior = 0;
    int numeroDeRepetidos = 0;
    String resposta = '';
    int numeroCartasMesmoNaipe = 0;
    bool isMesmoNaipe = false;
    int numeroCartasEmSequencia = 0;
    bool isSequencia = false;
    int numeroCartasEmSequenciaAs = 0;
    bool isSequenciaAs = false;
    bool temAs = false;
    //verifica quantas cartas repetidas tem
    //caso numeroDeRepetidos = 0: nenhum par,
    //caso numeroDeRepetidos = 1 : um par,
    //caso numeroDeRepetidos = 2: dois pares,
    //caso numeroDeRepetidos = 3: uma trinca,
    //caso numeroDeRepetidos = 4: uma trinca e um par (full house),
    // caso numeroDeRepetidos = 6: uma quadra
    for (int m = 0; m < 5; m++) {
      for (int n = m + 1; n < 5; n++) {
        if (PokerBrain.cardsOptions[lista[m]]['numero'] == PokerBrain.cardsOptions[lista[n]]['numero']) {
          numeroDeRepetidos = numeroDeRepetidos + 1;
        }
      }
    }
    //verifica qual eh o maior numero da mao
    for (int i = 0; i < 5; i++) {
      for (int j = i + 1; j < 5; j++) {
        if (PokerBrain.cardsOptions[lista[i]]['numero'] >= PokerBrain.cardsOptions[lista[j]]['numero']) {
          maior = PokerBrain.cardsOptions[lista[i]]['numero'];
          if (j == 4) {
            i = 5;
          }
        } else {
          maior = PokerBrain.cardsOptions[lista[j]]['numero'];
          i = j;
          j = j++;
        }
      }
    }

    //verifica se sao todas as cartas da mao sao do mesmo naipe
    for (int m = 0; m < 5; m++) {
      for (int n = m + 1; n < 5; n++) {
        if (PokerBrain.cardsOptions[lista[m]]['naipe'] == PokerBrain.cardsOptions[lista[n]]['naipe']) {
          numeroCartasMesmoNaipe = numeroCartasMesmoNaipe + 1;
        }
      }
    }
    if (numeroCartasMesmoNaipe == 10) {
      isMesmoNaipe = true;
    }

    //verifica se tem sequencia normal
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 5; j++) {
        if (PokerBrain.cardsOptions[lista[j]]['numero'] == (maior - i - 1)) {
          numeroCartasEmSequencia = numeroCartasEmSequencia + 1;
          j = 5;
        }
      }
    }
    if (numeroCartasEmSequencia == 4) {
      isSequencia = true;
    }

    //verifica se tem As
    for (int cards in lista) {
      if (PokerBrain.cardsOptions[cards]['numero'] == 1) {
        temAs = true;
      }
    }

    //se tem As, verifica se tem sequencia com A alto (10 J Q K A)
    if (temAs == true) {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
          if (PokerBrain.cardsOptions[lista[j]]['numero'] == (13 - i)) {
            numeroCartasEmSequenciaAs = numeroCartasEmSequenciaAs + 1;
            j = 5;
          }
        }
      }
    }
    if (numeroCartasEmSequenciaAs == 4) {
      isSequenciaAs = true;
    }

    //define os nomes das maos
    switch (numeroDeRepetidos) {
      case 0:
        if (isMesmoNaipe == true && isSequenciaAs == true) {
          resposta = 'Royal Flush';
        } else if (isMesmoNaipe == true && isSequencia == true) {
          resposta = 'Straight Flush';
        } else if (isSequencia == true || isSequenciaAs == true) {
          resposta = 'Straight';
        } else if (isMesmoNaipe == true) {
          resposta = 'Flush';
        } else {
          resposta = 'Nenhum par';
        }
        break;

      case 1:
        resposta = 'Um par';
        break;
      case 2:
        resposta = 'Dois pares';
        break;
      case 3:
        resposta = 'Trinca';
        break;
      case 4:
        resposta = 'Full house';
        break;
      case 6:
        resposta = 'Quadra';
        break;
    }
    /*
    usado para testes:
    print('cartas: $listaTestePlayer1Cartas, naipes: $listaTestePlayer1Naipe $resposta');
   */

    Map<String, dynamic> resultadoPlayer = {
      'resposta': resposta,
      'maior': maior,
    };
    return resultadoPlayer;
  }
}
