import 'package:flutter/material.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/home/home.dart';
import 'package:opassage/models/rooms_model.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationStep1Screen extends StatefulWidget {
  RoomsModel? room;

  ReservationStep1Screen({super.key, this.room});

  @override
  State<ReservationStep1Screen> createState() => _ReservationStep1ScreenState();
}

class _ReservationStep1ScreenState extends State<ReservationStep1Screen> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Réservation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                _buildStepIndicator(1, true),
                Container(
                  width: 30,
                  height: 2,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                ),
                _buildStepIndicator(2, false),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITRE
                  const Text(
                    'Choisir une date',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  /// CALENDRIER
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: _focusedDay,
                      rangeStartDay: _startDate,
                      rangeEndDay: _endDate,
                      calendarFormat: CalendarFormat.month,
                      rangeSelectionMode: RangeSelectionMode.enforced,
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _startDate = start;
                          _endDate = end;
                          _focusedDay = focusedDay;
                        });
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        rangeStartDecoration: const BoxDecoration(
                          color: Color(0xFF9C27B0),
                          shape: BoxShape.circle,
                        ),
                        rangeEndDecoration: const BoxDecoration(
                          color: Color(0xFF9C27B0),
                          shape: BoxShape.circle,
                        ),
                        rangeHighlightColor: Color(0xFF9C27B0),
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFF9C27B0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// DATE SÉLECTIONNÉE
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: appColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF9C27B0),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _dateLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
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

          /// BOUTON SUIVANT
          Padding(
            padding: EdgeInsets.all(4.w),
            child: SubmitButton(
              "Suivant",
              onPressed: () {

                if (_endDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Veuillez sélectionner une date de départ',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReservationStep2Screen(
                      room: widget.room,
                      startDate: _startDate,
                      endDate:
                          _endDate ?? _startDate!.add(const Duration(days: 1)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String get _dateLabel {
    if (_startDate == null) return 'Aucune date sélectionnée';

    if (_endDate == null || isSameDay(_startDate!, _endDate!)) {
      return 'Séjour le ${_formatDate(_startDate!)}';
    }

    return 'Du ${_formatDate(_startDate!)} au ${_formatDate(_endDate!)}';
  }

  String _formatDate(DateTime date) {
    final months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Widget _buildStepIndicator(int step, bool isActive) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF9C27B0) : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
