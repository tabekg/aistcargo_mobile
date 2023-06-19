import 'package:flutter/material.dart';

class HomeBoxItemWidget extends StatelessWidget {
  final List<Widget> children;
  final Color color;
  final Function()? onTap;

  const HomeBoxItemWidget({
    super.key,
    required this.children,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 100,
          height: 100,
          child: Center(
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
