import 'package:flutter/material.dart';
import '../viewmodel/view_model_profile.dart';

class PickProfilePhotoButtomSheet extends StatelessWidget {
  const PickProfilePhotoButtomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return SizedBox(
      width: pageSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () async => await PickProfilePhoto().pickFromCamera(),
            label: const Text('Kamera'),
            icon: const Icon(Icons.camera_outlined),
          ),
          TextButton.icon(
            onPressed: () async => await PickProfilePhoto().pickFromGallery(),
            label: const Text('Galeri'),
            icon: const Icon(Icons.image_outlined),
          ),
        ],
      ),
    );
  }
}