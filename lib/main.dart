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
  String result = '';
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
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
            TextField(
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
            DropdownButton<String>(
              items: _currencies.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              value: _currency,
              onChanged: (String value) {
                _onDropDownChanged(value);
              },
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              onPressed: () {
                setState(() {
                  result = distanceController.text;
                });
              },
              child: Text(
                'Submit',
                textScaleFactor: 1.5,
              ),
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
}
