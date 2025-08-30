import 'package:flutter/material.dart';
// 👇 adjust this path to where you saved the page
import 'checklisttime_screen.dart';

const kTeal = Color(0xFF0E847D);
const kTealLight = Color(0xFFE8F4F3);
const kCardBorder = Color(0xFFE7E7E7);

class AssignedVehiclesPage extends StatefulWidget {
  const AssignedVehiclesPage({super.key});

  @override
  State<AssignedVehiclesPage> createState() => _AssignedVehiclesPageState();
}

class _AssignedVehiclesPageState extends State<AssignedVehiclesPage> {
  final TextEditingController _search = TextEditingController();

  final List<String> _all = const [
    'Nostalgia',
    'Ocean Whisper',
    'Silver Horizon',
    'Honda Civic (ABC 9832)',
    'Suzuki Cultus (BKX 2245)',
    'Suzuki Alto (MEP 4521)',
  ];

  late List<String> _filtered = List.from(_all);
  int? _selectedIndex = 1; // highlight “Ocean Whisper” like the screenshot

  void _runFilter(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? List.from(_all)
          : _all.where((v) => v.toLowerCase().contains(query)).toList();

      // keep selection meaningful when filtering
      if (_selectedIndex != null) {
        final selName = _all[_selectedIndex!];
        final newIdx = _filtered.indexWhere((name) => name == selName);
        _selectedIndex = newIdx == -1 ? null : newIdx;
      }
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = _all.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/images/vehicle_image.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Assigned Vehicles ($count)',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kCardBorder),
            ),
            child: TextField(
              controller: _search,
              onChanged: _runFilter,
              decoration: const InputDecoration(
                hintText: 'Search Vehicles',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // List
          ...List.generate(_filtered.length, (i) {
            final name = _filtered[i];
            final selected = _selectedIndex == i;
            return _VehicleRow(
              name: name,
              selected: selected,
              onTap: () {
                setState(() => _selectedIndex = i);
                // ✅ Navigate and pass the tapped vehicle
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChecklistTimePage(
                      assignedVehicle: name,
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _VehicleRow extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback? onTap;

  const _VehicleRow({
    required this.name,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: selected ? kTealLight : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kCardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kCardBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/vehicle_image.png',
              width: 28,
              height: 28,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black87),
        onTap: onTap,
      ),
    );
  }
}
