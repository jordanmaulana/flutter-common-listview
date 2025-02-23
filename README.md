<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

A listview in flutter has some common basic required UX as described in Features. The problem is, most designers (according to my experiences) is only showing the design with defined data to the design. Ignoring the states or basic UX that should be available in every listview. And programmers might miss some of those required minimum common UX listview. E.g: Missing next page loading.
This package is for those who are getting trouble to get it done because this package summarize and simplify the DX to make those minimum UX available.

## Features

1. Show loading
2. Drag to refresh
3. Next page on scroll to bottom
4. Show error
5. Show empty placeholder

## Getting started

```
import 'package:common_listview/common_listview.dart';
```

## Usage

```dart
CommonPaginatedList(
    loading: loading,
    page: page,
    length: data.length,
    itemBuilder: (c, i) {
    Issue data = this.data[i];
    return ListTile(
        leading: Text('$i'),
        title: Text('${data.title}'),
    );
    },
    onNext: onNext,
    onRefresh: () async {
    resetData();
    },
    errorMsg: null,
)
```
