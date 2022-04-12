################################################################################################
## 環境変数 flavor
################################################################################################
DEV_FLAVOR := dev
PROD_FLAVOR := prod


################################################################################################
## 基本コマンド
################################################################################################
# packages install
.PHONY: dependencies
dependencies:
	flutter pub get

# packages upgrade
.PHONY: upgrade
upgrade:
	flutter packages upgrade

# packages clean
.PHONY: clean
clean:
	flutter clean

# code analyze
.PHONY: analyze
analyze:
	flutter analyze

# l10n generate
.PHONY: l10n
l10n:
	flutter gen-l10n

# code generate
.PHONY: build-runner
build-runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

# run test
.PHONY: test
test:
	flutter test


################################################################################################
## 実行
################################################################################################

# run dev (with Device Preview)
.PHONY: run-dev-preview
run-dev-preview:
	flutter run --dart-define=FLAVOR=${DEV_FLAVOR} --dart-define=PREVIEW=true --target lib/main.dart

# run dev
.PHONY: run-dev-non-preview
run-dev-non-preview:
	flutter run --dart-define=FLAVOR=${DEV_FLAVOR} --dart-define=PREVIEW=false --target lib/main.dart

# run prod (with Device Preview)
.PHONY: run-prod-preview
run-prod-preview:
	flutter run --dart-define=FLAVOR=${PROD_FLAVOR} --dart-define=PREVIEW=true --target lib/main.dart

# run prod
.PHONY: run-prod-non-preview
run-prod-non-preview:
	flutter run --dart-define=FLAVOR=${PROD_FLAVOR} --dart-define=PREVIEW=false --target lib/main.dart


################################################################################################
## ビルド
################################################################################################

# build APK dev
.PHONY: build-android-dev
build-android-dev:
	flutter build apk --dart-define=FLAVOR=$(DEV_FLAVOR) --target lib/main.dart

# build APK prod
.PHONY: build-android-prod
build-android-prod:
	flutter build apk --dart-define=FLAVOR=$(PROD_FLAVOR) --target lib/main.dart

# build IOS dev
.PHONY: build-ios-dev
build-ios-dev:
	flutter build ios --dart-define=FLAVOR=$(DEV_FLAVOR) --target lib/main.dart

# build IOS prod
.PHONY: build-ios-prod
build-ios-prod:
	flutter build ios --dart-define=FLAVOR=$(PROD_FLAVOR) --target lib/main.dart
