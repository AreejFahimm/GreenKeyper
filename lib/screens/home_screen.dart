import 'package:flutter/material.dart';
import 'assigned_vehicles_screen.dart';
import 'checklisttime_screen.dart';
void main() => runApp(const GreenkeyperApp());

class GreenkeyperApp extends StatelessWidget {
  const GreenkeyperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greenkeyper',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF6F7F7),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color kTeal = Color(0xFF127C76);
  static const Color kTealDark = Color(0xFF0E847D);
  static const Color kTealDeep = Color(0xFF0B8A83);
  static const Color kAmber = Color(0xFFF0AE3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: AppBar(
        backgroundColor: kTeal,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: const [
            SizedBox(width: 12),
            Icon(Icons.home_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Home',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          // bell with tiny dot
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                tooltip: 'Notifications',
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withOpacity(.25),
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/images/vehicle_image.png'),
              ),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          // HERO CARD (big teal gradient with subtle shapes)
          
          _HeroCard(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0E847D), Color(0xFF127C76)],
            ),
            child: const Text(
              'Hello Jane Cooper, 👋\nWelcome to Greenkeyper!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w700,
                height: 1.80,
              ),
            ),
          ),
          const SizedBox(height: 22),

          // ROW: Assigned Vehicles + Checklist Status
          // ROW: Assigned Vehicles + Checklist Status
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Assigned Vehicles (with navigation)
    Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AssignedVehiclesPage(),
            ),
          );
        },
        child: _AssignedVehiclesCard(
          count: '03',
          extra: '+01',
        ),
      ),
    ),
    const SizedBox(width: 10),

              // Checklist Status
              Expanded(
                child: _ChecklistStatusCard(
                  statusLabel: 'Checked',
                  segments: const [
                    _DonutSeg(0.62, kTealDeep), // Beginning of day
                    _DonutSeg(0.38, kAmber),    // End of day
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Vehicle Fault Status (below)
          _ElevatedCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle Fault Status',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 14),
                _progressRow('Resolved', 1.0, kTeal, '03'),
                const SizedBox(height: 12),
                _progressRow('Pending', 0.3, kAmber, '01'),
              ],
            ),
          ),
          const SizedBox(height: 24),


          // LARGE GRADIENT BUTTON
          SizedBox(
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kTealDark, kTeal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: Color(0x22000000), blurRadius: 10, offset: Offset(0, 6)),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AssignedVehiclesPage(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Proceed to checklist',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bars row (exact rounded mini bar, value on right)
  static Widget _progressRow(String label, double value, Color color, String trailing) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: const Color(0xFFEFEFEF),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(trailing, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

// ---------- Cards & Widgets (styled to match screenshot) ----------

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.child, required this.gradient});
  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      clip: true,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      background: gradient,
      child: Stack(
        children: [
          // subtle geometric accents
          Positioned(
            right: -10,
            top: -8,
            child: Opacity(
              opacity: .10,
              child: Icon(Icons.crop_square_rounded, size: 110, color: Colors.white),
            ),
          ),
          Positioned(
            left: -6,
            bottom: -14,
            child: Opacity(
              opacity: .10,
              child: Icon(Icons.change_history_rounded, size: 130, color: Colors.white),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _ElevatedCard extends StatelessWidget {
  const _ElevatedCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.background,
    this.clip = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final Gradient? background;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background == null ? Colors.white : null,
        gradient: background,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: child,
    );

    if (clip) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: content,
      );
    }
    return content;
  }
}

class _AssignedVehiclesCard extends StatelessWidget {
  const _AssignedVehiclesCard({required this.count, required this.extra});
  final String count;
  final String extra;

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF7F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.directions_car_filled_rounded, color: Colors.teal),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Assigned Vehicles', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF0AE3E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const _AvatarStack(),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  extra,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          _MiniAvatar(offset: 0, image: AssetImage('assets/images/vehicle_image.png')),
          _MiniAvatar(offset: 18, image: AssetImage('assets/images/vehicle_image.png')),
          _MiniAvatar(offset: 36, image: AssetImage('assets/images/vehicle_image.png')),
        ],
      ),
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar({required this.offset, required this.image});
  final double offset;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.white,
        child: CircleAvatar(radius: 11, backgroundImage: image),
      ),
    );
  }
}

class _ChecklistStatusCard extends StatelessWidget {
  const _ChecklistStatusCard({required this.statusLabel, required this.segments});
  final String statusLabel;
  final List<_DonutSeg> segments;

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFFEFF7F6),
                child: Icon(Icons.check, color: Colors.teal, size: 18),
              ),
              const SizedBox(width:1),
              const Expanded(
                child: Text('Checklist Status', style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel,
                  style: const TextStyle(
                    color: Color(0xFF0B8A83),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: 116,
              height: 116,
              child: CustomPaint(painter: _DonutPainter(segments: segments)),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: const [
              _Legend(color: Color(0xFF0B8A83), label: 'Beginning of the day'),
              SizedBox(height: 6),
              _Legend(color: Color(0xFFF0AE3E), label: 'End of the day'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        const SizedBox(width: 4),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54))),
      ],
    );
  }
}

class _DonutSeg {
  final double fraction; // 0..1
  final Color color;
  const _DonutSeg(this.fraction, this.color);
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.segments});
  final List<_DonutSeg> segments;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = size.shortestSide * 0.18; // matches thickness in mock
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    // start from top (12 o’clock)
    double startDeg = -90.0;
    for (final s in segments) {
      final sweepDeg = 360 * s.fraction;
      paint.color = s.color;
      canvas.drawArc(rect.deflate(stroke / 2), _deg2rad(startDeg), _deg2rad(sweepDeg), false, paint);
      startDeg += sweepDeg;
    }
  }

  double _deg2rad(double d) => d * 3.1415926535897932 / 180.0;

  @override
  bool shouldRepaint(covariant _DonutPainter old) {
    if (old.segments.length != segments.length) return true;
    for (int i = 0; i < segments.length; i++) {
      if (old.segments[i].fraction != segments[i].fraction ||
          old.segments[i].color != segments[i].color) return true;
    }
    return false;
  }
}
