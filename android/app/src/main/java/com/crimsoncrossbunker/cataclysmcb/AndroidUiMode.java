package com.crimsoncrossbunker.cataclysmcb;

final class AndroidUiMode {
    private AndroidUiMode() {
    }

    static boolean isNewUiBuild() {
        return BuildConfig.CCB_NEW_UI;
    }
}
