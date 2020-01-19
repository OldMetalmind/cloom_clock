// Copyright 2020 Filipe Barroso. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';

enum AnimationState { show, hide }

class NumberFlareControler extends FlareController {
  final AnimationState currentState;
  final double _animationSpeed = 1;

  //Note: since in Rive the animation for `in` is 2 seconds
  //  and the `out`is 1 seconds, this serve as compensation
  //  so they take the same time
  final double _riveCompensation = 2.1;

  NumberFlareControler({this.currentState = AnimationState.show});

  double _animationTime = 0.0;

  ActorAnimation _animationIn;
  ActorAnimation _animationOut;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _animationTime += elapsed;
    assert(currentState != null);
    switch (currentState) {
      case AnimationState.show:
        _animationIn.apply(
            (_animationIn.duration * _animationTime * _animationSpeed) -
                _riveCompensation,
            artboard,
            1.0);
        break;
      case AnimationState.hide:
        _animationOut.apply(
            _animationOut.duration * _animationTime * _animationSpeed,
            artboard,
            1.0);
        break;
      default:
        throw Exception("Invalid state!");
    }
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    this._animationTime = 0.0;
    this._animationIn = artboard.getAnimation("in");
    assert(_animationIn != null);
    this._animationOut = artboard.getAnimation("out");
    assert(_animationOut != null);
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    // Empty on purpose
  }
}
