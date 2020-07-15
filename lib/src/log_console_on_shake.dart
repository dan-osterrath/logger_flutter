part of logger_flutter;

class LogConsoleOnShake extends StatefulWidget {
  final Widget child;
  final bool dark;
  final bool debugOnly;
  final double shakeThresholdGravity;
  final int minTimeBetweenShakes;
  final int shakeCountResetTime;
  final int minShakeCount;

  LogConsoleOnShake({
    @required this.child,
    this.dark,
    this.debugOnly = true,
    this.shakeThresholdGravity = 1.25,
    this.minTimeBetweenShakes = 160,
    this.shakeCountResetTime = 1500,
    this.minShakeCount = 2,
  });

  @override
  _LogConsoleOnShakeState createState() => _LogConsoleOnShakeState();
}

class _LogConsoleOnShakeState extends State<LogConsoleOnShake> {
  ShakeDetector _detector;
  final Lock _openLock = new Lock();

  @override
  void initState() {
    super.initState();

    if (widget.debugOnly) {
      assert(() {
        _init();
        return true;
      }());
    } else {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _init() {
    _detector = ShakeDetector(
      onPhoneShake: _openLogConsole,
      shakeThresholdGravity: widget.shakeThresholdGravity,
      minTimeBetweenShakes: widget.minTimeBetweenShakes,
      shakeCountResetTime: widget.shakeCountResetTime,
      minShakeCount: widget.minShakeCount,
    );
    _detector.startListening();
  }

  _openLogConsole() async {
    _openLock.synchronized(() async {
      _detector.stopListening();

      var logConsole = LogConsole(
        showCloseButton: true,
        dark: widget.dark ?? Theme.of(context).brightness == Brightness.dark,
      );
      PageRoute route;
      if (Platform.isIOS) {
        route = CupertinoPageRoute(builder: (_) => logConsole);
      } else {
        route = MaterialPageRoute(builder: (_) => logConsole);
      }

      await Navigator.push(context, route);

      _detector.startListening();
    });
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
