import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:quote_and_joke/state/quotes_notifier.dart';
import 'package:quote_and_joke/utils/constants.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/services/visibility_helper.dart';
import 'package:hooks_riverpod/all.dart';

// Needed so that you can't trigger another animation while one is running
final inAnimationProvider = StateProvider<bool>((ref) => false);

final isDragProvider = StateProvider<bool>((ref) => false);

class IsDrag extends ChangeNotifier {}

mixin QuoteAnimationMixin {
  QuoteAnimationMixinFields fields;
}
