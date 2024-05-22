import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Compress extends StatefulWidget {
  const Compress({Key? key}) : super(key: key);

  @override
  State<Compress> createState() => _CompressState();
}

class _CompressState extends State<Compress> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _compressedFile;

/*   Future<void> compress() async {
    var result = await FlutterImageCompress.compressAndGetFile(
      _imageFile!.absolute.path,
      _imageFile!.path + 'compressed.jpg',
      quality: 66,
    );
    setState(() {
      // ignore: unrelated_type_equality_checks
      _compressedFile = result;
    });
  }
 */

  Future<void> compress() async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        _imageFile!.absolute.path,
        _imageFile!.path + 'compressed.jpg',
        quality: 66,
      );

      // Convierte XFile a File utilizando el constructor File() de path_provider
      _compressedFile = result != null ? File(result.path) : null;

      setState(() {
        // Actualiza el estado con el archivo comprimido
        _compressedFile = _compressedFile;
      });
    } catch (e) {
      // Manejo de errores
      print("Error durante la compresión: $e");
      // Podrías mostrar un mensaje de error al usuario o realizar otra acción apropiada aquí
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Image Compress'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Before'),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
                width: 200,
              ),
            if (_imageFile != null) Text('${_imageFile!.lengthSync()} bytes'),
            const Divider(),
            const Text('After'),
            if (_compressedFile != null)
              Image.file(
                _compressedFile!,
                height: 200,
                width: 200,
              ),
            if (_compressedFile != null)
              Text('${_compressedFile!.lengthSync()} bytes'),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                await pickImage();
              },
              child: const Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                await compress();
              },
              child: const Text('Compress'),
            )
          ],
        ),
      ),
    );
  }
}
