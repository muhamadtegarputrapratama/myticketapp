import 'package:flutter/material.dart';
import 'bukti_pembayaran_page.dart';

class DialogTunai extends StatefulWidget {
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
  State<DialogTunai> createState() => _DialogTunaiState();
}

class _DialogTunaiState extends State<DialogTunai> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _header("Pembayaran Tunai"),
              const SizedBox(height: 20),

              Image.asset(
                "assets/images/cash.png",
                height: 120,
              ),

              const SizedBox(height: 16),

              _infoBox(),

              const SizedBox(height: 22),

              _button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: isLoading ? null : () => Navigator.pop(context),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _infoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Jika pembayaran tunai telah diterima oleh petugas, silakan klik tombol konfirmasi pembayaran untuk menyelesaikan transaksi.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _button() {
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
        onPressed: isLoading ? null : _confirm,
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

  Future<void> _confirm() async {
    setState(() => isLoading = true);

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
