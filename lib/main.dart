import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_mvvm_test/pages/home/home.dart';
import 'package:go_router_mvvm_test/repository/select_item.dart';
import 'package:go_router_mvvm_test/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SelectItemRepository()),
    ],
    child: const Main(),
  ));
}

class MainViewModel with ChangeNotifier {
  final SelectItemRepository repository;

  MainViewModel(this.repository) {
    repository.addListener(() {
      print('MainViewModel->listener :: $idx');
      print('MainViewModel->listener :: ${repository.idx}');
      notifyListeners();
    });
  }

  int get idx => repository.idx;
  set idx(int i) {
    print('MainViewModel->setIdx :: $i');
    repository.idx = i;
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  bool _isAnimating = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  late AnimationController _controller2;
  late Animation<Offset> _offsetAnimation2;

  int a = 1;
  final b = [
    Colors.pink,
    Colors.deepOrangeAccent,
    Colors.amber,
    Colors.greenAccent,
    Colors.blue,
    Colors.deepPurple,
  ];

  @override
  void initState() {
    super.initState();
    const duration = Duration(milliseconds: 300);

    _controller = AnimationController(duration: duration, vsync: this);
    _controller2 = AnimationController(duration: duration, vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _isAnimating = false;
        });
      }
    });

    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimating = true;
      a++;
    });
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else if (_controller2.status == AnimationStatus.completed) {
      _controller2.reverse().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/home',
        routes: [
          StatefulShellRoute.indexedStack(
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/home',
                    builder: (context, state) => const HomePage(),
                  ),
                ],
              ),
            ],
            builder: (context, state, shell) => Scaffold(
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  shell,
                  GestureDetector(
                    onTap: _toggleAnimation,
                    child: Stack(
                      children: [
                        SlideTransition(
                          position: _offsetAnimation,
                          child: _buildBottomSheet(
                            'SECOND',
                            b[(a.isOdd ? a : a - 1) % 6],
                          ),
                        ),
                        SlideTransition(
                          position: _offsetAnimation2,
                          child: _buildBottomSheet(
                            'FIRST',
                            b[(a.isEven ? a : a - 1) % 6],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const SplashPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(String text, Color color) {
    return Container(
      width: double.infinity,
      height: 300,
      color: color.withOpacity(0.5),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
