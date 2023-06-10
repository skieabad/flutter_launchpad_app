echo 'Start building'

clear
flutter clean
flutter pub get
flutter build apk --release

echo 'Done building'