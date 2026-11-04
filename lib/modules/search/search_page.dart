import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/my_scaffold.dart';
import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'search_controller.dart';
import 'widgets/mobile/m_search_body.dart';
import 'widgets/tab/t_search_body.dart';
import 'widgets/web/search_body.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [SearchBody(), Footer()]
                : isTab
                ? [TSearchBody(), TFooter()]
                : [MSearchBody(), MFooter()],
          );
        },
      ),
    );
  }
}
