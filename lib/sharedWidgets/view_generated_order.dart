import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:vege_food/Models/apiConstants.dart';

class ViewaGeneratedOrder extends StatefulWidget {
  final String ordername;
  const ViewaGeneratedOrder({
    Key? key,
    required this.ordername
  }) : super(key: key);

  @override
  State<ViewaGeneratedOrder> createState() => _ViewaGeneratedOrderState();
}

class _ViewaGeneratedOrderState extends State<ViewaGeneratedOrder> {
  bool _isLoading = true;
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL("${ApiConstants.baseUrl}/reports/${widget.ordername}");

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading?Center(child: CircularProgressIndicator()):PDFViewer(
          document: document!,
          zoomSteps: 1,
        ),
      ),
    );
  }
}
