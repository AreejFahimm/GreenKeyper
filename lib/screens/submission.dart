import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

const _teal = Color(0xFF0E847D);
const _teal2 = Color(0xFF127C76);
const _cardBorder = Color(0xFFE6E6E6);
const _paleStrip = Color(0xFFF6F8FA);

class SubmissionPage extends StatefulWidget {
  const SubmissionPage({super.key});

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  final _note = TextEditingController();
  final _picker = ImagePicker();
  final List<XFile> _images = [];

  // Signature (package)
  late SignatureController _sigController;
  Key _sigWidgetKey = UniqueKey(); // force rebuild on clear
  bool get _hasSignature => _sigController.isNotEmpty;

  // lock ListView while signing
  bool _lockScroll = false;

  @override
  void initState() {
    super.initState();
    _sigController = SignatureController(
      penStrokeWidth: 2.6,
      penColor: Colors.black87,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _sigController.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final files = await _picker.pickMultiImage();
    if (files != null && files.isNotEmpty) {
      setState(() => _images.addAll(files));
    }
  }

  void _clearSignature() {
    _sigController.dispose(); // drop old state to avoid ghost flash
    _sigController = SignatureController(
      penStrokeWidth: 2.6,
      penColor: Colors.black87,
      exportBackgroundColor: Colors.white,
    );
    _sigWidgetKey = UniqueKey();
    setState(() {}); // rebuild Signature widget
  }

  void _submit() {
    if (!_hasSignature) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signature is required')),
      );
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context, false),
        ),
        titleSpacing: 0,
        title: Row(
          children: const [
            Icon(Icons.verified_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Submission',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        physics: _lockScroll
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        children: [
          _SectionHeader(
            icon: Icons.border_color_rounded,
            title: 'Add Signature',
            subtitle: '(Required)',
          ),
          const SizedBox(height: 8),
          _CardWrap(
            child: Column(
              children: [
                // Signature pad (package)
                SizedBox(
                  height: 150,
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: (_) => setState(() => _lockScroll = true),
                    onPointerUp:   (_) => setState(() => _lockScroll = false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _cardBorder),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Signature(
                          key: _sigWidgetKey,
                          controller: _sigController,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Add Signature here',
                        style: TextStyle(color: Colors.black45)),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: _clearSignature,
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          _SectionHeader(
            icon: Icons.description_outlined,
            title: 'Add Note',
            subtitle: '(Optional)',
          ),
          const SizedBox(height: 8),
          _CardWrap(
            child: TextField(
              controller: _note,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter Defect details here...',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 18),

          _SectionHeader(
            icon: Icons.image_rounded,
            title: 'Add Images',
            subtitle: '(Optional)',
          ),
          const SizedBox(height: 8),
          _CardWrap(
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  _UploadTile(onTap: _pickImages),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_images[i].path),
                            fit: BoxFit.cover,
                            width: 160,
                            height: 120,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Submit button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(color: Colors.white),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [_teal, _teal2],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
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
}

/* ------------ UI helpers ------------ */

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: _teal, size: 26),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        if (subtitle != null)
          Text(' $subtitle',
              style:
                  const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _CardWrap extends StatelessWidget {
  final Widget child;
  const _CardWrap({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _UploadTile extends StatelessWidget {
  final VoidCallback onTap;
  const _UploadTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _cardBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.cloud_upload_outlined, color: Colors.black45),
            SizedBox(height: 6),
            Text('Click to upload\nimage',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}




