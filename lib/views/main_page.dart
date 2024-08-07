import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sight_companion/models/physical_keyboard.dart';
import 'package:sight_companion/models/models.dart';
import 'package:sight_companion/models/braille.dart';
import 'package:sight_companion/views/braille_ui.dart';
import 'package:sight_companion/views/keyboard_focus_node.dart';

const bool demo = false;
const String appTitle = demo ? "Braille Learning" : "Braille Learning Game";

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? targetLetter;

    targetLetter = Provider.of<GameState>(context).targetCharacter;
    String inputLetter =
        Braille.brailleBoolToChar(Provider.of<InputState>(context).keys) ?? " ";
    String inputLabel = "Input character ( ${inputLetter.toUpperCase()} ) :";

    String title = appTitle;
    int goal = Provider.of<GameState>(context).goalPos;
    int pos = Provider.of<GameState>(context).currentPos;
    int score = Provider.of<GameState>(context).score;

    switch (Provider.of<GameState>(context).state) {
      case GameStates.running:
        title = "($pos/$goal) - score: $score";
        break;
      case GameStates.won:
        if (score > 100) {
          title = "Congratulations! Score: $score";
        } else {
          title = "Game over! Score: $score";
        }

        break;
      case GameStates.initial:
      case GameStates.pause:
        break;
    }

    IconData brightness = Icons.settings_brightness;
    if (Provider.of<AppOptionsState>(context).darkTheme == true)
      brightness = Icons.mode_night;
    if (Provider.of<AppOptionsState>(context).darkTheme == false)
      brightness = Icons.light_mode;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          const KeyboardFocus(),
          /*IconButton(
            onPressed: () {

            }, icon: Icon(Icons.screen_rotation) ,tooltip: "Vertical/Horizontal layout"
          ),*/
          IconButton(
              onPressed: () {
                Provider.of<AppOptionsState>(context, listen: false)
                    .changeTheme();
              },
              icon: Icon(brightness),
              tooltip: Provider.of<AppOptionsState>(context, listen: false)
                          .darkTheme ==
                      null
                  ? "Theme (using system's)"
                  : "Theme"),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Objective text:"),
              TextField(
                minLines: 1,
                maxLines: 4,
                onChanged: (_) {
                  Provider.of<GameState>(context, listen: false).resetGame();
                },
                onTap: () {
                  Provider.of<GameState>(context, listen: false).pause();
                },
                controller:
                    Provider.of<GameState>(context, listen: false).controller,
              ),
            ]),
          ),
          Flexible(
            flex: 6,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(flex: 1),
                  Flexible(
                      flex: 10,
                      child: InputBrailleCharacter(label: inputLabel)),
                  const Spacer(flex: 1),
                  Flexible(
                      flex: 4,
                      child: TargetBrailleCharacter(
                          label: targetLetter.toUpperCase())),
                  const Spacer(flex: 1),
                ]),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              child: Text(
                  !demo
                      ? "${DateTime.now().year}, GD"
                      : "${DateTime.now().year}",
                  style: TextStyle(color: Theme.of(context).disabledColor)),
              onPressed: () {
                showLicensePage(context);
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height > 500 ? 15 : 0,
          )
        ],
      ),
    );
  }
}

class InputBrailleCharacter extends StatelessWidget {
  const InputBrailleCharacter({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    List<BrailleDotData> dotData = [];
    for (int i = 0; i < Braille.numberOfDots; i++) {
      dotData.add(BrailleDotData(
        state: Provider.of<InputState>(context).keys.value[i],
        letter: Provider.of<AppOptionsState>(context).showKeyboardLetters
            ? MyPhysicalKeyboard.letters[i]
            : " ",
        id: i,
      ));
    }
    BrailleAsBoolList input =
        Provider.of<InputState>(context, listen: false).keys;
    bool rightAnswer = Provider.of<GameState>(context).isRightAnswer(input);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
        fit: FlexFit.tight,
        child: Center(
            child: Text(
          label,
          style: const TextStyle(fontSize: 25),
        )),
      ),
      Flexible(
        flex: 5,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: BrailleCharacter(
              dots: dotData,
              onDotPress: (dotId) {
                Provider.of<InputState>(context, listen: false)
                    .changeDot(context, dotId);
              }),
        ),
      ),
      Flexible(
          flex: 1,
          child: Center(
              child: ElevatedButton(
            style: ButtonStyle(
              // toDo move color to materialStateProperties
              backgroundColor: rightAnswer
                  ? MaterialStateProperty.all<Color>(const Color(0xff00a010))
                  : null,
            ),
            onPressed: () {
              submitButtonPress(context);
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    (rightAnswer ? "✅ Next" : "Clear") +
                        (Provider.of<AppOptionsState>(context)
                                .showKeyboardLetters
                            ? " [Spacebar]"
                            : ""),
                    style: rightAnswer
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : const TextStyle(),
                    textAlign: TextAlign.center)),
          ))),
    ]);
  }
}

class TargetBrailleCharacter extends StatelessWidget {
  const TargetBrailleCharacter({super.key, required this.label});

  final String label;
  @override
  Widget build(BuildContext context) {
    bool hide = !Provider.of<GameState>(context).answerVisible;
    List<BrailleDotData> dotData = [];
    String? target = Provider.of<GameState>(context).targetCharacter;
    for (int i = 0; i < Braille.numberOfDots; i++) {
      dotData.add(BrailleDotData(
          state: hide
              ? false
              : (Braille.charToBrailleBoolList(target)?.value[i] ?? false),
          letter: hide ? "?" : "",
          id: i));
    }
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Spacer(
        flex: 22,
      ),
      const Text(
        "Objective :",
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
      Text(
        label,
        style: const TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      const Spacer(),
      Expanded(
        flex: 12,
        child: BrailleCharacter(dots: dotData),
      ),
      const Spacer(),
      TextButton(
        child: Text(hide ? "Show answer" : "Hide answer",
            textAlign: TextAlign.center),
        onPressed: () {
          Provider.of<GameState>(context, listen: false).setAnswerVisible();
        },
      ),
    ]);
  }
}

showLicensePage(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => LicensePage(
            applicationName: appTitle,
            applicationLegalese: "${DateTime.now().year}",
            applicationVersion: "1.0.1",
          ));
}
