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

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _isChecked = true;

  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// IMAGE BACKGROUND
          Positioned.fill(
            child: Image.asset("assets/images/2.png", fit: BoxFit.cover),
          ),

          /// GRADIENT OVERLAY
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),

          /// CONTENU
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: .end,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                color: appColorBlack.withValues(alpha: .4),
                              ),

                              Column(
                                children: [
                                  /// TITRE
                                  Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      "Plonge dans l’univers des belles "
                                      "expériences dans ton hébergement "
                                      "avec O'Passage, ton appli",
                                      style: TextStyle(
                                        color: appColorSecond,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Gap(4.h),

                                  /// FORMULAIRE AVEC COURBE
                                  ClipPath(
                                    clipper: NewClipperR(),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(6.w),
                                      color: appColorFondLogin,

                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: .min,
                                          mainAxisAlignment: .start,
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text(
                                              "\nCréer ton compte",
                                              style: TextStyle(
                                                color: appColor,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Gap(1.h),
                                            Text(
                                              "Pseudo ou prénoms",
                                              style: TextStyle(
                                                color: appColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Gap(1.h),

                                            InputText(
                                              hintText: "jeanmichel",
                                              controller: name,
                                              validatorMessage:
                                                  "Veuillez saisir votre pseudo ou prénoms",
                                            ),

                                            Gap(1.h),
                                            Text(
                                              "Créer un mot de passe",
                                              style: TextStyle(
                                                color: appColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Gap(1.h),

                                            InputPassword(
                                              hintText: "**********",
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
                                            Text(
                                              "Confirme le mot de passe",
                                              style: TextStyle(
                                                color: appColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Gap(1.h),

                                            InputPassword(
                                              hintText: "**********",
                                              controller: confirmPassword,
                                              validatorMessage:
                                                  "Veuillez confirmer votre mot de passe",
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

                                            Gap(3.h),

                                            SubmitButton(
                                              AppConstants.btnCreate,
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (password.text ==
                                                      confirmPassword.text) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreatePinPage(
                                                              username:
                                                                  name.text,
                                                              login:
                                                                  widget.login,
                                                              role:
                                                                  widget.texte,
                                                              password:
                                                                  password.text,
                                                            ),
                                                      ),
                                                    );
                                                  } else {
                                                    SnackbarHelper.showError(
                                                      context,
                                                      "Les mots de passe ne correspondent pas",
                                                    );
                                                  }
                                                }
                                              },
                                            ),

                                            Gap(1.h),

                                            /// CONDITIONS
                                            Row(
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
                                                        fontSize: 14.sp,
                                                        color: appColorBlack,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text:
                                                              "J'accepte les ",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "Conditions générales d’utilisation",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          ),
                                                          recognizer: TapGestureRecognizer()
                                                            ..onTap = () {
                                                              showBarModalBottomSheet(
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                expand: true,
                                                                topControl: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: FloatingActionButton.small(
                                                                    heroTag:
                                                                        "Condition",
                                                                    backgroundColor:
                                                                        appColorWhite,
                                                                    shape:
                                                                        const CircleBorder(),
                                                                    onPressed: () =>
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop(),
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color:
                                                                          appColorBlack,
                                                                    ),
                                                                  ),
                                                                ),
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Container(),
                                                              );
                                                            },
                                                        ),
                                                        const TextSpan(
                                                          text: " et la ",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "Politique de Confidentialité.",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          ),
                                                          recognizer: TapGestureRecognizer()
                                                            ..onTap = () {
                                                              showBarModalBottomSheet(
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                expand: true,
                                                                topControl: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: FloatingActionButton.small(
                                                                    heroTag:
                                                                        "Politique",
                                                                    backgroundColor:
                                                                        appColorWhite,
                                                                    shape:
                                                                        const CircleBorder(),
                                                                    onPressed: () =>
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop(),
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color:
                                                                          appColorBlack,
                                                                    ),
                                                                  ),
                                                                ),
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Container(),
                                                              );
                                                            },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "NB : La création d'un compte "
                                              "suppose que tu as consulté et "
                                              "accepté les Conditions Générales "
                                              "d'Utilisation et la Politique "
                                              "de Confidentialité.",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// BACK BUTTON + LOGO
          Positioned(
            top: 4.h,
            left: 2.w,
            child: Row(
              children: [
                FloatingActionButton.small(
                  backgroundColor: appColorWhite,
                  elevation: 0,
                  shape: CircleBorder(),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back_ios_outlined, color: appColor),
                ),
                Image.asset("assets/images/logo_color.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewClipperR extends CustomClipper<Path> {
  final double leftOffset;

  NewClipperR({this.leftOffset = 80.0});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, leftOffset);

    path.cubicTo(
      size.width * 0.20,
      -25.0,
      size.width * 0.90,
      -8.0,
      size.width,
      50.0,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
