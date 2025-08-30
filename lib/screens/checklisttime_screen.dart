// checklist_time_page.dart  (update)
import 'package:flutter/material.dart';
import 'checklist_screen.dart';

const _teal = Color(0xFF0E847D);
const _teal2 = Color(0xFF127C76);
const _paleStrip = Color(0xFFF1F7FB);
const _cardBorder = Color(0xFFE6E6E6);

class ChecklistTimePage extends StatefulWidget {
  final String assignedVehicle;
  const ChecklistTimePage({super.key, required this.assignedVehicle});

  @override
  State<ChecklistTimePage> createState() => _ChecklistTimePageState();
}

class _ChecklistTimePageState extends State<ChecklistTimePage> {
  bool _beginCompleted = false;
  bool _endCompleted = false;


Future<void> _openChecklist({required bool beginning}) async {
  final items = beginning ? _beginItems : _endItems;

  final completed = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (_) => ChecklistPage(
        title: beginning ? 'Beginning of the Day' : 'End of the Day',
        items: items,
      ),
    ),
  );

  if (!mounted) return;
  setState(() {
    if (beginning) {
      _beginCompleted = completed == true;
    } else {
      _endCompleted = completed == true;
    }
  });
}

  // sample data (8 like your screenshot)
  final List<String> _beginItems = const [
    'Place Dock/Deck Mats at Nostalgia.',
    'Switch the Shore Power Dock Station Breakers right to “off.”',
    'Remove Shore Power Cord & store properly on the Dock Station.',
    'Rotate all Three (3) Battery Selectors to “on” with (1,1,2).',
    'Store all Instrument/Stereo Covers on top shelf of the Cabin.',
    'Switch “Air/Cooler Pump”, “Cabin Air”, and “Helm Air” Breakers left to “off.”',
    'Rinse Nostalgia with fresh water.',
    'Switch “Air/Cooler Pump”, “Cabin Air”, and “Helm Air” Breakers left to “off.”',
  ];

  final List<String> _endItems = const [
    'Secure mooring lines.',
    'Turn off cabin electronics.',
    'Close hatches and windows.',
    'Remove trash.',
    'Check bilge pump.',
    'Lock storage.',
    'Power down shore supply.',
    'Final walk-around.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: const [
            Icon(Icons.access_time_rounded, color: _teal),
            SizedBox(width: 8),
            Text('Checklist Time',
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          // Assigned vehicle card (top)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _cardBorder),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: _cardBorder),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/vehicle_image.png', width: 36, height: 36, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(widget.assignedVehicle,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // strip
          Container(
            height: 38,
            decoration: BoxDecoration(color: _paleStrip, borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Row(
              children: const [
                Icon(Icons.fact_check_outlined, color: _teal),
                SizedBox(width: 8),
                Text('Select your checklist time', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // Beginning of the Day
_TimeCard(
  // Beginning of the Day
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [_teal, _teal2],
  ),
  title: 'Beginning of the Day',
  questionsCount: _beginItems.length,
  completed: _beginCompleted,
  onTap: () {
    debugPrint('begin tapped');       // quick sanity check in console
    _openChecklist(beginning: true);  // pushes ChecklistPage
  },
),

_TimeCard(
  // End of the Day
  background: Colors.white,
  borderColor: _cardBorder,
  title: 'End of the Day',
  questionsCount: _endItems.length,
  completed: _endCompleted,
  titleColor: Colors.black87,
  onTap: () {
    debugPrint('end tapped');
    _openChecklist(beginning: false);
  },
),

        ],
      ),
    );
  }
}

/* ---- UI piece for the two big cards ---- */
class _TimeCard extends StatelessWidget {
  final Gradient? gradient;
  final Color? background;
  final Color? borderColor;
  final String title;
  final int questionsCount;
  final bool completed;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _TimeCard({
    required this.title,
    required this.questionsCount,
    required this.completed,
    this.gradient,
    this.background,
    this.borderColor,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gradientCard = gradient != null;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 150,
        padding: const EdgeInsets.fromLTRB(18, 18, 12, 14),
        decoration: BoxDecoration(
          color: background,
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(gradientCard ? 0.12 : 0.06), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: titleColor ?? (gradientCard ? Colors.white : Colors.black87),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    )),
                const SizedBox(height: 6),
                Text('Checklist Questions  $questionsCount',
                    style: TextStyle(color: gradientCard ? Colors.white70 : Colors.black54)),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  if (completed)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: gradientCard ? Colors.white.withOpacity(0.2) : const Color(0xFFF1F7FB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Completed',
                          style: TextStyle(color: gradientCard ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
                    ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: gradientCard ? Colors.white.withOpacity(0.2) : const Color(0xFFF1F7FB),
                    child: Icon(Icons.arrow_forward, color: gradientCard ? Colors.white : Colors.black87, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
