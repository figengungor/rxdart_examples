import 'package:flutter/material.dart';
import 'package:rxdart_examples/form_validation_combine_latest/form_validation_bloc.dart';
export 'package:rxdart_examples/form_validation_combine_latest/form_validation_bloc.dart';

class FormValidationProvider extends StatefulWidget {
  final Widget child;

  FormValidationProvider({this.child});

  @override
  _FormValidationProviderState createState() => _FormValidationProviderState();

  static _InheritedWidget of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_InheritedWidget)
          as _InheritedWidget);
}

class _FormValidationProviderState extends State<FormValidationProvider> {
  FormValidationBloc _bloc = FormValidationBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
      bloc: _bloc,
      child: widget.child,
    );
  }
}

class _InheritedWidget extends InheritedWidget {
  final FormValidationBloc bloc;

  _InheritedWidget({this.bloc, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
