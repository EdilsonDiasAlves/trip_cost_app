import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  TextEditingController distanceController = TextEditingController();
  TextEditingController averageConsumptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String result = '';
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Cost Calculator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                  labelText: 'Distance',
                  hintText: 'e.g. 124',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: averageConsumptionController,
                  decoration: InputDecoration(
                    labelText: 'Distance per Unit',
                    hintText: 'e.g. 17',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: Row(children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'e.g. 1.65',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                )),
                Container(
                  width: _formDistance * 5,
                ),
                Expanded(
                    child: DropdownButton<String>(
                  items: _currencies.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  value: _currency,
                  onChanged: (String value) {
                    _onDropDownChanged(value);
                  },
                )),
              ]),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    setState(() {
                      result = _calculate();
                    });
                  },
                  child: Text(
                    'Submit',
                    textScaleFactor: 1.5,
                  ),
                )),
                Expanded(
                    child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  textColor: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    setState(() {
                      _reset();
                    });
                  },
                  child: Text(
                    'Reset',
                    textScaleFactor: 1.5,
                  ),
                )),
              ],
            ),
            Text(result),
          ],
        ),
      ),
    );
  }

  _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _consumption = double.parse(averageConsumptionController.text);
    double _fuelCost = double.parse(priceController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = 'The total cost of your trip is ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;

    return _result;
  }

  void _reset() {
    distanceController.text = '';
    averageConsumptionController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }
}
