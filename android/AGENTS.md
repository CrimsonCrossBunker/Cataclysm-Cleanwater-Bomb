# `android/` agent instructions

- Owns the Gradle app, Java UI, packaging, and Android native integration.
- Preserve desktop/Android behavioral boundaries and the native Android HUD contract.
- Never commit SDK paths, signing material, generated APKs, or local Gradle state.
- Run Gradle builds/tests only when explicitly requested.
