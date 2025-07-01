import 'package:flutter/material.dart';

class NeighborhoodItem extends StatelessWidget {
  const NeighborhoodItem({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onTap,
  });
  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withValues(alpha: isSelected ? 1 : .5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
