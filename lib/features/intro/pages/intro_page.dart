import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/auth/auth.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int _pageIndex = 0;
  late int _nbreSlides;

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
                  MaterialPageRoute(builder: (context) => ChoiseRegisterPage()),
                );
              }
            },
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

  OnboardSlide({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.total,
    required this.onNext,
  });

  @override
  State<OnboardSlide> createState() => _OnboardSlideState();
}

class _OnboardSlideState extends State<OnboardSlide> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  String? otp;

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
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();
  var lastName = TextEditingController();
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
      mainAxisAlignment: .center,
      children: [
        InputText(
          hintText: "votre@email.com",
          keyboardType: TextInputType.emailAddress,
          controller: email,
          prefixIcon: Icon(Icons.email_outlined),
        ),
        Gap(1.h),
        Text("OU"),
        Gap(1.h),
        Container(
          padding: EdgeInsets.only(left: 4.w),
          decoration: BoxDecoration(
            color: appColorInputFond,
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(
              color: _isFocused ? appColor : appColorBorder,
              width: 2,
            ),
          ),
          child: InternationalPhoneNumberInput(
            focusNode: _focusNode,
            onInputChanged: (PhoneNumber number) {
              phoneIndicator = number.phoneNumber!;
            },
            onInputValidated: (bool value) {},
            hintText: "Téléphone",
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            countries: ['CI'],
            initialValue: number,
            textFieldController: login,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            onSaved: (PhoneNumber number) {},
          ),
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
        border: Border.all(color: appColorBorder, width: 2),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appColorBorder, width: 2),
      borderRadius: BorderRadius.circular(3.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(color: appColorWhite),
    );

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Text(
          "Veuillez saisir le code de vérification à 4 "
          "chiffres reçu sur l’email fournis.",
          style: TextStyle(
            color: appColorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
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
                onPressed: () {},
                couleur: appColor,
                textcouleur: appColorWhite,
              ),
            ),
          ],
        ),
        Gap(1.h),
        Text(
          "Vous pouvez demander un nouveau code une fois "
          "le compte à rebours terminé. \n\n114 secondes restantes",
          style: TextStyle(
            color: appColorBlack,
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
      children: [
        InputText(
          hintText: "votre@email.com",
          keyboardType: TextInputType.emailAddress,
          controller: email,
          prefixIcon: Icon(Icons.email_outlined),
        ),
        Gap(1.h),
        Text("OU"),
        Gap(1.h),
        Container(
          padding: EdgeInsets.only(left: 4.w),
          decoration: BoxDecoration(
            color: appColorInputFond,
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(
              color: _isFocused ? appColor : appColorBorder,
              width: 2,
            ),
          ),
          child: InternationalPhoneNumberInput(
            focusNode: _focusNode,
            onInputChanged: (PhoneNumber number) {
              phoneIndicator = number.phoneNumber!;
            },
            onInputValidated: (bool value) {},
            hintText: "Téléphone",
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            countries: ['CI'],
            initialValue: number,
            textFieldController: login,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            onSaved: (PhoneNumber number) {},
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
                          color: Colors.white,
                          fontSize: FontSize(18.sp),
                          textAlign: TextAlign.center,
                        ),
                      },
                    ),

                    Gap(2.h),

                    /// CARD BLANCHE EN BAS
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Connectez-vous ou inscrivez-vous pour continuer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: appColorBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Gap(2.h),

                          /// FORMULAIRE DYNAMIQUE SELON LE TYPE
                          _buildForm(widget.data.formType),

                          Gap(2.h),

                          SubmitButton(
                            AppConstants.btnNext,
                            onPressed: widget.onNext,
                          ),

                          Gap(2.h),

                          /// SOCIALS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  icon: Icon(Icons.facebook),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                              Gap(3.w),
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.red,
                                child: IconButton(
                                  icon: Icon(Icons.g_mobiledata),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),

                          Gap(2.h),

                          /// INDICATEURS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.total,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: DotIndicator(
                                  isActive: index == widget.pageIndex,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
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
