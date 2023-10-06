// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';

enum TypeFile {
  singleGallery,
  singleCamera,
  multiGallery,
}

class UtilsFiles {
  UtilsFiles();

  /// converting to Uint8List to pass to printer
  static Future<Uint8List> filePathToUint8List(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List imageBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return imageBytes;
  }

  static Future<String> networkImageToBase64(String imageUrl) async {
    try {
      final url = Uri.parse(imageUrl);
      http.Response response = await http.get(url);
      final bytes = response.bodyBytes;
      //return (bytes != null ? base64Encode(bytes) : null);
      return base64Encode(bytes);
    } on Exception catch (_) {
      return imageUrl;
    }
  }

  /// get [File] from assets path
  static Future<File> getFileFromAssets(String path) async {
    debugPrint('Create file from assets');
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    //final file = File('${(await getExternalStorageDirectory())!.path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    debugPrint('File Created [${file.path}]');
    return file;
  }

  /// readJsonAssets
  static Future readJson(String pathAssetsJson) async {
    final String response = await rootBundle.loadString(pathAssetsJson);
    final data = await jsonDecode(response);
    return data;
  }

  /// Create File From data
  ///
  /// [data] as File
  ///
  /// [data] as String by Base 64
  ///
  /// [data] as Uint8List
  ///
  /// [extension] is required. Default is "PNG"
  ///
  static Future<String> createFile({
    required data,
    required String extension,
    bool hideDirectory = true,
    String? name,
  }) async {
    try {
      // get path
      final Directory appDir1 = await getApplicationDocumentsDirectory();
      final Directory appDir2 = await getApplicationSupportDirectory();
      final Directory appDir = hideDirectory ? appDir2 : appDir1;

      // bytes convert
      late Uint8List bytes;
      if (data is String) {
        bytes = base64Decode(data);
      } else if (data is File) {
        bytes = (data).readAsBytesSync();
      } else {
        bytes = data;
      }

      // file name
      final fileName = name ?? DateTime.now().millisecondsSinceEpoch.toString();
      final ext = extension.isNotEmpty ? 'png' : extension;
      // create file
      File file = File("${appDir.path}/$fileName.$ext");
      // write file from bytes
      await file.writeAsBytes(bytes);
      debugPrint('File created');
      return file.path;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  /// converting from Uint8List to base 64
  static String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  /// converting to Uint8List to pass to printer
  static Future<Uint8List> imagePathToUint8List(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List imageBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return imageBytes;
  }

  static Future<File?> getImageGallery(
      {TypeFile type = TypeFile.singleGallery, bool isCompress = true}) async {
    final ImagePicker picker = ImagePicker();

    if (type == TypeFile.singleGallery) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1250,
        maxWidth: 1250,
        imageQuality: isCompress ? 35 : 100,
      );
      return image == null ? null : File(image.path);
    } else if (type == TypeFile.singleCamera) {
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1250,
        maxWidth: 1250,
        imageQuality: isCompress ? 35 : 100,
      );
      return photo == null ? null : File(photo.path);
    } else {
      return null;
    }
  }

  static String fileToBase64(File fileData) {
    List<int> imageBytes = fileData.readAsBytesSync();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static Uint8List base64ToUint8List(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return Uint8List(0);
    }
  }

  static Uint8List fileToUint8List(File fileData) {
    debugPrint('Create Uint8List from file');
    final base64String = fileToBase64(fileData);
    final base64Image = base64ToUint8List(base64String);
    debugPrint('Uint8List Created [${base64Image.length}]');
    return base64Image;
  }

  static Future<File> croppedImageFile(File imageFile,
      {required BuildContext context,
      String title = 'Editor de imagen'}) async {
    final size = MediaQuery.of(context).size;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.grey,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          title: title,
        ),
        WebUiSettings(
          context: context,
          enableZoom: true,
          enableExif: true,
          enableResize: true,
          boundary: CroppieBoundary(
            width: ((size.height > size.width ? size.width : size.height) * 0.5)
                .toInt(),
            height:
                ((size.height > size.width ? size.width : size.height) * 0.5)
                    .toInt(),
          ),
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : imageFile;
  }

  static String compress(String json) {
    final enCodedJson = utf8.encode(json);
    final gZipJson = gzip.encode(enCodedJson);
    final base64Json = base64.encode(gZipJson);

    final decodeBase64Json = base64.decode(base64Json);
    final decodegZipJson = gzip.decode(decodeBase64Json);
    final originalJson = utf8.decode(decodegZipJson);
    return originalJson;
  }

  static Future<String> createFileFromString(String encodedStr,
      [bool isTemp = true]) async {
    Uint8List bytes = base64.decode(encodedStr);
    String dir1 = (await getTemporaryDirectory()).path;
    String dir2 = (await getApplicationDocumentsDirectory()).path;
    String dir = isTemp ? dir1 : dir2;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
