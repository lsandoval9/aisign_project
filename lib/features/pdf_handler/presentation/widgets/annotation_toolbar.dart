import 'package:aisign_project/features/pdf_handler/domain/enums/annotation_enum.dart';
import 'package:flutter/material.dart';

class AnnotationToolbar extends StatelessWidget {
  final AnnotationTool selectedTool;
  final Color selectedColor;
  final double strokeWidth;
  final Function(AnnotationTool) onToolSelected;
  final Function(Color) onColorSelected;
  final Function(double) onStrokeWidthChanged;

  const AnnotationToolbar({
    super.key,
    required this.selectedTool,
    required this.selectedColor,
    required this.strokeWidth,
    required this.onToolSelected,
    required this.onColorSelected,
    required this.onStrokeWidthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolButton(
            icon: Icons.pan_tool,
            tool: AnnotationTool.none,
            tooltip: 'Pan Mode',
          ),
          _buildToolButton(
            icon: Icons.edit,
            tool: AnnotationTool.ink,
            tooltip: 'Pen',
          ),
          _buildToolButton(
            icon: Icons.highlight,
            tool: AnnotationTool.highlighter,
            tooltip: 'Highlighter',
          ),
          const SizedBox(width: 8),
          _buildColorPicker(),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required AnnotationTool tool,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        color: selectedTool == tool ? Colors.blue : Colors.black,
        onPressed: () => onToolSelected(tool),
      ),
    );
  }

  Widget _buildColorPicker() {
    return PopupMenuButton<Color>(
      tooltip: 'Select Color',
      icon: Icon(Icons.color_lens, color: selectedColor),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: Colors.red,
          child: _colorCircle(Colors.red),
        ),
        PopupMenuItem(
          value: Colors.blue,
          child: _colorCircle(Colors.blue),
        ),
        PopupMenuItem(
          value: Colors.green,
          child: _colorCircle(Colors.green),
        ),
        PopupMenuItem(
          value: Colors.yellow,
          child: _colorCircle(Colors.yellow),
        ),
        PopupMenuItem(
          value: Colors.black,
          child: _colorCircle(Colors.black),
        ),
      ],
      onSelected: onColorSelected,
    );
  }

  Widget _colorCircle(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
    );
  }
}