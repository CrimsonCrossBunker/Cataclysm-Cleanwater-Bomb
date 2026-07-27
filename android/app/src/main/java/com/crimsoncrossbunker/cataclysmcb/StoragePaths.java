package com.crimsoncrossbunker.cataclysmcb;

import android.content.Context;
import android.os.Environment;
import android.preference.PreferenceManager;

import java.io.File;

final class StoragePaths {
    static final String PREF_USE_LEGACY_STORAGE = "Use Legacy Storage";
    private static final String PUBLIC_USER_DIRECTORY = "cataclysm-ccb";

    private StoragePaths() {
    }

    static boolean useLegacyStorage(Context context) {
        return PreferenceManager.getDefaultSharedPreferences(context.getApplicationContext())
            .getBoolean(PREF_USE_LEGACY_STORAGE, false);
    }

    static File getUserDirectory(Context context) {
        if (useLegacyStorage(context)) {
            return context.getExternalFilesDir(null);
        }
        return new File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOCUMENTS),
            PUBLIC_USER_DIRECTORY
        );
    }
}
