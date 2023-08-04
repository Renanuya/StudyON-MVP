import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../homePage/viewmodel/home_page_viewmodel.dart';
import '../../login/view/login_page.dart';
import '../veiwmodel/rank_view_model.dart';
part "rank_page_mixin.dart";

enum RankPageTab {
  weekly,
  monthly,
  allTime,
}

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with SingleTickerProviderStateMixin, RankPageMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: _currentTab.index);
    context.read<RankUserListDataProviderAllTime>().setList();
    context.read<RankUserListDataProviderMonthly>().setList();
    context.read<RankUserListDataProviderWeekly>().setList();
  }

  @override
  Widget build(BuildContext context) {
    final userProviderAllTime =
        Provider.of<RankUserListDataProviderAllTime>(context, listen: true);
    final userProviderMonthly =
        Provider.of<RankUserListDataProviderMonthly>(context, listen: true);
    final userProviderWeekly =
        Provider.of<RankUserListDataProviderWeekly>(context, listen: true);

    final user = FirebaseAuth.instance.currentUser;
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    if (userProviderAllTime.getReady == false &&
        userProviderMonthly.getReady == false &&
        userProviderWeekly.getReady == false) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    } else {
      if (userProviderAllTime.getModel == null &&
          userProviderMonthly.getModel == null &&
          userProviderWeekly.getModel == null) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: mWidth * 0.805555556,
                            height: mHeight * 0.2262963,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE7E7E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: mWidth * 0.0462962962962963,
                                  left: mWidth * 0.0462962962962963,
                                  top: mHeight * 0.0262962962962963,
                                  bottom: mHeight * 0.0231481481481481),
                              child: InkWell(
                                onTap: () {
                                  if (user == null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      user?.displayName ??
                                          'Önce hesap açmalısınız',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mWidth * 0.0555555555555556,
                                        //  fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: mHeight * 0.01,
                                    ),
                                    Container(
                                      width: mWidth * 0.6481481481481481,
                                      height: mHeight * 0.1157407407407407,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFC9C7C7),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star_border_outlined,
                                                  size: mWidth *
                                                      0.0694444444444444),
                                              Text(
                                                'Puan',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.037037037037037,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                '${context.watch<TimerDataProiver>().getModel.allTime ?? '0'}',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.037037037037037,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          //! Bunları responsive yapmama gerek var mı bilemedim.
                                          const VerticalDivider(
                                            color: Color(0xFFffffff),
                                            thickness: 2,
                                            indent: 20,
                                            endIndent: 20,
                                            width: 0,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.public_outlined,
                                                  size: mWidth *
                                                      0.0694444444444444),
                                              Text(
                                                'Siralama',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.037037037037037,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                //burası
                                                '${userProviderAllTime.getUserRank}',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.037037037037037,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: mHeight * 0.0115740740740741),
                TabWidget(
                  tabController: _tabController,
                  onTabChanged: _onTabChanged,
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      //Weekly
                      Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: mHeight * 0.095,
                                          ),
                                          Container(
                                            width: mWidth * 0.1157407407407407,
                                            height: mWidth * 0.1157407407407407,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/50x50"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: OvalBorder(),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  mHeight * 0.0231481481481481),
                                          Text(
                                            '${userProviderWeekly.getModel?[1].name ?? ''} ${userProviderWeekly.getModel?[1].surname ?? ''}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  mWidth * 0.0324074074074074,
                                              //  fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star_border_outlined,
                                                  size: mWidth *
                                                      0.0462962962962963),
                                              Text(
                                                'Puan ',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.0277777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                '${userProviderWeekly.getModel?[1].weekly ?? '0'}',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.0277777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: mWidth * 0.2685185185185185,
                                            height:
                                                mHeight * 0.1793981581481481,
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFFFF8474),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              '2',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    mWidth * 0.1759259259259259,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                mHeight * 0.0231481481481481,
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Image.asset(
                                                        'assets/images/crown.png',
                                                      )
                                                    : Image.asset(
                                                        'assets/images/crown.png',
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: mWidth * 0.1157407407407407,
                                            height: mWidth * 0.1157407407407407,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/50x50"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: OvalBorder(),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  mHeight * 0.0115740740740741),
                                          Text(
                                            '${userProviderWeekly.getModel?.first.name ?? ''} ${userProviderWeekly.getModel?.first.surname ?? ''}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  mWidth * 0.0324074074074074,
                                              //  fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  mHeight * 0.005787037037037),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star_border_outlined,
                                                  size: mWidth *
                                                      0.0462962962962963),
                                              Text(
                                                'Puan ',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.0277777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                '${userProviderWeekly.getModel?[0].weekly ?? '0'}',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.0277777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: mWidth * 0.2685185185185185,
                                            height:
                                                mHeight * 0.2335814814814815,
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFF139487),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              '1',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    mWidth * 0.2222222222222222,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: mHeight * 0.15625,
                                          ),
                                          Container(
                                            width: mWidth * 0.1157407407407407,
                                            height: mWidth * 0.1157407407407407,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/50x50"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: OvalBorder(),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  mHeight * 0.0115740740740741),
                                          Text(
                                            '${userProviderWeekly.getModel?[2].name ?? ''} ${userProviderWeekly.getModel?[2].surname ?? ''}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  mWidth * 0.0324074074074074,
                                              //  fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  mHeight * 0.005787037037037),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star_border_outlined,
                                                  size: mWidth *
                                                      0.0462962962962963),
                                              Text(
                                                'Puan ',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.0277777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                '${userProviderWeekly.getModel?[2].weekly ?? '0'}',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF37352F),
                                                  fontSize: mWidth *
                                                      0.0277777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: mWidth * 0.2685185185185185,
                                            height:
                                                mHeight * 0.1294148148148148,
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFFFFE162),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              '3',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    mWidth * 0.1527777777777778,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: mWidth * 0.9,
                            height: mHeight * 0.16709,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7E7E6),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: (context
                                            .watch<
                                                RankUserListDataProviderWeekly>()
                                            .getModel
                                            ?.length ??
                                        0) -
                                    3, // 4. öğeden başlaması için 3 çıkarıldı
                                itemBuilder: (context, index) {
                                  final user = context
                                          .watch<RankUserListDataProviderWeekly>()
                                          .getModel![
                                      index +
                                          3]; // 4. öğeden başlamak için index + 3
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffD9D9D9),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            alignment: Alignment.center,
                                            child: Text('${index + 4}'),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/50x50"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: OvalBorder(),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 100,
                                            child: Text(((user.name! +
                                                            user.surname!)
                                                        .length <=
                                                    20)
                                                ? '${user.name ?? ''} ${user.surname ?? ''}'
                                                : user.name ?? ''),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                    Icons.star_border_outlined),
                                                Text(
                                                  '${user.weekly ?? '0'} Puan',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      //monthly
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: mHeight * 0.095,
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.1157407407407407,
                                              height:
                                                  mWidth * 0.1157407407407407,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.0231481481481481),
                                            Text(
                                              '${userProviderMonthly.getModel?[1].name ?? ''} ${userProviderMonthly.getModel?[1].surname ?? ''}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    mWidth * 0.0324074074074074,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_border_outlined,
                                                    size: mWidth *
                                                        0.0462962962962963),
                                                Text(
                                                  'Puan ',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${userProviderMonthly.getModel?[1].monthly ?? '0'}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.2685185185185185,
                                              height:
                                                  mHeight * 0.1793981581481481,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFF8474),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '2',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: mWidth *
                                                      0.1759259259259259,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  mHeight * 0.0231481481481481,
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 70,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Image.asset(
                                                          'assets/images/crown.png',
                                                        )
                                                      : Image.asset(
                                                          'assets/images/crown.png',
                                                        ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.1157407407407407,
                                              height:
                                                  mWidth * 0.1157407407407407,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.0115740740740741),
                                            Text(
                                              '${userProviderMonthly.getModel?.first.name ?? ''} ${userProviderMonthly.getModel?.first.surname ?? ''}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    mWidth * 0.0324074074074074,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.005787037037037),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_border_outlined,
                                                    size: mWidth *
                                                        0.0462962962962963),
                                                Text(
                                                  'Puan ',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${userProviderMonthly.getModel?[0].monthly ?? '0'}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.2685185185185185,
                                              height:
                                                  mHeight * 0.2335814814814815,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFF139487),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: mWidth *
                                                      0.2222222222222222,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: mHeight * 0.15625,
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.1157407407407407,
                                              height:
                                                  mWidth * 0.1157407407407407,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.0115740740740741),
                                            Text(
                                              '${userProviderMonthly.getModel?[2].name ?? ''} ${userProviderMonthly.getModel?[2].surname ?? ''}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    mWidth * 0.0324074074074074,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.005787037037037),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_border_outlined,
                                                    size: mWidth *
                                                        0.0462962962962963),
                                                Text(
                                                  'Puan ',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${userProviderMonthly.getModel?[2].monthly ?? '0'}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.2685185185185185,
                                              height:
                                                  mHeight * 0.1294148148148148,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFFE162),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '3',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: mWidth *
                                                      0.1527777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: mWidth * 0.9,
                              height: mHeight * 0.16709,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7E7E6),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: (context
                                              .watch<
                                                  RankUserListDataProviderMonthly>()
                                              .getModel
                                              ?.length ??
                                          0) -
                                      3, // 4. öğeden başlaması için 3 çıkarıldı
                                  itemBuilder: (context, index) {
                                    final user = context
                                            .watch<
                                                RankUserListDataProviderMonthly>()
                                            .getModel![
                                        index +
                                            3]; // 4. öğeden başlamak için index + 3
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffD9D9D9),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              alignment: Alignment.center,
                                              child: Text('${index + 4}'),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 100,
                                              child: Text(((user.name! +
                                                              user.surname!)
                                                          .length <=
                                                      20)
                                                  ? '${user.name ?? ''} ${user.surname ?? ''}'
                                                  : user.name ?? ''),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(Icons
                                                      .star_border_outlined),
                                                  Text(
                                                    '${user.monthly ?? '0'} Puan',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //alltime
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: mHeight * 0.095,
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.1157407407407407,
                                              height:
                                                  mWidth * 0.1157407407407407,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.0231481481481481),
                                            Text(
                                              '${userProviderAllTime.getModel?[1].name ?? ''} ${userProviderAllTime.getModel?[1].surname ?? ''}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    mWidth * 0.0324074074074074,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_border_outlined,
                                                    size: mWidth *
                                                        0.0462962962962963),
                                                Text(
                                                  'Puan ',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${userProviderAllTime.getModel?[1].allTime ?? '0'}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.2685185185185185,
                                              height:
                                                  mHeight * 0.1793981581481481,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFF8474),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '2',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: mWidth *
                                                      0.1759259259259259,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  mHeight * 0.0231481481481481,
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 70,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Image.asset(
                                                          'assets/images/crown.png',
                                                        )
                                                      : Image.asset(
                                                          'assets/images/crown.png',
                                                        ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.1157407407407407,
                                              height:
                                                  mWidth * 0.1157407407407407,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.0115740740740741),
                                            Text(
                                              '${userProviderAllTime.getModel?.first.name ?? ''} ${userProviderAllTime.getModel?.first.surname ?? ''}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    mWidth * 0.0324074074074074,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.005787037037037),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_border_outlined,
                                                    size: mWidth *
                                                        0.0462962962962963),
                                                Text(
                                                  'Puan ',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${userProviderAllTime.getModel?[0].allTime ?? '0'}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.2685185185185185,
                                              height:
                                                  mHeight * 0.2335814814814815,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFF139487),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: mWidth *
                                                      0.2222222222222222,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: mHeight * 0.15625,
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.1157407407407407,
                                              height:
                                                  mWidth * 0.1157407407407407,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.0115740740740741),
                                            Text(
                                              '${userProviderAllTime.getModel?[2].name ?? ''} ${userProviderAllTime.getModel?[2].surname ?? ''}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    mWidth * 0.0324074074074074,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                                height: mHeight *
                                                    0.005787037037037),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_border_outlined,
                                                    size: mWidth *
                                                        0.0462962962962963),
                                                Text(
                                                  'Puan ',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${userProviderAllTime.getModel?[2].allTime ?? '0'}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF37352F),
                                                    fontSize: mWidth *
                                                        0.0277777777777778,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width:
                                                  mWidth * 0.2685185185185185,
                                              height:
                                                  mHeight * 0.1294148148148148,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFFE162),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '3',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: mWidth *
                                                      0.1527777777777778,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: mWidth * 0.9,
                              height: mHeight * 0.16709,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7E7E6),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: (context
                                              .watch<
                                                  RankUserListDataProviderAllTime>()
                                              .getModel
                                              ?.length ??
                                          0) -
                                      3, // 4. öğeden başlaması için 3 çıkarıldı
                                  itemBuilder: (context, index) {
                                    final user = context
                                            .watch<
                                                RankUserListDataProviderAllTime>()
                                            .getModel![
                                        index +
                                            3]; // 4. öğeden başlamak için index + 3
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffD9D9D9),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              alignment: Alignment.center,
                                              child: Text('${index + 4}'),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/50x50"),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 100,
                                              child: Text(((user.name! +
                                                              user.surname!)
                                                          .length <=
                                                      20)
                                                  ? '${user.name ?? ''} ${user.surname ?? ''}'
                                                  : user.name ?? ''),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(Icons
                                                      .star_border_outlined),
                                                  Text(
                                                    '${user.allTime ?? '0'} Puan',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  void _onTabChanged(int tabIndex) {
    setState(() {
      _currentTab = RankPageTab.values[tabIndex];
      _pageController.jumpToPage(tabIndex);
    });
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentTab = RankPageTab.values[pageIndex];
      _tabController.animateTo(pageIndex);
    });
  }
}

class TabWidget extends StatelessWidget {
  final TabController? tabController;
  final Function(int) onTabChanged;

  const TabWidget({
    Key? key,
    required this.tabController,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        top: mHeight * 0.0115740740740741,
        left: mWidth * 0.0347222222222222,
        right: mWidth * 0.0347222222222222,
      ),
      child: Container(
        height: mHeight * 0.0636574074074074,
        width: mWidth * 0.805555556, //burası
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TabBar(
          controller: tabController,
          onTap: onTabChanged,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicator: BoxDecoration(
            color: const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(10),
          ),
          unselectedLabelColor: const Color(0xFF37352F),
          tabs: const [
            Tab(
              text: 'Haftalık',
            ),
            Tab(
              text: 'Aylık',
            ),
            Tab(
              text: 'Genel', // Add your third tab name here
            ),
          ],
        ),
      ),
    );
  }
}
