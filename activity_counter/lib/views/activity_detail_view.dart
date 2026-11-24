import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final String activityId;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  void _showSnackBar(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? const Color(0xFFDB2777),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Text(message),
        duration: const Duration(milliseconds: 1100),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF8FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Reset Counter?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF831843),
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin mengembalikan nilai counter menjadi 0?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      viewModel.resetCounter(activityId);
      if (context.mounted) {
        _showSnackBar(context, 'Counter berhasil di-reset ke 0');
      }
    }
  }

  Future<void> _confirmDelete(BuildContext context, String activityName) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF8FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Hapus Aktivitas?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFBE123C),
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus "$activityName" dari daftar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      viewModel.deleteActivity(activityId);
      if (context.mounted) {
        _showSnackBar(
          context,
          'Aktivitas "$activityName" berhasil dihapus',
          color: const Color(0xFFE11D48),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final activity = viewModel.getActivityById(activityId);

        if (activity == null) {
          return const Scaffold(
            body: Center(child: Text('Aktivitas tidak ditemukan')),
          );
        }

        final ringProgress = (activity.counter % 10) / 10.0;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Detail Aktivitas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                tooltip: 'Edit Nama',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivityFormView(
                        viewModel: viewModel,
                        activity: activity,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color(0xFFBE123C),
                ),
                tooltip: 'Hapus Aktivitas',
                onPressed: () => _confirmDelete(context, activity.name),
              ),
              const SizedBox(width: 6),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 36,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: const Color(0xFFFCE7F3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF472B6)
                              .withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE7F3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'TARGET AKTIVITAS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color(0xFFDB2777),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          activity.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF831843),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Ring Progress & Lingkaran Pastel
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: CircularProgressIndicator(
                                  value: activity.counter == 0
                                      ? 0
                                      : (ringProgress == 0
                                            ? 1.0
                                            : ringProgress),
                                  strokeWidth: 12,
                                  backgroundColor: const Color(0xFFFCE7F3),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color(0xFFEC4899),
                                      ),
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              Container(
                                width: 156,
                                height: 156,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFBCFE8), // Soft Pink
                                      Color(0xFFE9D5FF), // Lavender Pastel
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 220),
                                  transitionBuilder: (child, anim) =>
                                      ScaleTransition(
                                        scale: anim,
                                        child: child,
                                      ),
                                  child: Text(
                                    '${activity.counter}',
                                    key: ValueKey<int>(activity.counter),
                                    style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF831843),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Tombol Kontrol Pastel (-), Reset, (+)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Tombol Kurang (-) - Soft Lavender
                            _buildPastelAction(
                              icon: Icons.remove_rounded,
                              bgColor: const Color(0xFFF3E8FF),
                              iconColor: const Color(0xFF9333EA),
                              size: 64,
                              onTap: activity.counter > 0
                                  ? () {
                                      HapticFeedback.lightImpact();
                                      final ok = viewModel.decrementCounter(
                                        activity.id,
                                      );
                                      if (ok) {
                                        _showSnackBar(
                                          context,
                                          'Counter berkurang: ${activity.counter}',
                                        );
                                      }
                                    }
                                  : null,
                            ),

                            // Tombol Reset - Soft Peach
                            _buildPastelAction(
                              icon: Icons.refresh_rounded,
                              bgColor: const Color(0xFFFFEDD5),
                              iconColor: const Color(0xFFEA580C),
                              size: 54,
                              onTap: activity.counter > 0
                                  ? () => _confirmReset(context)
                                  : null,
                            ),

                            // Tombol Tambah (+) - Rose Pink
                            _buildPastelAction(
                              icon: Icons.add_rounded,
                              bgColor: const Color(0xFFEC4899),
                              iconColor: Colors.white,
                              size: 72,
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                viewModel.incrementCounter(activity.id);
                                _showSnackBar(
                                  context,
                                  'Counter bertambah: ${activity.counter}',
                                  color: const Color(0xFFDB2777),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPastelAction({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required double size,
    required VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;
    return Opacity(
      opacity: isDisabled ? 0.45 : 1.0,
      child: Material(
        color: bgColor,
        shape: const CircleBorder(),
        elevation: isDisabled ? 0 : 3,
        shadowColor: bgColor.withValues(alpha: 0.5),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(icon, color: iconColor, size: size * 0.45),
          ),
        ),
      ),
    );
  }
}
