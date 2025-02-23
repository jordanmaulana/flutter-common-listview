import 'package:common_listview/common_listview.dart';
import 'package:dio/dio.dart';
import 'package:example/issue.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final dio = Dio();

  bool loading = true;
  int page = 1;
  List<Issue> data = [];

  void getData() async {
    setState(() {
      loading = true;
    });

    final response = await dio.get(
      'https://api.github.com/repositories/1300192/issues?page=$page',
      options: Options(
        headers: {
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        },
      ),
    );

    final result = (response.data as List)
        .map((e) => Issue.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      if (page == 1) {
        data = result;
      } else {
        data.addAll(result);
      }
      loading = false;
    });
  }

  void onNext() {
    setState(() {
      page++;
    });
    getData();
  }

  void resetData() {
    setState(() {
      page = 1;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CommonListView Example'),
        ),
        body: CommonPaginatedList(
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
        ),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
}
