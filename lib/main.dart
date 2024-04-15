import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

void main() {
  appWindow.size = const Size(600, 450);
  runApp(const MyApp());
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = 'CFA - System 0.1.0';
    win.show();
  });
}

const accentColor = Color.fromARGB(255, 187, 187, 188);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
          body: WindowBorder(
        color: accentColor,
        width: 1,
        child: const Row(children: [LeftSide(), RightSide()]),
      )),
    );
  }
}

const borderColor = Color.fromARGB(255, 188, 188, 188);

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: borderColor)),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: accentColor,
              child: Row(
                children: [
                  WindowTitleBarBox(),
                  Expanded(child: MoveWindow()),
                  // WindowButtons()
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                        child: Text('Menu'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text('Content'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const backgroundStartColor = Color.fromARGB(255, 255, 255, 255);
const backgroundEndColor = Color.fromARGB(255, 161, 188, 235);

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [backgroundStartColor, backgroundEndColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.8])),
            child: Column(
              children: [
                WindowTitleBarBox(
                  child: Row(children: [
                    Expanded(child: MoveWindow()),
                    const WindowButtons(),
                    /* iconBuilder: (buttonContext) {
                      final window = appWindow;
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          window.maximizeOrRestore();
                        },
                        child: Container(
                          height: double.infinity,
                          color: const Color(0x00000000),
                          child: Icon(
                            window.isMaximized
                                ? Icons.filter_none
                                : Icons.filter_center_focus,
                            size: 15,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      );
                    } */
                  ]),
                ),
                Expanded(child: Container())
              ],
            )));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF000000),
    mouseOver: const Color(0xFF000000),
    mouseDown: const Color(0xFF000000),
    iconMouseOver: const Color(0xFFFFFFFF),
    iconMouseDown: const Color(0xFFFFFFFF));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF000000),
    iconMouseOver: const Color(0xFFFFFFFF),
    iconMouseDown: const Color(0xFFFFFFFF));

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      MinimizeWindowButton(
        colors: buttonColors,
      ),
      appWindow.isMaximized
          ? RestoreWindowButton(
              colors: buttonColors,
              onPressed: maximizeOrRestore,
            )
          : MaximizeWindowButton(
              colors: buttonColors,
              onPressed: maximizeOrRestore,
            ),
      CloseWindowButton(
        colors: closeButtonColors,
      )
    ]);
  }
}
