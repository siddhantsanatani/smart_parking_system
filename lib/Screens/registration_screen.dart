import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/getwidget.dart';
import 'package:smart_parking_system/Screens/success_screen.dart';
import '/design_system/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WizardFormReg extends StatefulWidget {
  static String id = 'reg_screen';
  const WizardFormReg({Key? key}) : super(key: key);

  @override
  _WizardFormState createState() => _WizardFormState();
}

class _WizardFormState extends State<WizardFormReg> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  late String gender;
  late String idCardNum;
  late String vehicleName;
  late String vehicleNumber;
  late String selectIdCard;
  late String number;
  // late String dob;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: BlurryModalProgressHUD(
              inAsyncCall: showSpinner,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitWave(
                color: AppColors.violet,
                size: 90.0,
              ),
              dismissible: false,
              opacity: 0.4,
              color: AppColors.overlay,
              child: SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                                      text: 'Register a new',
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
                            if (state.stepCompleted == 0) {
                              setState(() {
                                showSpinner = true;
                              });
                              await _auth
                                  .createUserWithEmailAndPassword(
                                      email: email, password: password)
                                  .then((value) {
                                GFToast.showToast("Account Added.", context,
                                    toastDuration: 2,
                                    toastPosition: GFToastPosition.BOTTOM_RIGHT,
                                    // toastBorderRadius: 1,
                                    backgroundColor: AppColors.navy,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 16.0));
                                GFToast.showToast(
                                    "Continue filling Personal Details",
                                    context,
                                    toastDuration: 2,
                                    toastPosition: GFToastPosition.BOTTOM_RIGHT,
                                    // toastBorderRadius: 1,
                                    backgroundColor: AppColors.navy,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 16.0));
                              }).onError((error, stackTrace) {
                                GFToast.showToast(error.toString(), context,
                                    toastDuration: 3,
                                    toastPosition: GFToastPosition.BOTTOM_RIGHT,
                                    // toastBorderRadius: 1,
                                    backgroundColor: AppColors.pink,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 16.0));
                              });
                              setState(() {
                                showSpinner = false;
                              });
                            } else if (state.stepCompleted == state.lastStep) {
                              setState(() {
                                showSpinner = true;
                              });
                              users
                                  .doc(_auth.currentUser!.uid)
                                  .set({
                                    'firstName': firstName,
                                    'gender': gender,
                                    'idCardNum': idCardNum,
                                    'lastName': lastName,
                                    'number': number,
                                    'selectIdCard': selectIdCard,
                                    'vehicleName': vehicleName,
                                    'vehicleNumber': vehicleNumber,
                                    // 'dob': dob // 42
                                  })
                                  .then((value) => print("User Added"))
                                  .onError((error, stackTrace) =>
                                      print("Failed to add user: $error"));
                              Navigator.pushNamed(context, SuccessScreen.id);
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                          // onFailure: (context, state) {
                          //   LoadingDialog.hide(context);
                          // },
                          child: StepperFormBlocBuilder<WizardFormBloc>(
                            formBloc: context.read<WizardFormBloc>(),
                            physics: const ClampingScrollPhysics(),
                            stepsBuilder: (formBloc) {
                              return [
                                _accountStep(formBloc!),
                                _personalStep(formBloc),
                                _vehicleStep(formBloc),
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
      continueButtonLabel: 'Next',
      cancelButtonLabel: 'Back',
      title: const Text('Account Details'),
      content: Column(
        children: [
          TextFieldBlocBuilder(
            maxLength: 14,
            maxLengthEnforced: MaxLengthEnforcement.enforced,
            textFieldBloc: wizardFormBloc.number,
            onChanged: (value) {
              number = value;
            },
            keyboardType: TextInputType.number,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: const InputDecoration(
              labelText: 'Number',
              prefixIcon: Icon(Icons.phone),
              counterText: "",
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.email,
            onChanged: (value) {
              email = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.password,
            onChanged: (value) {
              password = value;
            },
            keyboardType: TextInputType.emailAddress,
            suffixButton: SuffixButton.obscureText,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _personalStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      continueButtonLabel: 'Next',
      cancelButtonLabel: 'Cancel',
      title: const Text('Personal Details'),
      content: Column(
        children: [
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.firstName,
            onChanged: (value) {
              firstName = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.lastName,
            onChanged: (value) {
              lastName = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          RadioButtonGroupFieldBlocBuilder<String>(
            selectFieldBloc: wizardFormBloc.gender,
            itemBuilder: (context, value) => FieldItem(
              child: Text(value),
              onTap: () {
                gender = value;
              },
            ),
            decoration: const InputDecoration(
              labelText: 'Gender',
              prefixIcon: SizedBox(),
            ),
          ),
          // DateTimeFieldBlocBuilder<String>(
          //   dateTimeFieldBloc: wizardFormBloc.birthDate,
          //   onChanged: (value) {
          //     dob = value!;
          //     // wizardFormBloc.birthDate.value!.toUtc().toIso8601String();
          //     print(dob);
          //   },
          //   pickerBuilder: (context, value) => FieldItem(
          //     child: value,
          //   ),
          //   firstDate: DateTime(1950),
          //   initialDate: DateTime.now(),
          //   lastDate: DateTime.now(),
          //   format: DateFormat('yyyy-MM-dd'),
          //   decoration: const InputDecoration(
          //     labelText: 'Date of Birth',
          //     prefixIcon: Icon(Icons.cake),
          //   ),
          // ),
          DropdownFieldBlocBuilder<String>(
            showEmptyItem: false,
            selectFieldBloc: wizardFormBloc.idCard,
            decoration: const InputDecoration(
              labelText: 'Select ID',
            ),
            selectedItemBuilder: (context, value) => FieldItem(
              child: Text(value),
            ),
            onChanged: (value) {
              selectIdCard = value!;
              print(selectIdCard);
            },
            itemBuilder: (context, value) => FieldItem(
              child: Label(
                text: value,
                color: AppColors.dark,
              ),
              // onTap: () {
              //   selectIdCard = value;
              // },
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.idNumber,
            onChanged: (value) {
              idCardNum = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'ID Number',
              prefixIcon: Icon(Icons.credit_card),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _vehicleStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      continueButtonLabel: 'Submit',
      cancelButtonLabel: 'Back',
      title: const Text('Vehicle Details'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.vehicleName,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              vehicleName = value;
            },
            decoration: const InputDecoration(
              labelText: 'Vehicle Name',
              prefixIcon: Icon(Icons.car_repair),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.vehicleNumber,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              vehicleNumber = value;
            },
            decoration: const InputDecoration(
              labelText: 'Vehicle Number',
              prefixIcon: Icon(Icons.confirmation_num),
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

  final firstName = TextFieldBloc();

  final lastName = TextFieldBloc();

  final gender = SelectFieldBloc(
    items: ['Male', 'Female', 'Other'],
  );

  // final birthDate = InputFieldBloc<DateTime?, String>(
  //   initialValue: null,
  //   toJson: (value) => value!.toUtc().toIso8601String(),
  //   validators: [FieldBlocValidators.required],
  // );

  final vehicleName = TextFieldBloc();

  final vehicleNumber = TextFieldBloc();

  final idNumber = TextFieldBloc();

  final idCard = SelectFieldBloc(
    items: ['PAN Card', 'Aadhaar', 'Driving License', 'Voter ID'],
  );

  WizardFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [email, number, password],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [firstName, lastName, gender, idCard, idNumber],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [vehicleName, vehicleNumber],
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
