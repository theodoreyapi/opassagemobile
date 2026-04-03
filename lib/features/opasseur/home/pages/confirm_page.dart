import 'package:flutter/material.dart';
import 'package:opassage/core/widgets/widgets.dart';

class ReservationConfirmedScreen extends StatelessWidget {
  ReservationConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// ICÔNE DE SUCCÈS
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              /// TITRE
              const Text(
                'Réservation Validée',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              /// SOUS-TITRE
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'Votre réservation à bien été prise en compte,\n',
                    ),
                    TextSpan(text: 'Merci de surveiller '),
                    TextSpan(
                      text: '"Réservations"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// BOUTON VOIR MES COMMANDES
              SizedBox(
                width: double.infinity,
                child: SubmitButton(
                  "Voir mes commandes",
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// BOUTON RETOUR
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text(
                  'Retour à l\'accueil',
                  style: TextStyle(
                    color: Color(0xFF9C27B0),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
