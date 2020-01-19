// Copyright 2020 Filipe Barroso. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:collection';

class FlareNumberAssets {
  LinkedList<FlareControllerEntry> _flareControllersData;

  FlareNumberAssets({String type}) {
    List<FlareControllerEntry> data = List.generate(
      10, // Number of digits 0->9
      (digit) => FlareControllerEntry(digit, lightType: type),
    );

    _flareControllersData = LinkedList<FlareControllerEntry>();
    //Note: When we grab the number 0 it will have the 9 as a previous
    _flareControllersData.addFirst(FlareControllerEntry(9, lightType: type));
    _flareControllersData.addAll(data);
    // [9 0 1 2 3 4 5 6 7 8 9]
  }

  FlareControllerEntry getController(int position) {
    //Note: Given we have a list [9 0 1 2 3 4 5 6 7 8 9]
    return _flareControllersData.elementAt(position + 1);
  }
}

class FlareControllerEntry extends LinkedListEntry<FlareControllerEntry> {
  String _asset;
  int _digit;

  FlareControllerEntry(this._digit, {String lightType}) {
    _asset = "assets/$lightType/${lightType}_0$_digit.flr";
  }

  String get asset {
    return _asset;
  }

  int get digit {
    return _digit;
  }

  @override
  String toString() {
    return "Asset: ${this._digit} , Asset ${this._asset}";
  }
}
