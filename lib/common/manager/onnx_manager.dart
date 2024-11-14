import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:onnxruntime/onnxruntime.dart';
import 'package:image/image.dart' as img;
import '../utils/image_utils.dart';

enum OnnxModelType {
  ocr,
}

class OnnxManager {
  OnnxManager._privateConstructor();
  static final OnnxManager _instance = OnnxManager._privateConstructor();
  factory OnnxManager() {
    return _instance;
  }

  late OrtSession session;
  late List strBuf;

  Future<void> initOnnxModel(OnnxModelType type) async {
    OrtEnv.instance.init();
    final sessionOptions = OrtSessionOptions();

    switch (type) {
      case OnnxModelType.ocr:
      default:
        const assetFileName = 'lib/assets/ocr/common_old.onnx';
        final rawAssetFile = await rootBundle.load(assetFileName);
        final bytes = rawAssetFile.buffer.asUint8List();
        session = OrtSession.fromBuffer(bytes, sessionOptions);
        break;
    }

    String jsonData =
        await rootBundle.loadString("lib/assets/ocr/common_old.json");
    strBuf = json.decode(jsonData);
  }

  Future<String> recognizeImage(Uint8List imageData) async {
    int width = ImageUtils.getWidth(imageData);
    int height = ImageUtils.getHeight(imageData);

    // 预处理图像
    img.Image image = ImageUtils.covertToImage(imageData);
    image = ImageUtils.resize(image, 64 * (width / height).floor(), 64);
    image = ImageUtils.toGray(image);

    // 定义形状
    List<int> shape = [1, 1, image.height, image.width];
    int dataSize = shape[0] * shape[1] * shape[2] * shape[3];
    Float32List data = Float32List(dataSize);
    imageData = image.toUint8List();

    int index = 0;
    // 数据填充
    for (int i = 0; i < imageData.length; i += 3, index++) {
      data[index] = (0.299 * imageData[i] +
              0.587 * imageData[i + 1] +
              0.114 * imageData[i + 2]) / 255.0;
      data[index] = (data[index] - 0.5) / 0.5;
    }

    // 推理
    final inputOrt = OrtValueTensor.createTensorWithDataList(data, shape);
    final inputs = {'input1': inputOrt};
    final runOptions = OrtRunOptions();
    final result = session.run(runOptions, inputs);
    inputOrt.release();
    runOptions.release();

    String words = "";
    if (result.isNotEmpty) {
      final output = result.first!.value as List<List<int>>;
      for(int i = 0; i < output.first.length; i++) {
        final index = output.first[i].toInt();
        words += strBuf[index];
      }
    }
    return words;
  }
}
