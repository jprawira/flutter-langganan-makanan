import 'package:flutter/material.dart';
import 'package:langganan_makanan/ui_data.dart';

class LengthPickerModel {
  bool isSelected;
  final String text;
  final String description;

  LengthPickerModel(this.isSelected, this.text, this.description);
}

class SubscribeLengthPicker extends StatefulWidget {
  final int pickerValue;
  final ValueChanged<int> onChanged;

  SubscribeLengthPicker(
      {Key key, this.pickerValue: 2, @required this.onChanged})
      : super(key: key);

  @override
  SubscribeLengthPickerState createState() => new SubscribeLengthPickerState();
}

class SubscribeLengthPickerState extends State<SubscribeLengthPicker> {
  List<LengthPickerModel> data = new List<LengthPickerModel>();

  void toggleValue(int index) {
    setState(() {
      data.forEach((element) => element.isSelected = false);
      data[index].isSelected = true;
    });
    widget.onChanged(index);
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
                        toggleValue(index);
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                _item.text,
                style: TextStyle(
                    color: _item.isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              new Text(_item.description,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.grey,
                      fontSize: 14.0))
            ],
          ),
        ));
  }
}
