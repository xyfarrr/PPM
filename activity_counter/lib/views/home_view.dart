import 'package:flutter/material.dart';

import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';
import 'activity_detail_view.dart';

class HomeView extends StatelessWidget {
  final ActivityViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  IconData _getActivityIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('buku') || lower.contains('baca')) {
      return Icons.menu_book_rounded;
    } else if (lower.contains('olahraga') ||
        lower.contains('push') ||
        lower.contains('gym') ||
        lower.contains('lari')) {
      return Icons.fitness_center_rounded;
    } else if (lower.contains('tugas') ||
        lower.contains('belajar') ||
        lower.contains('koding')) {
      return Icons.laptop_mac_rounded;
    } else if (lower.contains('air') || lower.contains('minum')) {
      return Icons.water_drop_rounded;
    } else if (lower.contains('ibadah') ||
        lower.contains('sholat') ||
        lower.contains('quran')) {
      return Icons.auto_awesome_rounded;
    }
    return Icons.favorite_rounded;
  }

  // Palet warna pastel lembut (background & warna ikon/teks)
  Map<String, Color> _getPastelPalette(int index) {
    const palettes = [
      {
        'bg': Color(0xFFFCE7F3), // Soft Pink
        'accent': Color(0xFFDB2777),
      },
      {
        'bg': Color(0xFFF3E8FF), // Soft Lavender
        'accent': Color(0xFF9333EA),
      },
      {
        'bg': Color(0xFFFFEDD5), // Soft Peach
        'accent': Color(0xFFEA580C),
      },
      {
        'bg': Color(0xFFD1FAE5), // Soft Mint
        'accent': Color(0xFF059669),
      },
      {
        'bg': Color(0xFFE0F2FE), // Baby Blue Pastel
        'accent': Color(0xFF0284C7),
      },
    ];
    return palettes[index % palettes.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final activities = viewModel.activities;
          final totalCounts = activities.fold<int>(
            0,
            (sum, item) => sum + item.counter,
          );

          return CustomScrollView(
            slivers: [
              // Header Gradasi Pink Pastel
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    MediaQuery.of(context).padding.top + 16,
                    20,
                    28,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFBCFE8), // Pink Sakura
                        Color(0xFFF9A8D4), // Rose Pastel
                        Color(0xFFFED7AA), // Sentuhan Peach Pastel
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PASTEL ACTIVITY TRACKER',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.4,
                                  color: Color(0xFF9D174D),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Activity Counter',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF831843),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.favorite_rounded,
                              color: Color(0xFFEC4899),
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // Kartu Statistik Pastel
                      Row(
                        children: [
                          Expanded(
                            child: _buildPastelStat(
                              title: 'Total Aktivitas',
                              value: '${activities.length}',
                              subtitle: 'Target tersimpan',
                              icon: Icons.auto_awesome_mosaic_rounded,
                              iconColor: const Color(0xFFDB2777),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildPastelStat(
                              title: 'Total Hitungan',
                              value: '$totalCounts',
                              subtitle: 'Selesai dilakukan',
                              icon: Icons.stars_rounded,
                              iconColor: const Color(0xFF9333EA),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Judul Bagian
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Aktivitas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF831843),
                        ),
                      ),
                      Text(
                        'Ketuk untuk menghitung',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.pink.shade300,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Daftar Aktivitas
              if (activities.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(22),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCE7F3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.spa_rounded,
                              size: 54,
                              color: Color(0xFFEC4899),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Belum Ada Aktivitas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF831843),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tekan tombol + di bawah untuk mulai menambahkan aktivitas favoritmu',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.pink.shade300),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final activity = activities[index];
                      final palette = _getPastelPalette(index);
                      final bgColor = palette['bg']!;
                      final accentColor = palette['accent']!;
                      final progress = (activity.counter % 10) / 10.0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFFCE7F3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF472B6)
                                  .withValues(alpha: 0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ActivityDetailView(
                                    viewModel: viewModel,
                                    activityId: activity.id,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Ikon Pastel
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: bgColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Icon(
                                          _getActivityIcon(activity.name),
                                          color: accentColor,
                                          size: 26,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      // Nama & Counter
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              activity.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4A0E2E),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                '${activity.counter} kali selesai',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: accentColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Tombol Edit Pastel
                                      IconButton(
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
                                        icon: const Icon(
                                          Icons.edit_rounded,
                                          size: 20,
                                          color: Color(0xFFDB2777),
                                        ),
                                        style: IconButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFFFCE7F3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // Progress Bar Pastel
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: activity.counter == 0
                                          ? 0.05
                                          : (progress == 0 ? 1.0 : progress),
                                      minHeight: 7,
                                      backgroundColor: bgColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        accentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }, childCount: activities.length),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFEC4899),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ActivityFormView(viewModel: viewModel),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text(
          'Tambah Aktivitas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPastelStat({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9D174D),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF831843),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: Colors.pink.shade400),
          ),
        ],
      ),
    );
  }
}
