import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Sederhana',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const KalkulatorHome(),
    );
  }
}

class KalkulatorHome extends StatefulWidget {
  const KalkulatorHome({super.key});

  @override
  State<KalkulatorHome> createState() => _KalkulatorHomeState();
}

class _KalkulatorHomeState extends State<KalkulatorHome> {
  // Variabel untuk menyimpan state kalkulator
  String _layar = '0';
  String _angkaPertama = '';
  String _operator = '';
  bool _menggantiLayar = false;

  // Fungsi untuk menangani input angka
  void _inputAngka(String angka) {
    setState(() {
      if (_menggantiLayar || _layar == '0') {
        _layar = angka;
        _menggantiLayar = false;
      } else {
        _layar += angka;
      }
    });
  }

  // Fungsi untuk menangani input operator
  void _inputOperator(String op) {
    setState(() {
      if (_angkaPertama.isNotEmpty && !_menggantiLayar) {
        _hitung();
      }
      _angkaPertama = _layar;
      _operator = op;
      _menggantiLayar = true;
    });
  }

  // Fungsi untuk melakukan perhitungan
  void _hitung() {
    if (_angkaPertama.isNotEmpty && _operator.isNotEmpty) {
      double angka1 = double.parse(_angkaPertama);
      double angka2 = double.parse(_layar);
      double hasil = 0;

      switch (_operator) {
        case '+':
          hasil = angka1 + angka2;
          break;
        case '-':
          hasil = angka1 - angka2;
          break;
        case '×':
          hasil = angka1 * angka2;
          break;
        case '÷':
          if (angka2 != 0) {
            hasil = angka1 / angka2;
          } else {
            _layar = 'Error';
            _clear();
            return;
          }
          break;
      }

      setState(() {
        _layar = hasil % 1 == 0 ? hasil.toInt().toString() : hasil.toString();
        _angkaPertama = '';
        _operator = '';
        _menggantiLayar = true;
      });
    }
  }

  // Fungsi untuk reset/clear
  void _clear() {
    setState(() {
      _layar = '0';
      _angkaPertama = '';
      _operator = '';
      _menggantiLayar = false;
    });
  }

  // Widget untuk membuat tombol kalkulator
  Widget _buildTombol(String text, {Color? warna, Color? warnaText}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            if (text == 'C') {
              _clear();
            } else if (text == '=') {
              _hitung();
            } else if (['+', '-', '×', '÷'].contains(text)) {
              _inputOperator(text);
            } else {
              _inputAngka(text);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: warna ?? Colors.grey[200],
            foregroundColor: warnaText ?? Colors.black,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Sederhana'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Layar tampilan hasil
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                _layar,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          
          // Tombol-tombol kalkulator
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Baris 1: Clear
                  Expanded(
                    child: Row(
                      children: [
                        _buildTombol('C', warna: Colors.red[400], warnaText: Colors.white),
                        _buildTombol('', warna: Colors.transparent),
                        _buildTombol('', warna: Colors.transparent),
                        _buildTombol('÷', warna: Colors.orange[400], warnaText: Colors.white),
                      ],
                    ),
                  ),
                  
                  // Baris 2: 7, 8, 9, ×
                  Expanded(
                    child: Row(
                      children: [
                        _buildTombol('7'),
                        _buildTombol('8'),
                        _buildTombol('9'),
                        _buildTombol('×', warna: Colors.orange[400], warnaText: Colors.white),
                      ],
                    ),
                  ),
                  
                  // Baris 3: 4, 5, 6, -
                  Expanded(
                    child: Row(
                      children: [
                        _buildTombol('4'),
                        _buildTombol('5'),
                        _buildTombol('6'),
                        _buildTombol('-', warna: Colors.orange[400], warnaText: Colors.white),
                      ],
                    ),
                  ),
                  
                  // Baris 4: 1, 2, 3, +
                  Expanded(
                    child: Row(
                      children: [
                        _buildTombol('1'),
                        _buildTombol('2'),
                        _buildTombol('3'),
                        _buildTombol('+', warna: Colors.orange[400], warnaText: Colors.white),
                      ],
                    ),
                  ),
                  
                  // Baris 5: 0, =
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () => _inputAngka('0'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                '0',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        _buildTombol('=', warna: Colors.blue[400], warnaText: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
