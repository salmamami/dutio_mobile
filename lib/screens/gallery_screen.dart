
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int? selectedIndex;

  final List<Color> photoColors = [
    const Color(0xFF8C9380),
    const Color(0xFFB9AA91),
    const Color(0xFF727C70),
    const Color(0xFFC2BBA8),
    const Color(0xFF9B9B8A),
    const Color(0xFF737D77),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 19,
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unggah Foto Laporan Piket',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.darkGreen,
                          ),
                        ),
                        Text(
                          'Pilih foto dari galeri',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.eco_outlined,
                    color: AppTheme.darkGreen,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),

            // UPLOAD AREA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 125,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE3CB),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 38,
                      color: AppTheme.darkGreen,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Unggah Foto',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Pilih gambar untuk laporan piket',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // RECENT FILES TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Recent Files',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // PHOTO GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: photoColors.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: photoColors[index],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.darkGreen
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: Colors.white70,
                                size: 32,
                              ),
                            ),
                            if (isSelected)
                              const Positioned(
                                right: 6,
                                top: 6,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppTheme.darkGreen,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // UPLOAD BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: selectedIndex == null
                      ? null
                      : () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/photo-preview',
                          );
                        },
                  icon: const Icon(Icons.upload_rounded),
                  label: const Text('Unggah Foto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkGreen,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
