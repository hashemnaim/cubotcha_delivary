import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/values/export.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../server/server_order.dart';
import 'screen/home/new_order_screen.dart';
import 'screen/home/history_order_screen.dart';
import 'screen/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AppController appController = Get.find();

  final PageController _pageController = PageController();
  OrderController orderController = Get.find();

  int _pageIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            leadingWidth: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh,
                    color: Theme.of(context).textTheme.bodyText1!.color),
                onPressed: () async {
                  await ServerOrder.instance.getOrders();
                },
              ),
            ],
            leading: SizedBox.shrink(),
            centerTitle: true,
            title: CustomPngImage(
              "im3",
              height: 60,
              width: 100,
            )),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          elevation: 10,
          unselectedItemColor: AppColors.blackDark,
          backgroundColor: AppColors.white,
          currentIndex: _pageIndex,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          iconSize: 25,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedLabelStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.w600,
          ),
          items: [
            _barItem(Icons.home, 'الرئيسية', 0),
            _barItem(Icons.menu, 'طلباتي', 1),
            _barItem(Icons.person, 'حسابي', 2),
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding:
            index == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 8.0),
        child: Icon(
          icon,
          color: index == _pageIndex ? AppColors.primary : Colors.grey,
        ),
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;

      _pageController.jumpToPage(pageIndex);
    });
  }
}
