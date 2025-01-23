import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/cupertino.dart';

import '../../../services/httpsClient.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget _appBar() {
    return Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Obx(() => AppBar(
              title: InkWell(
                onTap: () {},
                child: AnimatedContainer(
                  width: controller.flag.value
                      ? Adapter.width(800)
                      : Adapter.width(620),
                  height: Adapter.height(92),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      color: controller.flag.value
                          ? const Color.fromRGBO(246, 246, 246, 1)
                          : Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Adapter.width(20), 0, Adapter.width(20), 0),
                        child: const Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "iphone 16 pro max",
                        style: TextStyle(
                            fontSize: Adapter.fontSize(36),
                            color: Colors.black26),
                      )
                    ],
                  ),
                ),
              ),
              leading: controller.flag.value
                  ? null
                  : const Icon(Icons.language_outlined, color: Colors.white70),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.qr_code,
                      color: Colors.black54,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.message_outlined,
                        color: Colors.black54)),
              ],
              centerTitle: true,
              backgroundColor:
                  controller.flag.value ? Colors.white : Colors.transparent,
              elevation: 0,
            )));
  }

  Widget _focus() {
    return SizedBox(
      height: Adapter.height(682),
      child: Obx(() => Swiper(
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl:
                    HttpsClient.replaceUri(controller.swiperList[index].pic),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fitWidth,
              );
            },
            // onTap: (index) => ,
            autoplay: true,
            autoplayDelay: 10000,
            duration: 2000,
            itemCount: controller.swiperList.length,
            viewportFraction: 1,
            scale: 1,
            pagination: SwiperPagination(
                margin: EdgeInsets.zero,
                builder: SwiperCustomPagination(builder: (context, config) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 50.0),
                    child: Row(
                      children: [
                        const Text(
                          'data',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        // 修改指示器
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: const DotSwiperPaginationBuilder(
                                    color: Colors.black12,
                                    activeColor: Colors.black26,
                                    size: 8,
                                    activeSize: 9)
                                .build(context, config),
                          ),
                        )
                      ],
                    ),
                  );
                })),
            // 修改左右滑动控制器
            // control:const SwiperControl(color: Color.fromARGB(120, 255, 255, 255)),
          )),
    );
  }

  Widget _category() {
    return Container(
      width: Adapter.width(1080),
      height: Adapter.height(472),
      child: Obx(() => Swiper(
            itemBuilder: (context, index) {
              return GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: Adapter.width(20),
                      mainAxisSpacing: Adapter.height(20)),
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Adapter.height(20)),
                          child: Container(
                              alignment: Alignment.center,
                              width: Adapter.height(140),
                              height: Adapter.height(140),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withOpacity(0.5), // 阴影颜色
                                      spreadRadius: 5, // 扩散半径
                                      blurRadius: 5, // 模糊半径
                                      offset: const Offset(5, 5), // 阴影偏移量
                                    ),
                                  ]),
                              child: CachedNetworkImage(
                                imageUrl: HttpsClient.replaceUri(controller
                                    .categoryList[index * 10 + i].pic),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            controller.categoryList[index * 10 + i].title,
                            style: TextStyle(fontSize: Adapter.fontSize(34)),
                          ),
                        )
                      ],
                    );
                  });
            },
            itemCount: controller.categoryList.length ~/ 10,
            pagination: SwiperPagination(
                margin: const EdgeInsets.all(0.0),
                builder: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: const RectSwiperPaginationBuilder(
                              color: Colors.black12,
                              activeColor: Color.fromARGB(160, 187, 255, 251),
                              activeSize: Size(30, 3),
                              size: Size(30, 3))
                          .build(context, config),
                    ),
                  );
                })),
            autoplay: false,
          )),
    );
  }

  Widget _buildHeader(double leftEdge, double topEdge, double rightEdge,
      double bottomEdge, String leftText, String rightText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftEdge, topEdge, rightEdge, bottomEdge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(leftText,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapter.fontSize(46))),
          Text(rightText,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: Adapter.fontSize(36),
                  color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildMasonryGrid(int itemCount, double itemSpace) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: itemSpace),
      color: const Color.fromRGBO(246, 246, 246, 1),
      child: Obx(
        () => GridView.builder(
          itemCount: controller.bestPlist.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Adapter.height(30),
              mainAxisSpacing: Adapter.width(30),
              childAspectRatio: 0.5),
          itemBuilder: (context, index) {
            return _buildGridItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return InkWell(
      onTap: () {
        // Get.toNamed("/product-content", arguments: {
        //   "pid": controller.bestPlist[index].id
        // });
      },
      child: Column(
        children: [
          Container(
            height: Adapter.height(500),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(Adapter.height(20)),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(HttpsClient.replaceUri(
                        controller.bestPlist[index].sPic)),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      // 处理图片加载错误
                      print('Image load error: $error');
                    })),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: _buildText(controller.bestPlist[index].title, 25,
                fontWeight: FontWeight.bold),
          ),

          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: _buildText("IPZZ-${controller.bestPlist[index].price}", 25, fontColor:Colors.blue[800]),
          // ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildText("有坂深雪", 25, fontColor: Colors.pink),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildText("2025-01-03", 25),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, double fontSize,
      {Color? fontColor, FontWeight? fontWeight}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Adapter.width(5),
        vertical: Adapter.width(5),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: fontColor ?? Colors.black,
          fontSize: Adapter.fontSize(fontSize),
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }

  Widget _update() {
    return Column(
      children: [
        _subTitle("最新更新", "查看更多"),
        _buildMasonryGrid(3, Adapter.width(30))
      ],
    );
  }

  Widget _subTitle(String leftText, String rightText, {bool isNext = false}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Adapter.width(30), Adapter.height(40),
          Adapter.width(30), Adapter.width(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(leftText,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapter.fontSize(48))),
          Row(
            children: [
              Text(rightText,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Adapter.fontSize(36),
                      color: Colors.black54)),
              isNext
                  ? Icon(
                      Icons.navigate_next_outlined,
                      size: Adapter.fontSize(60),
                      color: Colors.black38,
                    )
                  : SizedBox.shrink()
            ],
          ),
        ],
      ),
    );
  }

  // CachedNetworkImage(
  //                             imageUrl: "https://www.itying.com/images/kaoxiang.png",

  //                             errorWidget: (context, url, error) =>
  //                                 const Icon(Icons.error),
  //                             fit: BoxFit.fitHeight,
  //                           )
  Widget _gridField01() {
    return Container(
      height: Adapter.height(738),
      padding: EdgeInsets.fromLTRB(Adapter.width(20), Adapter.height(0),
          Adapter.width(20), Adapter.width(20)),
      child: Row(
        children: [
          // 左侧
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Obx(() => Swiper(
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: HttpsClient.replaceUri(
                              controller.hotselectionList[index].pic),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: controller.hotselectionList.length,
                      pagination: SwiperPagination(
                          margin: EdgeInsets.zero,
                          builder: SwiperCustomPagination(
                              builder: (context, config) {
                            return ConstrainedBox(
                              constraints:
                                  const BoxConstraints.expand(height: 50.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FractionPaginationBuilder(
                                        fontSize: Adapter.fontSize(35),
                                        activeFontSize: Adapter.fontSize(50),
                                        color: Colors.black12,
                                        activeColor: Colors.black26)
                                    .build(context, config),
                              ),
                            );
                          })),
                      autoplay: true,
                      autoplayDelay: 12000,
                      duration: 2000,
                    )),
              )),
          SizedBox(
            width: Adapter.width(20),
          ),
          // 右侧
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 15,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adapter.width(20)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6), // 设置倒角
                            border: Border.all(
                              color: Colors.black54, // 边框颜色
                              width: 0.1, // 边框宽度
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 70, 70, 70)
                                    .withOpacity(0.1), // 阴影颜色
                                spreadRadius: 0.2, // 阴影扩散半径
                                blurRadius: 5, // 模糊半径
                                offset: const Offset(0, 1), // 阴影偏移
                              ),
                            ]),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("作品预约受付",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Adapter.fontSize(46),
                                            fontWeight: FontWeight.w400)),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: Adapter.fontSize(40),
                                      color: Colors.black54,
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("近期有26部影片即将上映",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize:
                                                    Adapter.fontSize(32)))),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              Adapter.height(10)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://www.itying.com/images/kaoxiang.png",
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ))
                                  ],
                                )),
                          ],
                        ),
                      )),
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Adapter.width(20)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6), // 设置倒角
                          border: Border.all(
                            color: Colors.black54, // 边框颜色
                            width: 0.1, // 边框宽度
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 70, 70, 70)
                                  .withOpacity(0.1), // 阴影颜色
                              spreadRadius: 0.2, // 阴影扩散半径
                              blurRadius: 5, // 模糊半径
                              offset: const Offset(0, 1), // 阴影偏移
                            ),
                          ]),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("新作实时发售",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Adapter.fontSize(46),
                                          fontWeight: FontWeight.w400)),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: Adapter.fontSize(40),
                                    color: Colors.black54,
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "近期有26部影片fwfagsdgrseghafawefwaegaer即将上映",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: Adapter.fontSize(32)))),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(Adapter.height(10)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://www.itying.com/images/kaoxiang.png",
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  // 明星推荐
  Widget _popularStars() {
    return Container(
      //margin: EdgeInsets.only(top: Adapter.height(20)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapter.width(20), vertical: Adapter.height(20)),
      width: Adapter.screenWidth(),
      height: Adapter.height(710),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "人气明星",
                style: TextStyle(
                    fontSize: Adapter.fontSize(48),
                    fontWeight: FontWeight.w500),
              ),
              const Text("查看更多", style: TextStyle(color: Colors.blueAccent))
            ],
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.actressInfoList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: Adapter.height(20)),
                    width: Adapter.width(360),
                    child: GFCard(
                      color: Colors.white,
                      showImage: true,
                      margin: EdgeInsets.only(right: Adapter.width(20)),
                      padding: const EdgeInsets.all(0),
                      boxFit: BoxFit.cover,
                      image: Image.asset(
                        controller.actressInfoList[index].assetPath,
                        fit: BoxFit.cover,
                        height: Adapter.height(470),
                      ),
                      title: GFListTile(
                        padding: EdgeInsets.all(Adapter.height(10)),
                        margin: const EdgeInsets.all(0),
                        title: Text(controller.actressInfoList[index].name),
                        icon: Obx(() => GFCheckbox(
                              size: Adapter.fontSize(60),
                              type: GFCheckboxType.circle,
                              // 边框颜色
                              activeBorderColor: GFColors.TRANSPARENT,
                              inactiveBorderColor: GFColors.TRANSPARENT,
                              // 背景颜色
                              activeBgColor: const Color.fromARGB(60, 0, 0, 0),
                              inactiveBgColor:
                                  const Color.fromARGB(60, 0, 0, 0),
                              activeIcon: Icon(
                                CupertinoIcons.suit_heart_fill,
                                color: const Color.fromARGB(255, 255, 110, 100),
                                size: Adapter.fontSize(44),
                              ),
                              onChanged: (value) {
                                controller.getChecked(index);
                              },
                              value: controller
                                  .actressInfoList[index].isChecked.value,
                              inactiveIcon: Icon(
                                CupertinoIcons.heart,
                                color: Colors.white70,
                                size: Adapter.fontSize(44),
                              ),
                            )),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  // 作品推荐
  Widget _popularFilms() {
    return Container(
      //margin: EdgeInsets.only(top: Adapter.height(20)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapter.width(20), vertical: Adapter.height(20)),
      width: Adapter.screenWidth(),
      height: Adapter.height(2000),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "本周热门作品",
                style: TextStyle(
                    fontSize: Adapter.fontSize(48),
                    fontWeight: FontWeight.w500),
              ),
              const Text("全部榜单", style: TextStyle(color: Colors.blueAccent))
            ],
          ),
          SizedBox(height: Adapter.height(20),),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),          
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: Adapter.height(20),
                  crossAxisSpacing: Adapter.width(20),
                  crossAxisCount: 3,
                  childAspectRatio: 0.50,
                ),
                scrollDirection: Axis.vertical,
                itemCount: controller.filmInfoList.length,
                itemBuilder: (context, index) {
                  return 
                   Container(
                    child: GFCard(
                      margin: EdgeInsets.all(0),
                      //elevation: 0,
                      color: Colors.white,
                      showImage: true,
                      padding: const EdgeInsets.all(0),
                      boxFit: BoxFit.cover,
                      image: Image.asset(
                        controller.filmInfoList[index],
                        fit: BoxFit.cover,
                        //height: Adapter.height(400),
                      ),
                      // title: GFListTile(
                      //   padding: EdgeInsets.all(Adapter.height(10)),
                      //   margin: const EdgeInsets.all(0),
                      //   title: Text("本郷愛たるゆえん エロいんです。25人と乱交パーティーしたらすっごくエロいんです。", style: TextStyle(fontSize: Adapter.fontSize(10)),),
                      // )
                      // content: Text("本郷愛たるゆえん エロいんです。25人と乱交パーティーしたらすっごくエロいんです。", 
                      //               style: TextStyle(fontSize: Adapter.fontSize(32)),
                      //               maxLines: 1,
                      //               overflow: TextOverflow.ellipsis),
                     
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _homePage() {
    return ListView(
      controller: controller.scrollController,
      children: [
        _focus(),
        SizedBox(
          height: Adapter.height(40),
        ),
        _category(),
        _gridField01(),
        //_subTitle("热门推荐", ""),
        _popularStars(),
        _popularFilms(),

        _update(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        body: Stack(
          children: [_homePage(), _appBar()],
        ));
  }
}
