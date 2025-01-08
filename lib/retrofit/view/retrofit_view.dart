import 'package:flutter/material.dart';
import 'package:flutter_animations_2/retrofit/controller/retrofit_post_controller.dart';
import 'package:provider/provider.dart';

class RetrofitView extends StatelessWidget {
  const RetrofitView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RetrofitPostController(),
      child: const _RetrofitViewHelper(),
    );
  }
}

class _RetrofitViewHelper extends StatefulWidget {
  const _RetrofitViewHelper();

  @override
  State<_RetrofitViewHelper> createState() => _RetrofitViewHelperState();
}

class _RetrofitViewHelperState extends State<_RetrofitViewHelper> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await context.read<RetrofitPostController>().postApiSettings();
    context.read<RetrofitPostController>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final retrofitController = context.watch<RetrofitPostController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retrofit learning"),
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: retrofitController.retrofitPost.length,
          itemBuilder: (context, index) {
            final item = retrofitController.retrofitPost[index];
            return ListTile(
              title: Text(
                item.title ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item.body ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () async {
                  context.read<RetrofitPostController>().delete(item);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
              onTap: () {
                context.read<RetrofitPostController>().post(item);
              },
            );
          },
        ),
        onRefresh: () async => context.read<RetrofitPostController>().refresh(),
      ),
    );
  }
}
