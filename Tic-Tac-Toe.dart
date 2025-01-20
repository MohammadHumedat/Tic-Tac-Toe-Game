import 'dart:io';

import 'dart:core';//This library provides the core functionalities of the Dart language, including essential classes

bool winner = false;
bool turnOfX = true;
int moveCount = 0;
// This list contains the values entered by the user.
List<String> strValues = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
// This list contains all the winning combinations in the game.
//My assmbtion is to take one side of through, its mean that the value of 345 is the same of 543.
List<List<int>> strSuccessValues = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
];

void main() {
  //This loop to check the end of game, and to continue playing until end the game.
  while (!winner && moveCount < 9) {
    printBoard();
    inputUser();
    if (winner) break;
  }
  //This condition to tell the end of game if it's actually ended
  if (!winner) {
    print('It\'s a DRAW!');
  }
}

// Check if a player (X or O) has a winning combination.
bool checkCombination(String player) {
  for (var combination in strSuccessValues) {
    if (combination.every((index) => strValues[index] == player)) {
      return true;
    }
  }
  return false;
}

// Check if there's a winner after a player's move.
void checkWinner(String player) {
  if (checkCombination(player)) {
    printBoard();
    print('$player WON!');
    winner = true;
  }
}

// Read and validate user input, then update the board.
//I used the error detection when the input is invalled.
void inputUser() {
  print('Enter a number (1-9) for ${turnOfX ? 'X' : 'O'}:');
  String? input = stdin.readLineSync();
  if (input == null || input.isEmpty || int.tryParse(input) == null) {
    print('Invalid input! Please provide a number between 1 and 9.');
    return;
  }
  int number = int.parse(input);
  if (number < 1 || number > 9 || strValues[number - 1] == 'X' || strValues[number - 1] == 'O') {
    print('Invalid move! The spot is already taken or out of range.');
    return;
  }
  strValues[number - 1] = turnOfX ? 'X' : 'O';
  checkWinner(turnOfX ? 'X' : 'O');
  turnOfX = !turnOfX; // Switch turns
  moveCount++;
}

// Clear the screen for a better user experience.
void clearScreen() {
  if (Platform.isWindows) {
    Process.runSync("cls", [], runInShell: true);
  } else {
    Process.runSync("clear", [], runInShell: true);
  }
}

// Print the Tic Tac Toe board.
void printBoard() {
  clearScreen();
  print('\n');
  print(' ${strValues[0]} | ${strValues[1]} | ${strValues[2]}');
  print('---|---|---');
  print(' ${strValues[3]} | ${strValues[4]} | ${strValues[5]}');
  print('---|---|---');
  print(' ${strValues[6]} | ${strValues[7]} | ${strValues[8]}');
  print('\n');
}