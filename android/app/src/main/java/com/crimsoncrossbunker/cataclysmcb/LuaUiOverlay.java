package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.os.Handler;
import android.text.InputType;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

/**
 * Retained native-View adapter for Lua UI.  C++ publishes an immutable widget
 * tree from the game thread; this class diffs stable ids on the Android UI
 * thread and sends bounded one-shot interaction values back through JNI.
 */
final class LuaUiOverlay extends FrameLayout {
    private static final String TAG = "LuaUiOverlay";
    private static final long POLL_INTERVAL_MS = 100L;
    private static final long EDIT_LONG_PRESS_MS = 650L;
    private static final String PREFS_NAME = "lua_ui_hud";
    private static final String PREF_LAYOUTS = "hud_layouts_v1";

    private final CataclysmDDA activity;
    private final SharedPreferences preferences;
    private final Handler handler = new Handler();
    private final Map<String, SurfaceHolder> surfaces = new HashMap<>();
    private final Map<String, View> widgets = new HashMap<>();
    private final Map<String, HudLayout> hudLayouts = new HashMap<>();
    private final LinkedHashMap<String, HudInfo> hudInfos = new LinkedHashMap<>();
    private final Button pageChooser;
    private final LinearLayout hudEditorBar;
    private FrameLayout radialMenuLayer;
    private final Runnable poller = new Runnable() {
        @Override
        public void run() {
            refresh();
            if (started) {
                handler.postDelayed(this, POLL_INTERVAL_MS);
            }
        }
    };

    private boolean started;
    private boolean editing;
    private String lastSnapshot = "";
    private final List<PageInfo> pages = new ArrayList<>();

    LuaUiOverlay(CataclysmDDA activity) {
        super(activity);
        this.activity = activity;
        preferences = activity.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        loadHudLayouts();
        setClipChildren(false);
        setClipToPadding(false);
        setClickable(false);

        pageChooser = new Button(activity);
        pageChooser.setText("Lua");
        pageChooser.setTextSize(12f);
        pageChooser.setMinWidth(0);
        pageChooser.setMinHeight(0);
        pageChooser.setPadding(dp(10), dp(4), dp(10), dp(4));
        pageChooser.setVisibility(GONE);
        pageChooser.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                showPageChooser();
            }
        });
        FrameLayout.LayoutParams chooserParams = new FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT,
            Gravity.TOP | Gravity.RIGHT);
        chooserParams.setMargins(dp(8), dp(8), dp(8), dp(8));
        addView(pageChooser, chooserParams);

        hudEditorBar = new LinearLayout(activity);
        hudEditorBar.setOrientation(LinearLayout.HORIZONTAL);
        hudEditorBar.setPadding(dp(4), dp(2), dp(4), dp(2));
        hudEditorBar.setBackground(panelBackground(true));
        hudEditorBar.setVisibility(GONE);

        Button resetHudLayout = new Button(activity);
        resetHudLayout.setText("恢复默认");
        resetHudLayout.setMinWidth(0);
        resetHudLayout.setMinHeight(0);
        resetHudLayout.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                resetCurrentOrientationLayouts();
            }
        });
        hudEditorBar.addView(resetHudLayout);

        Button finishHudEditing = new Button(activity);
        finishHudEditing.setText("完成");
        finishHudEditing.setMinWidth(0);
        finishHudEditing.setMinHeight(0);
        finishHudEditing.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                setHudEditing(false);
            }
        });
        hudEditorBar.addView(finishHudEditing);

        FrameLayout.LayoutParams editorParams = new FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT,
            Gravity.TOP | Gravity.CENTER_HORIZONTAL);
        editorParams.setMargins(dp(8), dp(8), dp(8), dp(8));
        addView(hudEditorBar, editorParams);
    }

    void start() {
        if (started) return;
        started = true;
        handler.post(poller);
    }

    void stop() {
        started = false;
        handler.removeCallbacks(poller);
        dismissRadialMenu();
    }

    void setHudEditing(boolean value) {
        if (editing == value) return;
        if (value) dismissRadialMenu();
        editing = value;
        for (SurfaceHolder holder : surfaces.values()) {
            configureHudEditor(holder);
        }
        hudEditorBar.setVisibility(editing ? VISIBLE : GONE);
        pageChooser.setVisibility(editing || pages.isEmpty() ? GONE : VISIBLE);
        if (editing) hudEditorBar.bringToFront();
        forceRefresh();
    }

    void showHudManager() {
        final List<HudInfo> toggleable = new ArrayList<>();
        for (HudInfo info : hudInfos.values()) {
            if (info.userToggleable) toggleable.add(info);
        }
        if (toggleable.isEmpty()) {
            Toast.makeText(activity, "当前没有可管理的 Lua HUD", Toast.LENGTH_SHORT).show();
            return;
        }
        String[] labels = new String[toggleable.size()];
        final boolean[] visible = new boolean[toggleable.size()];
        for (int i = 0; i < toggleable.size(); i++) {
            HudInfo info = toggleable.get(i);
            labels[i] = info.title;
            HudLayout layout = hudLayouts.get(layoutKey(info.id));
            visible[i] = layout == null || layout.visible;
        }
        new AlertDialog.Builder(activity)
            .setTitle("Lua HUD")
            .setMultiChoiceItems(labels, visible, new DialogInterface.OnMultiChoiceClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which, boolean checked) {
                    visible[which] = checked;
                }
            })
            .setPositiveButton("保存", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    applyHudVisibility(toggleable, visible);
                }
            })
            .setNeutralButton("编辑布局", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    applyHudVisibility(toggleable, visible);
                    setHudEditing(true);
                    Toast.makeText(activity,
                        "拖动 HUD 调整位置，拖动右下角调整大小，长按打开详细设置",
                        Toast.LENGTH_LONG).show();
                }
            })
            .setNegativeButton("关闭", null)
            .show();
    }

    private void applyHudVisibility(List<HudInfo> infos, boolean[] visible) {
        for (int i = 0; i < infos.size(); i++) {
            HudLayout layout = getOrCreateLayout(infos.get(i));
            layout.visible = visible[i];
        }
        saveHudLayouts();
        forceRefresh();
    }

    boolean containsTouch(float rawX, float rawY) {
        if (radialMenuLayer != null) return true;
        int[] location = new int[2];
        if (pageChooser.getVisibility() == VISIBLE) {
            pageChooser.getLocationOnScreen(location);
            if (rawX >= location[0] && rawX <= location[0] + pageChooser.getWidth() &&
                    rawY >= location[1] && rawY <= location[1] + pageChooser.getHeight()) return true;
        }
        for (SurfaceHolder holder : surfaces.values()) {
            holder.root.getLocationOnScreen(location);
            if (rawX >= location[0] && rawX <= location[0] + holder.root.getWidth() &&
                    rawY >= location[1] && rawY <= location[1] + holder.root.getHeight()) return true;
        }
        return false;
    }

    @Override
    protected void onSizeChanged(int width, int height, int oldWidth, int oldHeight) {
        super.onSizeChanged(width, height, oldWidth, oldHeight);
        // Re-apply fractional/anchor positioning after rotation or split-screen resize.
        lastSnapshot = "";
        if (started) {
            handler.removeCallbacks(poller);
            handler.post(poller);
        }
    }

    private void refresh() {
        String raw = activity.getLuaUiSnapshot();
        if (raw == null || raw.isEmpty() || raw.equals(lastSnapshot)) return;
        try {
            JSONObject snapshot = new JSONObject(raw);
            if (snapshot.optInt("schema", 0) != 1) return;
            applySnapshot(snapshot);
            lastSnapshot = raw;
        } catch (JSONException e) {
            Log.w(TAG, "Rejected Lua UI snapshot", e);
        }
    }

    private void applySnapshot(JSONObject snapshot) throws JSONException {
        JSONArray entries = snapshot.optJSONArray("surfaces");
        if (entries == null) entries = new JSONArray();
        String selectedPage = snapshot.optString("selectedPage", "");
        Set<String> seenSurfaces = new HashSet<>();
        Set<String> seenWidgets = new HashSet<>();
        pages.clear();
        hudInfos.clear();

        for (int i = 0; i < entries.length(); i++) {
            JSONObject entry = entries.optJSONObject(i);
            if (entry == null) continue;
            String id = entry.optString("id", "");
            String kind = entry.optString("kind", "");
            if (id.isEmpty()) continue;
            if ("page".equals(kind)) {
                pages.add(new PageInfo(id.substring("page:".length()),
                    entry.optString("title", id)));
                if (editing || !id.equals("page:" + selectedPage)) continue;
            } else if ("hud".equals(kind)) {
                HudInfo info = HudInfo.fromJson(entry);
                hudInfos.put(id, info);
                HudLayout layout = hudLayouts.get(layoutKey(id));
                if (info.userToggleable && layout != null && !layout.visible) continue;
            }
            seenSurfaces.add(id);
            SurfaceHolder holder = obtainSurface(id, kind);
            if ("hud".equals(kind)) holder.info = hudInfos.get(id);
            holder.title.setText(entry.optString("title", id));
            holder.content.removeAllViews();
            JSONArray nodes = entry.optJSONArray("nodes");
            if (nodes != null) {
                renderNodes(holder.content, nodes, id, seenWidgets);
            }
            positionSurface(holder, entry, kind);
            configureHudEditor(holder);
        }

        for (String id : new ArrayList<>(surfaces.keySet())) {
            if (!seenSurfaces.contains(id)) {
                SurfaceHolder removed = surfaces.remove(id);
                removeView(removed.root);
            }
        }
        for (String id : new ArrayList<>(widgets.keySet())) {
            if (!seenWidgets.contains(id)) widgets.remove(id);
        }
        pageChooser.setVisibility(editing || pages.isEmpty() ? GONE : VISIBLE);
        pageChooser.bringToFront();
        hudEditorBar.setVisibility(editing ? VISIBLE : GONE);
        if (editing) hudEditorBar.bringToFront();
    }

    private SurfaceHolder obtainSurface(final String id, String kind) {
        SurfaceHolder existing = surfaces.get(id);
        if (existing != null) return existing;

        SurfacePanel panel = new SurfacePanel(activity);
        panel.setOrientation(LinearLayout.VERTICAL);
        panel.setPadding(dp(10), dp(8), dp(10), dp(8));
        panel.setBackground(panelBackground(false));
        panel.setClickable(true);

        LinearLayout titleRow = new LinearLayout(activity);
        titleRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView title = new TextView(activity);
        title.setTextColor(Color.WHITE);
        title.setTypeface(Typeface.DEFAULT, Typeface.BOLD);
        titleRow.addView(title, new LinearLayout.LayoutParams(0,
            ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        if ("page".equals(kind)) {
            Button close = new Button(activity);
            close.setText("×");
            close.setMinWidth(0);
            close.setMinHeight(0);
            close.setOnClickListener(new OnClickListener() {
                @Override
                public void onClick(View view) {
                    activity.selectLuaUiPage("");
                }
            });
            titleRow.addView(close, new LinearLayout.LayoutParams(dp(44), dp(40)));
        }
        panel.addView(titleRow);

        LinearLayout content = new LinearLayout(activity);
        content.setOrientation(LinearLayout.VERTICAL);
        ScrollView scroll = new ScrollView(activity);
        scroll.setFillViewport(true);
        scroll.addView(content, new ScrollView.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        panel.addView(scroll, new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, 0, 1f));

        SurfaceHolder created = new SurfaceHolder(id, kind, panel, titleRow, title, content);
        surfaces.put(id, created);
        addView(panel);
        return created;
    }

    private void positionSurface(SurfaceHolder holder, JSONObject entry, String kind) {
        if ("page".equals(kind)) {
            FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
                Math.max(dp(280), Math.round(getWidth() * .88f)),
                Math.max(dp(240), Math.round(getHeight() * .82f)), Gravity.CENTER);
            holder.root.setLayoutParams(params);
            holder.root.setAlpha(1f);
            holder.root.bringToFront();
            pageChooser.bringToFront();
            return;
        }
        HudLayout saved = hudLayouts.get(layoutKey(holder.id));
        if (saved != null) {
            positionHudLayout(holder, saved);
            return;
        }
        HudInfo info = holder.info != null ? holder.info : HudInfo.fromJson(entry);
        positionHudLayout(holder, defaultLayout(info));
    }

    private void positionHudLayout(final SurfaceHolder holder, HudLayout layout) {
        if (getWidth() <= 0 || getHeight() <= 0) {
            holder.root.post(new Runnable() {
                @Override
                public void run() {
                    forceRefresh();
                }
            });
            return;
        }
        int width = Math.max(dp(120), Math.round(clamp(layout.width, .10f, .90f) * getWidth()));
        // Native radial controls are 80dp tall.  Include the panel's vertical
        // padding in the minimum so a compact one-control HUD never becomes a
        // clipped ScrollView that has to be dragged to reveal the other half.
        int height = Math.max(dp(96), Math.round(clamp(layout.height, .08f, .90f) * getHeight()));
        int left = Math.round(clamp(layout.x, 0f, 1f) * getWidth());
        int top = Math.round(clamp(layout.y, 0f, 1f) * getHeight());
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(width, height,
            Gravity.TOP | Gravity.LEFT);
        params.leftMargin = Math.max(0, Math.min(left, Math.max(0, getWidth() - width)));
        params.topMargin = Math.max(0, Math.min(top, Math.max(0, getHeight() - height)));
        holder.root.setLayoutParams(params);
        holder.root.setAlpha(clamp(layout.opacity, .20f, 1f));
    }

    private HudLayout defaultLayout(HudInfo info) {
        HudLayout layout = new HudLayout();
        layout.width = clamp(info.defaultWidth, .10f, .90f);
        layout.height = clamp(info.defaultHeight, .08f, .90f);
        float xOffset = dp(Math.round(info.offsetX)) / Math.max(1f, getWidth());
        float yOffset = dp(Math.round(info.offsetY)) / Math.max(1f, getHeight());
        layout.x = info.anchor.contains("right") ? 1f - layout.width - xOffset : xOffset;
        layout.y = info.anchor.contains("bottom") ? 1f - layout.height - yOffset : yOffset;
        layout.x = clamp(layout.x, 0f, 1f - layout.width);
        layout.y = clamp(layout.y, 0f, 1f - layout.height);
        layout.opacity = clamp(info.alpha, .20f, 1f);
        layout.visible = true;
        return layout;
    }

    private HudLayout getOrCreateLayout(HudInfo info) {
        String key = layoutKey(info.id);
        HudLayout layout = hudLayouts.get(key);
        if (layout == null) {
            SurfaceHolder holder = surfaces.get(info.id);
            if (holder != null && holder.root.getWidth() > 0 && getWidth() > 0 && getHeight() > 0) {
                layout = new HudLayout();
                FrameLayout.LayoutParams params = (FrameLayout.LayoutParams) holder.root.getLayoutParams();
                layout.x = params.leftMargin / (float)getWidth();
                layout.y = params.topMargin / (float)getHeight();
                layout.width = holder.root.getWidth() / (float)getWidth();
                layout.height = holder.root.getHeight() / (float)getHeight();
                layout.opacity = holder.root.getAlpha();
                layout.visible = true;
            } else {
                layout = defaultLayout(info);
            }
            hudLayouts.put(key, layout);
        }
        return layout;
    }

    private void configureHudEditor(final SurfaceHolder holder) {
        if (!"hud".equals(holder.kind)) return;
        boolean editable = editing && holder.info != null;
        holder.root.setEditing(editable);
        boolean showBackground = editable || holder.info == null || holder.info.background;
        holder.root.setBackground(showBackground ? panelBackground(editable) : null);
        boolean showTitle = holder.info == null || editable || holder.info.titleBar;
        holder.titleRow.setVisibility(showTitle ? VISIBLE : GONE);
        holder.root.setClickable(editable || (holder.info != null && holder.info.interactive));
        if (editable && holder.editorTouch == null) {
            holder.editorTouch = new HudEditorTouchListener(holder);
        }
        holder.root.setOnTouchListener(editable ? holder.editorTouch : null);
    }

    private void showHudStyleEditor(final SurfaceHolder holder) {
        if (holder.info == null) return;
        final HudLayout layout = getOrCreateLayout(holder.info);
        LinearLayout controls = new LinearLayout(activity);
        controls.setOrientation(LinearLayout.VERTICAL);
        int padding = dp(18);
        controls.setPadding(padding, padding, padding, padding);
        final float[] values = { layout.width, layout.height, layout.opacity };
        if (holder.info.scalable) {
            addSlider(controls, "宽度", 10, 90, Math.round(values[0] * 100),
                new SliderCallback() {
                    @Override public void onChanged(int value) { values[0] = value / 100f; }
                });
            addSlider(controls, "高度", 8, 90, Math.round(values[1] * 100),
                new SliderCallback() {
                    @Override public void onChanged(int value) { values[1] = value / 100f; }
                });
        }
        addSlider(controls, "不透明度", 20, 100, Math.round(values[2] * 100),
            new SliderCallback() {
                @Override public void onChanged(int value) { values[2] = value / 100f; }
            });
        final CheckBox visible = new CheckBox(activity);
        visible.setText("显示此 HUD");
        visible.setChecked(layout.visible);
        visible.setEnabled(holder.info.userToggleable);
        controls.addView(visible);

        new AlertDialog.Builder(activity)
            .setTitle(holder.info.title)
            .setView(controls)
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    layout.width = clamp(values[0], .10f, .90f);
                    layout.height = clamp(values[1], .08f, .90f);
                    layout.x = clamp(layout.x, 0f, 1f - layout.width);
                    layout.y = clamp(layout.y, 0f, 1f - layout.height);
                    layout.opacity = clamp(values[2], .20f, 1f);
                    if (holder.info.userToggleable) layout.visible = visible.isChecked();
                    saveHudLayouts();
                    forceRefresh();
                }
            })
            .setNeutralButton("恢复脚本默认", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    hudLayouts.remove(layoutKey(holder.id));
                    saveHudLayouts();
                    forceRefresh();
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void addSlider(LinearLayout layout, String label, int minimum, int maximum,
            int value, final SliderCallback callback) {
        TextView title = textView(label);
        layout.addView(title);
        final TextView number = textView(String.valueOf(value) + "%");
        number.setGravity(Gravity.CENTER);
        number.setMinWidth(dp(52));
        SeekBar seek = new SeekBar(activity);
        seek.setMax(maximum - minimum);
        seek.setProgress(Math.max(0, Math.min(maximum - minimum, value - minimum)));
        final int min = minimum;
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) {
                int actual = min + progress;
                number.setText(String.valueOf(actual) + "%");
                callback.onChanged(actual);
            }
            @Override public void onStartTrackingTouch(SeekBar bar) { }
            @Override public void onStopTrackingTouch(SeekBar bar) { }
        });
        LinearLayout row = new LinearLayout(activity);
        row.setOrientation(LinearLayout.HORIZONTAL);
        row.addView(seek, new LinearLayout.LayoutParams(0,
            ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        row.addView(number);
        layout.addView(row);
    }

    private void renderNodes(LinearLayout parent, JSONArray nodes, String path,
            Set<String> seen) throws JSONException {
        for (int i = 0; i < nodes.length(); i++) {
            JSONObject node = nodes.optJSONObject(i);
            if (node == null) continue;
            String type = node.optString("type", "");
            String nativeId = node.optString("id", "");
            String key = nativeId.isEmpty() ? path + "/" + i + ":" + type : nativeId;
            View view = buildNode(node, key, seen);
            if (view == null) continue;
            detach(view);
            parent.addView(view, defaultParams(type));
        }
    }

    private View buildNode(final JSONObject node, final String key, Set<String> seen)
            throws JSONException {
        final String type = node.optString("type", "");
        seen.add(key);
        if ("same_line".equals(type) || "table_row".equals(type) ||
                "table_column".equals(type) || "item_width".equals(type) ||
                "tooltip".equals(type)) return null;

        if ("separator".equals(type) || "spacing".equals(type) || "new_line".equals(type)) {
            View line = obtain(key, View.class);
            line.setBackgroundColor("separator".equals(type) ? 0x667A8B99 : Color.TRANSPARENT);
            return line;
        }
        if ("radial_select".equals(type)) {
            RadialSelectView radial = obtain(key, RadialSelectView.class);
            radial.configure(node, key);
            return radial;
        }
        if ("button".equals(type) || "small_button".equals(type) ||
                "radio".equals(type) || "selectable".equals(type)) {
            Button button = obtain(key, Button.class);
            String label = node.optString("label", key);
            if (node.optBoolean("boolValue", false) && !"button".equals(type)) label = "✓ " + label;
            button.setText(label);
            button.setOnClickListener(new OnClickListener() {
                @Override
                public void onClick(View view) {
                    activity.submitLuaUiInteraction(node.optString("id", key), "click");
                }
            });
            return button;
        }
        if ("checkbox".equals(type)) {
            final CheckBox check = obtain(key, CheckBox.class);
            check.setOnCheckedChangeListener(null);
            check.setText(node.optString("label", key));
            check.setTextColor(Color.WHITE);
            check.setChecked(node.optBoolean("boolValue", false));
            check.setOnCheckedChangeListener((button, checked) ->
                activity.submitLuaUiInteraction(node.optString("id", key),
                    checked ? "bool:1" : "bool:0"));
            return check;
        }
        if ("slider_int".equals(type) || "slider_float".equals(type)) {
            LinearLayout row = obtain(key, LinearLayout.class);
            row.setOrientation(LinearLayout.VERTICAL);
            row.removeAllViews();
            TextView label = textView(node.optString("label", key));
            final SeekBar seek = new SeekBar(activity);
            final double min = node.optDouble("minimum", 0.0);
            final double max = node.optDouble("maximum", 100.0);
            final boolean floating = "slider_float".equals(type);
            seek.setMax(1000);
            double current = floating ? node.optDouble("numberValue", min) :
                node.optInt("integerValue", (int)min);
            seek.setProgress(max <= min ? 0 :
                (int)Math.round(1000.0 * (current - min) / (max - min)));
            seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
                @Override public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) { }
                @Override public void onStartTrackingTouch(SeekBar bar) { }
                @Override public void onStopTrackingTouch(SeekBar bar) {
                    double value = min + (max - min) * bar.getProgress() / 1000.0;
                    String encoded = floating ? "number:" + value : "int:" + Math.round(value);
                    activity.submitLuaUiInteraction(node.optString("id", key), encoded);
                }
            });
            row.addView(label);
            row.addView(seek);
            return row;
        }
        if ("input_int".equals(type) || "input_float".equals(type) ||
                "input_text".equals(type)) {
            final EditText input = obtain(key, EditText.class);
            input.setHint(node.optString("label", key));
            if (!input.hasFocus()) {
                if ("input_text".equals(type)) input.setText(node.optString("stringValue", ""));
                else if ("input_int".equals(type)) input.setText(String.valueOf(node.optInt("integerValue", 0)));
                else input.setText(String.valueOf(node.optDouble("numberValue", 0.0)));
            }
            input.setInputType("input_text".equals(type) ? InputType.TYPE_CLASS_TEXT :
                InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL |
                    InputType.TYPE_NUMBER_FLAG_SIGNED);
            input.setOnFocusChangeListener(new OnFocusChangeListener() {
                @Override
                public void onFocusChange(View view, boolean focused) {
                    if (focused) return;
                    String prefix = "input_text".equals(type) ? "text:" :
                        ("input_int".equals(type) ? "int:" : "number:");
                    activity.submitLuaUiInteraction(node.optString("id", key),
                        prefix + input.getText().toString());
                }
            });
            return input;
        }
        if ("progress".equals(type)) {
            LinearLayout row = obtain(key, LinearLayout.class);
            row.setOrientation(LinearLayout.VERTICAL);
            row.removeAllViews();
            String text = node.optString("text", "");
            if (!text.isEmpty()) row.addView(textView(text));
            ProgressBar progress = new ProgressBar(activity, null,
                android.R.attr.progressBarStyleHorizontal);
            progress.setMax(1000);
            progress.setProgress((int)Math.round(1000 * node.optDouble("numberValue", 0.0)));
            row.addView(progress);
            return row;
        }
        if ("child".equals(type) || "table".equals(type) || "tabs".equals(type) ||
                "tab".equals(type) || "tree".equals(type) || "modal".equals(type) ||
                "virtual_list".equals(type)) {
            LinearLayout container = obtain(key, LinearLayout.class);
            container.setOrientation(LinearLayout.VERTICAL);
            container.removeAllViews();
            String label = node.optString("label", "");
            if (!label.isEmpty()) {
                TextView heading = textView(label);
                heading.setTypeface(Typeface.DEFAULT, Typeface.BOLD);
                container.addView(heading);
            }
            JSONArray children = node.optJSONArray("children");
            if (children != null) renderNodes(container, children, key, seen);
            return container;
        }

        TextView text = obtain(key, TextView.class);
        String value = node.optString("text", node.optString("label", ""));
        if ("bullet".equals(type)) value = "• " + value;
        text.setText(value);
        if ("color_text".equals(type)) {
            text.setTextColor(parseColor(node.optString("stringValue", ""), Color.WHITE));
        } else {
            text.setTextColor("disabled_text".equals(type) ? 0xFF9E9E9E : Color.WHITE);
        }
        text.setTextSize("heading".equals(type) ? 17f : 14f);
        text.setTypeface(Typeface.DEFAULT,
            "heading".equals(type) ? Typeface.BOLD : Typeface.NORMAL);
        return text;
    }

    @SuppressWarnings("unchecked")
    private <T extends View> T obtain(String key, Class<T> type) {
        View existing = widgets.get(key);
        if (existing != null && type.isInstance(existing)) return (T)existing;
        if (existing != null) detach(existing);
        View created;
        if (type == RadialSelectView.class) created = new RadialSelectView(activity);
        else if (type == Button.class) created = new Button(activity);
        else if (type == CheckBox.class) created = new CheckBox(activity);
        else if (type == EditText.class) created = new EditText(activity);
        else if (type == LinearLayout.class) created = new LinearLayout(activity);
        else if (type == TextView.class) created = new TextView(activity);
        else created = new View(activity);
        widgets.put(key, created);
        return (T)created;
    }

    private void showPageChooser() {
        if (pages.isEmpty()) return;
        final String[] titles = new String[pages.size() + 1];
        titles[0] = "关闭页面";
        for (int i = 0; i < pages.size(); i++) titles[i + 1] = pages.get(i).title;
        new AlertDialog.Builder(activity)
            .setTitle("Lua UI pages")
            .setItems(titles, (dialog, which) ->
                activity.selectLuaUiPage(which == 0 ? "" : pages.get(which - 1).id))
            .show();
    }

    private LinearLayout.LayoutParams defaultParams(String type) {
        if ("separator".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(1));
        if ("spacing".equals(type) || "new_line".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(8));
        if ("radial_select".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(80));
        return new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT);
    }

    private void showRadialMenu(final RadialSelectView source, final JSONObject node,
            final String fallbackId) {
        dismissRadialMenu();
        final JSONArray options = node.optJSONArray("children");
        if (options == null || options.length() == 0) return;

        final FrameLayout layer = new FrameLayout(activity);
        layer.setClickable(true);
        layer.setBackgroundColor(Color.TRANSPARENT);
        layer.setOnClickListener(view -> dismissRadialMenu());
        radialMenuLayer = layer;
        addView(layer, new FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        layer.bringToFront();

        layer.post(new Runnable() {
            @Override
            public void run() {
                if (radialMenuLayer != layer) return;
                int[] overlayLocation = new int[2];
                int[] sourceLocation = new int[2];
                LuaUiOverlay.this.getLocationOnScreen(overlayLocation);
                source.getLocationOnScreen(sourceLocation);
                float centerX = sourceLocation[0] - overlayLocation[0] + source.getWidth() / 2f;
                float centerY = sourceLocation[1] - overlayLocation[1] + source.getHeight() / 2f;
                int optionSize = dp(82);
                float radius = dp(112);
                int margin = dp(8);
                String widgetId = node.optString("id", fallbackId);

                for (int i = 0; i < options.length(); i++) {
                    final JSONObject option = options.optJSONObject(i);
                    if (option == null) continue;
                    final String optionId = option.optString("id", "");
                    if (optionId.isEmpty()) continue;
                    boolean enabled = option.optBoolean("enabled", true);
                    boolean selected = option.optBoolean("selected", false);
                    Button button = new Button(activity);
                    button.setAllCaps(false);
                    button.setText(option.optString("label", optionId));
                    button.setTextSize(12f);
                    button.setTextColor(enabled ? Color.WHITE : 0xFF8A949C);
                    button.setGravity(Gravity.CENTER);
                    button.setMinWidth(0);
                    button.setMinHeight(0);
                    button.setPadding(dp(4), dp(2), dp(4), dp(2));
                    button.setEnabled(enabled);
                    button.setBackground(radialButtonBackground(selected, enabled));
                    if (enabled) {
                        button.setOnClickListener(view -> {
                            if (activity.submitLuaUiInteraction(widgetId,
                                    "select:" + optionId)) {
                                dismissRadialMenu();
                            } else {
                                Toast.makeText(activity, "移动模式切换未被游戏接受",
                                    Toast.LENGTH_SHORT).show();
                            }
                        });
                    }

                    double angle = -Math.PI / 2.0 + 2.0 * Math.PI * i / options.length();
                    int left = Math.round(centerX + radius * (float)Math.cos(angle) - optionSize / 2f);
                    int top = Math.round(centerY + radius * (float)Math.sin(angle) - optionSize / 2f);
                    left = Math.max(margin, Math.min(left, layer.getWidth() - optionSize - margin));
                    top = Math.max(margin, Math.min(top, layer.getHeight() - optionSize - margin));
                    FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(optionSize, optionSize);
                    params.leftMargin = left;
                    params.topMargin = top;
                    layer.addView(button, params);
                }
            }
        });
    }

    private void dismissRadialMenu() {
        if (radialMenuLayer == null) return;
        removeView(radialMenuLayer);
        radialMenuLayer = null;
    }

    private GradientDrawable radialButtonBackground(boolean selected, boolean enabled) {
        GradientDrawable background = new GradientDrawable();
        background.setShape(GradientDrawable.OVAL);
        background.setColor(!enabled ? 0xCC263038 : selected ? 0xEE235D86 : 0xE62B3944);
        background.setStroke(dp(2), selected ? 0xFF7FC8FF : 0xB3C6D3DC);
        return background;
    }

    private TextView textView(String value) {
        TextView text = new TextView(activity);
        text.setText(value);
        text.setTextColor(Color.WHITE);
        text.setTextSize(14f);
        return text;
    }

    private int parseColor(String encoded, int fallback) {
        String[] components = encoded.split(",");
        if (components.length != 4) return fallback;
        try {
            int red = Math.round(255f * clamp(Float.parseFloat(components[0]), 0f, 1f));
            int green = Math.round(255f * clamp(Float.parseFloat(components[1]), 0f, 1f));
            int blue = Math.round(255f * clamp(Float.parseFloat(components[2]), 0f, 1f));
            int alpha = Math.round(255f * clamp(Float.parseFloat(components[3]), 0f, 1f));
            return Color.argb(alpha, red, green, blue);
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private GradientDrawable panelBackground(boolean editor) {
        GradientDrawable background = new GradientDrawable();
        background.setColor(0xDD111820);
        background.setCornerRadius(dp(8));
        background.setStroke(dp(editor ? 3 : 1), editor ? 0xFFFFC107 : 0x996E8CA3);
        return background;
    }

    private void loadHudLayouts() {
        String raw = preferences.getString(PREF_LAYOUTS, null);
        if (raw == null || raw.isEmpty()) return;
        try {
            JSONObject root = new JSONObject(raw);
            JSONObject entries = root.optJSONObject("entries");
            if (entries == null) return;
            java.util.Iterator<String> keys = entries.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                HudLayout layout = HudLayout.fromJson(entries.optJSONObject(key));
                if (layout != null) hudLayouts.put(key, layout);
            }
        } catch (JSONException e) {
            Log.w(TAG, "Ignoring invalid saved Lua HUD layout", e);
        }
    }

    private void saveHudLayouts() {
        JSONObject root = new JSONObject();
        JSONObject entries = new JSONObject();
        try {
            root.put("schema", 1);
            for (Map.Entry<String, HudLayout> entry : hudLayouts.entrySet()) {
                entries.put(entry.getKey(), entry.getValue().toJson());
            }
            root.put("entries", entries);
            preferences.edit().putString(PREF_LAYOUTS, root.toString()).apply();
        } catch (JSONException e) {
            Log.w(TAG, "Could not save Lua HUD layout", e);
        }
    }

    private String orientationName() {
        return getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE
            ? "landscape" : "portrait";
    }

    private String layoutKey(String id) {
        return orientationName() + "|" + id;
    }

    private void resetCurrentOrientationLayouts() {
        String prefix = orientationName() + "|";
        for (String key : new ArrayList<>(hudLayouts.keySet())) {
            if (key.startsWith(prefix)) hudLayouts.remove(key);
        }
        saveHudLayouts();
        forceRefresh();
        Toast.makeText(activity, "已恢复当前方向的 Lua HUD 默认布局", Toast.LENGTH_SHORT).show();
    }

    private void forceRefresh() {
        lastSnapshot = "";
        refresh();
    }

    private static float clamp(float value, float minimum, float maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }

    private void detach(View view) {
        if (view.getParent() instanceof ViewGroup) ((ViewGroup)view.getParent()).removeView(view);
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    private final class HudEditorTouchListener implements OnTouchListener {
        private final SurfaceHolder holder;
        private final Handler pressHandler = new Handler();
        private float downRawX;
        private float downRawY;
        private float startX;
        private float startY;
        private float startWidth;
        private float startHeight;
        private boolean resizing;
        private boolean moved;
        private HudLayout layout;
        private final Runnable longPress = new Runnable() {
            @Override
            public void run() {
                if (!moved) showHudStyleEditor(holder);
            }
        };

        HudEditorTouchListener(SurfaceHolder holder) {
            this.holder = holder;
        }

        @Override
        public boolean onTouch(View view, MotionEvent event) {
            switch (event.getActionMasked()) {
                case MotionEvent.ACTION_DOWN:
                    layout = getOrCreateLayout(holder.info);
                    downRawX = event.getRawX();
                    downRawY = event.getRawY();
                    startX = layout.x;
                    startY = layout.y;
                    startWidth = layout.width;
                    startHeight = layout.height;
                    resizing = holder.info.scalable &&
                        event.getX() >= view.getWidth() - dp(36) &&
                        event.getY() >= view.getHeight() - dp(36);
                    moved = false;
                    pressHandler.postDelayed(longPress, EDIT_LONG_PRESS_MS);
                    return true;
                case MotionEvent.ACTION_MOVE:
                    float dx = (event.getRawX() - downRawX) / Math.max(1f, getWidth());
                    float dy = (event.getRawY() - downRawY) / Math.max(1f, getHeight());
                    if (Math.abs(dx) > .005f || Math.abs(dy) > .005f) {
                        moved = true;
                        pressHandler.removeCallbacks(longPress);
                    }
                    if (resizing) {
                        layout.width = clamp(startWidth + dx, .10f, .90f);
                        layout.height = clamp(startHeight + dy, .08f, .90f);
                        layout.x = clamp(layout.x, 0f, 1f - layout.width);
                        layout.y = clamp(layout.y, 0f, 1f - layout.height);
                    } else if (holder.info.movable) {
                        layout.x = clamp(startX + dx, 0f, 1f - layout.width);
                        layout.y = clamp(startY + dy, 0f, 1f - layout.height);
                    }
                    positionHudLayout(holder, layout);
                    return true;
                case MotionEvent.ACTION_CANCEL:
                case MotionEvent.ACTION_UP:
                    pressHandler.removeCallbacks(longPress);
                    if (moved) saveHudLayouts();
                    return true;
                default:
                    return true;
            }
        }
    }

    private static final class SurfacePanel extends LinearLayout {
        private boolean editing;

        SurfacePanel(Context context) {
            super(context);
        }

        void setEditing(boolean value) {
            editing = value;
        }

        @Override
        public boolean onInterceptTouchEvent(MotionEvent event) {
            return editing || super.onInterceptTouchEvent(event);
        }
    }

    private static final class SurfaceHolder {
        final String id;
        final String kind;
        final SurfacePanel root;
        final LinearLayout titleRow;
        final TextView title;
        final LinearLayout content;
        HudInfo info;
        HudEditorTouchListener editorTouch;
        SurfaceHolder(String id, String kind, SurfacePanel root, LinearLayout titleRow,
                TextView title, LinearLayout content) {
            this.id = id;
            this.kind = kind;
            this.root = root;
            this.titleRow = titleRow;
            this.title = title;
            this.content = content;
        }
    }

    private final class RadialSelectView extends FrameLayout {
        private final Button centerButton;

        RadialSelectView(Context context) {
            super(context);
            setClipChildren(false);
            setClipToPadding(false);
            centerButton = new Button(context);
            centerButton.setAllCaps(false);
            centerButton.setTextColor(Color.WHITE);
            centerButton.setTextSize(14f);
            centerButton.setTypeface(Typeface.DEFAULT, Typeface.BOLD);
            centerButton.setGravity(Gravity.CENTER);
            centerButton.setMinWidth(0);
            centerButton.setMinHeight(0);
            centerButton.setPadding(dp(4), dp(2), dp(4), dp(2));
            addView(centerButton, new FrameLayout.LayoutParams(dp(72), dp(72), Gravity.CENTER));
        }

        void configure(final JSONObject node, final String fallbackId) {
            centerButton.setText(node.optString("label", "?"));
            centerButton.setBackground(radialButtonBackground(true, true));
            centerButton.setOnClickListener(view -> showRadialMenu(this, node, fallbackId));
        }
    }

    private static final class HudInfo {
        String id;
        String title;
        String anchor;
        float offsetX;
        float offsetY;
        float alpha;
        float defaultWidth;
        float defaultHeight;
        boolean interactive;
        boolean background;
        boolean titleBar;
        boolean movable;
        boolean scalable;
        boolean userToggleable;

        static HudInfo fromJson(JSONObject json) {
            HudInfo info = new HudInfo();
            info.id = json.optString("id", "");
            info.title = json.optString("title", info.id);
            info.anchor = json.optString("anchor", "top_left");
            info.offsetX = (float)json.optDouble("x", 12.0);
            info.offsetY = (float)json.optDouble("y", 12.0);
            info.alpha = clamp((float)json.optDouble("alpha", .85), .20f, 1f);
            info.defaultWidth = clamp((float)json.optDouble("defaultWidth", .28), .10f, .90f);
            info.defaultHeight = clamp((float)json.optDouble("defaultHeight", .18), .08f, .90f);
            info.interactive = json.optBoolean("interactive", false);
            info.background = json.optBoolean("background", true);
            info.titleBar = json.optBoolean("titleBar", false);
            info.movable = json.optBoolean("movable", true);
            info.scalable = json.optBoolean("scalable", true);
            info.userToggleable = json.optBoolean("userToggleable", true);
            return info;
        }
    }

    private static final class HudLayout {
        float x;
        float y;
        float width;
        float height;
        float opacity;
        boolean visible;

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("x", x);
            json.put("y", y);
            json.put("width", width);
            json.put("height", height);
            json.put("opacity", opacity);
            json.put("visible", visible);
            return json;
        }

        static HudLayout fromJson(JSONObject json) {
            if (json == null) return null;
            HudLayout layout = new HudLayout();
            layout.width = clamp((float)json.optDouble("width", .28), .10f, .90f);
            layout.height = clamp((float)json.optDouble("height", .18), .08f, .90f);
            layout.x = clamp((float)json.optDouble("x", 0), 0f, 1f - layout.width);
            layout.y = clamp((float)json.optDouble("y", 0), 0f, 1f - layout.height);
            layout.opacity = clamp((float)json.optDouble("opacity", .85), .20f, 1f);
            layout.visible = json.optBoolean("visible", true);
            return layout;
        }
    }

    private interface SliderCallback {
        void onChanged(int value);
    }

    private static final class PageInfo {
        final String id;
        final String title;
        PageInfo(String id, String title) {
            this.id = id;
            this.title = title;
        }
    }
}
