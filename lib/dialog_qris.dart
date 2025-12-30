import 'dart:async';
import 'package:flutter/material.dart';
import 'bukti_pembayaran_page.dart';

class DialogQRIS extends StatefulWidget {
  final String title;
  final String type;
  final String price;

  const DialogQRIS({
    super.key,
    required this.title,
    required this.type,
    required this.price,
  });

  @override
  State<DialogQRIS> createState() => _DialogQRISState();
}

class _DialogQRISState extends State<DialogQRIS> {
  static const int maxSeconds = 30;
  int secondsLeft = maxSeconds;
  Timer? timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpired = secondsLeft == 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),

              Image.asset("assets/images/QR.png", height: 160),

              const SizedBox(height: 14),

              const Text(
                "Scan QR untuk Membayar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              const Text(
                "Gunakan e-wallet atau mobile banking untuk scan QR di atas.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isExpired ? Colors.red.shade50 : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isExpired
                      ? "Waktu pembayaran habis"
                      : "Waktu tersisa $secondsLeft detik",
                  style: TextStyle(
                    color: isExpired ? Colors.red : Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              _buildButton(isExpired),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Pembayaran QRIS",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: isLoading ? null : () => Navigator.pop(context),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildButton(bool isExpired) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: (isExpired || isLoading) ? null : _handleConfirm,
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
    );
  }

  Future<void> _handleConfirm() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    timer?.cancel();
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
