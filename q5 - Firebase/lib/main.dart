import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: const Text('Restaurant Table Booking'),
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
  CollectionReference users = FirebaseFirestore.instance.collection('auth');
  void login(context) async {
    var flag = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: textFieldsValue[0], password: textFieldsValue[1]);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(const SnackBar(
          content: Text('No user found for that email.'),
          backgroundColor: Colors.red,
        ));
        flag = false;
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(const SnackBar(
          content: Text('Wrong password provided for that user.'),
          backgroundColor: Colors.red,
        ));
        flag = false;
      }
    }
    if (flag) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar(const SnackBar(
            content: Text('Login Failed'),
            backgroundColor: Colors.red,
          ));
        } else {
          users.doc(textFieldsValue[0]).get().then((value) {
            Map<String, dynamic> data = value.data()! as Map<String, dynamic>;
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoggedIn(
                        currUser: data['Name'],
                      )),
            );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant Table Booking - Login'),
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
                                      if (value.toString().isEmpty) {
                                        return "Enter Email";
                                      }
                                      RegExp regex = RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                      if (!regex.hasMatch(value.toString())) {
                                        return 'Enter valid Email';
                                      } else {
                                        return null;
                                      }
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
                                      if (value.toString().isEmpty) {
                                        return "Enter Password";
                                      }
                                      if (value.toString().length < 7) {
                                        return 'Password must be more than 6 characters';
                                      }
                                    }),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 40.0),
                                    child: ElevatedButton(
                                      child: const Text('Submit'),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          login(context);
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
  CollectionReference users = FirebaseFirestore.instance.collection('auth');
  void register(context) async {
    var flag = true;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: textFieldsValue[2],
        password: textFieldsValue[3],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        flag = false;
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'email-already-in-use') {
        flag = false;
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      flag = false;
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    if (flag) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar(const SnackBar(
            content: Text('Login Failed'),
            backgroundColor: Colors.red,
          ));
        } else {
          users.doc(textFieldsValue[2]).get().then((value) {
            if (value.exists) {
              Scaffold.of(context)
                  // ignore: deprecated_member_use
                  .showSnackBar(const SnackBar(
                content: Text('User already Exists. Try Logging In.'),
                backgroundColor: Colors.red,
              ));
            } else {
              users
                  .doc(textFieldsValue[2])
                  .set({
                    'Name': textFieldsValue[0],
                    'Phone Number': textFieldsValue[1],
                    'Email': textFieldsValue[2],
                  })
                  .then((value) => Scaffold.of(context)
                          // ignore: deprecated_member_use
                          .showSnackBar(const SnackBar(
                        content: Text('User Registered'),
                        backgroundColor: Colors.green,
                      )))
                  .catchError((error) => Scaffold.of(context)
                          // ignore: deprecated_member_use
                          .showSnackBar(SnackBar(
                        content: Text('Failed to Register User: $error'),
                        backgroundColor: Colors.red,
                      )));
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant Table Booking - Register'),
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
                                if (value.toString().isEmpty)
                                  return "Enter Email";
                                RegExp regex = RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                if (!regex.hasMatch(value.toString())) {
                                  return 'Enter valid Email';
                                } else {
                                  return null;
                                }
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
                                if (value.toString().isEmpty)
                                  return "Enter Password";
                                if (value.toString().length < 7) {
                                  return 'Password must be more than 6 characters';
                                }
                              },
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 40.0, top: 40.0),
                                child: ElevatedButton(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      register(context);
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
          title: const Text('Restaurant Table Booking - Logged In'),
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
