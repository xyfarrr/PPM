import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  final ActivityViewModel viewModel;
  final ActivityModel? activity;

  const ActivityFormView({super.key, required this.viewModel, this.activity});

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  late final TextEditingController _nameController;
  String? _errorText;

  bool get isEditMode => widget.activity != null;

  final List<String> _suggestions = [
    'Minum Air 8 Gelas',
    'Skincare Pagi & Malam',
    'Baca Buku 1 Bab',
    'Olahraga Ringan',
    'Mengerjakan Tugas',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: isEditMode ? widget.activity!.name : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveActivity() {
    final inputName = _nameController.text.trim();

    if (inputName.isEmpty) {
      setState(() {
        _errorText = 'Nama aktivitas tidak boleh kosong';
      });
      return;
    }

    if (isEditMode) {
      widget.viewModel.updateActivityName(widget.activity!.id, inputName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFDB2777),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: const Text('Nama aktivitas berhasil diperbarui'),
        ),
      );
    } else {
      widget.viewModel.addActivity(inputName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFEC4899),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: const Text('Aktivitas baru berhasil ditambahkan'),
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit Aktivitas' : 'Aktivitas Baru',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFFCE7F3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF472B6).withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCE7F3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isEditMode
                          ? Icons.edit_rounded
                          : Icons.favorite_border_rounded,
                      color: const Color(0xFFDB2777),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditMode
                              ? 'Ubah Nama Aktivitas'
                              : 'Buat Aktivitas Baru',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF831843),
                          ),
                        ),
                        Text(
                          'Tulis kebiasaan positif yang ingin dicatat',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.pink.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Nama Aktivitas',
                  hintText: 'Ketik nama aktivitas...',
                  filled: true,
                  fillColor: const Color(0xFFFFF5F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFFBCFE8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFFBCFE8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFFEC4899),
                      width: 2,
                    ),
                  ),
                  errorText: _errorText,
                ),
                onChanged: (_) {
                  if (_errorText != null) {
                    setState(() => _errorText = null);
                  }
                },
              ),
              if (!isEditMode) ...[
                const SizedBox(height: 18),
                Text(
                  'Rekomendasi Aktivitas:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.pink.shade400,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _suggestions.map((item) {
                    return ActionChip(
                      label: Text(
                        item,
                        style: const TextStyle(
                          color: Color(0xFF9D174D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: const Color(0xFFFCE7F3),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      onPressed: () {
                        setState(() {
                          _nameController.text = item;
                          _errorText = null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC4899),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Simpan Aktivitas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
