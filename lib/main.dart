import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyApp createState() => MyApp();
  var listItem = ["Kelvin", "Reamur"];
  double _inputUser = 0;
  double _kelvin = 0;
  double _reamur = 0;
  final inputController = TextEditingController();
  String _newValue = "Kelvin";
  double _result = 0;

  final listKonverter = <String>[];
  final hasil = <double>[];

  void perhitunganSuhu() {
    setState(() {
      _inputUser = double.parse(inputController.text);
      if (_newValue == "Kelvin") {
        _result = _inputUser + 273;
        listKonverter.add(_newValue);
        hasil.add(_result);
      } else {
        _result = (4 / 5) * _inputUser;
        listKonverter.add(_newValue);
        hasil.add(_result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konverter Suhu"),
        ),
        body: Container(
          child: Column(
            children: [
              // Kolom Pertama
              TextFormField(
                decoration: new InputDecoration(
                    hintText: "Masukkan Suhu Dalam Celcius"),
                keyboardType: TextInputType.number,
                controller: inputController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              // Kolom Kedua
              DropdownButton<String>(
                items: listItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _newValue,
                onChanged: (String? changeValue) {
                  setState(() {
                    _newValue = changeValue ?? '';
                  });
                },
              ),
              // Kolom Ketiga
              Result(result: _result),
              //Kolom Keempat
              SizedBox(
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: perhitunganSuhu,
                    child: Text('Konversi Suhu'),
                  ),
                ),
              ),
              // Kolom Kelima
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Riwayat Konversi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Kolom Keenam
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(
                      listKonverter[index] + " : " + hasil[index].toString());
                },
                itemCount: listKonverter.length,
              ))
            ],
          ),
        ),
      ),
    );
  }

  void dropdownOnChanged(String changeValue) {
    setState(() {
      _newValue = changeValue;
    });
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required double result,
  })  : _result = result,
        super(key: key);

  final double _result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Hasil",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "$_result",
          style: TextStyle(fontSize: 30),
        )
      ]),
    );
  }
}
