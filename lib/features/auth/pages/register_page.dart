import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../auth.dart';

class RegisterPage extends StatefulWidget {
  String? texte;
  String? login;

  RegisterPage({super.key, this.texte, this.login});

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

  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatePinPage(username: name.text,
                                      login: widget.login,
                                      role: widget.texte,
                                      password: password.text,),
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
}
