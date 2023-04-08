// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TrackerData {
  final String title, date;
  final List<TrackerDetails> tracker_details;
  TrackerData({
    required this.title,
    required this.date,
    required this.tracker_details,
  });
}

class TrackerDetails {
  final String title, datetime;
  TrackerDetails({
    required this.title,
    required this.datetime,
  });
}

class OrderTrackerZen extends StatelessWidget {
  final List<TrackerData> tracker_data;
  final Color? success_color,
      background_color,
      screen_background_color,
      text_primary_color,
      text_secondary_color;
  final int animation_duration;
  const OrderTrackerZen({
    super.key,
    required this.tracker_data,
    this.success_color,
    this.background_color,
    this.screen_background_color,
    this.text_primary_color,
    this.text_secondary_color,
    this.animation_duration = 1500,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = tracker_data[index];
        return TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: tracker_data.length.toDouble(),
          ),
          duration: Duration(
            milliseconds: animation_duration * tracker_data.length,
          ),
          builder: (context, value, child) {
            return OrderTrackerListItem(
              success_color: success_color,
              background_color: background_color,
              screen_background_color: screen_background_color,
              title: OrderTitleAndDate(
                title: data.title,
                date: data.date,
                text_primary_color: text_primary_color,
                text_secondary_color: text_secondary_color,
              ),
              detailListItems: [
                for (var i = 0; i < data.tracker_details.length; i++)
                  OrderTrackerDetails(
                    title: data.tracker_details[i].title,
                    datetime: data.tracker_details[i].datetime,
                  ),
              ],
              isLastItem: index == tracker_data.length - 1,
              showLine: value > index,
            );
          },
        );
      },
      itemCount: tracker_data.length,
      padding: EdgeInsets.zero,
    );
  }
}

class OrderTrackerListItem extends StatefulWidget {
  final OrderTitleAndDate title;
  final List<OrderTrackerDetails>? detailListItems;
  final Color? success_color, background_color, screen_background_color;
  final bool isLastItem, showLine;
  const OrderTrackerListItem({
    super.key,
    required this.title,
    this.detailListItems,
    this.isLastItem = false,
    this.showLine = false,
    this.success_color,
    this.background_color,
    this.screen_background_color,
  });

  @override
  State<OrderTrackerListItem> createState() => _OrderTrackerListItemState();
}

class _OrderTrackerListItemState extends State<OrderTrackerListItem> {
  GlobalKey rowKey = GlobalKey();
  double getRowHeight() {
    final RenderBox? rowRenderBox =
        rowKey.currentContext?.findRenderObject() as RenderBox?;
    return rowRenderBox?.size.height ?? 0.0;
  }

  var rowHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        rowHeight = getRowHeight();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.isLastItem
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                  width: 2,
                  height: rowHeight,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: TweenAnimationBuilder(
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          color: widget.success_color ?? Colors.green,
                          backgroundColor:
                              widget.background_color ?? Colors.grey[400],
                        );
                      },
                      tween:
                          Tween<double>(begin: 0, end: widget.showLine ? 1 : 0),
                      duration: Duration(milliseconds: 1500),
                    ),
                  ),
                ),
              ),
        Row(
          key: rowKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: widget.success_color ?? Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.screen_background_color ?? Colors.white,
                  width: 2,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.title,
                  widget.detailListItems == null
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.detailListItems!,
                        ),
                  widget.detailListItems == null
                      ? SizedBox()
                      : SizedBox(height: 13),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OrderTrackerDetails extends StatelessWidget {
  final title, datetime;
  final Color? text_primary_color, text_secondary_color;
  const OrderTrackerDetails({
    super.key,
    required this.title,
    required this.datetime,
    this.text_primary_color,
    this.text_secondary_color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: text_primary_color ?? Colors.black,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 5),
          Text(
            datetime,
            style: TextStyle(
              color: text_secondary_color ?? Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTitleAndDate extends StatelessWidget {
  final title, date;
  final Color? text_primary_color, text_secondary_color;
  const OrderTitleAndDate({
    super.key,
    required this.title,
    required this.date,
    this.text_primary_color,
    this.text_secondary_color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: text_primary_color ?? Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          Text(
            date,
            style: TextStyle(
              color: text_secondary_color ?? Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
