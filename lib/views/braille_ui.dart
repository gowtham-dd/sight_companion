import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sight_companion/models/models.dart';

/// This widget will ocupy the whole area by the given constraints.
class BrailleCharacter extends StatelessWidget {
  const BrailleCharacter({super.key, required this.dots, this.onDotPress});

  final List<BrailleDotData> dots;
  final Function? onDotPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center, //para pc: center
      children: <Widget>[
        Flexible(
          flex: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BrailleDot(id: 0, dotData: dots, onDotPress: onDotPress),
              const Spacer(),
              BrailleDot(id: 1, dotData: dots, onDotPress: onDotPress),
              const Spacer(),
              BrailleDot(id: 2, dotData: dots, onDotPress: onDotPress),
            ],
          ),
        ),
        Flexible(child: Container()),
        Flexible(
          flex: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BrailleDot(id: 3, dotData: dots, onDotPress: onDotPress),
              const Spacer(),
              BrailleDot(id: 4, dotData: dots, onDotPress: onDotPress),
              const Spacer(),
              BrailleDot(id: 5, dotData: dots, onDotPress: onDotPress),
            ],
          ),
        ),
      ],
    );
  }
}

class BrailleDot extends StatelessWidget {
  const BrailleDot(
      {super.key, required this.dotData, this.onDotPress, required this.id});

  final int id;
  final List<BrailleDotData> dotData;
  final Function? onDotPress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 10,
        child: RepaintBoundary(
            child: AspectRatio(
          aspectRatio: 1,
          child: IgnorePointer(
              ignoring: (onDotPress == null),
              child: RawMaterialButton(
                onPressed: () {
                  if (onDotPress != null) {
                    onDotPress!(id);
                    Provider.of<GameState>(context, listen: false).resume();
                  }
                },
                shape: const CircleBorder(
                    side: BorderSide(width: 2, color: Colors.black)),
                fillColor:
                    dotData[id].state ? Theme.of(context).hintColor : null,
                child: Text(dotData[id].letter ?? " ",
                    style: TextStyle(
                        color: Theme.of(context).shadowColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 15)),
              )),
        )));
  }
}

class BrailleDotData {
  BrailleDotData({required this.state, this.letter, required this.id});

  bool state = false;
  String? letter;
  int id;
}
