import 'package:flutter/material.dart';

class StoreBadge extends StatelessWidget {
  final String storeCode;
  final VoidCallback onChangeStore;

  const StoreBadge({super.key, required this.storeCode, required this.onChangeStore});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(9)),
            child: const Icon(Icons.storefront_rounded, color: Colors.white, size: 15),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO (API day): swap "Store #$storeCode" for the real store
              // name/branch returned once the code is looked up server-side.
              Text(
                'Store #$storeCode',
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const Text('Connected', style: TextStyle(color: Color(0xFF4ADE80), fontSize: 10.5)),
            ],
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onChangeStore,
            child: const Icon(Icons.refresh_rounded, color: Colors.white70, size: 17),
          ),
        ],
      ),
    );
  }
}
