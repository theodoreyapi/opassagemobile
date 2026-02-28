import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:opassage/features/menu/pages/menu_page.dart';
import 'package:sizer/sizer.dart';

class PinUnlockPage extends StatefulWidget {
  final String storedPin;
  //final VoidCallback onSuccess;

  const PinUnlockPage({
    super.key,
    required this.storedPin,
   // required this.onSuccess,
  });

  @override
  State<PinUnlockPage> createState() => _PinUnlockPageState();
}

class _PinUnlockPageState extends State<PinUnlockPage>
    with SingleTickerProviderStateMixin {
  final List<int> _pin = [];

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _shakeAnimation = Tween(begin: -10.0, end: 10.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  void _goToHome() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MenuPage()),
    );
  }

  void _addDigit(int digit) {
    if (_pin.length < 4) {
      setState(() => _pin.add(digit));

      if (_pin.length == 4) {
        final enteredPin = _pin.join();
        if (enteredPin == widget.storedPin) {
          _goToHome();
        } else {
          _errorPin();
        }
      }
    }
  }

  void _errorPin() {
    HapticFeedback.vibrate();
    _shakeController.forward(from: 0);
    _pin.clear();
    setState(() {});
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8E2A8B),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(
              "Entrer votre code",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(4.h),

            AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (_, child) => Transform.translate(
                offset: Offset(_shakeAnimation.value, 0),
                child: child,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < _pin.length
                          ? Colors.yellow
                          : Colors.white54,
                    ),
                  );
                }),
              ),
            ),

            Gap(5.h),
            _buildKeyboard(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        for (var row in [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9],
        ])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map(_buildKey).toList(),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 70),
            _buildKey(0),
            IconButton(
              icon: const Icon(Icons.backspace, color: Colors.white),
              onPressed: _removeDigit,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(int number) {
    return GestureDetector(
      onTap: () => _addDigit(number),
      child: SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Text(
            "$number",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}