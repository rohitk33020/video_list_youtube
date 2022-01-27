import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:yellow_class/model/data_model.dart';
import 'package:yellow_class/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fetch content from the json file
  Future<List<DataModel>> readJson() async {
    final String response = await rootBundle.loadString('assets/dataset.json');
    List<dynamic> data = await json.decode(response);
    List<DataModel> list = data.map((ele) => DataModel.fromJson(ele)).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: videoList(),
      ),
    );
  }

  Widget videoList() {
    return InViewNotifierList(
      scrollDirection: Axis.vertical,
      initialInViewIds: const ['0'],
      isInViewPortCondition:
          (double deltaTop, double deltaBottom, double viewPortDimension) {
        return deltaTop < (0.2 * viewPortDimension) &&
            deltaBottom > (0.2 * viewPortDimension);
      },
      builder: (BuildContext context, int index) {
        return Container(
            width: double.infinity,
            height: 300.0,
            alignment: Alignment.center,
            child: FutureBuilder(
                future: readJson(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DataModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Text(snapshot.connectionState.toString()));
                  } else if (snapshot.hasData) {
                    var item = snapshot.data![index];
                    return InViewNotifierWidget(
                      id: '$index',
                      builder:
                          (BuildContext context, bool isInView, Widget? child) {
                        return VideoCard(
                          videoUrl: item.videoUrl!,
                          isPlay: isInView,
                          coverPicture: item.coverPicture!,
                          title: item.title!,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const CircularProgressIndicator();
                  }
                }));
      },
    );
  }
}
