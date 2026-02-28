import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:opassage/features/intro/intro.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../../menu/pages/menu_page.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _isEmail = false;

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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  var login = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(
                      "Connexion",
                      style: TextStyle(
                        color: appColorBlack,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gap(4.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(1.h),
                        Text(
                          "Bon retour !",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Connectez-vous a votre compte",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(5.h),
                        _isEmail
                            ? InputText(
                                hintText: "Adresse e-mail",
                                keyboardType: TextInputType.text,
                                controller: email,
                                validatorMessage: "Veuillez saisir votre email",
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: appColorWhite,
                                  borderRadius: BorderRadius.circular(3.w),
                                  border: Border.all(
                                    color: _isFocused
                                        ? appColor
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: InternationalPhoneNumberInput(
                                  focusNode: _focusNode,
                                  onInputChanged: (PhoneNumber number) {
                                    phoneIndicator = number.phoneNumber!;
                                  },
                                  onInputValidated: (bool value) {},
                                  errorMessage: "Le numéro est invalide",
                                  hintText: "Téléphone",
                                  selectorConfig: const SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  selectorTextStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  initialValue: number,
                                  textFieldController: login,
                                  formatInput: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        signed: true,
                                        decimal: true,
                                      ),
                                  inputBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  onSaved: (PhoneNumber number) {},
                                ),
                              ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isEmail = !_isEmail;
                              login.clear();
                            });
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              _isEmail
                                  ? "Se connecter avec un numéro de téléphone"
                                  : "Se connecter avec une adresse e-mail",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: appColorChoise,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Gap(4.h),
                        SubmitButton(
                          AppConstants.btnLogin,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loginUser(context);
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Tous les champs sont obligatoires",
                              );
                            }
                          },
                        ),
                        Gap(3.h),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => IntroPage()),
                              );
                            },
                            child: Text(
                              "Pas encore de compte ? ${AppConstants.btnRegister}",
                              style: TextStyle(
                                color: appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
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

  Future<void> loginUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text('Authentification...')),
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
        Uri.parse(ApiUrls.postAuthLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': email.text.isNotEmpty ? email.text : phoneIndicator,
          'password': password.text,
        }),
      );
      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("rentre");
        // Sauvegarder toutes les infos utilisateur
        print(responseData['data']['phone'] ?? "");
        await Future.wait([
          SharedPreferencesHelper().saveInteger(
            'identifiant',
            responseData['data']['id'],
          ),
          SharedPreferencesHelper().saveString(
            'username',
            responseData['data']['username'],
          ),
          SharedPreferencesHelper().saveString(
            'email',
            responseData['data']['email'] ?? "",
          ),
          SharedPreferencesHelper().saveString(
            'phone',
            responseData['data']['phone'] ?? "",
          ),
          SharedPreferencesHelper().saveInteger(
            'code',
            responseData['data']['code'],
          ),
          SharedPreferencesHelper().saveString(
            'role',
            responseData['data']['role'],
          ),
        ]);

        Navigator.pop(context);

        SnackbarHelper.showSuccess(context, responseData['message']);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
          (route) => false,
        );
      } else if (response.statusCode == 401) {
        Navigator.pop(context);
        SnackbarHelper.showWarning(context, responseData['message']);
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
          "Impossible de se connecter. Veuillez réessayer!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
    }
  }
}
