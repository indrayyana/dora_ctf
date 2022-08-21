import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Flag extends StatefulWidget {
  const Flag({Key? key}) : super(key: key);

  @override
  State<Flag> createState() => _FlagState();
}

class _FlagState extends State<Flag> {
  var text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child: Container(
              height: MediaQuery.maybeOf(context)!.size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'SlashRoot CTF 6.0',
                            style: TextStyle(fontSize: 22, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Image.asset(
                      'images/Dora.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                      ),
                      onPressed: () async {
                        text = await scanner.scan();
                        setState(() {});
                      },
                      child: const Text(
                        'Cari Flag',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 150,
                      width: 250,
                      child: text == null
                          ? Image.asset(
                              'images/Flag.png',
                            )
                          : Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text('$text',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green)),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
