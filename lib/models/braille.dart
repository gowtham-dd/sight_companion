import 'package:equatable/equatable.dart';

class Braille {
  static const int numberOfDots=6;

  static const Map<String, String> _dictionarySpecials = {
  "W" : "111010" ,
  " " : "000000" ,
  ""  : "000000" ,

  "#" : "111100" ,
  "^" : "100000" ,
  "." : "110010" ,
  "," : "000010" ,
  ":" : "010010" ,
  ";" : "000110" ,
  "?" : "100110" ,
  "!" : "010110" ,
  "(" : "110110" ,
  ")" : "110110" ,
  "\"": "110100" ,
  "_" : "100100" ,
  "@" : "011100" ,
  };

  static const bool _enableAbbreviationsDictionary=false;
  static const Map<String, String> _dictionaryAbbreviations = {

  "AND" : "101111" ,
  "FOR" : "111111" ,
  "OF"  : "110111" ,
  "THE" : "101110" ,
  "WITH": "111110" ,

  "CH"  : "100001" ,
  "GH"  : "100011" ,
  "SH"  : "101001" ,
  "TH"  : "111001" ,
  "WH"  : "111001" ,
  "ED"  : "101011" ,
  "ER"  : "111011" ,
  "OU"  : "110011" ,
  "OW"  : "101010" ,
  };

  /// returns corresponding dots in binary notation, dot #1 weighs 1, dot #3 weighs 4, etc.
  /// returns null if undefined.
  static int? _charToBraille(String input) {

    int? codeToReturn;
    const List<String> dictionaryAToJ = [ "1" , "11" , "1001" , "11001" , "10001" , "1011" , "11011" , "10011" , "1010" , "11010" ];
    const List<String> codeLetters = ["ABCDEFGHIJ" , "KLMNOPQRST", "UVXYZ"];
    const int thirdDot=4, sixthDot=32;

    input=input.toUpperCase();
    if (! (input.contains(RegExp(r"^[A-Z\d ]$")) || _dictionaryAbbreviations.containsKey(input) && _enableAbbreviationsDictionary || _dictionarySpecials.containsKey(input)) ) {
      return null;
    } else if ( input.contains(RegExp(r"^\d$")) ) {  // if input is a number, convert it to letter ( 1->a ; etc )
      if (input == "0") {input=10.toString();}
      input=codeLetters[0][int.parse(input)-1];
    }

    if (input.length == 1) {
      if ( codeLetters[0].contains(input) ) codeToReturn = int.parse(dictionaryAToJ[codeLetters[0].indexOf(input)], radix: 2);
      if ( codeLetters[1].contains(input) ) codeToReturn = int.parse(dictionaryAToJ[codeLetters[1].indexOf(input)], radix: 2) + thirdDot;
      if ( codeLetters[2].contains(input) ) codeToReturn = int.parse(dictionaryAToJ[codeLetters[2].indexOf(input)], radix: 2) + thirdDot + sixthDot;
    }

    if (_dictionarySpecials.containsKey(input)) { codeToReturn = int.parse(_dictionarySpecials[input]!, radix: 2); }
    if ( _enableAbbreviationsDictionary && _dictionaryAbbreviations.containsKey(input)) { codeToReturn = int.parse(_dictionaryAbbreviations[input]!, radix: 2); }

    return codeToReturn;

  }

  static BrailleAsBoolList? charToBrailleBoolList(String char) {
    const int pow2to6=64;
    List<bool> bitArray=[];
    int? number = _charToBraille(char);
    if (number == null) {
      return null;
    } else {
      // toDo better
      for (int i = 0 ; i < pow2to6 ; i++) {
        bool isBitSet = (number & (1 << i)) != 0;
        bitArray.add(isBitSet);
      }
      bitArray=bitArray.sublist(0,6);
      return BrailleAsBoolList( bitArray);
    }

  }

  /// looks for a match for a given braille character (cheap reverse lookup function)
  static String? brailleBoolToChar ( BrailleAsBoolList input ) {
    // try every possibility until a match occurs
    for ( int i=0 ; i < _StaticData.possibleResults.length ; i++ ) {
      if ( charToBrailleBoolList(_StaticData.possibleResults[i]) == input ) {
        return _StaticData.possibleResults[i];
      }
    }
    return null;
  }


}

/// generates 'expensive' data only once.
class _StaticData {
  // 'static final' is like creating a Singleton variable
  static final List<String> possibleResults = _init();

  static List<String> _init () {
    late List<String> possibleResults_;
    //generate list of the 26 letters
    List<String> aToZ = List.generate(26, (index) {
      int asciiValue = 'A'.codeUnitAt(0) + index;
      return String.fromCharCode(asciiValue);
    });

    possibleResults_ = aToZ;
    possibleResults_.addAll(Braille._dictionarySpecials.keys);
    if (Braille._enableAbbreviationsDictionary) { possibleResults_.addAll(Braille._dictionaryAbbreviations.keys); }
    return possibleResults_; // returns almost every possible input character that can be converted to a braille character.
  }
}

class BrailleAsBoolList extends Equatable {
  late final List<bool> value;

  BrailleAsBoolList([List<bool>? value]) {
    if (value != null) {
      assert (value.length == 6);
    }
    this.value = value ?? List.filled(Braille.numberOfDots, false);
  }

  @override
  List<Object?> get props => [value];

}

class MyTestClass {
  late final List<bool> value;

  MyTestClass([List<bool>? value]) {
    this.value = value ?? List.filled(Braille.numberOfDots, false);
  }

  @override
  bool operator ==(Object other) {
    bool isMyListEqual(List<Object?> a, List<Object?> b){
      if (a.length != b.length) return false;
      for (int i=0 ; i<a.length ; i++) {
        if (a[i] != b[i]) return false;
      }
      return true;
    }

    return identical(this, other) ||
    other is MyTestClass &&
    runtimeType == other.runtimeType &&
    isMyListEqual(value,other.value);
  }

  @override
  int get hashCode {
    return Object.hash(value[0],value[1],value[2],value[3],value[4],value[5]);
  }

}