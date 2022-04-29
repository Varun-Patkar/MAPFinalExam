import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './utils/validator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinical ERP System'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                )
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterForm()),
                )
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> textFieldsValue = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clinical ERP System - Login'),
          centerTitle: true,
        ),
        body: Builder(
            builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                    key: const Key("Email"),
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.email),
                                      hintText: 'Enter your Email ID',
                                      labelText: 'Email ID',
                                    ),
                                    validator: (String? value) {
                                      textFieldsValue.add(value ?? "");
                                      return(FieldValidator.validateEmail(value));
                                    }),
                                // },
                                // ),
                                TextFormField(
                                    key: const Key("Password"),
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      hintText: 'Enter your Password',
                                      labelText: 'Password',
                                    ),
                                    validator: (String? value) {
                                      textFieldsValue.add(value ?? "");
                                      return(FieldValidator.validatePassword(value));
                                    }),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 40.0),
                                    child: ElevatedButton(
                                      child: const Text('Submit'),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // login(context);
                                        }
                                      },
                                    )),
                              ],
                            ),
                          ))
                    ])));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class RegisterFormState extends State<RegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final List<String> textFieldsValue = [];
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clinical ERP System - Register'),
          centerTitle: true,
        ),
        body: Builder(
            builder: (context) => Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'Enter your Full Name',
                                labelText: 'Name',
                              ),
                              validator: (value) {
                                textFieldsValue.add(value ?? "");
                                if (value!.isEmpty) {
                                  return "Please Enter Your Name";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.phone),
                                hintText: 'Enter a Phone Number',
                                labelText: 'Phone',
                              ),
                              validator: (value) {
                                textFieldsValue.add(value ?? "");
                                if (num.tryParse(value ?? "") == null) {
                                  return 'Mobile Number must be a number';
                                } else if (value?.length != 10)
                                  return 'Mobile Number must be of 10 digit';
                                else
                                  return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Enter your Email ID',
                                labelText: 'Email ID',
                              ),
                              validator: (value) {
                                textFieldsValue.add(value ?? "");
                                return(FieldValidator.validateEmail(value));
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: 'Enter your Password',
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                textFieldsValue.add(value ?? "");
                                return(FieldValidator.validatePassword(value));
                              },
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 40.0, top: 40.0),
                                child: ElevatedButton(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // register(context);
                                    }
                                  },
                                )),
                          ],
                        ),
                      )
                    ])));
  }
}

class LoggedIn extends StatelessWidget {
  final String currUser;
  const LoggedIn({Key? key, this.currUser = "Anonymous"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clinical ERP System - Logged In'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Hello, $currUser',
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () => {},
                child: const Text(
                  'Book Some Tables',
                  style: const TextStyle(fontSize: 30),
                )),
            const Padding(padding: EdgeInsets.all(100)),
          ],
        )));
  }
}
