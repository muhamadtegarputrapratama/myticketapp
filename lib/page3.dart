import 'package:flutter/material.dart';
import 'dialog_tunai.dart';
import 'dialog_kartu_kredit.dart';
import 'dialog_qris.dart';

class PembayaranPage extends StatelessWidget {
  final String title;
  final String type;
  final String price;

  const PembayaranPage({
    super.key,
    required this.title,
    required this.type,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pembayaran",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalTagihan(),

            const SizedBox(height: 30),

            const Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildPaymentMethod(
              icon: Icons.money_rounded,
              iconColor: Colors.green,
              title: "Tunai (Cash)",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogTunai(
                    price: price,
                    title: title,
                    type: type,
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _buildPaymentMethod(
              icon: Icons.credit_card_rounded,
              iconColor: Colors.purple,
              title: "Kartu Kredit",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogKartuKredit(
                    price: price,
                    title: title,
                    type: type,
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _buildPaymentMethod(
              icon: Icons.qr_code_2_rounded,
              iconColor: Colors.blue,
              title: "QRIS / QR Pay",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogQRIS(
                    price: price,
                    title: title,
                    type: type,
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            _buildHelpBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalTagihan() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.blue,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Tagihan",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Nama Pesanan                       $title - $type\n"
                  "Tanggal                                    22 Mei 2025",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 94, 92, 92),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.question_mark_outlined, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Hubungi Admin untuk bantuan pembayaran.",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 7),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
