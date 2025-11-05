import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'network_checker.dart';

/// 全局网络状态提示条
class NetworkBanner extends StatelessWidget {
  final Widget child;
  const NetworkBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<NetworkChecker>(
          builder: (context, checker, _) {
            if (!checker.hasConnection) {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: const SafeArea(
                    child: Text(
                      '⚠️ 当前无网络，请检查连接',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
