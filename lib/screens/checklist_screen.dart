// checklist_page.dart
import 'package:flutter/material.dart';
import 'submission.dart ';

class ChecklistPage extends StatefulWidget {
  final String title;                  // e.g. "Beginning of the Day"
  final List<String> items;            // checklist questions

  const ChecklistPage({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  late List<bool> _checked;
  double get _progress => _checked.where((v) => v).length / _checked.length;

  @override
  void initState() {
    super.initState();
    _checked = List<bool>.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final percentText = '${(_progress * 100).round()}%';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E847D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context, false), // not completed
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const Icon(Icons.list_alt_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Checklist (${widget.items.length})',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 6,
                      backgroundColor: Colors.white.withOpacity(0.25),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF00B2A9)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(percentText, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
        itemCount: widget.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final idx = i + 1;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: ListTile(
              leading: _StepDot(number: idx, active: _checked[i]),
              title: Text(widget.items[i]),
              trailing: Checkbox(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                value: _checked[i],
                onChanged: (v) => setState(() => _checked[i] = v ?? false),
              ),
              onTap: () => setState(() => _checked[i] = !_checked[i]),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E847D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
           
// inside build() -> bottomNavigationBar button:
onPressed: _progress == 1.0
    ? () async {
        final submitted = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (_) => const SubmissionPage(),
          ),
        );
        if (submitted == true && mounted) {
          Navigator.pop(context, true); // bubble "completed" back to Checklist Time
        }
      }
    : null,                                 // disabled until all checked
          ),
        ),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final int number;
  final bool active;
  const _StepDot({required this.number, required this.active});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: active ? const Color(0xFF0E847D) : const Color(0xFFE1E9EE),
      child: Text('$number', style: TextStyle(color: active ? Colors.white : Colors.black54, fontWeight: FontWeight.w700)),
    );
  }
}
