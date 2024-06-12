// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterkeepme/core/util/function/app_function_checklist.dart';
import 'package:flutterkeepme/core/widgets/common_search_bar_checklist.dart';

import '../../../../../../core/core.dart';

class SliverChecklists extends StatelessWidget {
  final Widget child;

  const SliverChecklists({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (_, __) {
        return [_appBar(context)];
      },
      body: RefreshIndicator(
        displacement: 80,
        onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
        child: child,
      ),
    );
  }

  _appBar(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      sliver: SliverAppBar(
        floating: true,
        snap: true,
        titleSpacing: 0,
        toolbarHeight: 50,
        leadingWidth: 0,
        forceMaterialTransparency: true,
        title: CommonSearchBar(),
        systemOverlayStyle: AppDevice.setStatusBartSilverAppBar(),
        leading: SizedBox(),
      ),
    );
  }
}
