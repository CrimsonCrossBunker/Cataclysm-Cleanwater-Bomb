package com.crimsoncrossbunker.cataclysmcb;

import org.libsdl.app.SDLActivity;
import org.libsdl.app.CleanwaterDummyEdit;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.graphics.Insets;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import android.os.SystemClock;
import android.os.Vibrator;
import android.preference.PreferenceManager;
import android.util.Log;
import android.net.Uri;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowInsets;
import android.view.WindowInsetsController;
import android.view.WindowManager;
import android.widget.RelativeLayout;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

public class CataclysmDDA extends SDLActivity {
    private static final String TAG = "CDDA";
    public static final String PREF_SYSTEM_UI_MODE = "Android system UI mode";
    public static final String PREF_FORCE_FULLSCREEN = "Force fullscreen";
    public static final String SYSTEM_UI_MODE_SYSTEM_BARS = "system_bars";
    public static final String SYSTEM_UI_MODE_FULLSCREEN = "fullscreen";
    public static final String SYSTEM_UI_MODE_EDGE_TO_EDGE = "edge_to_edge";
    private static final int REQUEST_IMPORT_HUD_LAYOUT = 4101;
    private static final int REQUEST_EXPORT_HUD_LAYOUT = 4102;

    private NativeUI nativeUI = new NativeUI(CataclysmDDA.this);
    private int lastImeLeft = -1;
    private int lastImeTop = -1;
    private int lastImeRight = -1;
    private int lastImeBottom = -1;
    private boolean lastImeVisible = false;
    private AndroidHudOverlay hudOverlay;
    private String pendingHudExportJson;

    // libmain.so must load first so cata_allocator binds before SDL's malloc.
    // SDL3 dlsym's SDL_main from getMainSharedObject(), which we point at libmain.so.
    @Override
    protected String[] getLibraries() {
        return new String[] {
            "main",
            "SDL3",
            "SDL3_image",
            "SDL3_mixer",
            "SDL3_ttf",
        };
    }

    @Override
    protected String getMainSharedObject() {
        return getApplicationInfo().nativeLibraryDir + "/libmain.so";
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (mLayout != null) {
            mTextEdit = new CleanwaterDummyEdit(this);
            mLayout.addView(mTextEdit, new RelativeLayout.LayoutParams(0, 0));
            mLayout.setVisibility(View.INVISIBLE);
        }
        setImeInsetListener();
        applySystemUiMode();
        installAndroidHudOverlay();
    }

    @Override
    protected void onResume() {
        super.onResume();
        applySystemUiMode();
        if (hudOverlay != null) {
            hudOverlay.start();
        }
        requestDisplayRefresh();
    }

    @Override
    protected void onPause() {
        if (hudOverlay != null) {
            hudOverlay.stop();
        }
        super.onPause();
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) {
            applySystemUiMode();
            requestDisplayRefresh();
        }
    }

    private String normalizeSystemUiMode(String mode) {
        if (SYSTEM_UI_MODE_FULLSCREEN.equals(mode) || SYSTEM_UI_MODE_EDGE_TO_EDGE.equals(mode)) {
            return mode;
        }
        return SYSTEM_UI_MODE_SYSTEM_BARS;
    }

    private String getStoredSystemUiMode() {
        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        String mode;
        if (preferences.contains(PREF_SYSTEM_UI_MODE)) {
            mode = normalizeSystemUiMode(preferences.getString(PREF_SYSTEM_UI_MODE, SYSTEM_UI_MODE_SYSTEM_BARS));
        } else {
            mode = preferences.getBoolean(PREF_FORCE_FULLSCREEN, false)
                ? SYSTEM_UI_MODE_EDGE_TO_EDGE
                : SYSTEM_UI_MODE_SYSTEM_BARS;
        }
        preferences.edit().putString(PREF_SYSTEM_UI_MODE, mode).apply();
        return mode;
    }

    private void applySystemUiMode() {
        applySystemUiMode(getStoredSystemUiMode());
    }

    private void applySystemUiMode(String rawMode) {
        String mode = normalizeSystemUiMode(rawMode);
        boolean hideSystemBars = !SYSTEM_UI_MODE_SYSTEM_BARS.equals(mode);
        boolean edgeToEdge = SYSTEM_UI_MODE_EDGE_TO_EDGE.equals(mode);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            getWindow().setDecorFitsSystemWindows(!edgeToEdge);
            WindowInsetsController controller = getWindow().getInsetsController();
            if (controller != null) {
                if (hideSystemBars) {
                    controller.hide(WindowInsets.Type.systemBars());
                    controller.setSystemBarsBehavior(
                        WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE);
                } else {
                    controller.show(WindowInsets.Type.systemBars());
                }
            }
        } else {
            View decor = getWindow().getDecorView();
            if (hideSystemBars) {
                decor.setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                    | View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                    | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                    | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                    | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                    | View.SYSTEM_UI_FLAG_FULLSCREEN);
            } else {
                decor.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
            }
        }

        if (hideSystemBars) {
            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN);
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
        } else {
            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN);
        }
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }

    private void setImeInsetListener() {
        final View decor = getWindow().getDecorView();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            decor.setOnApplyWindowInsetsListener(new View.OnApplyWindowInsetsListener() {
                @Override
                public WindowInsets onApplyWindowInsets(View view, WindowInsets insets) {
                    boolean imeVisible = insets.isVisible(WindowInsets.Type.ime());
                    Insets imeInsets = insets.getInsets(WindowInsets.Type.ime());
                    notifyImeInsetsChanged(
                        imeInsets.left,
                        imeInsets.top,
                        Math.max(0, view.getWidth() - imeInsets.right),
                        Math.max(0, view.getHeight() - imeInsets.bottom),
                        imeVisible);
                    return insets;
                }
            });
            decor.requestApplyInsets();
        } else {
            decor.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
                @Override
                public void onGlobalLayout() {
                    Rect visibleFrame = new Rect();
                    decor.getWindowVisibleDisplayFrame(visibleFrame);
                    int rootHeight = decor.getRootView().getHeight();
                    boolean imeVisible = rootHeight - visibleFrame.bottom > rootHeight / 5;
                    notifyImeInsetsChanged(
                        visibleFrame.left,
                        visibleFrame.top,
                        visibleFrame.right,
                        visibleFrame.bottom,
                        imeVisible);
                }
            });
        }
    }

    private void notifyImeInsetsChanged(int left, int top, int right, int bottom, boolean visible) {
        if (lastImeLeft == left && lastImeTop == top && lastImeRight == right &&
                lastImeBottom == bottom && lastImeVisible == visible) {
            return;
        }
        lastImeLeft = left;
        lastImeTop = top;
        lastImeRight = right;
        lastImeBottom = bottom;
        lastImeVisible = visible;
        try {
            onNativeImeInsetsChanged(left, top, right, bottom, visible);
        } catch(UnsatisfiedLinkError e) {
            // The Activity can receive early inset callbacks before native startup.
        }
    }

    private static native void onNativeImeInsetsChanged(
        int left, int top, int right, int bottom, boolean visible);

    private static native boolean nativeEnqueueHudAction(String actionId, int contextRevision,
        boolean dangerousAuthorized);
    private static native String nativeGetHudSnapshot();
    private static native void nativeSetHudMinimapRect(int x, int y, int width, int height,
        int viewportWidth, int viewportHeight, boolean visible);
    private static native void nativeSetHudSubscriptions(String encodedSources);
    private static native void nativeRequestDisplayRefresh();

    private void requestDisplayRefresh() {
        try {
            nativeRequestDisplayRefresh();
        } catch (UnsatisfiedLinkError ignored) {
            // Activity callbacks can run before libmain has finished loading.
        }
    }

    private void installAndroidHudOverlay() {
        if (mLayout == null || hudOverlay != null) {
            return;
        }
        hudOverlay = new AndroidHudOverlay(this);
        mLayout.addView(hudOverlay, new ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
    }

    boolean enqueueHudAction(String actionId, int contextRevision,
            boolean dangerousAuthorized) {
        try {
            return nativeEnqueueHudAction(actionId, contextRevision, dangerousAuthorized);
        } catch (UnsatisfiedLinkError e) {
            return false;
        }
    }

    String getHudSnapshot() {
        try {
            return nativeGetHudSnapshot();
        } catch (UnsatisfiedLinkError e) {
            return "";
        }
    }

    void setHudMinimapRect(int x, int y, int width, int height,
            int viewportWidth, int viewportHeight, boolean visible) {
        try {
            nativeSetHudMinimapRect(x, y, width, height,
                viewportWidth, viewportHeight, visible);
        } catch (UnsatisfiedLinkError ignored) {
        }
    }

    void setHudSubscriptions(String encodedSources) {
        try {
            nativeSetHudSubscriptions(encodedSources == null ? "" : encodedSources);
            requestDisplayRefresh();
        } catch (UnsatisfiedLinkError ignored) {
        }
    }

    /** Invoked by the C++ main-menu action; this does not block the game thread. */
    public void showAndroidHudManager() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                installAndroidHudOverlay();
                if (hudOverlay != null) {
                    hudOverlay.showManager();
                }
            }
        });
    }

    void importHudLayout() {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("application/json");
        startActivityForResult(intent, REQUEST_IMPORT_HUD_LAYOUT);
    }

    void exportHudLayout(String json) {
        exportHudLayout(json, "cataclysm-android-hud-package.json");
    }

    void exportHudLayout(String json, String fileName) {
        if (json == null || json.isEmpty()) {
            toast("没有可导出的 HUD 布局");
            return;
        }
        pendingHudExportJson = json;
        Intent intent = new Intent(Intent.ACTION_CREATE_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("application/json");
        intent.putExtra(Intent.EXTRA_TITLE, fileName);
        startActivityForResult(intent, REQUEST_EXPORT_HUD_LAYOUT);
    }

    void shareHudLayout(String json) {
        if (json == null || json.isEmpty()) {
            toast("没有可分享的 HUD 布局");
            return;
        }
        Intent intent = new Intent(Intent.ACTION_SEND);
        intent.setType("application/json");
        intent.putExtra(Intent.EXTRA_TEXT, json);
        startActivity(Intent.createChooser(intent, "分享 HUD 布局"));
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null || data.getData() == null) {
            return;
        }
        Uri uri = data.getData();
        if (requestCode == REQUEST_IMPORT_HUD_LAYOUT) {
            try {
                installAndroidHudOverlay();
                if (hudOverlay != null) {
                    hudOverlay.importPackage(readTextFromUri(uri));
                }
            } catch (IOException e) {
                Log.w(TAG, "Could not import HUD layout", e);
                toast("读取 HUD 布局失败");
            }
        } else if (requestCode == REQUEST_EXPORT_HUD_LAYOUT) {
            try {
                writeTextToUri(uri, pendingHudExportJson == null ? "" : pendingHudExportJson);
                toast("HUD 布局已导出");
            } catch (IOException e) {
                Log.w(TAG, "Could not export HUD layout", e);
                toast("导出 HUD 布局失败");
            } finally {
                pendingHudExportJson = null;
            }
        }
    }

    private String readTextFromUri(Uri uri) throws IOException {
        StringBuilder content = new StringBuilder();
        InputStream stream = getContentResolver().openInputStream(uri);
        if (stream == null) {
            throw new IOException("Unable to open input URI");
        }
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(stream, "UTF-8"));
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append('\n');
            }
            reader.close();
        } finally {
            stream.close();
        }
        return content.toString();
    }

    private void writeTextToUri(Uri uri, String text) throws IOException {
        OutputStream stream = getContentResolver().openOutputStream(uri);
        if (stream == null) {
            throw new IOException("Unable to open output URI");
        }
        try {
            stream.write(text.getBytes("UTF-8"));
        } finally {
            stream.close();
        }
    }

    public void setSystemUiMode(final String mode) {
        final String normalizedMode = normalizeSystemUiMode(mode);
        PreferenceManager.getDefaultSharedPreferences(getApplicationContext())
            .edit()
            .putString(PREF_SYSTEM_UI_MODE, normalizedMode)
            .apply();
        try {
            runOnUiThread(new Runnable() {
                public void run() {
                    applySystemUiMode(normalizedMode);
                }
            });
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void vibrate(int duration) {
        try {
            Vibrator v = (Vibrator)getSystemService(Context.VIBRATOR_SERVICE);
            v.vibrate(duration);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void toast(final String message) {
        try {
            runOnUiThread(new Runnable() {
                public void run() {
                    Toast.makeText(getApplicationContext(), message, Toast.LENGTH_SHORT).show();
                }
            });
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
    }

    private boolean isHardwareKeyboardAvailable() {
        return getResources().getConfiguration().keyboard == Configuration.KEYBOARD_QWERTY;
    }

    private float getDisplayDensity() {
        return getResources().getDisplayMetrics().density;
    }

    public void show_sdl_surface() {
        try {
            runOnUiThread(new Runnable() {
                public void run() {
                    if (mLayout != null) {
                        mLayout.setVisibility(View.VISIBLE);
                    }
                    installAndroidHudOverlay();
                    if (hudOverlay != null) {
                        hudOverlay.start();
                    }
                    requestDisplayRefresh();
                }
            });
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public boolean getDefaultSetting(final String settingsName, boolean defaultValue) {
        return PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getBoolean(settingsName, defaultValue);
    }

    public String getDefaultStringSetting(final String settingsName, String defaultValue) {
        if (PREF_SYSTEM_UI_MODE.equals(settingsName)) {
            return getStoredSystemUiMode();
        }
        String setting = PreferenceManager.getDefaultSharedPreferences(getApplicationContext())
            .getString(settingsName, defaultValue);
        return setting != null ? setting : defaultValue;
    }

    public String getSystemLang() {
        return getResources().getConfiguration().locale.toLanguageTag().replace('-', '_');
    }

    public NativeUI getNativeUI() {
        return nativeUI;
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        if (hudOverlay != null) {
            hudOverlay.observeGlobalTouchEvent(event);
        }
        return super.dispatchTouchEvent(event);
    }

    /** Cancel SDL's pending touch when a blank long-press becomes HUD editing. */
    void cancelActiveGameTouch() {
        if (mLayout == null) {
            return;
        }
        long now = SystemClock.uptimeMillis();
        MotionEvent cancel = MotionEvent.obtain(now, now, MotionEvent.ACTION_CANCEL, 0f, 0f, 0);
        try {
            mLayout.dispatchTouchEvent(cancel);
        } finally {
            cancel.recycle();
        }
    }

    /**
     * Legacy entry point retained for external callers.  Extra key-mapped
     * buttons have been replaced by the direct-action HUD manager.
     */
    public void showButtonManage() {
        showAndroidHudManager();
    }
}
