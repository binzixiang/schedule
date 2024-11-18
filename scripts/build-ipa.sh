# 构建未签名的IPA

cd "$( cd "$( dirname "$0"  )" && pwd  )/.."

# flutter pub get
# flutter build ios --release --no-codesign

cd build/ios/archive/Runner.xcarchive/Products/Applications
mkdir -p Payload
mv Runner.app Payload

# sh ../../../scripts/thin-payload.sh
zip -9 release-ios.ipa -r Payload