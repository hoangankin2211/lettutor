import 'package:flutter/material.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';

class DefaultPagination<T> extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final List<T> items;
  final bool loading;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Function() listenScrollBottom;

  final ScrollPhysics? physics;
  final Widget? loadingWidget;
  final int totalPage;
  final int page;

  const DefaultPagination({
    super.key,
    this.physics,
    this.separatorBuilder,
    this.loadingWidget,
    required this.items,
    this.loading = false,
    required this.itemBuilder,
    required this.listenScrollBottom,
    this.totalPage = 0,
    this.page = 1,
  });

  @override
  State<DefaultPagination<T>> createState() => _DefaultPaginationState<T>();
}

class _DefaultPaginationState<T> extends State<DefaultPagination<T>> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_listenScroll);
  }

  void _listenScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        widget.listenScrollBottom();
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_listenScroll);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: widget.separatorBuilder ??
          (context, index) => const SizedBox(height: 10),
      physics: widget.physics ??
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      controller: _scrollController,
      itemCount: widget.items.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.items.length) {
          return widget.itemBuilder(context, index);
        }
        if (index >= widget.items.length && widget.page < widget.totalPage) {
          // Timer(const Duration(milliseconds: 30), () {
          //   _scrollController!.jumpTo(
          //     _scrollController!.position.maxScrollExtent,
          //   );
          // });
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: widget.loadingWidget ?? const AppLoadingIndicator(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
