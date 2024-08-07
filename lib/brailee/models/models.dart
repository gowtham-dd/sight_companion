import 'package:flutter/material.dart';
import 'package:sight_companion/models/braille.dart';
import 'package:provider/provider.dart';

enum GameStates {
  running,
  won,
  pause,
  initial
}

class AppOptionsState extends ChangeNotifier {
  bool? darkTheme;
  late bool showKeyboardLetters, verticalLayout;

  reset() {
    verticalLayout=false;
    showKeyboardLetters=false;
    notifyListeners();
  }

  AppOptionsState() {
    reset();
  }

  changeTheme() {
    darkTheme ??= false;
    darkTheme = ! darkTheme!;
    notifyListeners();
  }

  ThemeMode getTheme() {
    if (darkTheme==null) return ThemeMode.system;
    return darkTheme! ? ThemeMode.dark : ThemeMode.light;
  }

  keyboardButtonPressed() {
    showKeyboardLetters=!showKeyboardLetters;

    notifyListeners();
  }
}

class GameState extends ChangeNotifier {
  //toDo: clean up, improve

  late TextEditingController controller;
  late String targetCharacter;
  late GameStates state;
  late int goalPos, currentPos, score;
  late bool answerVisible, answerShown;

  static const String defaultGoalText = "Write the text of this field, letter by letter, by turning on the right dots.";

  GameState() {
    controller = TextEditingController(text: defaultGoalText);
    reset();
  }

  reset() {
    answerVisible=true;
    resetGame();
    notifyListeners();
  }
  resetGame() {
    answerShown=answerVisible;
    score=0;
    state  = GameStates.initial;
    targetCharacter = " ";
    goalPos=controller.value.text.length;
    currentPos = 0;
    _refreshTarget();
  }

  _refreshTarget(){
    if (goalPos==currentPos) {
      state=GameStates.won;
      currentPos = 0;
    } else if (goalPos < currentPos) {
      currentPos = 0;
    } else {
      if (goalPos == 0) { // no input text
        resetGame();
        controller.text="Example";
      }
      targetCharacter=controller.value.text[currentPos];
    }
  }

  resume() { //(on input change)
    if (state==GameStates.won){
      resetGame();
    }
    state=GameStates.running;
    _refreshTarget();
    notifyListeners();
  }
  pause(){
    state=GameStates.pause;
    notifyListeners();
  }
  bool isRightAnswer(BrailleAsBoolList input){
    return (input == (Braille.charToBrailleBoolList(targetCharacter) ?? BrailleAsBoolList()) && (state != GameStates.won));
  }
  bool submitInput(BrailleAsBoolList input){
    const bool skipSpaces=true;
    if (state != GameStates.running ) {
      return false;
    }
    _refreshTarget();
    do {
      if (isRightAnswer(input) || (targetCharacter==" " && skipSpaces) ) {
        if ( targetCharacter!=" " && input != BrailleAsBoolList() ) {
          changeScore(100);
        }
        currentPos++;
        answerShown=answerVisible;
      }
      _refreshTarget();
    } while ( targetCharacter == " " && skipSpaces && state != GameStates.won);

    notifyListeners();
    return (state == GameStates.won);
  }
  changeScore(int score) {
    if (!answerShown) this.score+=score;
    notifyListeners();
  }
  setAnswerVisible({bool? s}){
    s ??= !answerVisible;
    if (!answerVisible && state==GameStates.running) {
      changeScore(-100);
      answerShown=true;
    }
    answerVisible=s;
    notifyListeners();
  }
}

//toDo move to a class
void submitButtonPress(BuildContext context) {
  if (Provider.of<GameState>(context, listen: false).submitInput(Provider.of<InputState>(context,listen: false).keys )) {
    if (Provider.of<GameState>(context, listen: false).score < 100 ) {
      showSnackBar(context, 'Game finished. Better luck for next time.', 5);
    } else {
      showSnackBar(context, 'Congratulations!! You won.', 5);
    }
  }
  Provider.of<InputState>(context,listen: false).changeToALetter(BrailleAsBoolList());
}

//toDo move to views
void showSnackBar(BuildContext context, String message, int seconds) {
  final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: seconds),
    ),
  );
}

class InputState extends ChangeNotifier {
  late BrailleAsBoolList keys;
  late FocusNode focusNode;

  InputState() {
    reset();
  }

  @override
  void dispose() {
    focusNode.dispose(); // Focus nodes need to be disposed.
    super.dispose();
  }

  reset() {
    keys = BrailleAsBoolList();
    focusNode = FocusNode();
  }
  changeDot(BuildContext context, int index, {bool? state}) { //state == null =>  means to toggle state
    keys.value[index] = state ?? !(keys.value[index]);
    Provider.of<GameState>(context,listen: false).changeScore(-10);
    notifyListeners();
  }
  changeToALetter(BrailleAsBoolList value) {
    keys=value;
    notifyListeners();
  }
}