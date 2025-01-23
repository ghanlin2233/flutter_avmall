import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../models/focus_model.dart';
import '../../../models/plist_model.dart';
import '../../../services/httpsClient.dart';
import '../../../models/image_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  HttpsClient httpsClient = HttpsClient();
  final ScrollController scrollController = ScrollController();
  RxList<FocusItemModel> swiperList = <FocusItemModel>[].obs;
  RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;
  RxList<PlistItemModel> bestPlist = <PlistItemModel>[].obs;
  RxList<FocusItemModel> hotselectionList = <FocusItemModel>[].obs;
  RxBool flag = false.obs;
  RxBool isChecked = false.obs;

  // 创建一个图片信息列表  
  final List<MyImage> actressInfoList = [  
    MyImage(name: '河北彩伽', assetPath: 'assets/images/act0.jpg'), 
    MyImage(name: '凉森玲梦', assetPath: 'assets/images/act1.jpg'),  
    MyImage(name: '八卦海', assetPath: 'assets/images/act2.jpg'),  
    MyImage(name: '流川夕', assetPath: 'assets/images/act3.jpg'),  
    MyImage(name: '玲村爱理', assetPath: 'assets/images/act4.jpg'),  
    MyImage(name: '？？？', assetPath: 'assets/images/act5.jpg'),
    // 可以继续添加更多图片信息  
  ];

  final List<String> filmInfoList = [  
    'assets/images/m0.jpg', 
    'assets/images/m1.jpg',  
    'assets/images/m2.jpg',  
    'assets/images/m3.jpg',  
    'assets/images/m4.jpg',  
    'assets/images/m5.jpg',
    // 可以继续添加更多图片信息  
  ];
  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    getFocusData();
    getCategoryData();
    getBestPlistData();
    getHotSelectionData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // 监听滑动事件
  void scrollControllerListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10 &&
          scrollController.position.pixels < 20) {
        if (flag.value == false) {
          flag.value = true;
          update();
        }
      }
      if (scrollController.position.pixels < 10) {
        if (flag.value == true) {
          flag.value = false;
          update();
        }
      }
    });
  }

  // 获取checked信息
  void getChecked(index){
    actressInfoList[index].isChecked.value = !actressInfoList[index].isChecked.value;
    update();
    // print("==========================");
    // print(imageInfoList[index].name);
    // print(imageInfoList[index].isChecked);
  }

  // 获取首页轮播图
  Future<void> getFocusData() async {
    var response = await httpsClient.get('api/focus');
    if (response != null) {
      var focus = FocusModel.fromJson(response.data);
      swiperList.value = focus.result!;
      update();
    }
  }

  // 获取片商分类数据
  Future<void> getCategoryData() async {
    var response = await httpsClient.get('api/bestCate');
    if (response != null) {
      var focus = CategoryModel.fromJson(response.data);
      categoryList.value = focus.result;
      update();
    }
  }

  // 获取热销甄选轮播图
  Future<void> getHotSelectionData() async {
    var response = await httpsClient.get('api/focus?position=2');
    if (response != null) {
      var focus = FocusModel.fromJson(response.data);
      hotselectionList.value = focus.result!;
      update();
    }
  }
  // 获取热门商品封面图
  Future<void> getBestPlistData() async {
    var response = await httpsClient.get('api/plist?is_best=1');
    if (response != null) {
      var data = PlistModel.fromJson(response.data);
      bestPlist.value = data.result;
      update();
    }
  }
}
