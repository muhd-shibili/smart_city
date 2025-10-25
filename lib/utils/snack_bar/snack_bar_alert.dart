import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../ui/widgets/buttons/ink_well_material.dart';

@lazySingleton
class SnackBarAlert {
  OverlaySupportEntry? currentEntry;

  void showToast({
    required String message,
    Function? onTap,
    String? actionText,
    bool isTop = false,
  }) {
    assert(onTap != null || (onTap == null && actionText == null));
    hide();

    currentEntry = showOverlayNotification(
      position: isTop ? NotificationPosition.top : NotificationPosition.bottom,
      duration: const Duration(seconds: 2),
      (context) => GestureDetector(
        onVerticalDragUpdate: (details) {
          if ((details.primaryDelta ?? 0) > 0) {
            hide();
          }
        },
        child: SafeArea(
          minimum: MediaQuery.viewInsetsOf(context),
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white60,
                  offset: Offset(0, 2),
                  blurRadius: 100,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Material(
              color: Colors.white70,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 15,
                        bottom: 15,
                        start: 15,
                      ),
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  InkWellMaterial(
                    color: Colors.white70,
                    borderRadius: 12,
                    onTap: () {
                      if (onTap != null) {
                        onTap();
                      }
                      hide();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        actionText ?? 'Dismiss',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCustomToast({
    required String message,
    required Function onTap,
    bool isTop = false,
  }) {
    hide();
    currentEntry = showOverlayNotification(
      position: isTop ? NotificationPosition.top : NotificationPosition.bottom,
      duration: const Duration(seconds: 2),
      (context) => GestureDetector(
        onVerticalDragUpdate: (details) {
          if ((details.primaryDelta ?? 0) > 0) {
            hide();
          }
        },
        child: SafeArea(
          minimum: MediaQuery.viewInsetsOf(context),
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white60,
                  offset: Offset(0, 2),
                  blurRadius: 100,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Material(
              color: Colors.white70,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: InkWell(
                onTap: () {
                  onTap();
                  hide();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 15,
                      bottom: 15,
                      start: 15,
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hide() {
    if (currentEntry != null) {
      currentEntry?.dismiss();
    }
  }
}
