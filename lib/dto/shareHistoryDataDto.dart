class ShareHistoryDataDto {
  DateTime _date;
  double _value;

  DateTime getDate() {
    return _date;
  }

  double getValue() {
    return _value;
  }

  ShareHistoryDataDto({required DateTime date, required double value})
      : this._date = date,
        this._value = value;
}