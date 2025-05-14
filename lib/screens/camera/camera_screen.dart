import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_identification_app/screens/camera/camera_preview_screen.dart';
import 'package:plant_identification_app/screens/identify/identify_result_screen.dart';
import 'package:plant_identification_app/theme/app_theme.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? imageFile;
  bool _isCameraInitialized = false;
  bool _isPermissionDenied = false;
  bool _isRearCameraSelected = true;
  bool _isFlashOn = false;
  int _currentZoomLevel = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initializeCamera();
    }
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      
      if (cameras != null && cameras!.isNotEmpty) {
        controller = CameraController(
          _isRearCameraSelected ? cameras![0] : cameras![1],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await controller!.initialize();
        
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
            _isPermissionDenied = false;
          });
        }
      }
    } on CameraException catch (e) {
      if (e.code == 'CameraAccessDenied') {
        setState(() {
          _isPermissionDenied = true;
        });
      }
    }
  }

  Future<void> _takePicture() async {
    final CameraController? cameraController = controller;
    
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    try {
      final XFile photo = await cameraController.takePicture();
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraPreviewScreen(
              imagePath: photo.path,
              onConfirm: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IdentifyResultScreen(
                      imagePath: photo.path,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    
    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      
      if (photo != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraPreviewScreen(
              imagePath: photo.path,
              onConfirm: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IdentifyResultScreen(
                      imagePath: photo.path,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _toggleCamera() {
    if (cameras != null && cameras!.length > 1) {
      setState(() {
        _isRearCameraSelected = !_isRearCameraSelected;
        _isCameraInitialized = false;
      });
      initializeCamera();
    }
  }

  void _toggleFlash() {
    if (controller != null) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      controller!.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    }
  }

  void _setZoomLevel(int level) {
    if (controller != null) {
      setState(() {
        _currentZoomLevel = level;
      });
      controller!.setZoomLevel(level.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isPermissionDenied) {
      return _buildPermissionDeniedUI();
    }

    if (!_isCameraInitialized) {
      return _buildLoadingUI();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button if needed
          },
        ),
        title: const Text('Take a Photo'),
        actions: [
          IconButton(
            icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: _toggleFlash,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),

          // Plant outline guide
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.7),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // Bottom UI
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 24.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Guidance text
                  const Text(
                    'Position the plant inside the frame',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Camera controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Gallery button
                      IconButton(
                        onPressed: _pickImageFromGallery,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      // Capture button
                      GestureDetector(
                        onTap: _takePicture,
                        child: Animate(
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ).custom(
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            // Create a pulse effect by scaling between 1.0 and 1.1
                            final scale = 1.0 + (0.1 * sin(value * pi));
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                        ).animate().fadeIn(delay: 200.ms),
                      ),

                      // Flip camera button
                      IconButton(
                        onPressed: _toggleCamera,
                        icon: const Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingUI() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: 24),
            Text(
              'Initializing camera...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedUI() {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.no_photography,
                size: 80,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Camera Access Required',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Plantia needs camera access to identify plants. Please grant camera permission in your device settings.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // This would typically open app settings
                  // But since we can't do that directly in Flutter web,
                  // we'll just try to initialize the camera again
                  initializeCamera();
                },
                child: const Text('GRANT ACCESS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}