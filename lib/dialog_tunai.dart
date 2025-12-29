import 'package:flutter/material.dart';
import 'bukti_pembayaran_page.dart';

class DialogTunai extends StatelessWidget {
  final String title;
  final String type;
  final String price;

  const DialogTunai({
    super.key,
    required this.title,
    required this.type,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pembayaran Tunai",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 22),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Image.asset("assets/images/cash.png", height: 120),

            const SizedBox(height: 14),

            const Text(
              "Pembayaran Tunai",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            const Text(
              "Jika pembayaran telah diterima, klik button konfirmasi pembayaran untuk menyelesaikan transaksi.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 22),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onPressed: () {
                Navigator.pop(context); //nutup dialog

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BuktiPembayaranPage(
                      title: title,
                      type: type,
                      price: price,
                    ),
                  ),
                );
              },

              child: const Text(
                "Konfirmasi Pembayaran",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
