import 'package:flutter/material.dart';
import 'package:my_books_app/core/loader/loading_overly_widget.dart';

class OverlayService {
  OverlayEntry? _overlayEntry;

  void showLoadingOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    if (_overlayEntry != null) return; // Overlay is already shown

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: LoadingOverlay(),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void hideLoadingOverlay() {
    if (_overlayEntry == null) return; // No overlay to remove

    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
