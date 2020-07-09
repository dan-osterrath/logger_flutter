part of logger_flutter;

class LogConsoleOutput extends LogOutput {
  final LogOutput wrapped;

  StreamController<OutputEvent> _controller;
  bool _shouldForward = false;

  LogConsoleOutput({this.wrapped}) {
    _controller = StreamController<OutputEvent>(
      onListen: () => _shouldForward = true,
      onPause: () => _shouldForward = false,
      onResume: () => _shouldForward = true,
      onCancel: () => _shouldForward = false,
    );
  }

  Stream<OutputEvent> get stream => _controller.stream;

  @override
  void output(OutputEvent event) {
    wrapped?.output(event);

    if (!_shouldForward) {
      return;
    }

    _controller.add(event);
  }

  @override
  void destroy() {
    _controller.close();
  }
}
