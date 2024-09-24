import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const OnboardingPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPlaying = false;
  final confettiCtrl = ConfettiController();
  double rating = 0;

  @override
  void initState() {
    super.initState();

    confettiCtrl.addListener(() {
      setState(() {
        isPlaying = confettiCtrl.state == ConfettiControllerState.playing;
      });
    });
    initialization();
  }

  void initialization() async {
    showToast('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    showToast('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    showToast('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    showToast('Go');
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            Lottie.network(
                'https://lottie.host/f1475918-72fb-4a64-9ed5-bba75d9f1cbd/Tmz8fGT4Fa.json'),
            ElevatedButton(
              child: Text(isPlaying ? 'Stop 😍' : 'Celebrate 🥳'),
              onPressed: () {
                if (isPlaying) {
                  confettiCtrl.stop();
                } else {
                  confettiCtrl.play();
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 80),
                textStyle: const TextStyle(fontSize: 28),
              ),
            ),
            ConfettiWidget(
            
              confettiController: confettiCtrl, shouldLoop: true,

              /// set direction
              // blastDirection: -pi / 2, //up
              // blastDirection: 0, //right
              // blastDirection: pi / 2, //down
              // blastDirection: pi, //left
              blastDirectionality: BlastDirectionality.explosive, //all

              /// set emission count
              emissionFrequency: 0.5, // 0.0 -> 1.0
              numberOfParticles: 20,

              /// set intensity
              minBlastForce: 10,
              maxBlastForce: 100,

              /// set speed
              gravity: 1.0, // 0.0 -> 1.0

              /// set shape or size
              createParticlePath: (size) {
                final path = Path();

                path.addOval(Rect.fromCircle(center: Offset.zero, radius: 6));
                return path;
              },

              /// set colors
              colors: const [
                Colors.red,
                Colors.green,
                Colors.yellow,
                Colors.blue,
                Colors.purpleAccent,
              ],
            ),
            Text('Rating: $rating',
                              style: const TextStyle(fontSize: 40)),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            updateOnDrag: true,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.music_note,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) => setState(() {
                              this.rating = rating;
                            }),
                          ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.share, //รูปไอคอนแชร์
        activeIcon: Icons.close, //แสดงรูปไอคอนปิด หลังจากคลิกปุ่ม
        //animatedIcon: AnimatedIcons.menu_close, //รูปไอคอนเมนู เมื่อคลิกจะเป็นปุ่มปิด
        backgroundColor: Colors.black, //สีพื้นหลังของปุ่ม
        overlayColor: Colors.black, //สีพื้นหลังเวลากดปุ่ม
        overlayOpacity: 0.4, //ระดับสี
        spacing: 12, //ระยะห่างระหว่างปุ่มหลักและปุ่มย่อย
        spaceBetweenChildren: 12, //ระยะห่างระหว่างปุ่มย่อย
        children: [
          SpeedDialChild(
              child: const Icon(Icons.mail),
              backgroundColor: Colors.lime,
              label: 'Mail',
              onTap: () => showToast('Selected Mail...')),
          SpeedDialChild(
              child: const Icon(Icons.copy),
              backgroundColor: Colors.lightGreen,
              label: 'Copy',
              onTap: () => showToast('Selected Copy...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              onTap: () => showToast('Selected Facebook...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.twitter,
                color: Colors.cyan,
              ),
              onTap: () => showToast('Selected Twitter...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onTap: () => showToast('Selected Google...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.twitter,
                color: Colors.green,
              ),
              onTap: () => showToast('Selected Google...')),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  showToast(String message) async {
    Fluttertoast.cancel();
    await Fluttertoast.showToast(msg: message, fontSize: 18);
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              Container(
                color: Colors.red,
                child: const Center(
                    child: Text('Page 1',
                        style: TextStyle(fontSize: 40, color: Colors.white))),
              ),
              Container(
                color: Colors.blue,
                child: const Center(
                    child: Text('Page 2',
                        style: TextStyle(fontSize: 40, color: Colors.white))),
              ),
              Container(
                color: Colors.green,
                child: const Center(
                    child: Text('Page 3',
                        style: TextStyle(fontSize: 40, color: Colors.white))),
              )
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    minimumSize: const Size.fromHeight(80)),
                child:
                    const Text('Get Started', style: TextStyle(fontSize: 24)),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: ''))),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => controller.jumpToPage(2),
                        child: const Text('SKIP')),
                    Center(
                        child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        spacing: 16,
                        dotHeight: 16,
                        dotWidth: 16,

                        // strokeWidth: 5,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    )),
                    TextButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        child: const Text('NEXT')),
                  ],
                ),
              ));
  }
}
