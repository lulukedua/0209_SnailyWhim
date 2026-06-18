import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/data/models/category_model.dart';
import 'package:snailywhim/data/repositories/category_repository.dart';

class CategoryFilterBar extends StatefulWidget {
  /// [kategoriId] = null berarti "Semua"
  final void Function(String? kategoriId) onSelected;
  final EdgeInsets padding;

  const CategoryFilterBar({
    super.key,
    required this.onSelected,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> {
  final CategoryRepository _repo = CategoryRepository();
  List<CategoryModel> _categories = [];
  String? _selectedId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final result = await _repo.getAllKategori();
      if (mounted)
        setState(() {
          _categories = result;
          _loading = false;
        });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _onTap(String? id) {
    final next = (_selectedId == id) ? null : id; // toggle off → reset ke Semua
    setState(() => _selectedId = next);
    widget.onSelected(next);
  }

  /// Reset chip dari luar (dipanggil parent saat pagination berubah)
  void reset() {
    if (_selectedId != null) setState(() => _selectedId = null);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Padding(
        padding: widget.padding,
        child: SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, __) => Container(
              width: 72,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      );
    }

    if (_categories.isEmpty) return const SizedBox();

    return Padding(
      padding: widget.padding,
      child: SizedBox(
        height: 36,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _Chip(
              label: "Semua",
              isSelected: _selectedId == null,
              onTap: () => _onTap(null),
            ),
            const SizedBox(width: 8),
            ..._categories.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _Chip(
                  label: cat.nama_kategori,
                  isSelected: _selectedId == cat.id,
                  onTap: () => _onTap(cat.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primColor
                : AppColors.primColor.withOpacity(0.35),
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primColor.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : AppColors.primTextColor,
          ),
        ),
      ),
    );
  }
}
