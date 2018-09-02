import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:langganan_makanan/ui_data.dart';
import 'subscribe_length_dialog.dart';

class LengthPickerModel {
  bool isSelected;
  String text;
  String description;

  LengthPickerModel(this.isSelected, this.text, this.description);
}

class SubscribeLengthPicker extends StatefulWidget {
  final int pickerValue;
  final int subscribeLength;
  final ValueChanged<Tuple2<int, int>> onChanged;

  SubscribeLengthPicker(
      {Key key,
      this.pickerValue: 2,
      @required this.subscribeLength,
      @required this.onChanged})
      : super(key: key);

  @override
  SubscribeLengthPickerState createState() => new SubscribeLengthPickerState();
}

class SubscribeLengthPickerState extends State<SubscribeLengthPicker> {
  List<LengthPickerModel> data = new List<LengthPickerModel>();

  void toggleValue(Tuple2<int, int> tuple) {
    int index = tuple.item1;
    int days = tuple.item2;
    setState(() {
      data.forEach((element) => element.isSelected = false);
      data[index].isSelected = true;
    });
    switch (index) {
      case 0:
        widget.onChanged(new Tuple2<int, int>(index, 20));
        data[3].text = 'Pilih Sendiri';
        data[3].description = 'Min. 2 hari';
        break;
      case 1:
        widget.onChanged(new Tuple2<int, int>(index, 10));
        data[3].text = 'Pilih Sendiri';
        data[3].description = 'Min. 2 hari';
        break;
      case 2:
        widget.onChanged(new Tuple2<int, int>(index, 5));
        data[3].text = 'Pilih Sendiri';
        data[3].description = 'Min. 2 hari';
        break;
      case 3:
        widget.onChanged(new Tuple2<int, int>(index, days));
        data[3].text = days.toString() + " Hari";
        if (days >= 2 && days < 10) {
          data[3].description = 'Rp 25,000/hari';
        } else if (days > 10 && days < 20) {
          data[3].description = 'Rp 24,250/hari';
        } else {
          data[3].description = 'Rp 22,500/hari';
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    data
      ..add(new LengthPickerModel(false, '20 Hari', 'Rp 22,500/hari'))
      ..add(new LengthPickerModel(false, '10 Hari', 'Rp 24,250/hari'))
      ..add(new LengthPickerModel(true, '5 Hari', 'Rp 25,000/hari'))
      ..add(new LengthPickerModel(false, 'Pilih Sendiri', 'Min. 2 hari'));
  }

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 1.25),
        itemBuilder: (BuildContext context, int index) {
          return new Container(
              padding: EdgeInsets.all(4.0),
              child: Material(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(5.0))),
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        if (index != 3) {
                          toggleValue(new Tuple2<int, int>(index, 0));
                        } else {
                          showDialog(
                              context: context,
                              child: new SimpleDialog(children: <Widget>[
                                new SubscribeLengthDialog(
                                    subscribeLength: widget.subscribeLength,
                                    onChanged: toggleValue)
                              ]));
                        }
                      },
                      child: new LengthPickerItem(data[index]))));
        });
  }
}

class LengthPickerItem extends StatelessWidget {
  final LengthPickerModel _item;
  LengthPickerItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Ink(
        decoration: new BoxDecoration(
            color: _item.isSelected ? UiData.mainOrange : Colors.white,
            border: new Border.all(width: 2.0, color: UiData.mainOrange),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                _item.text,
                style: new TextStyle(
                    color: _item.isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              new Text(_item.description,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.grey,
                      fontSize: 14.0))
            ],
          ),
        ));
  }
}
