// import 'package:flutter/material.dart';
// import 'dart:developer' as developer;

// class InfiniteListView extends StatefulWidget {
//   final Widget child;
//   final Future<void> Function() onLoadMore;
//   final bool hasMore;
//   final bool isLoading;

//   const InfiniteListView({
//     super.key,
//     required this.child,
//     required this.onLoadMore,
//     required this.hasMore,
//     required this.isLoading,
//   });

//   @override
//   State<InfiniteListView> createState() => _InfiniteListViewState();
// }

// class _InfiniteListViewState extends State<InfiniteListView> {
//   bool _isFetching = false;

//   Future<void> _load() async {
//     if (_isFetching) {
//       developer.log("Already fetching");
//       return;
//     }

//     if (widget.isLoading) {
//       developer.log("Widget loading");
//       return;
//     }

//     if (!widget.hasMore) {
//       developer.log("No more data");
//       return;
//     }

//     developer.log("Load More Triggered");

//     _isFetching = true;

//     await widget.onLoadMore();

//     developer.log("Load More Finished");

//     _isFetching = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//       onNotification: (notification) {
//         developer.log(notification.runtimeType.toString());
//         developer.log(
//           "Scroll : ${notification.metrics.pixels} / ${notification.metrics.maxScrollExtent}",
//         );
//         developer.log("TYPE = ${notification.runtimeType}", name: "SCROLL");

//         developer.log("PIXEL = ${notification.metrics.pixels}", name: "SCROLL");

//         developer.log(
//           "MAX = ${notification.metrics.maxScrollExtent}",
//           name: "SCROLL",
//         );

//         if (notification.metrics.pixels >=
//             notification.metrics.maxScrollExtent - 150) {
//           developer.log("Near Bottom");
//           _load();
//         }

//         return false;
//       },
//       child: widget.child,
//     );
//   }
// }
import 'package:flutter/material.dart';

class InfiniteListView extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onLoadMore; 
  final bool hasMore;
  final bool isLoading;

  const InfiniteListView({
    super.key,
    required this.child,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 150) {
          if (!isLoading && hasMore) {
            onLoadMore();
          }
        }
        return false;
      },
      child: child,
    );
  }
}