import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TelaCamera extends StatefulWidget {
  const TelaCamera({Key? key}) : super(key: key);

  @override
  State<TelaCamera> createState() => _TelaCameraState();
}

class _TelaCameraState extends State<TelaCamera> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  XFile? image;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      // ignore: avoid_print
      print(e.description);
    }
  }

  _startCamera() {
    if (cameras.isEmpty) {
      // ignore: avoid_print
      print('Câmera não foi encontrada');
    } else {
      _previewCamera(cameras.first);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      // ignore: avoid_print
      print(e.description);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câmera'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: _arquivoWidget(),
        ),
      ),
      floatingActionButton: (image != null)
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pop(context),
              label: const Text('Enviar'),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _arquivoWidget() {
    return SizedBox(
      child: image == null
          ? _cameraPreviewWidget()
          : image?.path != null
              ? Image.file(File(image!.path))
              : const Text('Não foi possível carregar a imagem'),
    );
  }

  _cameraPreviewWidget() {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Carregando..',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CameraPreview(controller!),
          _botaoCapturaWidget(),
        ],
      );
    }
  }

  _botaoCapturaWidget() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: CircleAvatar(
          radius: 32,
          backgroundColor: Colors.blueGrey.shade200,
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () => {
              _capturarImagem(),
            },
          ),
        ));
  }

  _capturarImagem() async {
    final CameraController? cameraController = controller;
    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        XFile file = await cameraController.takePicture();
        if (mounted) setState(() => image = file);
      } on CameraException catch (e) {
        // ignore: avoid_print
        print(e.description);
      }
    }
  }
}
