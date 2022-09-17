import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({Key? key}) : super(key: key);

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  //user input controller
  TextEditingController textController = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref("hello");

  Future<void> create() async {
    await ref.push().set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }

  //variables
  String word = "";
  int consonants = 0;
  int vowels = 0;
  String palindrome = "";
  int characters = 0;
  List<String> array = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('A Word Analyzer')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Word',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Word',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 280,
              margin: const EdgeInsets.only(left: 80),
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    create();

                    //count vowels and consonants
                    array = textController.text.split("");
                    for (var i = 0; i < array.length; i++) {
                      if (array[i] == 'a' ||
                          array[i] == 'e' ||
                          array[i] == 'i' ||
                          array[i] == 'o' ||
                          array[i] == 'u')
                        vowels = vowels + 1;
                      else
                        consonants = consonants + 1;
                    }

                    //Palindrome check
                    String reverse =
                        textController.text.split('').reversed.join('');

                    if (textController.text == reverse) {
                      palindrome = 'Yes';
                    } else {
                      palindrome = 'No';
                    }

                    //count total characters
                    characters = array.length;

                    //user input
                    word = textController.text;

                    // set state to display changes
                    setState(() {});
                  },
                  child: const Text('Analyze')),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Word',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(' : ${word}'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'No of Consonants',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(' : ${consonants}'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'No of Vowels',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(' : ${vowels}'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'Number of Characters',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(' : ${characters}'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'Palindrome',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(' : ${palindrome}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
