import 'package:flutter/material.dart';
import 'package:podsonly/core/services/api_service.dart';
import 'package:podsonly/core/services/product_model.dart';

class TempAPIUI extends StatelessWidget {
  const TempAPIUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Temp API UI'),
        ),
        body: Column(
          children: [
            const Text('Temp API UI'),
            FutureBuilder<ProductModel>(
              future: APIService().getItem(),
              builder:
                  (BuildContext context, AsyncSnapshot<ProductModel> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data?.title ?? ''),
                      Text(snapshot.data?.description ?? ''),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ));
  }
}
