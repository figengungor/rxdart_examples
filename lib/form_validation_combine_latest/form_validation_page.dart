import 'package:flutter/material.dart';
import 'package:rxdart_examples/form_validation_combine_latest/form_validation_provider.dart';

class FormValidationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FormValidationBloc _bloc = FormValidationProvider.of(context).bloc;
    return Scaffold(
      appBar: AppBar(title: Text('Form Validation')),
      body: _buildBody(_bloc),
    );
  }

  _buildBody(FormValidationBloc bloc) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _buildEmailField(bloc),
              _buildPasswordField(bloc),
              _buildSubmitButton(bloc),
            ]
                .map((item) => Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: item,
                    ))
                .toList(),
          ),
        ),
      );

  _buildEmailField(FormValidationBloc bloc) => StreamBuilder(
        stream: bloc.email,
        builder: (context, snapshot) => TextField(
              decoration: InputDecoration(
                  labelText: 'E-mail', errorText: snapshot.error),
              onChanged: bloc.changeEmail,
            ),
      );

  _buildPasswordField(FormValidationBloc bloc) => StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) => TextField(
              decoration: InputDecoration(
                  labelText: 'Password', errorText: snapshot.error),
              onChanged: bloc.changePassword,
              obscureText: true,
            ),
      );

  _buildSubmitButton(FormValidationBloc bloc) => StreamBuilder(
        stream: bloc.isSubmitValid,
        builder: (context, snapshot) => RaisedButton(
              child: Text('Submit'),
              onPressed: snapshot.hasData && snapshot.data ? bloc.submit : null,
            ),
      );
}
