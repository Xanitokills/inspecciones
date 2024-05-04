import 'dart:convert';

import 'package:flutter/material.dart';

class ImageIndex extends StatelessWidget {
  const ImageIndex({
    super.key,
    required this.index,
    required this.image,
    required this.camera,
    required this.upload,
  });
  final String index;
  final String image;
  final Function camera;
  final Function upload;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        width: double.infinity,
        // color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(index),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    camera();
                  },
                  child: image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            base64Decode(image),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Text('Cámara'),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    upload();
                  },
                  child: image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            base64Decode(image),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Text('Galeria'),
                ),
              ),
            ),
          ],
        ));
  }
}
