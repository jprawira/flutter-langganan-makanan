import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'calendar_tile.dart';
import 'package:langganan_makanan/utils/date_utils.dart';

typedef DayBuilder(BuildContext context, DateTime day);

class Calendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<Tuple2<DateTime, DateTime>> onSelectedRangeChange;
  final bool isExpandable;
  final DayBuilder dayBuilder;
  final bool showChevronsToChangeRange;
  final bool showTodayAction;
  final bool showCalendarPickerIcon;
  final DateTime initialCalendarDateOverride;
  final int daysSelected;

  Calendar(
      {Key key,
      this.onDateSelected,
      this.onSelectedRangeChange,
      this.isExpandable: false,
      this.dayBuilder,
      this.showTodayAction: false,
      this.showChevronsToChangeRange: true,
      this.showCalendarPickerIcon: false,
      this.initialCalendarDateOverride,
      @required this.daysSelected})
      : super(key: key);

  @override
  CalendarState createState() => new CalendarState();
}

class CalendarState extends State<Calendar> {
  final calendarUtils = new Utils();
  final DateTime now = new DateTime.now();
  DateTime today = new DateTime.now();
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime _selectedDate;
  Tuple2<DateTime, DateTime> selectedRange;
  String currentMonth;
  bool isExpanded = true;
  String displayMonth;

  List<DateTime> _selectedDays;

  DateTime get selectedDate => _selectedDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);
    if (widget.initialCalendarDateOverride != null)
      today = widget.initialCalendarDateOverride;
    selectedMonthsDays = Utils.daysInMonth(today);
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
    selectedWeeksDays =
        Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
            .toList()
            .sublist(0, 7);
    _selectedDate = today;

    displayMonth = Utils.formatMonth(Utils.firstDayOfMonth(today));
  }

  /// Set selected days to next n-workdays.
  void _updateSelectedDays() {
    DateTime _thisDay = new DateTime(today.year, today.month, today.day);
    _selectedDays = Utils.workdaysInRange(
            _thisDay, _thisDay.add(new Duration(days: widget.daysSelected + 1)))
        .toList();

    while (_selectedDays.length < widget.daysSelected) {
      DateTime _finalDay = _selectedDays.removeLast();
      _selectedDays += Utils.workdaysInRange(
          _finalDay, _finalDay.add(new Duration(days: widget.daysSelected - _selectedDays.length)))
          .toList();
    }

    for (int i = 0; i < _selectedDays.length; i++) {
      debugPrint("SELECTED: " + _selectedDays[i].toIso8601String());
    }
  }

  Widget get nameAndIconRow {
    var leftInnerIcon;
    var rightInnerIcon;
    var leftOuterIcon;
    var rightOuterIcon;

    if (widget.showCalendarPickerIcon) {
      rightInnerIcon = new IconButton(
        onPressed: () => selectDateFromPicker(),
        icon: new Icon(Icons.calendar_today),
      );
    } else {
      rightInnerIcon = new Container();
    }

    if (widget.showChevronsToChangeRange) {
      leftOuterIcon = new IconButton(
        onPressed: isExpanded ? previousMonth : previousWeek,
        icon: new Icon(Icons.chevron_left, color: Colors.grey[700]),
      );
      rightOuterIcon = new IconButton(
        onPressed: isExpanded ? nextMonth : nextWeek,
        icon: new Icon(Icons.chevron_right, color: Colors.grey[700]),
      );
    } else {
      leftOuterIcon = new Container();
      rightOuterIcon = new Container();
    }

    if (widget.showTodayAction) {
      leftInnerIcon = new InkWell(
        child: new Text('Today', style: new TextStyle(color: Colors.grey[700])),
        onTap: resetToToday,
      );
    } else {
      leftInnerIcon = new Container();
    }

    return new Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftOuterIcon ?? new Container(),
            leftInnerIcon ?? new Container(),
            new Text(
              displayMonth,
              style: new TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            rightInnerIcon ?? new Container(),
            rightOuterIcon ?? new Container(),
          ],
        ));
  }

  Widget get calendarGridView {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white, width: 1.5)),
      child: new GestureDetector(
        onHorizontalDragStart: (gestureDetails) => beginSwipe(gestureDetails),
        onHorizontalDragUpdate: (gestureDetails) =>
            getDirection(gestureDetails),
        onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
        child: new GridView.count(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          crossAxisCount: 7,
          childAspectRatio: 1.0,
          mainAxisSpacing: 0.0,
          padding: new EdgeInsets.only(bottom: 0.0),
          children: calendarBuilder(),
        ),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeeksDays;

    Utils.weekdays.forEach(
      (day) {
        dayWidgets.add(
          new CalendarTile(
            isDayOfWeek: true,
            dayOfWeek: day,
          ),
        );
      },
    );

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach(
      (day) {
        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (this.widget.dayBuilder != null) {
          dayWidgets.add(
            new CalendarTile(
              child: this.widget.dayBuilder(context, day),
            ),
          );
        } else {
          // To handle displaying weekends
          if (day.weekday % 6 != 0 && day.weekday % 7 != 0) {
            dayWidgets.add(
              new CalendarTile(
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                date: day,
                dateStyles: configureDateStyle(monthStarted, monthEnded),
                //isSelected: Utils.isSameDay(selectedDate, day),
                isSelected: _selectedDays.contains(day),
              ),
            );
          } else {
            dayWidgets.add(
              new CalendarTile(
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                date: day,
                dateStyles: new TextStyle(color: Colors.grey[400]),
                isSelected: Utils.isSameDay(selectedDate, day),
              ),
            );
          }
        }
      },
    );
    return dayWidgets;
  }

  TextStyle configureDateStyle(monthStarted, monthEnded) {
    TextStyle dateStyles;
    if (isExpanded) {
      dateStyles = monthStarted && !monthEnded
          ? new TextStyle(color: Colors.grey[700])
          : new TextStyle(color: Colors.grey[400]);
    } else {
      dateStyles = new TextStyle(color: Colors.black);
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(Utils.fullDayFormat(selectedDate)),
          new IconButton(
            iconSize: 20.0,
            padding: new EdgeInsets.all(0.0),
            onPressed: toggleExpanded,
            icon: isExpanded
                ? new Icon(Icons.arrow_drop_up)
                : new Icon(Icons.arrow_drop_down),
          ),
        ],
      );
    } else {
      return new Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update values
    _updateSelectedDays();
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameAndIconRow,
          new ExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          )
        ],
      ),
    );
  }

  void resetToToday() {
    today = new DateTime.now();
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);

    setState(() {
      _selectedDate = today;
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      displayMonth = Utils.formatMonth(Utils.firstDayOfWeek(today));
    });

    _launchDateSelectionCallback(today);
  }

  void nextMonth() {
    setState(() {
      // Limit the picker only to next month from now.
      if (today.month - now.month % 12 < 1) {
        today = new DateTime(today.year, today.month + 1);
        var firstDateOfNewMonth = Utils.firstDayOfMonth(today);
        var lastDateOfNewMonth = Utils.lastDayOfMonth(today);
        updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
        selectedMonthsDays = Utils.daysInMonth(today);
        displayMonth = Utils.formatMonth(today);
      }
    });
  }

  void previousMonth() {
    setState(() {
      // Limit the picker only to previous month from now.
      if (now.month - today.month % 12 < 1) {
        today = new DateTime(today.year, today.month - 1);
        var firstDateOfNewMonth = Utils.firstDayOfMonth(today);
        var lastDateOfNewMonth = Utils.lastDayOfMonth(today);
        updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
        selectedMonthsDays = Utils.daysInMonth(today);
        displayMonth = Utils.formatMonth(today);
      }
    });
  }

  void nextWeek() {
    setState(() {
      today = Utils.nextWeek(today);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      displayMonth = Utils.formatMonth(Utils.firstDayOfWeek(today));
    });
  }

  void previousWeek() {
    setState(() {
      today = Utils.previousWeek(today);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      displayMonth = Utils.formatMonth(Utils.firstDayOfWeek(today));
    });
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    selectedRange = new Tuple2<DateTime, DateTime>(start, end);
    if (widget.onSelectedRangeChange != null) {
      widget.onSelectedRangeChange(selectedRange);
    }
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    if (selected != null) {
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

      setState(() {
        _selectedDate = selected;
        selectedWeeksDays =
            Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList();
        selectedMonthsDays = Utils.daysInMonth(selected);
        displayMonth = Utils.formatMonth(Utils.firstDayOfWeek(selected));
      });

      _launchDateSelectionCallback(selected);
    }
  }

  var gestureStart;
  var gestureDirection;
  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      if (isExpanded) {
        nextMonth();
      } else {
        nextWeek();
      }
    } else {
      if (isExpanded) {
        previousMonth();
      } else {
        previousWeek();
      }
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  // TODO: DISABLE DATE PICKING FOR PREVIOUS DAYS, HOLIDAYS, AND WEEKEND
  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(day);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(day);
    setState(() {
      _selectedDate = day;
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = Utils.daysInMonth(day);
    });
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected(day);
    }
  }
}

class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      flex: 1,
      child: new AnimatedCrossFade(
        firstChild: collapsed,
        secondChild: expanded,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
