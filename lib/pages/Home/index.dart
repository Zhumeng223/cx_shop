import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 页码
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: '',
    title: '',
    subTypes: [],
  );

  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      _key.currentState?.show();
      setState(() {});
    });
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      print("滚动到底部了");
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        _getRecommendList();
      }
    });
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
  }

  // 分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  // 特惠推荐
  Future<void> _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListAPI();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    // 如果已经有请求正在加载或没有下一页了，就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();

    // 所有数据获取成功，刷新成功
    Toastutils.showToast(context, "刷新成功！");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();

  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
