import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mencari Flag...'),
        actions: [
          IconButton(
            onPressed: () => cameraController.toggleTorch(),
            icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return Icon(Icons.flash_off, color: Colors.white);
                    case TorchState.on:
                      return Icon(Icons.flash_on, color: Colors.yellow);
                  }
                }),
            iconSize: 32.0,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: MobileScanner(
                      onDetect: _foundBarcode,
                      controller: cameraController,
                      allowDuplicates: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'images/swiping.jpg',
                    height: 150,
                    width: 250,
                  ),
                ),
                Text(
                  'Cepat temukan Flag-nya\n sebelum dicuri oleh Swiper',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.pink[600],
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.orange,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoundCodeScreen(value: code),
          ));
    }
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  const FoundCodeScreen({Key? key, required this.value}) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Found Flag'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.value,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ));
  }
}
