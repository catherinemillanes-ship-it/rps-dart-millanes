import 'dart:io';

/// Gets the player's name and uses a default name if no name is entered.
String getPlayerName(String defaultName) {
  stdout.write('Enter $defaultName name: ');
  String? nameInput = stdin.readLineSync();
  String playerName = nameInput?.trim() ?? '';

  if (playerName.isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }

  return playerName;
}

/// Checks if the move entered by the player is one of the valid moves.
String? validateMove(String moveInput, List<String> validMoves) {
  String selectedMove = moveInput.trim().toLowerCase();

  return validMoves.contains(selectedMove) ? selectedMove : null;
}

/// Asks the player to enter a move and keeps asking until a valid move is entered.
String getMove(String playerName, List<String> validMoves) {
  while (true) {
    stdout.write(
        '$playerName, enter your move (rock/paper/scissors): ');

    String? moveInput = stdin.readLineSync();
    String? selectedMove = validateMove(moveInput ?? '', validMoves);

    if (selectedMove != null) {
      return selectedMove;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// Checks the two moves and returns the name of the player who wins.
String? decideWinner(
    String player1Name,
    String player1Move,
    String player2Name,
    String player2Move) {
  if (player1Move == player2Move) {
    return null;
  }

  if ((player1Move == 'rock' && player2Move == 'scissors') ||
      (player1Move == 'paper' && player2Move == 'rock') ||
      (player1Move == 'scissors' && player2Move == 'paper')) {
    return player1Name;
  }

  return player2Name;
}

/// Runs the Rock, Paper, Scissors game and keeps track of the scores.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String player1Name = getPlayerName('Player 1');
  String player2Name = getPlayerName('Player 2');

  List<String> validMoves = ['rock', 'paper', 'scissors'];

  int player1Score = 0;
  int player2Score = 0;
  int roundNumber = 1;
  String playAgain;

  do {
    print('--- Round $roundNumber ---');

    String player1Move = getMove(player1Name, validMoves);

    for (int lineNumber = 0; lineNumber < 30; lineNumber++) {
      print('');
    }

    String player2Move = getMove(player2Name, validMoves);

    print(
        '$player1Name chose $player1Move. '
        '$player2Name chose $player2Move.');

    String? winner = decideWinner(
        player1Name,
        player1Move,
        player2Name,
        player2Move);

    if (winner == player1Name) {
      player1Score++;
    } else if (winner == player2Name) {
      player2Score++;
    }

    print('Result: ${winner ?? "It\'s a draw!"}');

    print(
        'Score -> $player1Name: $player1Score | '
        '$player2Name: $player2Score');

    do {
      stdout.write('Play again? (y/n): ');

      String? replayInput = stdin.readLineSync();
      playAgain = replayInput?.trim().toLowerCase() ?? 'n';

      if (playAgain != 'y' && playAgain != 'n') {
        print('Please enter y or n.');
      }
    } while (playAgain != 'y' && playAgain != 'n');

    roundNumber++;
  } while (playAgain == 'y');

  print('===== FINAL SCORE =====');

  print(
      '$player1Name: $player1Score | '
      '$player2Name: $player2Score');

  if (player1Score > player2Score) {
    print('Overall winner: $player1Name');
  } else if (player2Score > player1Score) {
    print('Overall winner: $player2Name');
  } else {
    print('Overall winner: It\'s a draw!');
  }
}
