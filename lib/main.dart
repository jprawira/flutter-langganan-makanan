import 'package:flutter/material.dart';
import 'ui_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mulai Langganan',
      theme: new ThemeData(primaryColor: Colors.white),
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

  // TODO: ADD COUNTER FOR NUMBER OF BOXES/DAY
  // TODO: ADD COUNTER FOR NUMBER OF DAYS
  // TODO: ADD LOGIC FOR DATE PICKER
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // TODO: ADD WIDGET FOR NAVIGATION

  Widget orderCard() {
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: new Card(
          color: Colors.white,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: orderCardElements(),
          ),
        ));
  }

  Widget orderCardElements() {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          numberOfBox(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(children: <Widget>[
              Flexible(child: numberOfBoxField()),
              Padding(padding: EdgeInsets.symmetric(horizontal: 4.0)),
              numberOfBoxDecrementButton(),
              Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
              numberOfBoxIncrementButton()
            ]),
          ),
          subscribeLengthPicker(),
          proTips()
        ]);
  }

  Widget numberOfBox() {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(UiData.numberOfBoxPerDayLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))
            ]));
  }

  Widget numberOfBoxField() {
    return new Container(
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            border: new Border.all(color: UiData.mainOrange, width: 2.0)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child: TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              decoration: InputDecoration(border: InputBorder.none),
            )),
            Text('Box',
                style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold, fontSize: 16.0)),
            Padding(padding: EdgeInsets.only(right: 70.0))
          ],
        ));
  }

  Widget numberOfBoxDecrementButton() {
    return new Container(
        constraints: BoxConstraints.expand(height: 48.0, width: 60.0),
        child: Material(
          elevation: 0.0,
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0))),
          child: InkWell(
            splashColor: UiData.mainOrange,
            child: Ink(
              decoration: BoxDecoration(color: UiData.mainOrange),
              child: Center(
                child: Text(
                  '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28.0),
                ),
              ),
            ),
          ),
        ));
  }

  Widget numberOfBoxIncrementButton() {
    return new Container(
        constraints: BoxConstraints.expand(height: 48.0, width: 60.0),
        child: Material(
          elevation: 0.0,
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            splashColor: UiData.mainOrange,
            child: Ink(
              decoration: BoxDecoration(color: UiData.mainOrange),
              child: Center(
                child: Text(
                  '+',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28.0),
                ),
              ),
            ),
          ),
        ));
  }

  Widget subscribeLengthPicker() {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(UiData.subscribeLengthLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))
            ]));
  }

  // TODO: MAKE WIDGET FOR DATE PICKER

  Widget proTips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Material(
        color: UiData.proTipBackground,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  UiData.proTipsLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                Divider(
                  height: 4.0,
                  color: Colors.transparent,
                ),
                Text(
                  UiData.proTipsContent,
                  style: TextStyle(fontSize: 14.0),
                )
              ]),
        ),
      ),
    );
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Text(
            UiData.subscriptionDetailLabel,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(UiData.pricePerBoxLabel, style: TextStyle(fontSize: 16.0)),
              new Text('Rp 25,000', style: TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(UiData.totalNumberOfBoxLabel,
                  style: TextStyle(fontSize: 16.0)),
              new Text('1 Box', style: TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(UiData.subscriptionLengthLabel,
                  style: TextStyle(fontSize: 16.0)),
              new Text('10 hari', style: TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
          child: new Text('Mulai Selasa, 28 Agustus 2018',
              style: TextStyle(color: Colors.grey, fontSize: 14.0)),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(UiData.totalAmount,
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              new Text('Rp 250,000',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ]),
    );
  }

  Widget nextButton() {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            constraints: BoxConstraints.expand(height: 54.0),
            child: Material(
              elevation: 10.0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                splashColor: UiData.mainOrange,
                child: Ink(
                  height: 50.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: UiData.buttonGradient)),
                  child: Center(
                    child: Text(
                      'Selanjutnya',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
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
          leading: new Icon(
            Icons.arrow_back,
            color: Colors.grey[600],
          ),
          elevation: 0.0,
          title: new Text(widget.title),
        ),
        body: new ListView(
            primary: false,
            children: <Widget>[orderCard(), detailsCard(), nextButton()]));
  }
}
