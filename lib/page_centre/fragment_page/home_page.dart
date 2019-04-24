import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:the_fish_fly/text_centre/text_field_inn.dart';

const APPBAR_SCROLL_OFFSET=100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    "images/banner.jpg",
    "images/banner1.jpg",
    "images/banner2.jpg",
    "images/banner3.jpg"
  ];
double appBarAlpha=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                        height: 120,
                        child: Swiper(
                            itemCount: _imageUrls.length,
                            autoplay: true,
                            itemBuilder: (BuildContext context, int indext) {
                              return Image.asset(_imageUrls[indext],
                                  fit: BoxFit.fill);
                            },
                            viewportFraction: 0.9,
                            scale: 0.95,
                            onTap: (index) => print('点击了第$index个'),
                            pagination: SwiperPagination())),
                    Container(
                      height: 800,
                      child: ListTile(
                        title: Text(TextFieldInn.getText("home")),
                      ),
                    )
                  ],
                )),
          ),
          Opacity(
            opacity: appBarAlpha ,
              child: Container(
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(TextFieldInn.getText("home"))))))
        ],
      ),
    );
  }

  _onScroll(double pixels) {
   double alpha=pixels/APPBAR_SCROLL_OFFSET;
   if(alpha<0){
     alpha=0;
   }else if(alpha>1){
     alpha=1;
   }
   setState(() {
     appBarAlpha=alpha;
   });
  }
}
