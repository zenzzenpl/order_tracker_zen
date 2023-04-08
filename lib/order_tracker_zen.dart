// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

/// A data model representing a single tracker.
///
/// This model includes a title, date, and list of tracker details.
class TrackerData {
  /// The title of the tracker data.
  final String title;

  /// The date associated with the tracker data.
  final String date;

  /// A list of tracker details.
  final List<TrackerDetails> tracker_details;

  /// Creates a new tracker data instance.
  ///
  /// The [title], [date], and [tracker_details] must not be null.
  TrackerData({
    required this.title,
    required this.date,
    required this.tracker_details,
  });
}

/// A data model representing the details of a tracker.
///
/// This model includes a title and a datetime.
class TrackerDetails {
  /// The title of the tracker details.
  final String title;

  /// The datetime associated with the tracker details.
  final String datetime;

  /// Creates a new tracker details instance.
  ///
  /// The [title] and [datetime] must not be null.
  TrackerDetails({
    required this.title,
    required this.datetime,
  });
}

/// A stateless widget that displays an order tracking progress.
///
/// This widget takes a list of `TrackerData` as input and displays a
/// progress indicator with customizable colors and animation duration.
class OrderTrackerZen extends StatelessWidget {
  /// A list of tracker data.
  final List<TrackerData> tracker_data;

  /// The success color used in the widget.
  final Color? success_color;

  /// The background color used in the widget.
  final Color? background_color;

  /// The screen background color used in the widget.
  final Color? screen_background_color;

  /// The primary text color used in the widget.
  final Color? text_primary_color;

  /// The secondary text color used in the widget.
  final Color? text_secondary_color;

  /// The duration of the animation in milliseconds.
  final int animation_duration;

  /// Creates an OrderTrackerZen widget.
  ///
  /// The [tracker_data] must not be null, and the [animation_duration] must be a positive integer.
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
    // Builds the list of tracker items
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = tracker_data[index];
        // Animate the status line
        return TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: tracker_data.length.toDouble(),
          ),
          duration: Duration(
            milliseconds: animation_duration * tracker_data.length,
          ),
          builder: (context, value, child) {
            // Build the main tracker item
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

/// A stateful widget representing a single order tracker list item.
///
/// This widget displays a title, date, and details for a single order tracker item.
class OrderTrackerListItem extends StatefulWidget {
  /// The title and date widget of the main order status widget.
  final OrderTitleAndDate title;

  /// A list of order tracker details.
  final List<OrderTrackerDetails>? detailListItems;

  /// The success color used in the widget.
  final Color? success_color;

  /// The background color used in the widget.
  final Color? background_color;

  /// The screen background color used in the widget.
  final Color? screen_background_color;

  /// This is true if it is the last item in the list.
  final bool isLastItem;

  // This is true if the status line should be shown.
  final bool showLine;

  /// Creates an OrderTrackerListItem widget.
  ///
  /// The [title] must not be null, [isLastItem] and [showLine] default to false.
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
// Dot widget
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
// Title and date widget
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

/// A stateless widget representing the details of an order tracker.
///
/// This widget displays a title and a datetime.
class OrderTrackerDetails extends StatelessWidget {
  /// The title of the order tracker details.
  final title;

  /// The datetime associated with the order tracker details.
  final datetime;

  /// The primary text color used in the widget.
  final Color? text_primary_color;

  /// The secondary text color used in the widget.
  final Color? text_secondary_color;

  /// Creates an OrderTrackerDetails widget.
  ///
  /// The [title] and [datetime] must not be null.
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

/// A stateless widget representing the title and date of an order tracker.
///
/// This widget displays a title and a date.
class OrderTitleAndDate extends StatelessWidget {
  /// The title of the order tracker.
  final title;

  /// The date associated with the order tracker.
  final date;

  /// The primary text color used in the widget.
  final Color? text_primary_color;

  /// The secondary text color used in the widget.
  final Color? text_secondary_color;

  /// Creates an OrderTitleAndDate widget.
  ///
  /// The [title] and [date] must not be null.
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
