import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/collection/collection_controller.dart';
import 'package:nocvla_web/modules/collection/widgets/mobile/m_collection_body.dart';
import 'package:nocvla_web/modules/collection/widgets/tab/t_collection_body.dart';
import 'package:nocvla_web/modules/collection/widgets/web/collection_body.dart';
import 'package:nocvla_web/modules/collection/widgets/web/collection_header.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_collection_bottom.dart';
import 'widgets/tab/t_collection_bottom.dart';
import 'widgets/web/collection_bottom.dart';

class CollectionPage extends GetView<CollectionController> {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [
                    CollectionHeader(),
                    CollectionBody(),
                    CollectionBottom(),
                    Footer(),
                  ]
                : isTab
                ? [
                    CollectionHeader(),
                    TCollectionBody(),
                    TCollectionBottom(),
                    TFooter(),
                  ]
                : [
                    CollectionHeader(),
                    MCollectionBody(),
                    MCollectionBottom(),
                    MFooter(),
                  ],
          );
        },
      ),
    );
  }
}
