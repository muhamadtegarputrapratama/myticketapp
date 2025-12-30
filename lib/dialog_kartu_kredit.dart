import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bukti_pembayaran_page.dart';

class DialogKartuKredit extends StatefulWidget {
  final String title;
  final String type;
  final String price;

  const DialogKartuKredit({
    super.key,
    required this.title,
    required this.type,
    required this.price,
  });

  @override
  State<DialogKartuKredit> createState() => _DialogKartuKreditState();
}

class _DialogKartuKreditState extends State<DialogKartuKredit> {
  bool isLoading = false;
  bool isCopied = false;

  final String nomorKartu = "8810 7766 1234 9876";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pembayaran Kartu Kredit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: isLoading ? null : () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 22),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Image.asset(
              "assets/images/card.png",
              height: 120,
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      nomorKartu,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: _handleCopy,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isCopied ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCopied ? Icons.check : Icons.copy,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isCopied ? "Tersalin" : "Salin",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "Transfer Pembayaran",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            const Text(
              "Pastikan nominal dan tujuan pembayaran sudah benar sebelum melanjutkan.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 22),

          
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isLoading ? null : _handleConfirmPayment,
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Konfirmasi Pembayaran",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCopy() {
    Clipboard.setData(ClipboardData(text: nomorKartu));

    setState(() {
      isCopied = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        isCopied = false;
      });
    });
  }

  void _handleConfirmPayment() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuktiPembayaranPage(
          title: widget.title,
          type: widget.type,
          price: widget.price,
        ),
      ),
    );
  }
}
