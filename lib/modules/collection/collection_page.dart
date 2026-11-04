import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/my_scaffold.dart';
import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'collection_controller.dart';
import 'widgets/mobile/m_collection_body.dart';
import 'widgets/mobile/m_collection_filter.dart';
import 'widgets/mobile/m_collection_header.dart';
import 'widgets/tab/t_collection_body.dart';
import 'widgets/tab/t_collection_filter.dart';
import 'widgets/tab/t_collection_header.dart';
import 'widgets/web/collection_body.dart';
import 'widgets/web/collection_filter.dart';
import 'widgets/web/collection_header.dart';

class CollectionPage extends GetView<CollectionController> {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: isDesktop
                    ? CollectionHeader()
                    : isTab
                    ? TCollectionHeader()
                    : MCollectionHeader(),
              ),
              PinnedHeaderSliver(
                child: isDesktop
                    ? CollectionFilter()
                    : isTab
                    ? TCollectionFilter()
                    : MCollectionFilter(),
              ),
              SliverToBoxAdapter(
                child: isDesktop
                    ? CollectionBody()
                    : isTab
                    ? TCollectionBody()
                    : MCollectionBody(),
              ),
              SliverToBoxAdapter(
                child: isDesktop
                    ? Footer()
                    : isTab
                    ? TFooter()
                    : MFooter(),
              ),
            ],
          );
        },
      ),
    );
  }
}
