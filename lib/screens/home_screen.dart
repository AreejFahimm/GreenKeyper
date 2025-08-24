import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'checklist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _teal = AppColors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.home, color: Colors.teal),
        ),
        title: const Text('Home', style: TextStyle(color: Colors.black87)),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Greeting card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _teal,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Hello Jane Cooper, 👋\nWelcome to Greenkeyper!',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 12),

          // Two small stat cards
          Row(
            children: [
              _statCard(
                color: const Color(0xFFE6F4F2),
                icon: Icons.local_shipping_outlined,
                title: 'Assigned\nVehicles',
                value: '03',
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6))],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36, height: 36,
                        child: CircularProgressIndicator(
                          value: 0.8, strokeWidth: 5, color: _teal, backgroundColor: Colors.teal.shade50,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Checklist\nStatus', style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 2),
                            Text('Checked', style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Vehicle fault status
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vehicle Fault Status', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _progressRow(label: 'Resolved', value: 0.85, trailing: '03', barColor: _teal),
                const SizedBox(height: 10),
                _progressRow(label: 'Pending', value: 0.2, trailing: '01', barColor: Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text('Select your checklist time', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),

          // Two checklist time cards
          Row(
            children: [
              _timeCard(
                context,
                title: 'Beginning of the Day',
                // Your original code had a typo: Icons.wb_twighlight → Icons.wb_twilight
                icon: Icons.wb_twilight,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistScreen())),
              ),
              const SizedBox(width: 12),
              _timeCard(
                context,
                title: 'End of the Day',
                icon: Icons.nights_stay_outlined,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _statCard({required Color color, required IconData icon, required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(Icons.local_shipping_outlined, color: Colors.teal)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _progressRow({required String label, required double value, required String trailing, required Color barColor}) {
    return Row(
      children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(value: value, minHeight: 6, color: barColor, backgroundColor: Colors.grey.shade200),
            ),
          ]),
        ),
        const SizedBox(width: 12),
        Text(trailing, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  static Widget _timeCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.teal),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('Checklist Questions\n30', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
