import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/utils/utils.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/auth/auth.dart';
import 'package:opassage/features/menu/menu.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../services/auth_service.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int _pageIndex = 0;
  late int _nbreSlides;

  String? registerLogin; // email ou téléphone

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => checkLogin());
    _pageController = PageController(initialPage: 0);
    _nbreSlides = demoData.length;
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString("role");
    if (role != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Container()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: demoData.length,
        onPageChanged: (index) => setState(() => _pageIndex = index),
        itemBuilder: (context, index) {
          final item = demoData[index];
          return OnboardSlide(
            data: item,
            pageIndex: _pageIndex,
            total: demoData.length,
            onNext: () {
              if (_pageIndex + 1 < demoData.length) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChoiseRegisterPage(login: registerLogin),
                  ),
                );
              }
            },
            onRegisterSuccess: (login) {
              setState(() {
                registerLogin = login;
              });
            },
            registerLogin: registerLogin,
          );
        },
      ),
    );
  }
}

// Enum pour définir les types de formulaires
enum FormType {
  emailPhone, // Slide 1: Email + Téléphone
  nameAddress, // Slide 2: Nom + Adresse
  finalInfo, // Slide 3: Autres infos
}

class Onboard {
  final String title, images;
  final FormType formType;

  Onboard({required this.title, required this.images, required this.formType});
}

final List<Onboard> demoData = [
  Onboard(
    images: "assets/images/1.png",
    title: AppConstants.txtOne,
    formType: FormType.emailPhone,
  ),
  Onboard(
    images: "assets/images/2.png",
    title: AppConstants.txtTwo,
    formType: FormType.nameAddress,
  ),
  Onboard(
    images: "assets/images/3.png",
    title: AppConstants.txtThree,
    formType: FormType.finalInfo,
  ),
];

class OnboardSlide extends StatefulWidget {
  final Onboard data;
  final int pageIndex;
  final int total;
  final VoidCallback onNext;
  final Function(String login)? onRegisterSuccess;
  final String? registerLogin;

  OnboardSlide({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.total,
    required this.onNext,
    this.onRegisterSuccess,
    this.registerLogin,
  });

  @override
  State<OnboardSlide> createState() => _OnboardSlideState();
}

class _OnboardSlideState extends State<OnboardSlide> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  String? otp;

  bool isLoading = false;
  int secondsLeft = 60;
  Timer? timer;

  late final TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  var login = TextEditingController();
  var email = TextEditingController();

  void dispose() {
    pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  // Méthode pour générer le formulaire selon le type
  Widget _buildForm(FormType formType) {
    switch (formType) {
      case FormType.emailPhone:
        return _buildEmailPhoneForm();
      case FormType.nameAddress:
        return _buildNameAddressForm();
      case FormType.finalInfo:
        return _buildFinalInfoForm();
    }
  }

  Widget _buildEmailPhoneForm() {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Text(
          "\n\nBienvenue,\nPour t'inscrire, renseigne ton",
          style: TextStyle(
            color: appColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gap(1.h),
        Text(
          "Numéro de téléphone",
          style: TextStyle(
            color: appColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(1.h),
        Container(
          padding: EdgeInsets.only(left: 4.w),
          decoration: BoxDecoration(
            color: appColor.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(
              color: _isFocused ? appColor : appColor,
              width: 2,
            ),
          ),
          child: InternationalPhoneNumberInput(
            focusNode: _focusNode,
            onInputChanged: (PhoneNumber number) {
              phoneIndicator = number.phoneNumber!;
            },
            onInputValidated: (bool value) {},
            hintText: "07 07 07 07 07",
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: appColor),
            countries: ['CI'],
            initialValue: number,
            textFieldController: login,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputBorder: OutlineInputBorder(borderSide: BorderSide.none),
            onSaved: (PhoneNumber number) {},
          ),
        ),
        Gap(1.h),
        Center(
          child: Text(
            "OU",
            style: TextStyle(
              color: appColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Gap(1.h),
        Text(
          "Adresse email",
          style: TextStyle(
            color: appColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(1.h),
        InputText(
          hintText: "jeanclaude@gmail.com",
          keyboardType: TextInputType.emailAddress,
          controller: email,
        ),
      ],
    );
  }

  Widget _buildNameAddressForm() {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: TextStyle(fontSize: 25.sp, color: appColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: appColor, width: 2),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appColor, width: 2),
      borderRadius: BorderRadius.circular(3.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(color: appColorWhite),
    );

    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Text(
          "\n\nCommençons ton inscription",
          style: TextStyle(
            color: appColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gap(1.h),
        Text(
          "Saisi le code reçu par sms ou email",
          style: TextStyle(
            color: appColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(1.h),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                controller: pinController,
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                showCursor: true,
                onCompleted: (pin) {
                  otp = pin;
                },
                onChanged: (value) {},
              ),
            ),
            Gap(1.w),
            Expanded(
              child: SubmitButton(
                height: 14.w,
                "Recevoir OTP",
                fontSize: 12.sp,
                onPressed: () async {
                  final body = jsonEncode({
                    "login": email.text.isNotEmpty
                        ? email.text
                        : phoneIndicator,
                  });
                  await AuthApi.resendOtp(body);
                  _startTimer();
                },
                couleur: appColor,
                textcouleur: appColorWhite,
              ),
            ),
          ],
        ),
        Gap(1.h),
        Text(
          secondsLeft > 0
              ? "Renvoyez le code dans : $secondsLeft "
                    "secondes"
              : "Vous pouvez renvoyer le code",
          style: TextStyle(
            color: appColor,
            fontWeight: FontWeight.normal,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFinalInfoForm() {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 50.sp),
        Text(
          textAlign: TextAlign.center,
          "Votre compte a été vérifié. Veuillez cliquer sur suivant "
          "pour terminer votre inscription",
          style: TextStyle(
            color: appColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// IMAGE FULL SCREEN
        Positioned.fill(
          child: Image.asset(widget.data.images, fit: BoxFit.cover),
        ),

        /// OVERLAY
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
        Column(
          children: [
            Spacer(),

            Stack(
              children: [
                Container(
                  height: 200,
                  color: appColorBlack.withValues(alpha: .4),
                ),

                /// TEXTE SUR IMAGE
                Column(
                  children: [
                    Html(
                      data: widget.data.title,
                      style: {
                        "body": Style(
                          color: appColorSecond,
                          fontSize: FontSize(18.sp),
                          textAlign: TextAlign.start,
                        ),
                      },
                    ),

                    Gap(2.h),

                    /// CARD BLANCHE EN BAS
                    ClipPath(
                      clipper: NewClipper(),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6.w),
                        color: appColorFondLogin,

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// FORMULAIRE DYNAMIQUE SELON LE TYPE
                            _buildForm(widget.data.formType),

                            Gap(2.h),

                            SubmitButton(
                              AppConstants.btnNext,
                              onPressed: () async {
                                if (widget.data.formType ==
                                    FormType.emailPhone) {
                                  await _handleRegister();
                                } else if (widget.data.formType ==
                                    FormType.nameAddress) {
                                  await _verifyOtp();
                                } else {
                                  widget.onNext();
                                }
                              },
                            ),

                            Gap(2.h),

                            /// SOCIALS
                            if (widget.data.formType ==
                                FormType.emailPhone) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appColorWhite,
                                      borderRadius: BorderRadius.circular(3.w),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.facebook_outlined,
                                        size: 25.sp,
                                      ),
                                      color: Colors.blue[900],
                                      onPressed: () {},
                                    ),
                                  ),
                                  Gap(3.w),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appColorWhite,
                                      borderRadius: BorderRadius.circular(3.w),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.g_mobiledata_outlined,
                                        size: 25.sp,
                                      ),
                                      color: Colors.red,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              Gap(2.h),
                            ],

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                  color: appColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        Positioned(
          right: 0,
          top: 20,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
            child: Text(
              "Passer",
              style: TextStyle(
                color: appColorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _verifyOtp() async {
    if (otp == null || otp!.length != 4) {
      SnackbarHelper.showError(context, "OTP invalide");
      return;
    }

    setState(() => isLoading = true);

    final body = jsonEncode({"login": widget.registerLogin, "otp": otp});

    final response = await AuthApi.verifyOtp(body);

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    print(responseData);

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      widget.onNext(); // 👉 formulaire final
    } else {
      SnackbarHelper.showError(context, _parseMessage(responseData['message']));
    }
  }

  String _parseMessage(dynamic message) {
    if (message is List) {
      return message.join('\n');
    }
    return message.toString();
  }

  Future<void> _handleRegister() async {
    if (email.text.isEmpty && login.text.isEmpty) {
      SnackbarHelper.showError(
        context,
        "Veuillez saisir un email ou un téléphone",
      );
      return;
    }

    final loginValue = email.text.isNotEmpty ? email.text : phoneIndicator;

    setState(() => isLoading = true);

    final body = jsonEncode({
      "login": email.text.isNotEmpty ? email.text : phoneIndicator,
    });

    final response = await AuthApi.registerOne(body);

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      _startTimer();
      widget.onRegisterSuccess?.call(loginValue);
      widget.onNext(); // 👉 formulaire OTP
    } else {
      SnackbarHelper.showError(context, _parseMessage(responseData['message']));
    }
  }

  void _startTimer() {
    secondsLeft = 60;
    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => secondsLeft--);
      }
    });
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 18 : 6,
      decoration: BoxDecoration(
        color: isActive ? appColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class NewClipper extends CustomClipper<Path> {
  final double leftOffset;

  // On définit à quelle distance du haut la courbe commence sur la gauche
  NewClipper({this.leftOffset = 80.0});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // 1. Point de départ : On commence plus bas sur le bord gauche
    path.moveTo(0, leftOffset);

    // 2. La courbe : Elle monte doucement vers le coin supérieur droit
    path.cubicTo(
      size.width * 0.20,
      -25.0, // contrôle gauche
      size.width * 0.90,
      -8.0, // contrôle droite (adouci ici)
      size.width, // Point d'arrivée X (Bord droit)
      50.0, // Point d'arrivée Y (Tout en haut à droite)
    );

    // 3. On trace les lignes pour fermer la forme (droite, bas, gauche)
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
