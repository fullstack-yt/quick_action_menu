import 'dart:math';

import 'package:flutter/material.dart';
import 'quick_action.dart';
import 'quick_action_icon.dart';

class QuickActionButton extends StatefulWidget {
  final QuickAction action;
  final bool isOpen;
  final int index;
  final Function() close;

  const QuickActionButton(
    this.action, {
    super.key,
    required this.isOpen,
    required this.index,
    required this.close,
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  final _radius = 130.0;
  final _offset = 10.0;

  double degToRad(double deg) {
    return pi * deg / 180.0;
  }

  double get _range => 90.0 - _offset;

  double get _alpha => _offset / 2 + widget.index * _range / 2;

  double get _radian => degToRad(_alpha);

  double get _b => sin(_radian) * _radius;

  double get _a => cos(_radian) * _radius;

  final _duration = const Duration(milliseconds: 250);
  var _isPressed = false;

  _pressDown() {
    setState(() {
      _isPressed = true;
    });
  }

  _pressUp() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      bottom: widget.isOpen ? _b : 0,
      right: widget.isOpen ? _a : 0,
      curve: Curves.easeOut,
      child: Padding(
        padding: const EdgeInsets.all(16.0)
            .copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
        child: AnimatedRotation(
          turns: widget.isOpen ? 0 : 0.1,
          alignment: Alignment.center,
          curve: Curves.easeOut,
          duration: _duration * 1.5,
          child: AnimatedOpacity(
            opacity: widget.isOpen ? 1 : 0,
            duration: _duration,
            child: AnimatedScale(
              scale: _isPressed ? 0.95 : 1,
              duration: _duration,
              child: GestureDetector(
                onTapDown: (_) => _pressDown(),
                onTapUp: (_) => _pressUp(),
                onTapCancel: () => _pressUp(),
                onTap: () {
                  widget.close();
                  widget.action.onTap();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: QuickActionIcon(
                    icon: Icon(
                      widget.action.icon,
                      size: 28,
                      color: widget.action.iconColor ?? Colors.black,
                    ),
                    backgroundColor: widget.action.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
