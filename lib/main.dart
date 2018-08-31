import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/calendar.dart';
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

  int _boxes = 1;
  int _daysCount = 2;
  int _totalValue = 25000;
  int _boxPrice = 25000;
  var _deviceSize;
  var _boxesCountController = new TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
  }

  // TODO: ADD COUNTER FOR NUMBER OF DAYS
  // TODO: ADD LOGIC FOR DATE PICKER
  // TODO: HANDLE WHEN USER INPUT NUMBER OF BOXES UNDER 1
  void _decrementBoxCount() {
    setState(() {
      if (_boxes > 1) {
        _boxes--;
        _updateBoxCount();
        _updateTotalValue(_boxPrice, _boxes, _daysCount);
      }
    });
  }

  void _incrementBoxCount() {
    setState(() {
      _boxes++;
      _updateBoxCount();
      _updateTotalValue(_boxPrice, _boxes, _daysCount);
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

  void _updateBoxPrice(int pickerValue) {
    setState(() {
      switch (pickerValue) {
        case 0:
          _boxPrice = 22500;
          _updateTotalValue(_boxPrice, _boxes, _daysCount);
          debugPrint('PER DAY: ' + 22500.toString());
          break;
        case 1:
          _boxPrice = 24250;
          _updateTotalValue(_boxPrice, _boxes, _daysCount);
          debugPrint('PER DAY: ' + 24250.toString());
          break;
        case 2:
          _boxPrice = 25000;
          _updateTotalValue(_boxPrice, _boxes, _daysCount);
          debugPrint('PER DAY: ' + 25000.toString());
          break;
        case 3:
          break;
      }
    });
  }

  // TODO: ADD WIDGET FOR NAVIGATION

  Widget numberOfBoxLabel() {
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
                child: TextField(
              controller: _boxesCountController,
              onChanged: (text) {
                _boxes = int.parse(text);
                _updateBoxCount();
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              decoration: InputDecoration(border: InputBorder.none),
            )),
            Text('Box',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
            Padding(padding: EdgeInsets.only(right: _deviceSize.width / 6.0))
          ],
        ));
  }

  Widget numberOfBoxDecrementButton() {
    return new Container(
        constraints: BoxConstraints.expand(height: 46.0, width: 60.0),
        child: Material(
          elevation: 0.0,
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0))),
          child: new InkWell(
            onTap: _decrementBoxCount,
            splashColor: Colors.redAccent,
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
        constraints: BoxConstraints.expand(height: 46.0, width: 60.0),
        child: Material(
          elevation: 0.0,
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0))),
          child: new InkWell(
            onTap: _incrementBoxCount,
            splashColor: Colors.redAccent,
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

  Widget subscribeLengthPickerLabel() {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(UiData.subscribeLengthLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))
            ]));
  }

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

  Widget orderCard() {
    return new Container(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 12.0),
        child: new Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(color: Colors.grey[400], blurRadius: 20.0)
            ]),
            child: new Card(
              color: Colors.white,
              elevation: 0.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: orderCardElements(),
              ),
            )));
  }

  Widget orderCardElements() {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          numberOfBoxLabel(),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Row(children: <Widget>[
              Flexible(child: numberOfBoxField()),
              Padding(padding: EdgeInsets.symmetric(horizontal: 4.0)),
              numberOfBoxDecrementButton(),
              Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
              numberOfBoxIncrementButton()
            ]),
          ),
          Divider(height: 8.0, color: Colors.transparent),
          subscribeLengthPickerLabel(),
          Container(
            constraints: BoxConstraints.expand(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? _deviceSize.height / 5
                        : _deviceSize.width / 2.5),
            // TODO: LINK SubscribeLengthPicker TO UPDATE _daysCount
            child: new SubscribeLengthPicker(onChanged: _updateBoxPrice),
          ),
          Divider(height: 12.0, color: Colors.transparent),
          new Container(
              decoration: new BoxDecoration(boxShadow: [
                new BoxShadow(color: Colors.grey, blurRadius: 6.0)
              ]),
              child: Material(
                  elevation: 0.0,
                  color: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  // TODO: MAKE CALENDAR ABLE TO PICK DAYS AND UPDATE _daysCount
                  child: new Calendar())),
          Divider(height: 12.0, color: Colors.transparent),
          proTips()
        ]);
  }

  Widget detailsCard() {
    return new Container(
        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
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
              new Text('Rp ' + rupiahFormat.format(_boxPrice),
                  style: TextStyle(fontSize: 16.0))
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
              new Text('$_boxes Box', style: TextStyle(fontSize: 16.0))
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
              new Text('$_daysCount hari', style: TextStyle(fontSize: 16.0))
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
              new Text('Rp ' + rupiahFormat.format(_totalValue),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ]),
    );
  }

  Widget nextButton() {
    return new Container(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            constraints: BoxConstraints.expand(height: 54.0),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(color: Colors.red[300], blurRadius: 20.0)
            ]),
            child: Material(
              elevation: 0.0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: InkWell(
                // TODO: DO SOMETHING
                onTap: () => debugPrint('TOTAL: ' + _totalValue.toString()),
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
    _deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
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
