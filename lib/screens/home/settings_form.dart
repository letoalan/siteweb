import 'package:website/models/user.dart';
import 'package:website/services/database.dart';
import 'package:flutter/material.dart';
import 'package:website/shared/constants.dart';
import 'package:website/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:website/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final userr = Provider.of<NewUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: userr.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget> [
                Text(
                  'Mettre à jour son café.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'SVP entrez un nom' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? '0',
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );

                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged:(val) => setState(() => _currentStrength = val.round()),
                ),
                // slider
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Mise à jour',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: userr.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength,
                            );
                        Navigator.pop(context);
                      }
                    }
                ),
              ],
            ),

          );
        } else {
          return Loading();

        }

      }
    );
  }
}
