import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

//화면에 뿌려야하는 데이터 추상화 vo 로 가정...
class DataVO {
  String image;
  String title;
  String date;
  String content;
  String location;
  DataVO(this.image, this.title, this.date, this.content, this.location);
}

List<DataVO> datas = [
  DataVO('images/lab_lotte_1.jpg', '롯데웨딩위크', '각 지점 본 매장', '2.14(금) ~ 2.23(일)',
      '백화점 전점'),
  DataVO('images/lab_lotte_2.jpg', 'LG TROMM 스타일러', '각 지점 본 매장',
      '2.14(금) ~ 2.29(토)', '백화점 전점'),
  DataVO(
      'images/lab_lotte_3.jpg', '금양와인 페스티발', '본매장', '2.15(토) ~ 2.20(목)', '잠실점'),
  DataVO('images/lab_lotte_4.jpg', '써스데이 아일랜드', '본 매장', '2.17(월) ~ 2.23(일)',
      '잠실점'),
  DataVO('images/lab_lotte_5.jpg', '듀풍클래식', '본 매장', '2.21(금) ~ 3.8(일)', '잠실점'),
];

//이벤트 카드(화면) 하나를 위한 위젯...
class CardADWidget extends StatelessWidget {
  DataVO vo;
  CardADWidget(this.vo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.pink[200],
        ),
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(vo.image, width: 350),
                  Container(
                    width: 350,
                    height: 100,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vo.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text(vo.content),
                        Text(vo.date)
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  child: Text(vo.location, style: TextStyle(color: Colors.white),),
                ),
                left: 30,
                bottom: 90,
              )
            ],
          ),
        )
      ],
    );
  }
}

//viewpager(화면 왼쪽, 오른쪽) 을 위해서..  stateful...
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
  //데이터 갯수 만큼.. card 위젯을 생성해 주는 개발자 함수...
  List<CardADWidget> makeViewPagerWidgets() {
    return datas.map((vo) {
      return CardADWidget(vo);
    }).toList();
  }
  //pageview 제어자...
  //여러 페이지가 있고.. 그 페이지들이 어떻게 보여야 하는지를 설정...
  PageController _controller = PageController(
    initialPage: 0,//초기 보여야 하는 페이지 index...
    viewportFraction: 0.8//현재 나오는 페이지.. 왼쪽, 오른쪽에 있는 페이지가 어느정도 보여야 하는지에 대한 설정..
    //1.0 미만으로 설정... 1.0 이면... 현 페이지만 보인다... 0.9  설정하면.. 90%가 현페이지.. 나머지 10%를 왼쪽, 오른쪽이..
  );

  @override
  Widget build(BuildContext context) {
    //화면 하단에 indicator 가 나오지 않아도 된다면.. PageView 만 이용...
    return PageIndicatorContainer(
      child: PageView(
        controller: _controller,
        children: makeViewPagerWidgets(),
      ),
      indicatorColor: Colors.white,
      indicatorSelectorColor: Colors.blue,
      length: datas.length,
      shape: IndicatorShape.roundRectangleShape(size: Size(20, 3)),//circle
      indicatorSpace: 1,
    );
  }
}





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        //SafeArea.... 화면을 구성하다 보면 디바이스 자체의 특성으로 화면의 하단, 상단이 안보일수 있다..
          //디바이스의 특성을 고려해서.. 앱의 화면이 나오게...해주는...
        body: SafeArea(
          child: Container(
            color: Colors.pink[200],
            child: MyWidget(),
          ),
        )
      ),
    );
  }
}

