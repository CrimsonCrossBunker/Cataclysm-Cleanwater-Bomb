package com.lyhglytx.cataclysmcb;

import org.libsdl.app.SDLActivity;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.graphics.drawable.GradientDrawable;
import android.graphics.Insets;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.SystemClock;
import android.os.Vibrator;
import android.preference.PreferenceManager;
import android.util.Log;
import android.net.Uri;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowInsets;
import android.view.WindowInsetsController;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.SeekBar;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Semaphore;

public class CataclysmDDA extends SDLActivity {
    private static final String TAG = "CDDA";
    private static final String EXTRA_BUTTON_PREFS = "extra_buttons";
    private static final String EXTRA_BUTTONS_KEY = "buttons";
    private static final float DEFAULT_BUTTON_TEXT_SIZE = 14f;
    private static final int DEFAULT_BUTTON_WIDTH_DP = 64;
    private static final int DEFAULT_BUTTON_HEIGHT_DP = 48;
    private static final int MIN_BUTTON_SIZE_DP = 32;
    private static final int MAX_BUTTON_SIZE_DP = 320;
    private static final int DEFAULT_BUTTON_TEXT_COLOR = 0xFFFFFFFF;
    private static final int DEFAULT_BUTTON_BG_COLOR = 0x00000000;
    private static final int[] BUTTON_PRESET_COLORS = {
        0x00000000,
        0xFFFFFFFF,
        0xFF000000,
        0xFF607D8B,
        0xFFF44336,
        0xFFE91E63,
        0xFF9C27B0,
        0xFF3F51B5,
        0xFF2196F3,
        0xFF00BCD4,
        0xFF4CAF50,
        0xFFFFEB3B,
        0xFFFF9800,
        0xFF795548,
        0xFF9E9E9E
    };
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
    private final Set<View> editorButtons = new HashSet<>();
    private final Set<View> playButtons = new HashSet<>();
    private final Semaphore buttonManageSemaphore = new Semaphore(0, true);
    private View buttonManageLayout;
    private FrameLayout buttonEditorContainer;
    private boolean deleteButtonMode = false;
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
            mLayout.setVisibility(View.INVISIBLE);
        }
        setImeInsetListener();
        applySystemUiMode();
        installHudOverlay();
    }

    @Override
    protected void onResume() {
        super.onResume();
        applySystemUiMode();
        if (hudOverlay != null) {
            hudOverlay.start();
        }
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

    private static native void nativeButtonClick(String text);
    private static native boolean nativeEnqueueHudAction(String actionId);
    private static native String nativeGetHudSnapshot();

    private void installHudOverlay() {
        if (mLayout == null || hudOverlay != null) {
            return;
        }
        hudOverlay = new AndroidHudOverlay(this);
        mLayout.addView(hudOverlay, new ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
    }

    boolean enqueueHudAction(String actionId) {
        try {
            return nativeEnqueueHudAction(actionId);
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

    /** Invoked by the C++ main-menu action; this does not block the game thread. */
    public void showAndroidHudManager() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                installHudOverlay();
                if (hudOverlay != null) {
                    hudOverlay.openSettings();
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
        if (json == null || json.isEmpty()) {
            toast("没有可导出的 HUD 布局");
            return;
        }
        pendingHudExportJson = json;
        Intent intent = new Intent(Intent.ACTION_CREATE_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("application/json");
        intent.putExtra(Intent.EXTRA_TITLE, "cataclysm-android-hud.json");
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
                if (hudOverlay != null) {
                    hudOverlay.importLayoutJson(readTextFromUri(uri));
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
                    installHudOverlay();
                    if (hudOverlay != null) {
                        hudOverlay.start();
                    }
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

    @Override
    public boolean dispatchKeyEvent(KeyEvent event) {
        if (event.getKeyCode() == KeyEvent.KEYCODE_BACK &&
                event.getAction() == KeyEvent.ACTION_DOWN &&
                buttonManageLayout != null) {
            showButtonManageMenu();
            return true;
        }
        return super.dispatchKeyEvent(event);
    }

    private void showButtonManageLayout() {
        if (buttonManageLayout != null) {
            return;
        }
        deleteButtonMode = false;
        buttonManageLayout = getLayoutInflater().inflate(R.layout.button_manage, null);
        buttonEditorContainer = buttonManageLayout.findViewById(R.id.container);
        addContentView(buttonManageLayout, new RelativeLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT));
        loadExtraButtons(true);
        toast("编辑模式：返回键打开管理菜单，拖动移动，长按编辑属性");
    }

    private void showButtonManageMenu() {
        String[] menuItems = {
            "新增按钮",
            deleteButtonMode ? "关闭删除模式" : "开启删除模式",
            "退出管理面板"
        };
        new AlertDialog.Builder(this)
            .setTitle("按键管理菜单")
            .setItems(menuItems, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    switch(which) {
                        case 0:
                            showNewButtonDialog();
                            break;
                        case 1:
                            deleteButtonMode = !deleteButtonMode;
                            toast(deleteButtonMode ? "删除模式：点击按钮即可删除" :
                                  "编辑模式：拖动移动，长按编辑属性");
                            break;
                        case 2:
                            showSaveDialog();
                            break;
                        default:
                            break;
                    }
                }
            })
            .show();
    }

    private void showNewButtonDialog() {
        final EditText input = new EditText(this);
        new AlertDialog.Builder(this)
            .setTitle("新建按钮")
            .setMessage("支持单个字符（含 emoji）、两个字符的“键盘”、三个字符的“tab”。")
            .setView(input)
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String text = input.getText().toString();
                    if (isValidButtonText(text)) {
                        createNewEditorButton(text);
                    } else {
                        showInvalidButtonDialog();
                    }
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private boolean isValidButtonText(String text) {
        if (text == null || text.isEmpty()) {
            return false;
        }
        int codePoints = text.codePointCount(0, text.length());
        return codePoints == 1 || "键盘".equals(text) || "tab".equals(text);
    }

    private void showInvalidButtonDialog() {
        new AlertDialog.Builder(this)
            .setTitle("无效的按钮文本")
            .setMessage("请输入单个字符、emoji、“tab”或“键盘”。")
            .setPositiveButton("确定", null)
            .show();
    }

    private void createNewEditorButton(String text) {
        final Button button = new Button(this);
        JSONObject data = createDefaultButtonData(text);
        float x = getWindow().getDecorView().getWidth() * 0.5f;
        float y = getWindow().getDecorView().getHeight() * 0.5f;
        try {
            data.put("x", x);
            data.put("y", y);
        } catch(JSONException e) {
            Log.e(TAG, "Failed to initialize extra button position", e);
        }
        button.setTag(data);
        button.setText(text);
        button.setLayoutParams(new FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT));
        button.setX(x);
        button.setY(y);
        applyButtonStyle(button, data);
        attachEditorButtonListener(button);
        editorButtons.add(button);
        buttonEditorContainer.addView(button);
    }

    private JSONObject createDefaultButtonData(String text) {
        JSONObject data = new JSONObject();
        try {
            data.put("text", text);
            data.put("textSize", DEFAULT_BUTTON_TEXT_SIZE);
            data.put("textColor", DEFAULT_BUTTON_TEXT_COLOR);
            data.put("bgColor", DEFAULT_BUTTON_BG_COLOR);
            data.put("rapidFire", false);
        } catch(JSONException e) {
            Log.e(TAG, "Failed to create extra button data", e);
        }
        return data;
    }

    private void applyButtonStyle(Button button, JSONObject data) {
        button.setAllCaps(false);
        button.setText(data.optString("text", button.getText().toString()));
        button.setTextSize((float)data.optDouble("textSize", DEFAULT_BUTTON_TEXT_SIZE));
        button.setTextColor(data.optInt("textColor", DEFAULT_BUTTON_TEXT_COLOR));
        button.setBackgroundColor(data.optInt("bgColor", DEFAULT_BUTTON_BG_COLOR));
        applyButtonSize(button, data);
    }

    private int dpToPx(int dp) {
        return Math.round(dp * getResources().getDisplayMetrics().density);
    }

    private int getButtonDimensionDp(Button button, boolean width) {
        int pixels = width ? button.getWidth() : button.getHeight();
        if (pixels <= 0 && button.getLayoutParams() != null) {
            int layoutSize = width ? button.getLayoutParams().width : button.getLayoutParams().height;
            if (layoutSize > 0) {
                pixels = layoutSize;
            }
        }
        int fallback = width ? DEFAULT_BUTTON_WIDTH_DP : DEFAULT_BUTTON_HEIGHT_DP;
        int dp = pixels > 0 ? Math.round(pixels / getResources().getDisplayMetrics().density) : fallback;
        return Math.max(MIN_BUTTON_SIZE_DP, Math.min(MAX_BUTTON_SIZE_DP, dp));
    }

    private void applyButtonSize(Button button, JSONObject data) {
        int widthDp = data.optInt("width", -1);
        int heightDp = data.optInt("height", -1);
        if (widthDp <= 0 && heightDp <= 0) {
            return;
        }
        ViewGroup.LayoutParams params = button.getLayoutParams();
        if (params == null) {
            params = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT);
        }
        params.width = widthDp > 0 ? dpToPx(widthDp) : ViewGroup.LayoutParams.WRAP_CONTENT;
        params.height = heightDp > 0 ? dpToPx(heightDp) : ViewGroup.LayoutParams.WRAP_CONTENT;
        button.setLayoutParams(params);
    }

    private void applyButtonSize(Button button, int widthDp, int heightDp) {
        ViewGroup.LayoutParams params = button.getLayoutParams();
        if (params == null) {
            params = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT);
        }
        params.width = dpToPx(widthDp);
        params.height = dpToPx(heightDp);
        button.setLayoutParams(params);
    }

    private void addButtonDimensionControl(LinearLayout layout, String label, final int[] value,
            final Button button, final int[] otherValue, final boolean width) {
        TextView dimensionLabel = new TextView(this);
        dimensionLabel.setText(label);
        layout.addView(dimensionLabel);

        LinearLayout dimensionRow = new LinearLayout(this);
        dimensionRow.setOrientation(LinearLayout.HORIZONTAL);
        dimensionRow.setGravity(Gravity.CENTER_VERTICAL);
        SeekBar dimensionSeekBar = new SeekBar(this);
        dimensionSeekBar.setMax(MAX_BUTTON_SIZE_DP - MIN_BUTTON_SIZE_DP);
        dimensionSeekBar.setProgress(value[0] - MIN_BUTTON_SIZE_DP);
        dimensionSeekBar.setLayoutParams(new LinearLayout.LayoutParams(
            0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f));
        final TextView dimensionValue = new TextView(this);
        dimensionValue.setText(String.valueOf(value[0]) + "dp");
        dimensionValue.setMinWidth(72);
        dimensionValue.setGravity(Gravity.CENTER);
        dimensionSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                value[0] = progress + MIN_BUTTON_SIZE_DP;
                dimensionValue.setText(String.valueOf(value[0]) + "dp");
                if (width) {
                    applyButtonSize(button, value[0], otherValue[0]);
                } else {
                    applyButtonSize(button, otherValue[0], value[0]);
                }
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });
        dimensionRow.addView(dimensionSeekBar);
        dimensionRow.addView(dimensionValue);
        layout.addView(dimensionRow);
    }

    @SuppressLint("ClickableViewAccessibility")
    private void attachEditorButtonListener(final Button button) {
        final int touchSlop = ViewConfiguration.get(this).getScaledTouchSlop();
        button.setOnTouchListener(new View.OnTouchListener() {
            float deltaX;
            float deltaY;
            float startRawX;
            float startRawY;
            boolean moved;
            boolean longPressed;
            final Handler handler = new Handler();
            final Runnable longPressRunnable = new Runnable() {
                @Override
                public void run() {
                    if (!moved && !deleteButtonMode) {
                        longPressed = true;
                        showButtonPropertiesDialog(button);
                    }
                }
            };

            @Override
            public boolean onTouch(View view, MotionEvent event) {
                switch(event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        if (deleteButtonMode) {
                            editorButtons.remove(button);
                            buttonEditorContainer.removeView(button);
                            return true;
                        }
                        moved = false;
                        longPressed = false;
                        startRawX = event.getRawX();
                        startRawY = event.getRawY();
                        deltaX = view.getX() - event.getRawX();
                        deltaY = view.getY() - event.getRawY();
                        handler.postDelayed(longPressRunnable, 500);
                        return true;
                    case MotionEvent.ACTION_MOVE:
                        if (longPressed) {
                            return true;
                        }
                        if (Math.abs(event.getRawX() - startRawX) > touchSlop ||
                                Math.abs(event.getRawY() - startRawY) > touchSlop) {
                            moved = true;
                            handler.removeCallbacks(longPressRunnable);
                        }
                        view.setX(event.getRawX() + deltaX);
                        view.setY(event.getRawY() + deltaY);
                        return true;
                    case MotionEvent.ACTION_UP:
                    case MotionEvent.ACTION_CANCEL:
                        handler.removeCallbacks(longPressRunnable);
                        return true;
                    default:
                        return false;
                }
            }
        });
    }

    private void showButtonPropertiesDialog(final Button button) {
        final JSONObject data = (JSONObject)button.getTag();
        if (data == null) {
            return;
        }
        final float[] textSize = { (float)data.optDouble("textSize", DEFAULT_BUTTON_TEXT_SIZE) };
        final int[] buttonWidth = { data.optInt("width", getButtonDimensionDp(button, true)) };
        final int[] buttonHeight = { data.optInt("height", getButtonDimensionDp(button, false)) };
        final int[] textColor = { data.optInt("textColor", DEFAULT_BUTTON_TEXT_COLOR) };
        final int[] bgColor = { data.optInt("bgColor", DEFAULT_BUTTON_BG_COLOR) };
        final boolean[] rapidFire = { data.optBoolean("rapidFire", false) };

        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        int padding = (int)(20 * getResources().getDisplayMetrics().density);
        layout.setPadding(padding, padding, padding, padding);

        TextView sizeLabel = new TextView(this);
        sizeLabel.setText("文字大小");
        layout.addView(sizeLabel);

        LinearLayout sizeRow = new LinearLayout(this);
        sizeRow.setOrientation(LinearLayout.HORIZONTAL);
        sizeRow.setGravity(Gravity.CENTER_VERTICAL);
        final SeekBar sizeSeekBar = new SeekBar(this);
        sizeSeekBar.setMax(40);
        sizeSeekBar.setProgress(Math.max(0, (int)textSize[0] - 8));
        sizeSeekBar.setLayoutParams(new LinearLayout.LayoutParams(
            0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f));
        final TextView sizeValue = new TextView(this);
        sizeValue.setText(String.valueOf((int)textSize[0]));
        sizeValue.setMinWidth(60);
        sizeValue.setGravity(Gravity.CENTER);
        sizeSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                textSize[0] = progress + 8;
                sizeValue.setText(String.valueOf(progress + 8));
                button.setTextSize(textSize[0]);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });
        sizeRow.addView(sizeSeekBar);
        sizeRow.addView(sizeValue);
        layout.addView(sizeRow);

        addButtonDimensionControl(layout, "按钮宽度", buttonWidth, button, buttonHeight, true);
        addButtonDimensionControl(layout, "按钮高度", buttonHeight, button, buttonWidth, false);

        TextView textColorLabel = new TextView(this);
        textColorLabel.setText("文字颜色");
        layout.addView(textColorLabel);
        layout.addView(createColorPicker(textColor[0], new ColorSelectedCallback() {
            @Override
            public void onColorSelected(int color) {
                textColor[0] = color;
                button.setTextColor(color);
            }
        }));

        TextView bgColorLabel = new TextView(this);
        bgColorLabel.setText("背景颜色");
        layout.addView(bgColorLabel);
        layout.addView(createColorPicker(bgColor[0], new ColorSelectedCallback() {
            @Override
            public void onColorSelected(int color) {
                bgColor[0] = color;
                button.setBackgroundColor(color);
            }
        }));

        final CheckBox rapidFireCheck = new CheckBox(this);
        rapidFireCheck.setText("连发模式（按住持续触发）");
        rapidFireCheck.setChecked(rapidFire[0]);
        rapidFireCheck.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                rapidFire[0] = isChecked;
            }
        });
        layout.addView(rapidFireCheck);

        ScrollView scrollView = new ScrollView(this);
        scrollView.setFillViewport(true);
        scrollView.addView(layout, new ScrollView.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT));

        new AlertDialog.Builder(this)
            .setTitle("按钮属性")
            .setView(scrollView)
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    try {
                        data.put("textSize", textSize[0]);
                        data.put("width", buttonWidth[0]);
                        data.put("height", buttonHeight[0]);
                        data.put("textColor", textColor[0]);
                        data.put("bgColor", bgColor[0]);
                        data.put("rapidFire", rapidFire[0]);
                    } catch(JSONException e) {
                        Log.e(TAG, "Failed to update extra button data", e);
                    }
                    applyButtonStyle(button, data);
                }
            })
            .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    applyButtonStyle(button, data);
                }
            })
            .show();
    }

    private interface ColorSelectedCallback {
        void onColorSelected(int color);
    }

    private HorizontalScrollView createColorPicker(int currentColor, final ColorSelectedCallback callback) {
        HorizontalScrollView scroll = new HorizontalScrollView(this);
        LinearLayout row = new LinearLayout(this);
        row.setOrientation(LinearLayout.HORIZONTAL);
        final View[] swatches = new View[BUTTON_PRESET_COLORS.length];
        final int[] selected = { -1 };
        int size = (int)(36 * getResources().getDisplayMetrics().density);
        int margin = (int)(4 * getResources().getDisplayMetrics().density);
        for (int i = 0; i < BUTTON_PRESET_COLORS.length; i++) {
            final int idx = i;
            final int color = BUTTON_PRESET_COLORS[i];
            final View swatch = new View(this);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(size, size);
            params.setMargins(margin, margin, margin, margin);
            swatch.setLayoutParams(params);
            swatch.setBackground(makeColorSwatch(color, color == currentColor));
            if (color == currentColor) {
                selected[0] = idx;
            }
            swatch.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (selected[0] >= 0) {
                        swatches[selected[0]].setBackground(makeColorSwatch(
                            BUTTON_PRESET_COLORS[selected[0]], false));
                    }
                    selected[0] = idx;
                    swatch.setBackground(makeColorSwatch(color, true));
                    callback.onColorSelected(color);
                }
            });
            swatches[i] = swatch;
            row.addView(swatch);
        }
        scroll.setBackgroundColor(0xFFEEEEEE);
        scroll.addView(row);
        return scroll;
    }

    private GradientDrawable makeColorSwatch(int color, boolean selected) {
        GradientDrawable drawable = new GradientDrawable();
        drawable.setColor(color);
        if (selected) {
            drawable.setStroke(4, 0xFF000000);
        }
        return drawable;
    }

    private void showSaveDialog() {
        new AlertDialog.Builder(this)
            .setTitle("是否保存")
            .setMessage("是否保存所有扩展按键？")
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    saveButtonsData();
                    closeButtonManageLayout();
                }
            })
            .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    closeButtonManageLayout();
                }
            })
            .show();
    }

    private void closeButtonManageLayout() {
        removeButtonManageLayout();
        editorButtons.clear();
        reloadPlayButtons();
        buttonManageSemaphore.release();
    }

    private void removeButtonManageLayout() {
        if (buttonManageLayout == null) {
            return;
        }
        ViewGroup parent = (ViewGroup)buttonManageLayout.getParent();
        if (parent != null) {
            parent.removeView(buttonManageLayout);
        }
        buttonManageLayout = null;
        buttonEditorContainer = null;
    }

    private void saveButtonsData() {
        SharedPreferences.Editor editor = getSharedPreferences(EXTRA_BUTTON_PREFS, MODE_PRIVATE).edit();
        JSONArray buttons = new JSONArray();
        for (View view : editorButtons) {
            if (!(view instanceof Button) || view.getTag() == null) {
                continue;
            }
            JSONObject data = (JSONObject)view.getTag();
            try {
                data.put("text", ((Button)view).getText().toString());
                data.put("x", view.getX());
                data.put("y", view.getY());
                buttons.put(data);
            } catch(JSONException e) {
                Log.e(TAG, "Failed to save extra button", e);
            }
        }
        editor.putString(EXTRA_BUTTONS_KEY, buttons.toString());
        editor.apply();
    }

    private void reloadPlayButtons() {
        removePlayButtons();
        loadExtraButtons(false);
    }

    private void removePlayButtons() {
        if (mLayout == null) {
            playButtons.clear();
            return;
        }
        for (View button : playButtons) {
            mLayout.removeView(button);
        }
        playButtons.clear();
    }

    private void loadExtraButtons(boolean editorMode) {
        SharedPreferences preferences = getSharedPreferences(EXTRA_BUTTON_PREFS, MODE_PRIVATE);
        String saved = null;
        try {
            saved = preferences.getString(EXTRA_BUTTONS_KEY, null);
        } catch(ClassCastException e) {
            Log.i(TAG, "Loading legacy extra button data");
        }
        if (saved != null && saved.startsWith("[")) {
            try {
                JSONArray buttons = new JSONArray(saved);
                for (int i = 0; i < buttons.length(); i++) {
                    createButtonFromData(buttons.getJSONObject(i), editorMode);
                }
                return;
            } catch(JSONException e) {
                Log.e(TAG, "Failed to load extra button JSON", e);
            }
        }

        Set<String> legacyButtons;
        try {
            legacyButtons = preferences.getStringSet(EXTRA_BUTTONS_KEY, null);
        } catch(ClassCastException e) {
            Log.e(TAG, "Extra button data has an unsupported format", e);
            return;
        }
        if (legacyButtons == null) {
            return;
        }
        for (String legacy : legacyButtons) {
            String[] parts = legacy.split("\\|");
            if (parts.length != 3) {
                continue;
            }
            JSONObject data = createDefaultButtonData(parts[0]);
            try {
                data.put("x", Float.parseFloat(parts[1]));
                data.put("y", Float.parseFloat(parts[2]));
            } catch(JSONException | NumberFormatException e) {
                Log.e(TAG, "Failed to load legacy extra button", e);
            }
            createButtonFromData(data, editorMode);
        }
    }

    @SuppressLint("ClickableViewAccessibility")
    private void createButtonFromData(JSONObject data, boolean editorMode) {
        final Button button = new Button(this);
        button.setTag(data);
        button.setText(data.optString("text", ""));
        button.setLayoutParams(new FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT));
        button.setX((float)data.optDouble("x", 0));
        button.setY((float)data.optDouble("y", 0));
        applyButtonStyle(button, data);

        if (editorMode) {
            attachEditorButtonListener(button);
            editorButtons.add(button);
            buttonEditorContainer.addView(button);
        } else if (mLayout != null) {
            attachPlayButtonListener(button, data.optBoolean("rapidFire", false));
            playButtons.add(button);
            mLayout.addView(button);
        }
    }

    @SuppressLint("ClickableViewAccessibility")
    private void attachPlayButtonListener(final Button button, final boolean rapidFire) {
        final Handler handler = new Handler();
        final Runnable[] rapidFireRunnable = new Runnable[1];
        final boolean[] firing = { false };
        button.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent event) {
                switch(event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        firing[0] = true;
                        performButtonClick(button);
                        if (rapidFire) {
                            rapidFireRunnable[0] = new Runnable() {
                                @Override
                                public void run() {
                                    if (firing[0]) {
                                        performButtonClick(button);
                                        handler.postDelayed(this, 80);
                                    }
                                }
                            };
                            handler.postDelayed(rapidFireRunnable[0], 200);
                        }
                        return true;
                    case MotionEvent.ACTION_UP:
                    case MotionEvent.ACTION_CANCEL:
                        firing[0] = false;
                        if (rapidFireRunnable[0] != null) {
                            handler.removeCallbacks(rapidFireRunnable[0]);
                            rapidFireRunnable[0] = null;
                        }
                        return true;
                    default:
                        return false;
                }
            }
        });
    }

    private void performButtonClick(Button button) {
        String text = button.getText().toString();
        if ("tab".equals(text)) {
            dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_TAB));
            dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_TAB));
        } else if ("键盘".equals(text)) {
            dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_BACK));
            dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_BACK));
        } else {
            nativeButtonClick(text);
        }
    }
}
