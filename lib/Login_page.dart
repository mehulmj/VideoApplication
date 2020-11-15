import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
    _LoginPageState createState() => new _LoginPageState();
}
enum FormType {
  login,
  register
}
class _LoginPageState extends State<LoginPage>{
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  Future validateAndSubmit() async{
    try{
      if(_formType==FormType.login)
      {
        if(validateAndSave())
        {
            final User  user= (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
            if(user!=null)
            print("Logged in : ${user.uid}");
            else
            print("Doesnt exist");
        }
      }
      else{
        if(validateAndSave()){
          final User user= (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print("yes");
          if(user!=null)
          print("Registered : ${user.uid}");
          else
          print("unable to create user");
        }
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  void moveToRegister()
  {
    formKey.currentState.reset();
    setState(() {
        _formType=FormType.register;
    });
  }
  void moveToLogin()
  {
    formKey.currentState.reset();
    setState(() {
          _formType=FormType.login;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:Text("Login Page")
        ),
      body : new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
        key: formKey,
        child:new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildinput() + buildbutton()
        ),
        )
      )
    );
      
  }
  List<Widget> buildinput()
  {
    if(_formType==FormType.login)
    {
        return [
          new TextFormField(
            decoration: new InputDecoration(labelText: "Email"),
            validator: (value) => value.isEmpty ? 'Email can\'t be empty':null ,
            onSaved:(value)=> _email = value,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (value) => value.isEmpty ? 'Password can\'t be empty':null ,
            onSaved: (value) => _password=value,
          )
          ];
        }
        else
        {
         return [
            new TextFormField(
              decoration: new InputDecoration(labelText: "Email"),
              validator: (value) => value.isEmpty ? 'Email can\'t be empty':null ,
              onSaved:(value)=> _email = value,
              ),
            new TextFormField(
              decoration: new InputDecoration(labelText: "Password"),
              obscureText: true,
              validator: (value) => value.isEmpty ? 'Password can\'t be empty':null ,
              onSaved: (value) => _password=value,
              )
          ];
        } 
        
    }
    List<Widget> buildbutton()
    {
      if(_formType==FormType.login)
      {
        return [
          new RaisedButton(
            child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          new FlatButton(onPressed: moveToRegister, child: new Text('Not an User? Create an account.',style: new TextStyle(fontSize: 20.0),))

        ];
      }
      else
      {
         return [
          new RaisedButton(
            child: new Text('Create an User', style: new TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          new FlatButton(onPressed: moveToLogin, child: new Text('Already an User? Login.',style: new TextStyle(fontSize: 20.0),))
        ];
      }
    }
  }

mixin AuthResult {
}