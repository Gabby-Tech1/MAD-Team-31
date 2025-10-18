import 'package:flutter/material.dart';
import 'package:parkright/models/parking_category.dart';
import 'package:parkright/utils/app_theme.dart';

class CategorySelectorComponent extends StatelessWidget {
  final List<ParkingCategory> categories;
  final ParkingCategory selectedCategory;
  final Function(ParkingCategory) onCategorySelected;

  const CategorySelectorComponent({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = category.id == selectedCategory.id;
          
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.backgroundLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category.icon,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}