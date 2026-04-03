import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:opassage/features/proprio/transaction/transaction.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_color.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final Color primaryPurple = const Color(0xFF5B0FA8);
  final Color accentYellow = const Color(0xFFFFC107);
  final Color lightBackground = const Color(0xFFF5F5F5);

  final List<Map<String, dynamic>> transactions = [
    {
      "title": "Confirmation de Reservation",
      "subtitle": "Code promo WELCOME10",
      "amount": "+ 50 000 FCFA",
      "date": "11/11/2026 à 09h00",
      "type": "plus",
    },
    {
      "title": "Confirmation de Reservation",
      "subtitle": "Wave",
      "amount": "+ 25 000 FCFA",
      "date": "11/11/2026 à 09h00",
      "type": "plus",
    },
    {
      "title": "Reversement O’Passage",
      "subtitle": "Orange",
      "amount": "- 50 000 FCFA",
      "date": "11/11/2026 à 09h00",
      "type": "minus",
    },
    {
      "title": "Reversement O’Passage",
      "subtitle": "Wave",
      "amount": "- 10 000 FCFA",
      "date": "11/11/2026 à 09h00",
      "type": "minus",
    },
    {
      "title": "Annulation de reservation",
      "subtitle": "Reversement suite à annulation",
      "amount": "- 50 000 FCFA",
      "date": "11/11/2026 à 09h00",
      "type": "cancel",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: Column(
        children: [
          // HEADER
          Container(
            height: 120,
            padding: const EdgeInsets.only(top: 40, left: 16),
            decoration: BoxDecoration(
              color: primaryPurple,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
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
                    child: Icon(
                      Icons.chevron_left,
                      color: accentYellow,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Mes transactions',
                  style: TextStyle(
                    color: accentYellow,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // SEARCH + FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Recherche",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // LIST
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: ListView.separated(
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade200),
                  itemBuilder: (context, index) {
                    final item = transactions[index];
                    return _buildItem(item);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item) {
    Color color;
    IconData icon;

    switch (item['type']) {
      case 'plus':
        color = Colors.purple;
        icon = Icons.star;
        break;
      case 'minus':
        color = Colors.orange;
        icon = Icons.rotate_left;
        break;
      case 'cancel':
        color = Colors.red;
        icon = Icons.close;
        break;
      default:
        color = Colors.grey;
        icon = Icons.circle;
    }

    return ListTile(
      onTap: () {
        showBarModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          expand: true,
          topControl: Align(
            alignment: Alignment.centerLeft,
            child: FloatingActionButton.small(
              heroTag: "Condition",
              backgroundColor: appColorWhite,
              shape: const CircleBorder(),
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, color: appColorBlack),
            ),
          ),
          context: context,
          builder: (context) => DetailTransactionPage(),
        );
      },
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        item['title'],
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(item['subtitle'], style: const TextStyle(fontSize: 11)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item['amount'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: item['type'] == 'plus'
                  ? Colors.green
                  : item['type'] == 'cancel'
                  ? Colors.red
                  : Colors.black,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item['date'],
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
