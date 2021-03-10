import 'package:Flutter30Days/painters/curved_painter.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import '../../helper/no_glow_scroll_behaviour.dart';
import '../../globals.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

List<String> randomNames = [
  "Chezaru",
  "Riha",
  "Milet",
  "Misizu",
  "Mitchell",
  "Marrie",
  "Megan",
  "Christene",
  "Touka",
];

class Person {
  String name;
  String image;
  String subtitle;
  String detail;

  Person(this.name, this.image, this.subtitle, this.detail);
}

class _ListPageState extends State<ListPage> {
  var width, height;

  List<Person> _list = [
    Person("Mitchell Barber", "assets/person1.jpg", "New on Vision",
        "Been through 2 stops you're following incoping with depression"),
    Person("Marrie George", "assets/person2.jpg", "New on Vision",
        "Been through 2 stops you're following incoping with depression"),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        return Scaffold(
          body: _buildBody(),
        );
      },
    );
  }

  _buildBody() {
    return CustomPaint(
      painter: CurvedPainter(),
      child: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      "Beranda",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Mdi.searchWeb,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
                  child: Text(
                    "Connect to People Like you",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )),
              Container(
                height: 0.3 * height,
                child: buildListView(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Explore Communities",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                  ),
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoGlowScrollBehaviour(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 17.0,
                                  color: Colors.black.withOpacity(0.05),
                                  offset: Offset(5.0, 10.0)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: isFullScreen(Size(width, height))
                                      ? (0.05 * height)
                                      : (0.04 * height),
                                  backgroundImage: AssetImage(
                                      _getCurrentItem(index, threeCount: true)
                                          .image),
                                ),
                                SizedBox(height: 5),
                                Wrap(
                                  children: [
                                    Text(
                                      randomNames[index],
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 9,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  buildListView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 0.8 * width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6.0,
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            AssetImage(_getCurrentItem(index).image),
                      ),
                      SizedBox(width: 0.025 * width),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _getCurrentItem(index).name,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Text(_getCurrentItem(index).subtitle)
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    _getCurrentItem(index).detail,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 6,
      scrollDirection: Axis.horizontal,
    );
  }

  Person _getCurrentItem(int index, {bool threeCount = false}) =>
      index % (threeCount ? 3 : 2) == 0 ? _list[0] : _list[1];
}
