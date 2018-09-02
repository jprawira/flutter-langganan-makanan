import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

import 'widgets/subscribe_length_picker.dart';
import 'ui_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mulai Langganan',
      theme: new ThemeData(primaryColor: UiData.mainOrange),
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
  final rupiahFormat = new NumberFormat("###,###,###");

  int _boxPrice;
  int _boxes;
  int _subscribeLength;
  int _totalValue;
  DateTime startDate;
  DateTime endDate;
  var _deviceSize;
  var _boxesCountController = new TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _boxPrice = 25000;
    _boxes = 1;
    _subscribeLength = 5;
    _totalValue = 25000;
    _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
  }

  void _decrementBoxCount() {
    setState(() {
      if (_boxes > 1) {
        _boxes--;
        _updateBoxCount();
        _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
      }
    });
  }

  void _incrementBoxCount() {
    setState(() {
      _boxes++;
      _updateBoxCount();
      _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
    });
  }

  void _updateBoxCount() {
    _totalValue = _boxes * 25000;
    _boxesCountController.text = _boxes.toString();
    debugPrint('BOXES: ' + _boxes.toString());
  }

  void _updateTotalValue(int price, int boxes, int days) {
    _totalValue = price * boxes * days;
  }

  void _updateBoxPriceAndDaysCount(Tuple2<int,int> tuple) {
    int pickerValue = tuple.item1;
    int days = tuple.item2;
    setState(() {
      switch (pickerValue) {
        case 0:
          _boxPrice = 22500;
          _subscribeLength = days;
          _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
          debugPrint('PER DAY: ' + _boxPrice.toString());
          debugPrint('DAYS: ' + _subscribeLength.toString());
          break;
        case 1:
          _boxPrice = 24250;
          _subscribeLength = days;
          _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
          debugPrint('PER DAY: ' + _boxPrice.toString());
          debugPrint('DAYS: ' + _subscribeLength.toString());
          break;
        case 2:
          _boxPrice = 25000;
          _subscribeLength = days;
          _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
          debugPrint('PER DAY: ' + _boxPrice.toString());
          debugPrint('DAYS: ' + _subscribeLength.toString());
          break;
        case 3:
          _subscribeLength = days;
          if (days >= 2 && days <=5) {
            _boxPrice = 25000;
            _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
            debugPrint('PER DAY: ' + _boxPrice.toString());
            debugPrint('DAYS: ' + _subscribeLength.toString());
          } else if (days > 5 && days <= 10) {
            _boxPrice = 24250;
            _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
            debugPrint('PER DAY: ' + _boxPrice.toString());
            debugPrint('DAYS: ' + _subscribeLength.toString());
          } else {
            _boxPrice = 22500;
            _updateTotalValue(_boxPrice, _boxes, _subscribeLength);
            debugPrint('PER DAY: ' + _boxPrice.toString());
            debugPrint('DAYS: ' + _subscribeLength.toString());
          }
          break;
      }
    });
  }

  // TODO: ADD LINES BETWEEN STEPS
  Widget stepsDisplay() {
    return new PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: new Container(
          height: 48.0,
          alignment: Alignment.center,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(
                    'Mulai',
                    style:
                        new TextStyle(color: UiData.mainOrange, fontSize: 12.0),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: new PhysicalModel(
                        shape: BoxShape.circle,
                        borderRadius: new BorderRadius.circular(20.0),
                        color: Colors.transparent,
                        child: new Container(
                          width: 15.0,
                          height: 15.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              width: 3.0,
                              color: UiData.mainOrange,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(
                    'Pengiriman',
                    style:
                        new TextStyle(color: Colors.grey[400], fontSize: 12.0),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: new PhysicalModel(
                        shape: BoxShape.circle,
                        borderRadius: new BorderRadius.circular(20.0),
                        color: Colors.transparent,
                        child: new Container(
                          width: 15.0,
                          height: 15.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              width: 3.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(
                    'Pembayaran',
                    style:
                        new TextStyle(color: Colors.grey[400], fontSize: 12.0),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: new PhysicalModel(
                        shape: BoxShape.circle,
                        borderRadius: new BorderRadius.circular(20.0),
                        color: Colors.transparent,
                        child: new Container(
                          width: 15.0,
                          height: 15.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              width: 3.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          )),
    );
  }

  Widget numberOfBoxLabel() {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(UiData.numberOfBoxPerDayLabel,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0))
            ]));
  }

  // TODO: HANDLE WHEN USER INPUT NUMBER OF BOXES UNDER 1
  Widget numberOfBoxField() {
    return new Container(
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(5.0),
            border: new Border.all(color: UiData.mainOrange, width: 2.0)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Flexible(
                child: new TextField(
              controller: _boxesCountController,
              onChanged: (text) {
                _boxes = int.parse(text);
                _updateBoxCount();
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: new TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              decoration: new InputDecoration(border: InputBorder.none),
            )),
            new Text('Box',
                style: new TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
            new Padding(
                padding: new EdgeInsets.only(right: _deviceSize.width / 6.0))
          ],
        ));
  }

  Widget numberOfBoxDecrementButton() {
    return new Container(
        constraints: const BoxConstraints.expand(height: 46.0, width: 60.0),
        child: new Material(
          elevation: 0.0,
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0))),
          child: new InkWell(
            onTap: _decrementBoxCount,
            splashColor: Colors.redAccent,
            child: new Ink(
              decoration: new BoxDecoration(color: UiData.mainOrange),
              child: new Center(
                child: new Text(
                  '-',
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.white, fontSize: 28.0),
                ),
              ),
            ),
          ),
        ));
  }

  Widget numberOfBoxIncrementButton() {
    return new Container(
        constraints: const BoxConstraints.expand(height: 46.0, width: 60.0),
        child: new Material(
          elevation: 0.0,
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0))),
          child: new InkWell(
            onTap: _incrementBoxCount,
            splashColor: Colors.redAccent,
            child: new Ink(
              decoration: new BoxDecoration(color: UiData.mainOrange),
              child: new Center(
                child: new Text(
                  '+',
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.white, fontSize: 28.0),
                ),
              ),
            ),
          ),
        ));
  }

  Widget subscribeLengthPickerLabel() {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(UiData.subscribeLengthLabel,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0))
            ]));
  }

  Widget proTips() {
    return new Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: new Material(
        color: UiData.proTipBackground,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  UiData.proTipsLabel,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                new Divider(
                  height: 4.0,
                  color: Colors.transparent,
                ),
                new Text(
                  UiData.proTipsContent,
                  style: new TextStyle(fontSize: 14.0),
                )
              ]),
        ),
      ),
    );
  }

  Widget orderCard() {
    return new Container(
        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
        child: new Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(color: Colors.grey[400], blurRadius: 20.0)
            ]),
            child: new Card(
              color: Colors.white,
              elevation: 0.0,
              child: new Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: orderCardElements(),
              ),
            )));
  }

  Widget orderCardElements() {
    return new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      numberOfBoxLabel(),
      new Container(
        padding: const EdgeInsets.all(4.0),
        child: new Row(children: <Widget>[
          new Flexible(child: numberOfBoxField()),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0)),
          numberOfBoxDecrementButton(),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 2.0)),
          numberOfBoxIncrementButton()
        ]),
      ),
      new Divider(height: 8.0, color: Colors.transparent),
      subscribeLengthPickerLabel(),
      new Container(
        constraints: new BoxConstraints.expand(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? _deviceSize.height / 5
                : _deviceSize.width / 2.5),
        // TODO: ADD DIALOG FOR "Pilih Sendiri"
        // TODO: ADD LOGIC FOR PICKING DATE
        child:
            new SubscribeLengthPicker(onChanged: _updateBoxPriceAndDaysCount),
      ),
      new Divider(height: 12.0, color: Colors.transparent),
      new Container(
          decoration: new BoxDecoration(
              boxShadow: [new BoxShadow(color: Colors.grey, blurRadius: 6.0)]),
          child: new Material(
              elevation: 0.0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              // TODO: MAKE CALENDAR ABLE TO PICK DAYS AND UPDATE _daysCount
              child: new Calendar(daysSelected: _subscribeLength))),
      new Divider(height: 12.0, color: Colors.transparent),
      proTips()
    ]);
  }

  Widget detailsCard() {
    return new Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child: new Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(color: Colors.grey[400], blurRadius: 20.0)
            ]),
            child: new Card(
              color: Colors.white,
              elevation: 0.0,
              child: detailsText(),
            )));
  }

  Widget detailsText() {
    return new Container(
      padding: const EdgeInsets.all(12.0),
      child:
          new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: new Text(
            UiData.subscriptionDetailLabel,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(UiData.pricePerBoxLabel,
                  style: new TextStyle(fontSize: 16.0)),
              new Text('Rp ' + rupiahFormat.format(_boxPrice),
                  style: new TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        new Divider(),
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(UiData.totalNumberOfBoxLabel,
                  style: new TextStyle(fontSize: 16.0)),
              new Text('$_boxes Box', style: new TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        new Divider(),
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(UiData.subscriptionLengthLabel,
                  style: new TextStyle(fontSize: 16.0)),
              new Text('$_subscribeLength hari', style: new TextStyle(fontSize: 16.0))
            ],
          ),
        ),
        // TODO: CHANGE TEXT USING startDate ACCORDINGLY
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
          child: new Text('Mulai Senin, 3 September 2018',
              style: new TextStyle(color: Colors.grey, fontSize: 14.0)),
        ),
        new Divider(),
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(UiData.totalAmount,
                  style: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold)),
              new Text('Rp ' + rupiahFormat.format(_totalValue),
                  style: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ]),
    );
  }

  Widget nextButton() {
    return new Container(
        padding: const EdgeInsets.all(12.0),
        child: new Container(
            constraints: const BoxConstraints.expand(height: 54.0),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(color: Colors.red[300], blurRadius: 20.0)
            ]),
            child: new Material(
              elevation: 0.0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: new InkWell(
                // TODO: DO SOMETHING
                onTap: () => debugPrint('TOTAL: ' + _totalValue.toString()),
                splashColor: UiData.mainOrange,
                child: new Ink(
                  height: 50.0,
                  decoration: new BoxDecoration(
                      gradient:
                          new LinearGradient(colors: UiData.buttonGradient)),
                  child: new Center(
                    child: new Text(
                      'Selanjutnya',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
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
    _deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          bottom: stepsDisplay(),
          leading: new Icon(
            Icons.arrow_back,
            color: Colors.grey[700],
          ),
          elevation: 0.0,
          title: new Text(widget.title),
        ),
        body: new ListView(
            children: <Widget>[orderCard(), detailsCard(), nextButton()]));
  }
}
