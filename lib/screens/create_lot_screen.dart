import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_button.dart';
import 'lot_summary_screen.dart';

/// Screen 3: Step-by-Step E-Waste Lot Creation Wizard.
class CreateLotScreen extends StatefulWidget {
  final AppState appState;

  const CreateLotScreen({super.key, required this.appState});

  @override
  State<CreateLotScreen> createState() => _CreateLotScreenState();
}

class _CreateLotScreenState extends State<CreateLotScreen> {
  int _currentStep = 1; // 1: Photo, 2: Category, 3: Weight

  // Form State
  String? _selectedPhotoLabel = 'Mobile & Electronics Lot Photo';
  String _selectedPhotoEmoji = '📱';
  final Set<String> _selectedCategories = {'Mobile / Smartphone'};
  double _weightKg = 24.5;

  // Categories list
  final List<Map<String, dynamic>> _categories = [
    {'title': 'Mobile / Smartphone', 'emoji': '📱'},
    {'title': 'Laptop / Computer', 'emoji': '💻'},
    {'title': 'Monitor / TV', 'emoji': '🖥️'},
    {'title': 'Refrigerator / AC', 'emoji': '❄️'},
    {'title': 'Electrical Items', 'emoji': '🔌'},
    {'title': 'Battery', 'emoji': '🔋'},
    {'title': 'Other E-Waste', 'emoji': '🧩'},
  ];

  // Estimated price calculation
  double get _estimatedValue {
    // Average rate ~ ₹100 per kg for demo
    return _weightKg * 100.0;
  }

  void _nextStep() {
    if (_currentStep == 1) {
      // Photo step check
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      if (_selectedCategories.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kripya kam se kam 1 category chunein!'),
            backgroundColor: AppColors.statusPending,
          ),
        );
        return;
      }
      setState(() => _currentStep = 3);
    } else if (_currentStep == 3) {
      if (_weightKg <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kripya sahi weight enter karein!'),
            backgroundColor: AppColors.statusPending,
          ),
        );
        return;
      }

      // Proceed to Summary screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LotSummaryScreen(
            appState: widget.appState,
            photoLabel: _selectedPhotoLabel ?? 'Sample E-Waste Lot',
            photoEmoji: _selectedPhotoEmoji,
            selectedCategories: _selectedCategories.toList(),
            weightKg: _weightKg,
            estimatedValue: _estimatedValue,
          ),
        ),
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep -= 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _selectPresetPhoto(String label, String emoji) {
    setState(() {
      _selectedPhotoLabel = label;
      _selectedPhotoEmoji = emoji;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label select ho gaya!'),
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _prevStep,
        ),
        title: const Text('Naya E-Waste Lot'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STEP PROGRESS BAR
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step $_currentStep of 3',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        _currentStep == 1
                            ? 'Photo Add Karein'
                            : _currentStep == 2
                                ? 'Category Chunein'
                                : 'Weight Dalein',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _currentStep / 3.0,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            // STEP BODY CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: _buildCurrentStepContent(),
              ),
            ),

            // BOTTOM NAVIGATION BUTTON
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(
                  top: BorderSide(color: AppColors.border, width: 1.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: CustomButton(
                text: _currentStep == 3 ? 'Aage Badhein' : 'Next Step 👉',
                onPressed: _nextStep,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildStep1Photo();
      case 2:
        return _buildStep2Category();
      case 3:
        return _buildStep3Weight();
      default:
        return const SizedBox();
    }
  }

  // ================= STEP 1: PHOTO =================
  Widget _buildStep1Photo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-Waste ki Photo Add Karein 📸',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Lot ki saaf photo kheecho ya gallery se chuno taaki recycler sahi dam de sake.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textMedium,
          ),
        ),

        const SizedBox(height: 24),

        // Photo Preview Box
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _selectedPhotoLabel != null
                  ? AppColors.primary
                  : AppColors.border,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: _selectedPhotoLabel != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _selectedPhotoEmoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _selectedPhotoLabel!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: AppColors.primary, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Photo selected & ready',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 54, color: AppColors.textLight),
                    SizedBox(height: 10),
                    Text(
                      'Abhi tak photo nahi dali gayi',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
        ),

        const SizedBox(height: 24),

        // Large Action Buttons: Photo Kheecho & Gallery se Chunein
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _selectPresetPhoto('Camera Photo: Mobile Lot', '📱'),
                icon: const Icon(Icons.camera_alt_rounded, size: 22),
                label: const Text('Photo Kheecho'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectPresetPhoto('Gallery Photo: Scrap Electronics', '🔌'),
                icon: const Icon(Icons.photo_library_rounded, size: 22, color: AppColors.primary),
                label: const Text(
                  'Gallery se Chunein',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Quick Sample Photo Presets
        const Text(
          'Sample Photo Presets (Demo ke liye tap karein):',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textMedium,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(
              avatar: const Text('📱'),
              label: const Text('Phones Batch'),
              onPressed: () => _selectPresetPhoto('Mobile Phones Lot', '📱'),
            ),
            ActionChip(
              avatar: const Text('💻'),
              label: const Text('Laptops Scrap'),
              onPressed: () => _selectPresetPhoto('Laptop Scrap Lot', '💻'),
            ),
            ActionChip(
              avatar: const Text('🔋'),
              label: const Text('Batteries Batch'),
              onPressed: () => _selectPresetPhoto('Heavy Battery Lot', '🔋'),
            ),
          ],
        ),
      ],
    );
  }

  // ================= STEP 2: CATEGORY =================
  Widget _buildStep2Category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-Waste kis type ka hai? 🗂️',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Aap ek ya zyada categories chun sakte hain (Tap to select):',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textMedium,
          ),
        ),

        const SizedBox(height: 20),

        // Categories Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final cat = _categories[index];
            final title = cat['title'] as String;
            final emoji = cat['emoji'] as String;
            final isSelected = _selectedCategories.contains(title);

            return CategoryCard(
              title: title,
              emoji: emoji,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(title);
                  } else {
                    _selectedCategories.add(title);
                  }
                });
              },
            );
          },
        ),

        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, size: 18, color: AppColors.textMedium),
              const SizedBox(width: 8),
              Text(
                'Chuni gayi categories: ${_selectedCategories.length}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= STEP 3: WEIGHT =================
  Widget _buildStep3Weight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Weight kitna hai? ⚖️',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Kante (Weighing scale) ke mutabiq total weight dalein:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textMedium,
          ),
        ),

        const SizedBox(height: 24),

        // Large Weight Display & Controls Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'COLLECTION WEIGHT',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              // Big Numbers Display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _weightKg.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'kg',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Stepper +/- Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepperButton('-5', () {
                    setState(() {
                      if (_weightKg > 5) _weightKg -= 5;
                    });
                  }),
                  const SizedBox(width: 10),
                  _buildStepperButton('-1', () {
                    setState(() {
                      if (_weightKg > 1) _weightKg -= 1;
                    });
                  }),
                  const SizedBox(width: 16),
                  _buildStepperButton('+1', () {
                    setState(() => _weightKg += 1);
                  }, isPositive: true),
                  const SizedBox(width: 10),
                  _buildStepperButton('+5', () {
                    setState(() => _weightKg += 5);
                  }, isPositive: true),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Quick Preset Chips
        const Text(
          'Quick Presets (Jaldi select karein):',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [5.0, 10.0, 24.5, 50.0].map((val) {
            final isSelected = _weightKg == val;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: OutlinedButton(
                  onPressed: () => setState(() => _weightKg = val),
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        isSelected ? AppColors.primaryLight : Colors.white,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    '${val.toStringAsFixed(val % 1 == 0 ? 0 : 1)} kg',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color:
                          isSelected ? AppColors.primaryDark : AppColors.textDark,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Estimated Value Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.earningsLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.earningsGold.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const Text('💰', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Anumanit Mulya (Estimated Value)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.earningsGold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${_estimatedValue.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepperButton(String label, VoidCallback onPressed,
      {bool isPositive = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isPositive ? AppColors.primary : const Color(0xFFF1F5F9),
        foregroundColor: isPositive ? Colors.white : AppColors.textDark,
        elevation: 0,
        minimumSize: const Size(60, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: isPositive ? Colors.white : AppColors.textDark,
        ),
      ),
    );
  }
}
