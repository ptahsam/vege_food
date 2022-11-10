import 'package:flutter/material.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/user.dart';

class ViewUserPhoto extends StatefulWidget {
  final User user;
  const ViewUserPhoto({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewUserPhoto> createState() => _ViewUserPhotoState();
}

class _ViewUserPhotoState extends State<ViewUserPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 32.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: Image.network(
              widget.user.user_photo!.contains("https")?widget.user.user_photo!:"${ApiConstants.baseUrl}/images/profiles/${widget.user.user_photo!}",
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
