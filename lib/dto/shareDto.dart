class ShareDto {
  double _shareValue;
  int _numberOfShares;
  String _shareName;
  String _shareSymbol;

  double getShareValue() {
    return _shareValue;
  }

  int getNumberOfShare() {
    return _numberOfShares;
  }

  String getShareName() {
    return _shareName;
  }

  String getShareSymbol() {
    return _shareSymbol;
  }

  ShareDto({shareValue, numberOfShares, shareName, shareSymbol})
      : this._shareValue = shareValue,
        this._numberOfShares = numberOfShares,
        this._shareName = shareName,
        this._shareSymbol = shareSymbol;
}