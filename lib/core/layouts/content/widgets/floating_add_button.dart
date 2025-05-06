
import 'package:aisign_project/config/enums/routes_enum.dart';
import 'package:aisign_project/config/router/theme_provider.dart';
import 'package:aisign_project/shared/providers/pdf_handler_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FloatingAddButton extends ConsumerStatefulWidget {
  const FloatingAddButton({super.key});

  @override
  _FloatingAddButtonState createState() => _FloatingAddButtonState();
}

class _FloatingAddButtonState extends ConsumerState<FloatingAddButton> {


  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      onPressed: () async {
        final pdfPicker = ref.read(pdfHandlerServiceProvider);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening file picker...'), duration: Duration(seconds: 1)),
        );

        try {

          final result = await pdfPicker.getFilePath();

          if (context.mounted) context.goNamed(RoutesEnum.pdfViewer.name, extra: result);

        } catch(e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to pick PDF: ${e.toString()}')),
          );
          return;
        }
      },
      child: const Icon(Icons.add),
    );
  }
}