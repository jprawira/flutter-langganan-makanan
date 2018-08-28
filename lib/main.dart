import 'package:flutter/material.dart';
import 'ui_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mulai Langganan',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Mulai Langganan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _days = 0;
  var deviceSize;
  AnimationController controller;
  Animation<double> animation;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget orderCard() {
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: new Card(
          color: Colors.white,
          elevation: 2.0,
          child: orderCardElements(),
        ));
  }

  Widget orderCardElements() {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[numberOfBoxPicker(), subscribeLengthPicker()]);
  }

  Widget numberOfBoxPicker() {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Jumlah box per hari',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
            ]));
  }

  Widget subscribeLengthPicker() {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Lama Langganan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
            ]));
  }

  Widget detailsCard() {
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: new Card(
          color: Colors.white,
          elevation: 2.0,
          child: detailsText(),
        ));
  }

  Widget detailsText() {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Rincian Langganan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Harga per box', style: TextStyle(fontSize: 18.0)),
                new Text('Rp 25,000', style: TextStyle(fontSize: 18.0))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Jumlah Box', style: TextStyle(fontSize: 18.0)),
                new Text('1 Box', style: TextStyle(fontSize: 18.0))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Lama Langganan', style: TextStyle(fontSize: 18.0)),
                new Text('10 hari', style: TextStyle(fontSize: 18.0))
              ],
            ),
            new Text('Mulai Selasa, 28 Agustus 2018',
                style: TextStyle(color: Colors.grey, fontSize: 16.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                new Text('Rp 250,000',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
              ],
            ),
          ]),
    );
  }

  Widget nextButton() {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            constraints: BoxConstraints.expand(height: 60.0),
            child: Material(
              elevation: 10.0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                splashColor: Colors.yellow,
                child: Ink(
                  height: 50.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: UIData.buttonGradient)),
                  child: Center(
                    child: Text(
                      'Selanjutnya',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new ListView(
            primary: false,
            children: <Widget>[orderCard(), detailsCard(), nextButton()]));
  }
}
