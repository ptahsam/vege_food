import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';

class MpesaPayment extends StatefulWidget {
  final String userphone;
  final double amount;
  final String orderid;
  const MpesaPayment({
    Key? key,
    required this.userphone,
    required this.amount,
    required this.orderid
  }) : super(key: key);

  @override
  State<MpesaPayment> createState() => _MpesaPaymentState();
}

class _MpesaPaymentState extends State<MpesaPayment> {

  String paymentStatus = "Initializing payment";

  Future<void> startCheckout({required String userPhone, required double amount, required String orderid}) async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https", host: "31fa-102-217-7-30.in.ngrok.io", path: "/vege_food/includes/mpesaresponse.php"),
          accountReference: "VegeFood",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "Pay for order ${orderid}",
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      String result = await AssistantMethods.saveTransactionData(context, orderid, transactionInitialisation['CheckoutRequestID'], "paid");
      print("TRANSACTION RESULT: " + transactionInitialisation.toString() + "\n" + result);
      if(result == "SUCCESSFULLY_ADDED"){
        displayToastMessage("Your payment was initialized. Waiting for response.", context);
        Navigator.pop(context,"successfully_processed");
      }else{
        Navigator.pop(context);
        //displayToastMessage("An error occurred. Please try again later.", context);
      }
      print("TRANSACTION RESULT: " + transactionInitialisation.toString() + "\n" + result);

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCheckout(userPhone: widget.userphone, amount: widget.amount, orderid: widget.orderid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white,),
        ),
      ),
    );
  }
}
