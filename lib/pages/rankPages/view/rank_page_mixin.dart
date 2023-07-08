part of 'rank_page.dart';

mixin RankPageMixin on State<RankPage> {
  late TabController _tabController;
  late PageController _pageController;
  RankPageTab _currentTab = RankPageTab.weekly;

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
