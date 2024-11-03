import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  String data = '';



  @override
  void initState() {
    super.initState();

    controller.text = 'id' + List.filled(10, 0).map((e) => Random().nextInt(9)).join('');
    controller2.text = '500';


    Future.doWhile(
        () async {
          var d = int.tryParse(controller2.text);

          if (d == null) {
            d = 500;
            controller2.text = '500';
          }

          await Future.delayed(Duration(milliseconds: d));

          final time = DateTime.now().millisecondsSinceEpoch;

          data = '$time / ${controller.text}';

          if (context.mounted) {
            setState(() {});
          }

          return true;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Обновление QR, мс'),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: controller2,
                ),
              ),

              SizedBox(height: 10,),

              SizedBox(
                height: 200,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PrettyQrView.data(
                    data: data,
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Text('Полезная нагрузка'),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: controller,
                ),
              )
            ],
          )
      )
    );
  }
}
