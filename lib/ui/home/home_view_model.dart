import 'package:flutter_app_template/data/repository/home/home_repository.dart';
import 'package:flutter_app_template/data/repository/home/home_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, AsyncValue<HomeState>>(
  (ref) => HomeViewModel(ref: ref),
);

class HomeViewModel extends StateNotifier<AsyncValue<HomeState>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  HomeViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    load();
  }

  late final HomeRepository homeRepository = _ref.read(homeRepositoryProvider);

  // 初期化
  Future<void> load() async {
    final result = await homeRepository.fetch();
    result.when(
      success: (data) {
        state = AsyncValue.data(
          HomeState(count: data),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  // カウントを+1
  void increment() {
    final count = state.value!.count;
    state = AsyncValue.data(
      HomeState(count: count + 1),
    );
  }
}
