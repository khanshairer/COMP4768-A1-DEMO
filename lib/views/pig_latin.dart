import 'package:flutter/material.dart';

class PigLatin extends StatefulWidget {
  @override
  _PigLatinState createState() => _PigLatinState();
}

class _PigLatinState extends State<PigLatin> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  void _Translator() {
    String translatedText = pigLatinTranslator(_controller.text);
    setState(() {
      _controller2.text =
          "Original Word :${_controller.text}\n"
          "Pig Latin : ${translatedText}";
    });
  }

  String pigLatinTranslator(String toTranslate) {
    List<String> vowels = ['a', 'e', 'i', 'o', 'u'];

    late String to_return;

    if (vowels.contains(toTranslate[0].toLowerCase())) {
      to_return = toTranslate + "way";
      return to_return;
    }

    int i = 0;
    while (i < toTranslate.length) {
      if (vowels.contains(toTranslate[i].toLowerCase())) {
        break;
      }
      i++;
    }

    to_return =
        toTranslate.substring(i, toTranslate.length) +
        toTranslate.substring(0, i) +
        "ay";

    return to_return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        toolbarOpacity: .8,
        toolbarHeight: 50,
        title: Text(
          'Pig Latin Translator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[200],
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Make children full width

              children: [
                SizedBox(height: 10),

                TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.amber[200],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.translate, color: Colors.amber[200]),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Enter word to translate',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintText: 'Word',
                    hintStyle: TextStyle(color: Colors.white70),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _Translator,
                  child: Text('Translate'),
                ),
                SizedBox(height: 20),
                Text(
                  _controller2.text,
                  style: TextStyle(
                    color: Colors.amber[200],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
