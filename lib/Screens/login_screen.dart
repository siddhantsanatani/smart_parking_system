import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
//import 'package:smart_parking_system/externals/flutter_form_bloc-0.30.1/lib/flutter_form_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/getwidget.dart';
import 'package:smart_parking_system/Screens/home.dart';
import '../externals/flutter_form_bloc-0.30.1/flutter_form_bloc.dart';
import '/design_system/styles.dart';

class WizardFormLogIn extends StatefulWidget {
  static String id = 'login_screen';
  const WizardFormLogIn({Key? key}) : super(key: key);

  @override
  _WizardFormLogInState createState() => _WizardFormLogInState();
}

class _WizardFormLogInState extends State<WizardFormLogIn> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: BlurryModalProgressHUD(
              inAsyncCall: showSpinner,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitDoubleBounce(
                color: AppColors.violet,
                size: 90.0,
              ),
              dismissible: false,
              opacity: 0.4,
              color: AppColors.overlay,
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          width: double.maxFinite,
                          height: 166,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: const [
                                    Expanded(
                                      child: SizedBox(),
                                      flex: 5,
                                    ),
                                    Header2(
                                      text: 'LogIn to your',
                                      color: AppColors.dark,
                                    ),
                                    Header2(
                                      text: 'Park.Inn Account',
                                      color: AppColors.dark,
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                      flex: 1,
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              Image.asset(
                                "images/corner_bg.png",
                                width: 172,
                                height: 166,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FormBlocListener<WizardFormBloc, String, String>(
                          // onSubmitting: (context, state) =>
                          //     LoadingDialog.show(context),
                          onSuccess: (context, state) async {
                            // LoadingDialog.hide(context);
                            if (state.stepCompleted == state.lastStep) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                if (_auth.currentUser != null) {
                                  GFToast.showToast(
                                      "Signed In Successfully", context,
                                      toastDuration: 2,
                                      toastPosition:
                                          GFToastPosition.BOTTOM_RIGHT,
                                      // toastBorderRadius: 1,
                                      backgroundColor: AppColors.navy,
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 16.0));
                                } else {
                                  GFToast.showToast(
                                      "Sign In Failed. Please verify your credential & try signing in again",
                                      context,
                                      toastDuration: const Duration(seconds: 3),
                                      toastPosition:
                                          GFToastPosition.BOTTOM_LEFT,
                                      // toastBorderRadius: 1,
                                      backgroundColor: AppColors.pink,
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 16.0));
                                }
                                Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const HomeScreen()),
                                    ModalRoute.withName('HomeScreen.id'));
                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                //print(e);
                              }
                            }
                          },
                          // onFailure: (context, state) {
                          //   LoadingDialog.hide(context);
                          // },
                          child: StepperFormBlocBuilder<WizardFormBloc>(
                            formBloc: context.read<WizardFormBloc>(),
                            // type: _type,
                            physics: const ClampingScrollPhysics(),
                            stepsBuilder: (formBloc) {
                              return [
                                _accountStep(formBloc!),
                              ];
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _accountStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      continueButtonLabel: 'Sign In',
      cancelButtonLabel: 'Back',
      title: const Text('LogIn Details'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            // enableOnlyWhenFormBlocCanSubmit: true,
            decoration: const InputDecoration(
              labelText: 'Email Id',
              prefixIcon: Icon(Icons.email),
              counterText: "",
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.password,
            keyboardType: TextInputType.emailAddress,
            suffixButton: SuffixButton.obscureText,
            onChanged: (value) => password = value,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ],
      ),
    );
  }
}

class WizardFormBloc extends FormBloc<String, String> {
  final username = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final email = TextFieldBloc<String>(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final number = TextFieldBloc<String>(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.number,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars,
    ],
  );

  WizardFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [email, password],
    );
  }

  // bool _showEmailTakenError = true;

  @override
  void onSubmitting() async {
    // if (state.currentStep == 0) {
    //   await Future.delayed(const Duration(milliseconds: 500));
    //
    //   if (_showEmailTakenError) {
    //     _showEmailTakenError = false;
    //
    //     email.addFieldError('That email is already taken');
    //
    //     emitFailure();
    //   } else {
    //     emitSuccess();
    //   }
    // } else if (state.currentStep == 1) {
    //   emitSuccess();
    // } else if (state.currentStep == 2) {
    //   await Future.delayed(const Duration(milliseconds: 500));

    emitSuccess();
    // }
  }
}

// class LoadingDialog extends StatelessWidget {
//   static void show(BuildContext context, {Key? key}) => showDialog<void>(
//         context: context,
//         useRootNavigator: false,
//         barrierDismissible: false,
//         builder: (_) => LoadingDialog(key: key),
//       ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

//   static void hide(BuildContext context) => Navigator.pop(context);

//   const LoadingDialog({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Center(
//         child: Card(
//           child: Container(
//             width: 80,
//             height: 80,
//             padding: const EdgeInsets.all(12.0),
//             // child: const CircularProgressIndicator(),
//           ),
//         ),
//       ),
//     );
//   }
// }
