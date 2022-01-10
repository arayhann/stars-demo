import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:stars/flashes.dart';
import 'package:stars/particles.dart';
import 'package:stars/stars_backgroud.dart';
import 'package:stars/static_stars.dart';

class Stars extends StatelessWidget {
  const Stars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = _createTween();
    return LayoutBuilder(
      builder: (context, constraints) {
        return LoopAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            return Stack(
              children: [
                const Positioned.fill(child: StarsBackground()),
                const Positioned.fill(child: StaticStars()),
                const Positioned.fill(child: Flashes()),
                Positioned.fill(
                  child: CustomPaint(
                    painter: ParticlePainter(
                      value: value.get(_P.particles),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Transform.scale(
                      scale: value.get(_P.scale),
                      child: Transform.rotate(
                        angle: value.get(_P.rotate),
                        child: FlutterLogo(size: constraints.maxWidth * 0.3),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

enum _P { scale, rotate, particles }

const MUSIC_UNIT_MS = 6165;

TimelineTween<_P> _createTween() {
  final tween = TimelineTween<_P>();

  tween
      .addScene(
        begin: Duration(milliseconds: (0.25 * MUSIC_UNIT_MS).round()),
        end: Duration(milliseconds: (0.75 * MUSIC_UNIT_MS).round()),
        curve: Curves.easeOutQuad,
      )
      .animate(_P.scale, tween: Tween(begin: 0.01, end: 1.5))
      .animate(_P.rotate, tween: Tween(begin: -70.6, end: 0.0));

  tween
      .addScene(
          begin: const Duration(seconds: 0),
          end: Duration(milliseconds: (1 * MUSIC_UNIT_MS).round()))
      .animate(_P.particles, tween: Tween(begin: 0.0, end: 3.0));

  return tween;
}
