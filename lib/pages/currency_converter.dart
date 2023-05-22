import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String? valueschoose;
  String? valueschoose1;

  @override
  Widget build(BuildContext context) {
    final _amount = TextEditingController();
    final _tot = TextEditingController();
    int cal;
    int result;

    var size= MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Text(
                "Currency Converter",
                style: TextStyle(fontSize: 30, color: Colors.black)),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _amount,
                decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(height: 15),
              DropdownButton<String>(
                  value: this.valueschoose,
                  items: <String>['CNY', 'SAR', 'USD'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => this.valueschoose = value)
              ),
              SizedBox(height: 15),
              DropdownButton<String>(
                value: this.valueschoose1,
                items: <String>['IDR'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() => this.valueschoose1 = value),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _tot,
                decoration: InputDecoration(
                    labelText: "Total",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(onTap: () {
                if (valueschoose == "CNY" && valueschoose1 == "IDR") {
                  cal = int.parse(_amount.text) * 2131;
                  result = cal;
                  _tot.text = result.toString();
                } else if (valueschoose == "SAR" &&
                    valueschoose1 == "IDR") {
                  cal = int.parse(_amount.text) * 3982;
                  result = cal;
                  _tot.text = result.toString();
                } else if (valueschoose == "USD" &&
                    valueschoose1 == "IDR") {
                  cal = int.parse(_amount.text) * 14936;
                  result = cal;
                  _tot.text = result.toString();
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: size.height / 14,
                width: size.width,

                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("Convert",
                style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
