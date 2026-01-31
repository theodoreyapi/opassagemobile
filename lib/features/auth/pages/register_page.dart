import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:opassage/features/menu/menu.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../auth.dart';

class RegisterPage extends StatefulWidget {
  String? texte;

  RegisterPage({super.key, this.texte});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  late bool _isChecked = true;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  var login = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    FloatingActionButton.small(
                      backgroundColor: appColorWhite,
                      elevation: 0,
                      shape: CircleBorder(),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Icon(Icons.arrow_back, color: appColorBlack),
                    ),
                    Image.asset("assets/images/logo_color.png"),
                  ],
                ),
                Gap(4.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "Plonge dans l’univers des belles expériences dans "
                          "ton hébergement",
                          style: TextStyle(
                            color: appColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(1.h),
                        Text(
                          "Renseignez vos informations pour finaliser "
                          "votre inscription",
                          style: TextStyle(
                            color: appColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(4.h),
                        InputText(
                          hintText: "Pseudo ou prenoms",
                          keyboardType: TextInputType.text,
                          controller: name,
                          validatorMessage:
                              "Veuillez saisir votre pseudo ou prenoms",
                        ),
                        Gap(1.h),
                        InputPassword(
                          hintText: "Mot de passe",
                          controller: password,
                          validatorMessage:
                              "Veuillez saisir votre mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                        Gap(1.h),
                        InputPassword(
                          hintText: "Confimer le mot de passe",
                          controller: confirmPassword,
                          validatorMessage:
                              "Veuillez saisir votre mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                        Gap(2.h),
                        SubmitButton(
                          AppConstants.btnCreate,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (password.text == confirmPassword.text) {
                                //registerUser(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(),
                                  ),
                                );
                              } else {
                                SnackbarHelper.showError(
                                  context,
                                  "Les mots de passe ne correspondent pas",
                                );
                              }
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Tous les champs sont obligatoires",
                              );
                            }
                          },
                        ),
                        Gap(2.h),
                        Center(
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: appColorBlack,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "J'accepte les conditions GU",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: appColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showBarModalBottomSheet(
                                              isDismissible: false,
                                              enableDrag: false,
                                              expand: true,
                                              topControl: Align(
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    FloatingActionButton.small(
                                                      heroTag: "Condition",
                                                      backgroundColor:
                                                          appColorWhite,
                                                      shape:
                                                          const CircleBorder(),
                                                      onPressed: () =>
                                                          Navigator.of(
                                                            context,
                                                          ).pop(),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: appColorBlack,
                                                      ),
                                                    ),
                                              ),
                                              context: context,
                                              builder: (context) => Container(),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appColor,
          surfaceTintColor: appColor,
          shadowColor: appColor,
          content: Row(
            children: [
              CircularProgressIndicator(color: appColorWhite),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Création du compte...',
                  style: TextStyle(color: appColorWhite),
                ),
              ),
            ],
          ),
        );
      },
    );

    try {
      // Autoriser les certificats auto-signés (attention en production)
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final response = await http.post(
        Uri.parse(ApiUrls.postRegister),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nom': name.text,
          'prenom': lastName.text,
          'phone': phoneIndicator.isEmpty ? login.text : phoneIndicator,
          'email': email.text,
          'password': password.text,
          'role': widget.texte == "Cliente" ? 'user' : 'hair',
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);

        SnackbarHelper.showSuccess(context, responseData['message']);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      } else if (response.statusCode == 401) {
        Navigator.pop(context);
        SnackbarHelper.showError(context, responseData['message']);
      } else if (response.statusCode == 422) {
        Navigator.pop(context);
        final message = responseData['message'];
        if (message is List && message.isNotEmpty) {
          SnackbarHelper.showError(context, message.first);
        } else if (message is String) {
          SnackbarHelper.showError(context, message);
        } else {
          SnackbarHelper.showError(context, "Une erreur est survenue.");
        }
      } else {
        Navigator.pop(context);
        SnackbarHelper.showError(
          context,
          "Impossible de s'enregistrer. Veuillez réessayer!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
    }
  }
}
