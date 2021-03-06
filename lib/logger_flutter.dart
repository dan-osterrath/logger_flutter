/// Flutter extension for logger
library logger_flutter;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart';

import 'src/ansi_parser.dart';
import 'src/shake_detector.dart';

part 'src/log_console_on_shake.dart';
part 'src/log_console.dart';
part 'src/log_console_output.dart';
