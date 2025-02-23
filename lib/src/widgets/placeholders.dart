import 'package:flutter/widgets.dart';

class ErrorMessage extends StatelessWidget {
  final String? errorMsg;
  final TextStyle? style;

  const ErrorMessage(
    this.errorMsg, {
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          errorMsg ?? '',
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  final String? text;
  final TextStyle? style;

  const NoData({
    super.key,
    this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'There is no data',
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
