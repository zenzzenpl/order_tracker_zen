import 'package:flutter/material.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Order Tracker Zen"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: OrderTrackerZen(
                  tracker_data: [
                    TrackerData(
                      title: "Order Place",
                      date: "Sat, 8 Apr '22",
                      tracker_details: [
                        TrackerDetails(
                          title: "Your order was placed on Zenzzen",
                          datetime: "Sat, 8 Apr '22 - 17:17",
                        ),
                        TrackerDetails(
                          title: "Zenzzen Arranged A Callback Request",
                          datetime: "Sat, 8 Apr '22 - 17:42",
                        ),
                      ],
                    ),
                    TrackerData(
                      title: "Order Shipped",
                      date: "Sat, 8 Apr '22",
                      tracker_details: [
                        TrackerDetails(
                          title: "Your order was shipped with MailDeli",
                          datetime: "Sat, 8 Apr '22 - 17:50",
                        ),
                      ],
                    ),
                    TrackerData(
                      title: "Order Delivered",
                      date: "Sat,8 Apr '22",
                      tracker_details: [
                        TrackerDetails(
                          title: "You received your order, by MailDeli",
                          datetime: "Sat, 8 Apr '22 - 17:51",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
