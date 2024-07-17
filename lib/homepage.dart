import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stopwatch stopwatch;
  late Timer t;
  late List<String> timerLaps = [];

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");

    return "$minutes:$seconds:$milliseconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 186, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 186, 253),
        title: const Text(
          "Stopwatch",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.25,
            child: Text(
              returnFormattedText(),
              style: const TextStyle(
                fontSize: 50,
                color: Colors.purple,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    stopwatch.stop();
                    timerLaps.add(returnFormattedText());
                  },
                  icon: const Icon(
                    Icons.pause_circle_filled_rounded,
                    color: Colors.purple,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    stopwatch.start();
                  },
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.purple,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    stopwatch.stop();
                    stopwatch.reset();
                    timerLaps.clear();
                  },
                  icon: const Icon(
                    Icons.stop_circle_rounded,
                    color: Colors.purple,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.45,
            child: ListView.builder(
              itemCount: timerLaps.length,
              itemBuilder: (context, index) {
                if (timerLaps.isNotEmpty) {
                  return Text(
                    'Lap${index + 1}: ${timerLaps[index].toString()}',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const Text(
                    'No laps yet',
                    style: TextStyle(color: Colors.purple),
                  );
                }
              },
            ),
          ),
          TextButton(
            onPressed: () {
              timerLaps.clear();
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.purple, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
