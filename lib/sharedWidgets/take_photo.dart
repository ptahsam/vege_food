import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vege_food/sharedWidgets/widgets.dart';

class TakePhoto extends StatefulWidget {
  final List<CameraDescription> cameras;
  const TakePhoto({
    Key? key,
    required this.cameras
  }) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  //CameraController? controller;

  //List<CameraDescription>? cameras;

  CameraController? _cameraController;
  Future<void>? _initializeCameraControllerFuture;
  int selectedCamera = 0;


  @override
  void initState() {
    //getCameras();
    initializeCamera(selectedCamera);
    super.initState();
  }

  initializeCamera(int cameraIndex) async{
    _cameraController = CameraController(widget.cameras[cameraIndex], ResolutionPreset.ultraHigh);

    _initializeCameraControllerFuture = _cameraController!.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;

      //final path =
      //join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      await _cameraController!.takePicture().then((XFile file){
        Navigator.pop(context,file);
      });

    } catch (e) {
      print(e);
    }
  }

  /*void getCameras() async{
   cameras = await availableCameras();
   controller = CameraController(cameras![0], ResolutionPreset.max);
   controller!.initialize().then((_) {
     if (!mounted) {
       return;
     }
     setState(() {});
   });
  }*/

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: <Widget>[
          FutureBuilder(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_cameraController!),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            top: 40.0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 12.0,right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.cameras.length > 1) {
                        setState(() {
                          selectedCamera = selectedCamera == 0 ? 1 : 0;//Switch camera
                          initializeCamera(selectedCamera);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('No secondary camera found'),
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    },
                    icon: selectedCamera == 0?Icon(MdiIcons.cameraFront,color: Colors.white,size: 28.0,):Icon(MdiIcons.cameraRear,color: Colors.white, size: 28.0,),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Center(
                child: CircleButton(
                  icon: Icons.camera,
                  iconSize: 22.0,
                  onPressed: (){
                    _takePicture(context);
                  },
                ),
              ),
            ),
          ),

        ]),
      ),
    );
  }
}
