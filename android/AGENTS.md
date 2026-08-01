# `android/` agent instructions

- This subtree owns the Gradle application, Java UI, packaging, and Android
  native integration.
- Preserve desktop/Android behavioural boundaries and the native Android HUD
  contract.
- Do not commit SDK paths, signing material, APKs, or local Gradle state.
- Run the narrowest Gradle task first; APK assembly requires a configured SDK.

```sh
cd android
./gradlew test
./gradlew assembleDebug
```

不得提交本机 SDK、签名材料或生成的 APK；平台行为变化必须说明桌面端影响。
