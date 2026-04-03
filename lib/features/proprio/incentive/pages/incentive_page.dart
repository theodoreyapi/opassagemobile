import 'package:flutter/material.dart';

class IncentivePage extends StatefulWidget {
  const IncentivePage({super.key});

  @override
  State<IncentivePage> createState() => _IncentivePageState();
}

class _IncentivePageState extends State<IncentivePage> {
  final Color primaryPurple = const Color(0xFF5B0FA8);
  final Color accentYellow = const Color(0xFFFFC107);
  final Color lightBackground = const Color(0xFFEEDAF8);

  bool isPercent = true;

  Set<String> selectedCategories = {"Repos / Dayuse\n(1H/2H/3H)"};
  String selectedMode = "Basic";
  String selectedClient = "O’Passeur Classic";
  String selectedEspace = "Espace 1";
  String selectedPricing = "Prix Weekend";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 120,
              padding: const EdgeInsets.only(top: 40, left: 16),
              decoration: BoxDecoration(
                color: primaryPurple,
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: accentYellow, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.chevron_left, color: accentYellow, size: 22),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Incentives & Gestion client',
                    style: TextStyle(
                        color: accentYellow,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Configure tes avantages en définissant les règles ci-dessous"),

                  // ---------------- REDUCTION ----------------
                  _buildSectionTitle("Réduction"),
                  _buildCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _radio("Par taux (%)", true),
                            _radio("Par montant (FCFA)", false),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: _input("Taux", "%", enabled: isPercent)),
                            const SizedBox(width: 10),
                            Expanded(
                                child: _input("Montant", "FCFA",
                                    enabled: !isPercent)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ---------------- CATEGORIE ----------------
                  _buildSectionTitle("Catégorie concernée"),
                  _buildCard(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _chip("Repos / Dayuse\n(1H/2H/3H)"),
                        _chip("Court / Long séjour"),
                        _chip("Demie (1/2) Journée"),
                        _chip("Demie (1/2) Journée Atypique"),
                        _chip("Court / Long séjour Atypique"),
                        _chip("Tout sélectionner"),
                      ],
                    ),
                  ),

                  // ---------------- MODE ----------------
                  _buildSectionTitle("Mode de commande"),
                  _buildCard(
                    child: Row(
                      children: [
                        _singleChoice("Basic", selectedMode,
                                (v) => setState(() => selectedMode = v)),
                        _singleChoice("Express", selectedMode,
                                (v) => setState(() => selectedMode = v)),
                        _singleChoice("Couplet", selectedMode,
                                (v) => setState(() => selectedMode = v)),
                      ],
                    ),
                  ),

                  // ---------------- CLIENT ----------------
                  _buildSectionTitle("Typologie de client"),
                  _buildCard(
                    child: Row(
                      children: [
                        _singleChoice("O’Passeur Classic", selectedClient,
                                (v) => setState(() => selectedClient = v)),
                        _singleChoice("O’Passeur Prime", selectedClient,
                                (v) => setState(() => selectedClient = v)),
                        _singleChoice("Tous", selectedClient,
                                (v) => setState(() => selectedClient = v)),
                      ],
                    ),
                  ),

                  // ---------------- PERIODE ----------------
                  _buildSectionTitle("Périodicité"),
                  _buildCard(
                    child: Row(
                      children: [
                        Expanded(child: _date("Du")),
                        const SizedBox(width: 10),
                        Expanded(child: _date("Au")),
                      ],
                    ),
                  ),

                  // ---------------- ESPACE ----------------
                  _buildSectionTitle("Espace concerné"),
                  _buildCard(
                    child: Row(
                      children: [
                        _singleChoice("Espace 1", selectedEspace,
                                (v) => setState(() => selectedEspace = v)),
                        _singleChoice("Espace 2", selectedEspace,
                                (v) => setState(() => selectedEspace = v)),
                        _singleChoice("Tous", selectedEspace,
                                (v) => setState(() => selectedEspace = v)),
                      ],
                    ),
                  ),

                  // ---------------- PRICING ----------------
                  _buildSectionTitle("Pricing concerné"),
                  _buildCard(
                    child: Row(
                      children: [
                        _singleChoice("Prix Weekend", selectedPricing,
                                (v) => setState(() => selectedPricing = v)),
                        _singleChoice("Prix semaine", selectedPricing,
                                (v) => setState(() => selectedPricing = v)),
                        _singleChoice("Tous", selectedPricing,
                                (v) => setState(() => selectedPricing = v)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // BOUTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Valider",
                          style: TextStyle(
                              color: accentYellow,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= COMPONENTS =================

  Widget _radio(String label, bool value) {
    return GestureDetector(
      onTap: () => setState(() => isPercent = value),
      child: Row(
        children: [
          Icon(
            isPercent == value
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: primaryPurple,
          ),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: primaryPurple)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    final isSelected = selectedCategories.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (label == "Tout sélectionner") {
            selectedCategories = {
              "Repos / Dayuse\n(1H/2H/3H)",
              "Court / Long séjour",
              "Demie (1/2) Journée",
              "Demie (1/2) Journée Atypique",
              "Court / Long séjour Atypique",
            };
          } else {
            isSelected
                ? selectedCategories.remove(label)
                : selectedCategories.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryPurple : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryPurple.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: isSelected ? Colors.white : primaryPurple, fontSize: 12),
        ),
      ),
    );
  }

  Widget _singleChoice(
      String label, String selected, Function(String) onTap) {
    final isSelected = label == selected;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(label),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? primaryPurple : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryPurple.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected ? Colors.white : primaryPurple,
                    fontSize: 12)),
          ),
        ),
      ),
    );
  }

  Widget _input(String label, String unit, {bool enabled = true}) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        suffixText: unit,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _date(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lightBackground),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 16, color: primaryPurple),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title,
          style: TextStyle(
              color: primaryPurple,
              fontWeight: FontWeight.bold,
              fontSize: 16)),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: lightBackground.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}