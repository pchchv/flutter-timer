import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class _Selector<T> extends StatefulWidget {

  @override
  _SelectorState<T> createState() => _SelectorState<T>();
}

class _SelectorState<T> extends State<_Selector<T>> {
  int _currentIndex = 0;
}
