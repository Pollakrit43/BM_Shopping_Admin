import 'package:flutter/material.dart';
import 'package:flutter_ecom_admin/controllers/controllers.dart';
import 'package:flutter_ecom_admin/models/models.dart';
import 'package:flutter_ecom_admin/screens/screens.dart';
import 'package:get/get.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final OrderStatsController orderStatsController =
      Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BM Shopping',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF010A26),
      ),
      backgroundColor: Color(0xFF54BFA1),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.35,
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.02,
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductScreen());
                },
                child: Card(
                  color: Color(0xFF4A96D9),
                  child: Center(
                    child: Text(
                      'Go to Products',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 150,
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 10,
            //   ),
            //   child: InkWell(
            //     onTap: () {
            //       Get.to(() => OrderScreen());
            //     },
            //     child: const Card(
            //       child: Center(
            //         child: Text('Go to Orders'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  final List<OrderStats> orderStats;

  const CustomBarChart({
    super.key,
    required this.orderStats,
  });

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (series, _) =>
            DateFormat.yMd().format(series.dateTime).toString(),
        //series.index.toString(),
        measureFn: (series, _) => series.orders,
        colorFn: (series, _) => series.barColor!,
      ),
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
