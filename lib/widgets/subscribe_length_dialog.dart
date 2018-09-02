import 'package:flutter/material.dart';
import 'package:langganan_makanan/ui_data.dart';

// TODO: SET UP DIALOG
class SubscribeLengthDialog extends StatefulWidget {
  final ValueChanged<int> onChanged;

  SubscribeLengthDialog({Key key, this.onChanged}) : super(key: key);

  @override
  SubscribeLengthDialogState createState() => new SubscribeLengthDialogState();
}

class SubscribeLengthDialogState extends State<SubscribeLengthDialog> {
  int _subscribeLength;
  var _deviceSize;
  var _subscribeLengthController;

  @override
  void initState() {
    super.initState();
    // TODO: PROPERLY INITIALIZE _subscribeLength
    _subscribeLength = 5;
    // TODO: USE _subscribeLength TO INITIALIZE
    _subscribeLengthController = new TextEditingController(text: '5');
  }

  void _updateSubscribeLength() {
    // TODO: HANDLE UPDATE LENGTH
    _subscribeLengthController.text = _subscribeLength.toString();
    debugPrint('LENGTH: ' + _subscribeLength.toString());
  }

  void _decrementSubscribeLength() {
    setState(() {
      if (_subscribeLength > 2) {
        _subscribeLength--;
        _updateSubscribeLength();
      }
    });
  }

  void _incrementSubscribeLength() {
    setState(() {
      _subscribeLength++;
      _updateSubscribeLength();
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      new Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(UiData.subscribeLengthDialogLabel,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0))
              ])),
      new Container(
        padding: const EdgeInsets.all(4.0),
        child: new Row(children: <Widget>[
          new Flexible(
              child: new Container(
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(5.0),
                      border: new Border.all(color: Colors.grey, width: 2.0)),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Flexible(
                          child: new TextField(
                        // TODO: HANDLE TEXT CHANGE
                        controller: _subscribeLengthController,
                        onChanged: (text) {
                          //_boxes = int.parse(text);
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                        decoration:
                            new InputDecoration(border: InputBorder.none),
                      ))
                    ],
                  ))),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0)),
          new Container(
              constraints:
                  const BoxConstraints.expand(height: 46.0, width: 60.0),
              child: new Material(
                elevation: 0.0,
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0))),
                child: new InkWell(
                  onTap: _decrementSubscribeLength,
                  splashColor: Colors.red,
                  child: new Ink(
                    decoration: new BoxDecoration(color: Colors.grey[700]),
                    child: new Center(
                      child: new Text(
                        '-',
                        textAlign: TextAlign.center,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 28.0),
                      ),
                    ),
                  ),
                ),
              )),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 2.0)),
          new Container(
              constraints:
                  const BoxConstraints.expand(height: 46.0, width: 60.0),
              child: new Material(
                elevation: 0.0,
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0))),
                child: new InkWell(
                  onTap: _incrementSubscribeLength,
                  splashColor: Colors.red,
                  child: new Ink(
                    decoration: new BoxDecoration(color: Colors.grey[700]),
                    child: new Center(
                      child: new Text(
                        '+',
                        textAlign: TextAlign.center,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 28.0),
                      ),
                    ),
                  ),
                ),
              )),
        ]),
      ),
      new Container(
          padding: const EdgeInsets.all(12.0),
          child: new Container(
              constraints: const BoxConstraints.expand(height: 54.0),
              child: new Material(
                elevation: 0.0,
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: new InkWell(
                  // TODO: CLOSE DIALOG AND SET SUBSCRIBE LENGTH
                  onTap: () => null,
                  splashColor: Colors.red,
                  child: new Ink(
                    height: 50.0,
                    decoration: new BoxDecoration(color: Colors.redAccent),
                    child: new Center(
                      child: new Text(
                        'OK',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              )))
    ]);
  }
}
