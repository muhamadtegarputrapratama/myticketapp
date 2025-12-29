import 'package:flutter/material.dart';
import 'page3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.light(),
      home: PembelianPage(),
    );
  }
}

class PembelianPage extends StatelessWidget {
  PembelianPage({super.key});
  final List<Map<String, String>> tiketList = [
    {"title": "Tiket untuk Dewasa", "type": "Reguler", "price": "300.000"},
    {"title": "Tiket untuk Dewasa", "type": "VIP", "price": "450.000"},
    {"title": "Tiket untuk Anak", "type": "Reguler", "price": "150.000"},
    {"title": "Tiket untuk Anak", "type": "VIP", "price": "250.000"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 360,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Ticketing App",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1230),
                    ),
                  ),
                ),

                Expanded( //mengisi ruang kosong yang tersedia  
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: tiketList.length, //berapa kali item builder di loop/tampilkan
                    itemBuilder: (context, index) { //item yang ditampilkan
                      final tiket = tiketList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tiket["title"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0B1230),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  tiket["type"]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  tiket["price"]!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E63F2),
                                  ),
                                ),
                              ],
                            ),

                            // Tombol Beli
                            GestureDetector(
                              onTap: () {
                                Navigator.push( //ke halaman baru
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PembayaranPage(
                                      title: tiket["title"]!,
                                      type: tiket["type"]!,
                                      price: tiket["price"]!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E63F2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.shopping_cart_outlined,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      "Beli",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
