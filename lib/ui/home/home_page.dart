import 'package:flutter/material.dart';
import 'package:flutter_app_template/config/extensions.dart';
import 'package:flutter_app_template/gen/assets.gen.dart';
import 'package:flutter_app_template/ui/home/home_view_model.dart';
import 'package:flutter_app_template/ui/hooks/use_l10n.dart';
import 'package:flutter_app_template/ui/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.watch(homeViewModelProvider.notifier);
    final l10n = useL10n();
    return state.when(
      data: (data) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.img.test.image(width: 200),
                  Text(
                    l10n.hello,
                    style: theme.textTheme.h70.bold().copyWith(
                          color: theme.appColors.onSecondary,
                        ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: theme.appColors.primary,
                      onPrimary: theme.appColors.onPrimary,
                    ),
                    onPressed: viewModel.increment,
                    child: Text(data.count.toString()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (e, msg) => Text(e.toString()),
      loading: () {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                color: theme.appColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
