package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.StateListDrawable;
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
import android.widget.PopupWindow;
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
import java.util.UUID;

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

    private final CataclysmDDA activity;
    private final LuaHudLayoutStore layoutStore;
    private final Handler handler = new Handler();
    private final Map<String, SurfaceHolder> surfaces = new HashMap<>();
    private final Map<String, View> widgets = new HashMap<>();
    private final Map<String, HudLayout> hudLayouts = new HashMap<>();
    private final LinkedHashMap<String, HudInfo> hudInfos = new LinkedHashMap<>();
    private final LinkedHashMap<String, HudAction> actionCatalog = new LinkedHashMap<>();
    private final LinearLayout hudEditorBar;
    private final LuaHudEditorDialog hudEditor;
    private FrameLayout radialMenuLayer;
    private PopupWindow actionSlotPopup;
    private ActionSlotView actionSlotPopupOwner;
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
    private String currentScene = LuaHudLayoutStore.DEFAULT_SCENE;
    private int currentContextRevision = -1;
    private String loadedLayoutKey = "";

    LuaUiOverlay(CataclysmDDA activity) {
        super(activity);
        this.activity = activity;
        SharedPreferences preferences =
            activity.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        layoutStore = new LuaHudLayoutStore(preferences);
        hudEditor = new LuaHudEditorDialog(activity, this, layoutStore);
        reloadActiveLayout();
        setClipChildren(false);
        setClipToPadding(false);
        setClickable(false);

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

        Button addHudButton = new Button(activity);
        addHudButton.setText("添加按键");
        addHudButton.setMinWidth(0);
        addHudButton.setMinHeight(0);
        addHudButton.setOnClickListener(view -> hudEditor.showAddButton());
        hudEditorBar.addView(addHudButton);

        Button configureHudButtons = new Button(activity);
        configureHudButtons.setText("编辑按键");
        configureHudButtons.setMinWidth(0);
        configureHudButtons.setMinHeight(0);
        configureHudButtons.setOnClickListener(view -> hudEditor.showButtonList());
        hudEditorBar.addView(configureHudButtons);

        Button configureElements = new Button(activity);
        configureElements.setText("显示元素");
        configureElements.setMinWidth(0);
        configureElements.setMinHeight(0);
        configureElements.setOnClickListener(view -> hudEditor.showElementVisibility());
        hudEditorBar.addView(configureElements);

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
        dismissActionSlotPopup();
    }

    void setHudEditing(boolean value) {
        if (editing == value) return;
        if (value && !ensureEditableLayout("自定义布局")) return;
        if (value) dismissRadialMenu();
        if (value) dismissActionSlotPopup();
        editing = value;
        for (SurfaceHolder holder : surfaces.values()) {
            configureHudEditor(holder);
        }
        hudEditorBar.setVisibility(editing ? VISIBLE : GONE);
        if (editing) hudEditorBar.bringToFront();
        forceRefresh();
    }

    void showHudManager() {
        updateRuntimeContext();
        hudEditor.showScenes();
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
        if (radialMenuLayer != null || actionSlotPopup != null) return true;
        int[] location = new int[2];
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
        updateRuntimeContext();
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
        Set<String> seenSurfaces = new HashSet<>();
        Set<String> seenWidgets = new HashSet<>();
        hudInfos.clear();

        for (int i = 0; i < entries.length(); i++) {
            JSONObject entry = entries.optJSONObject(i);
            if (entry == null) continue;
            String id = entry.optString("id", "");
            String kind = entry.optString("kind", "");
            if (id.isEmpty()) continue;
            if (!"hud".equals(kind)) continue;
            HudInfo info = HudInfo.fromJson(entry);
            hudInfos.put(id, info);
            HudLayout layout = hudLayouts.get(info.layoutElementId);
            if (info.userToggleable && layout != null && !layout.visible) continue;
            seenSurfaces.add(id);
            SurfaceHolder holder = obtainSurface(id, kind);
            holder.info = info;
            holder.title.setText(entry.optString("title", id));
            holder.content.removeAllViews();
            JSONArray nodes = entry.optJSONArray("nodes");
            if (nodes != null) {
                renderNodes(holder.content, nodes, id, seenWidgets);
            }
            positionSurface(holder, entry, kind);
            configureHudEditor(holder);
        }

        renderCustomElements(seenSurfaces, seenWidgets);

        for (String id : new ArrayList<>(surfaces.keySet())) {
            if (!seenSurfaces.contains(id)) {
                SurfaceHolder removed = surfaces.remove(id);
                removeView(removed.root);
            }
        }
        for (String id : new ArrayList<>(widgets.keySet())) {
            if (!seenWidgets.contains(id)) widgets.remove(id);
        }
        if (actionSlotPopupOwner != null &&
                !seenWidgets.contains(actionSlotPopupOwner.widgetId)) {
            dismissActionSlotPopup();
        }
        hudEditorBar.setVisibility(editing ? VISIBLE : GONE);
        if (editing) hudEditorBar.bringToFront();
    }

    private void renderCustomElements(Set<String> seenSurfaces, Set<String> seenWidgets)
            throws JSONException {
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        if (active.official) return;
        for (LuaHudLayoutStore.Element element : active.elements.values()) {
            if (!LuaHudLayoutStore.TYPE_ACTION_BUTTON.equals(element.type) || !element.visible) {
                continue;
            }
            String surfaceId = "custom:" + element.id;
            seenSurfaces.add(surfaceId);
            HudInfo info = HudInfo.forCustomAction(surfaceId, element);
            hudInfos.put(surfaceId, info);
            SurfaceHolder holder = obtainSurface(surfaceId, "hud");
            holder.info = info;
            holder.root.setPadding(0, 0, 0, 0);
            holder.title.setText(info.title);
            holder.content.removeAllViews();

            JSONObject node = new JSONObject();
            node.put("type", "action_slot");
            node.put("id", "custom_slot:" + element.id);
            node.put("customElementId", element.id);
            node.put("contextRevision", currentContextRevision);
            node.put("selectedAction", element.selectedAction);
            if (!element.label.isEmpty()) node.put("customLabel", element.label);
            JSONArray children = new JSONArray();
            for (String actionId : element.actions) {
                HudAction action = actionCatalog.get(actionId);
                if (action == null || action.dangerous) continue;
                JSONObject choice = new JSONObject();
                choice.put("id", action.id);
                choice.put("label", action.label);
                choice.put("enabled", true);
                children.put(choice);
            }
            node.put("children", children);
            JSONArray nodes = new JSONArray();
            nodes.put(node);
            renderNodes(holder.content, nodes, surfaceId, seenWidgets);
            HudLayout placement = hudLayouts.get(element.id);
            if (placement == null) {
                placement = HudLayout.fromElement(element);
                hudLayouts.put(element.id, placement);
            }
            positionHudLayout(holder, placement);
            configureHudEditor(holder);
        }
    }

    private void updateRuntimeContext() {
        String raw = activity.getHudSnapshot();
        if (raw == null || raw.isEmpty()) return;
        try {
            JSONObject snapshot = new JSONObject(raw);
            if (snapshot.optInt("schema", 0) != 2) return;
            String nextScene = snapshot.optString("context", "");
            if (nextScene.isEmpty()) nextScene = currentScene;
            int nextRevision = snapshot.optInt("contextRevision", -1);
            LinkedHashMap<String, HudAction> nextCatalog = new LinkedHashMap<>();
            JSONArray actions = snapshot.optJSONArray("actions");
            if (actions != null) {
                for (int i = 0; i < actions.length(); ++i) {
                    JSONObject action = actions.optJSONObject(i);
                    if (action == null) continue;
                    String id = action.optString("id", "");
                    boolean dangerous = action.optBoolean("dangerous", false);
                    if (id.isEmpty() || dangerous) continue;
                    nextCatalog.put(id, new HudAction(id,
                        action.optString("label", id),
                        action.optString("group", "context"),
                        action.optBoolean("repeatable", false), false));
                }
            }
            boolean sceneChanged = !nextScene.equals(currentScene);
            boolean actionsChanged = nextRevision != currentContextRevision ||
                !nextCatalog.keySet().equals(actionCatalog.keySet());
            currentScene = nextScene;
            currentContextRevision = nextRevision;
            actionCatalog.clear();
            actionCatalog.putAll(nextCatalog);
            layoutStore.rememberScene(currentScene, sceneTitle(currentScene));
            String binding = currentScene + "|" + orientationName() + "|" +
                layoutStore.activeLayoutId(currentScene, orientationName());
            if (sceneChanged || !binding.equals(loadedLayoutKey)) {
                reloadActiveLayout();
                actionsChanged = true;
            }
            if (actionsChanged) lastSnapshot = "";
        } catch (JSONException e) {
            Log.w(TAG, "Ignoring invalid Android HUD action snapshot", e);
        }
    }

    private String sceneTitle(String scene) {
        if (LuaHudLayoutStore.DEFAULT_SCENE.equals(scene)) return "游戏地图";
        return scene;
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
        HudLayout saved = holder.info == null ? null :
            hudLayouts.get(holder.info.layoutElementId);
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
        boolean compactAction = holder.info != null && holder.info.customAction;
        int minimumWidth = compactAction ? dp(76) : dp(120);
        int width = Math.max(minimumWidth,
            Math.round(clamp(layout.width, .06f, .90f) * getWidth()));
        // Native radial controls are 80dp tall.  Include the panel's vertical
        // padding in the minimum so a compact one-control HUD never becomes a
        // clipped ScrollView that has to be dragged to reveal the other half.
        int minimumHeight = compactAction ? dp(44) : dp(88);
        int height = Math.max(minimumHeight,
            Math.round(clamp(layout.height, .05f, .90f) * getHeight()));
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
        String key = info.layoutElementId;
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
        final int minimumWidth = holder.info.customAction ? 6 : 10;
        final int minimumHeight = holder.info.customAction ? 5 : 8;
        if (holder.info.scalable) {
            addSlider(controls, "宽度", minimumWidth, 90, Math.round(values[0] * 100),
                new SliderCallback() {
                    @Override public void onChanged(int value) { values[0] = value / 100f; }
                });
            addSlider(controls, "高度", minimumHeight, 90, Math.round(values[1] * 100),
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
                    layout.width = clamp(values[0], minimumWidth / 100f, .90f);
                    layout.height = clamp(values[1], minimumHeight / 100f, .90f);
                    layout.x = clamp(layout.x, 0f, 1f - layout.width);
                    layout.y = clamp(layout.y, 0f, 1f - layout.height);
                    layout.opacity = clamp(values[2], .20f, 1f);
                    if (holder.info.userToggleable) layout.visible = visible.isChecked();
                    saveHudLayouts();
                    forceRefresh();
                }
            })
            .setNeutralButton(holder.info.customAction ? "删除按键" : "恢复脚本默认",
                new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    hudLayouts.remove(holder.info.layoutElementId);
                    String activeId =
                        layoutStore.activeLayoutId(currentScene, orientationName());
                    layoutStore.removeElement(currentScene, orientationName(), activeId,
                        holder.info.layoutElementId);
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
        if ("action_slot".equals(type)) {
            ActionSlotView slot = obtain(key, ActionSlotView.class);
            slot.configure(node, key);
            return slot;
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
        else if (type == ActionSlotView.class) created = new ActionSlotView(activity);
        else if (type == Button.class) created = new Button(activity);
        else if (type == CheckBox.class) created = new CheckBox(activity);
        else if (type == EditText.class) created = new EditText(activity);
        else if (type == LinearLayout.class) created = new LinearLayout(activity);
        else if (type == TextView.class) created = new TextView(activity);
        else created = new View(activity);
        widgets.put(key, created);
        return (T)created;
    }

    private LinearLayout.LayoutParams defaultParams(String type) {
        if ("separator".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(1));
        if ("spacing".equals(type) || "new_line".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(8));
        if ("radial_select".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(80));
        if ("action_slot".equals(type)) return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(44));
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

    private void dismissActionSlotPopup() {
        if (actionSlotPopup == null) return;
        PopupWindow popup = actionSlotPopup;
        actionSlotPopup = null;
        actionSlotPopupOwner = null;
        popup.dismiss();
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

    private void saveHudLayouts() {
        String activeId = layoutStore.activeLayoutId(currentScene, orientationName());
        if (LuaHudLayoutStore.OFFICIAL_LAYOUT_ID.equals(activeId)) return;
        LuaHudLayoutStore.Layout active =
            layoutStore.findLayout(currentScene, orientationName(), activeId);
        if (active == null) return;
        ArrayList<LuaHudLayoutStore.Element> changed = new ArrayList<>();
        for (Map.Entry<String, HudLayout> entry : hudLayouts.entrySet()) {
            LuaHudLayoutStore.Element element = active.elements.get(entry.getKey());
            if (element == null) {
                if (!entry.getKey().startsWith("surface:")) continue;
                element = new LuaHudLayoutStore.Element();
                element.id = entry.getKey();
                element.type = LuaHudLayoutStore.TYPE_LUA_SURFACE;
                element.sourceId = entry.getKey().substring("surface:".length());
            }
            entry.getValue().copyTo(element);
            changed.add(element);
        }
        layoutStore.putElements(currentScene, orientationName(), activeId, changed);
    }

    private void reloadActiveLayout() {
        hudLayouts.clear();
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        for (LuaHudLayoutStore.Element element : active.elements.values()) {
            if (LuaHudLayoutStore.TYPE_LUA_SURFACE.equals(element.type) ||
                    LuaHudLayoutStore.TYPE_ACTION_BUTTON.equals(element.type)) {
                hudLayouts.put(element.id, HudLayout.fromElement(element));
            }
        }
        loadedLayoutKey = currentScene + "|" + orientationName() + "|" + active.id;
    }

    private String orientationName() {
        return getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE
            ? "landscape" : "portrait";
    }

    private void resetCurrentOrientationLayouts() {
        layoutStore.setActive(currentScene, orientationName(),
            LuaHudLayoutStore.OFFICIAL_LAYOUT_ID);
        editing = false;
        reloadActiveLayout();
        forceRefresh();
        Toast.makeText(activity, "已切换到当前场景的官方默认布局", Toast.LENGTH_SHORT).show();
    }

    String currentSceneId() {
        updateRuntimeContext();
        return currentScene;
    }

    String currentOrientationId() {
        return orientationName();
    }

    boolean isCurrentScene(String scene) {
        return currentScene.equals(scene);
    }

    List<LuaHudLayoutStore.Element> captureCurrentElements() {
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        LinkedHashMap<String, LuaHudLayoutStore.Element> result = new LinkedHashMap<>();
        for (LuaHudLayoutStore.Element element : active.elements.values()) {
            result.put(element.id, element.copy());
        }
        for (HudInfo info : hudInfos.values()) {
            if (info.customAction) continue;
            HudLayout placement = hudLayouts.get(info.layoutElementId);
            if (placement == null) placement = defaultLayout(info);
            LuaHudLayoutStore.Element element = result.get(info.layoutElementId);
            if (element == null) {
                element = new LuaHudLayoutStore.Element();
                element.id = info.layoutElementId;
                element.type = LuaHudLayoutStore.TYPE_LUA_SURFACE;
                element.sourceId = info.id;
            }
            placement.copyTo(element);
            result.put(element.id, element);
        }
        return new ArrayList<>(result.values());
    }

    boolean ensureEditableLayout(String suggestedName) {
        String orientation = orientationName();
        String activeId = layoutStore.activeLayoutId(currentScene, orientation);
        if (!LuaHudLayoutStore.OFFICIAL_LAYOUT_ID.equals(activeId)) return true;
        LuaHudLayoutStore.Layout created = layoutStore.createLayout(currentScene, orientation,
            suggestedName, captureCurrentElements());
        if (created == null) {
            Toast.makeText(activity, "无法创建更多布局", Toast.LENGTH_SHORT).show();
            return false;
        }
        reloadActiveLayout();
        forceRefresh();
        return true;
    }

    LuaHudLayoutStore.Layout createLayoutCopy(String scene, String name) {
        List<LuaHudLayoutStore.Element> seed;
        if (isCurrentScene(scene)) {
            seed = captureCurrentElements();
        } else {
            LuaHudLayoutStore.Layout active =
                layoutStore.activeLayout(scene, orientationName());
            seed = new ArrayList<>(active.elements.values());
        }
        LuaHudLayoutStore.Layout created =
            layoutStore.createLayout(scene, orientationName(), name, seed);
        if (isCurrentScene(scene) && created != null) {
            reloadActiveLayout();
            forceRefresh();
        }
        return created;
    }

    void activateLayout(String scene, String layoutId) {
        if (!layoutStore.setActive(scene, orientationName(), layoutId)) return;
        if (isCurrentScene(scene)) {
            setHudEditing(false);
            reloadActiveLayout();
            forceRefresh();
        }
    }

    void editLayout(String scene, String layoutId) {
        if (!isCurrentScene(scene)) {
            Toast.makeText(activity, "进入该游戏场景后才能在画面上编辑位置",
                Toast.LENGTH_LONG).show();
            return;
        }
        activateLayout(scene, layoutId);
        setHudEditing(true);
        Toast.makeText(activity,
            "拖动元素调整位置，拖动右下角缩放；上方可添加或编辑按键",
            Toast.LENGTH_LONG).show();
    }

    List<HudAction> availableHudActions() {
        updateRuntimeContext();
        return new ArrayList<>(actionCatalog.values());
    }

    List<ButtonBinding> editableButtons() {
        ArrayList<ButtonBinding> result = new ArrayList<>();
        HashSet<String> seen = new HashSet<>();
        for (View widget : widgets.values()) {
            if (!(widget instanceof ActionSlotView)) continue;
            ActionSlotView slot = (ActionSlotView)widget;
            if (slot.widgetId == null || slot.widgetId.isEmpty() ||
                    !seen.add(slot.widgetId)) {
                continue;
            }
            String configId = slot.customElementId.isEmpty() ?
                "override:" + slot.widgetId : slot.customElementId;
            result.add(new ButtonBinding(configId, slot.widgetId,
                slot.displayName(), !slot.customElementId.isEmpty(),
                slot.customLabel, new ArrayList<>(slot.configuredActionIds())));
        }
        return result;
    }

    List<ElementBinding> editableElements() {
        LinkedHashMap<String, ElementBinding> result = new LinkedHashMap<>();
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        for (HudInfo info : hudInfos.values()) {
            if (info.customAction) continue;
            LuaHudLayoutStore.Element saved = active.elements.get(info.layoutElementId);
            result.put(info.layoutElementId, new ElementBinding(info.layoutElementId,
                info.title, saved == null || saved.visible));
        }
        for (LuaHudLayoutStore.Element element : active.elements.values()) {
            if (!LuaHudLayoutStore.TYPE_ACTION_BUTTON.equals(element.type)) continue;
            String title = element.label;
            if (title.isEmpty() && !element.selectedAction.isEmpty()) {
                HudAction action = actionCatalog.get(element.selectedAction);
                title = action == null ? element.selectedAction : action.label;
            }
            if (title.isEmpty()) title = "自定义按键";
            result.put(element.id, new ElementBinding(element.id, title, element.visible));
        }
        return new ArrayList<>(result.values());
    }

    void setElementVisibility(List<ElementBinding> elements, boolean[] visible) {
        if (elements == null || visible == null ||
                !ensureEditableLayout("自定义布局")) {
            return;
        }
        LuaHudLayoutStore.Layout active = layoutStore.activeLayout(
            currentScene, orientationName());
        ArrayList<LuaHudLayoutStore.Element> changed = new ArrayList<>();
        for (int i = 0; i < elements.size() && i < visible.length; ++i) {
            ElementBinding binding = elements.get(i);
            LuaHudLayoutStore.Element element = active.elements.get(binding.id);
            if (element == null && binding.id.startsWith("surface:")) {
                String sourceId = binding.id.substring("surface:".length());
                HudInfo info = hudInfos.get(sourceId);
                if (info == null) continue;
                element = new LuaHudLayoutStore.Element();
                element.id = binding.id;
                element.type = LuaHudLayoutStore.TYPE_LUA_SURFACE;
                element.sourceId = sourceId;
                defaultLayout(info).copyTo(element);
            }
            if (element == null) continue;
            element.visible = visible[i];
            changed.add(element);
        }
        if (layoutStore.putElements(currentScene, orientationName(), active.id, changed)) {
            reloadActiveLayout();
            forceRefresh();
        }
    }

    void addCustomButton(List<String> actions, String label) {
        if (actions == null || actions.isEmpty() || !ensureEditableLayout("自定义布局")) return;
        LuaHudLayoutStore.Element element = new LuaHudLayoutStore.Element();
        element.id = "button:" + UUID.randomUUID().toString();
        element.type = LuaHudLayoutStore.TYPE_ACTION_BUTTON;
        element.label = label == null ? "" : label.trim();
        for (String action : actions) {
            if (actionCatalog.containsKey(action) && !element.actions.contains(action)) {
                element.actions.add(action);
            }
        }
        if (element.actions.isEmpty()) return;
        element.selectedAction = element.actions.get(0);
        int existing = 0;
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        for (LuaHudLayoutStore.Element saved : active.elements.values()) {
            if (LuaHudLayoutStore.TYPE_ACTION_BUTTON.equals(saved.type)) existing++;
        }
        element.width = .16f;
        element.height = .075f;
        element.x = clamp(.42f + (existing % 4) * .02f, 0f, 1f - element.width);
        element.y = clamp(.18f + (existing % 6) * .09f, 0f, 1f - element.height);
        element.opacity = .92f;
        String activeId = layoutStore.activeLayoutId(currentScene, orientationName());
        if (layoutStore.putElement(currentScene, orientationName(), activeId, element)) {
            reloadActiveLayout();
            forceRefresh();
        }
    }

    void configureButton(ButtonBinding binding, List<String> actions, String label) {
        if (binding == null || actions == null || actions.isEmpty() ||
                !ensureEditableLayout("自定义布局")) {
            return;
        }
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        LuaHudLayoutStore.Element element = active.elements.get(binding.configId);
        if (element == null) {
            element = new LuaHudLayoutStore.Element();
            element.id = binding.configId;
            element.type = binding.custom ?
                LuaHudLayoutStore.TYPE_ACTION_BUTTON : LuaHudLayoutStore.TYPE_ACTION_OVERRIDE;
            element.sourceId = binding.widgetId;
        }
        element.label = label == null ? "" : label.trim();
        String previous = element.selectedAction;
        element.actions.clear();
        for (String action : actions) {
            if (actionCatalog.containsKey(action) && !element.actions.contains(action)) {
                element.actions.add(action);
            }
        }
        if (element.actions.isEmpty()) return;
        element.selectedAction = element.actions.contains(previous) ?
            previous : element.actions.get(0);
        String activeId = layoutStore.activeLayoutId(currentScene, orientationName());
        if (layoutStore.putElement(currentScene, orientationName(), activeId, element)) {
            if (binding.custom) reloadActiveLayout();
            forceRefresh();
        }
    }

    void removeButton(ButtonBinding binding) {
        if (binding == null || !ensureEditableLayout("自定义布局")) return;
        String activeId = layoutStore.activeLayoutId(currentScene, orientationName());
        if (layoutStore.removeElement(currentScene, orientationName(), activeId,
                binding.configId)) {
            reloadActiveLayout();
            forceRefresh();
        }
    }

    private LuaHudLayoutStore.Element actionConfiguration(String widgetId,
            String customElementId) {
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        String id = customElementId == null || customElementId.isEmpty() ?
            "override:" + widgetId : customElementId;
        LuaHudLayoutStore.Element element = active.elements.get(id);
        return element == null ? null : element.copy();
    }

    private boolean selectConfiguredAction(String configId, String actionId) {
        LuaHudLayoutStore.Layout active =
            layoutStore.activeLayout(currentScene, orientationName());
        LuaHudLayoutStore.Element element = active.elements.get(configId);
        if (element == null || !element.actions.contains(actionId) ||
                !actionCatalog.containsKey(actionId)) {
            return false;
        }
        element.selectedAction = actionId;
        return layoutStore.putElement(currentScene, orientationName(), active.id, element);
    }

    boolean importLayoutPackage(String json) {
        boolean imported = layoutStore.importPackage(json);
        if (imported) {
            reloadActiveLayout();
            forceRefresh();
        }
        return imported;
    }

    String exportLayoutPackage() {
        return layoutStore.exportPackage();
    }

    void requestLayoutImport() {
        activity.importHudLayout();
    }

    void requestLayoutExport() {
        activity.exportHudLayout(exportLayoutPackage());
    }

    void requestLayoutShare() {
        activity.shareHudLayout(exportLayoutPackage());
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
                        float minimumWidth = holder.info.customAction ? .06f : .10f;
                        float minimumHeight = holder.info.customAction ? .05f : .08f;
                        layout.width = clamp(startWidth + dx, minimumWidth, .90f);
                        layout.height = clamp(startHeight + dy, minimumHeight, .90f);
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

    /**
     * Native retained renderer for one Lua action_slot.  The large region
     * executes the selected named action; the small region only exists when
     * more than one currently registered candidate is available.
     */
    private final class ActionSlotView extends LinearLayout {
        private final Button trigger;
        private final Button selector;
        private final List<ActionChoice> choices = new ArrayList<>();
        private String widgetId;
        private String selectedId;
        private int contextRevision;
        private String customElementId = "";
        private String configElementId = "";
        private String customLabel = "";
        private String configurationKey = "";

        ActionSlotView(Context context) {
            super(context);
            setOrientation(HORIZONTAL);
            setGravity(Gravity.CENTER_VERTICAL);

            trigger = actionSlotButton(false);
            addView(trigger, new LinearLayout.LayoutParams(0, dp(40), 1f));

            selector = actionSlotButton(true);
            selector.setText("▾");
            LinearLayout.LayoutParams selectorParams =
                new LinearLayout.LayoutParams(dp(34), dp(40));
            selectorParams.setMargins(dp(3), 0, 0, 0);
            addView(selector, selectorParams);

            trigger.setOnClickListener(view -> triggerSelectedAction());
            selector.setOnClickListener(view -> showChoices());
        }

        void configure(JSONObject node, String fallbackId) {
            String nextWidgetId = node.optString("id", fallbackId);
            int nextRevision = node.optInt("contextRevision", -1);
            String nextSelectedId = node.optString("selectedAction", "");
            String nextCustomElementId = node.optString("customElementId", "");
            String nextCustomLabel = node.optString("customLabel", "");
            List<ActionChoice> nextChoices = new ArrayList<>();
            LuaHudLayoutStore.Element override =
                actionConfiguration(nextWidgetId, nextCustomElementId);
            if (override != null) {
                nextSelectedId = override.selectedAction;
                if (!override.label.isEmpty()) nextCustomLabel = override.label;
                for (String actionId : override.actions) {
                    HudAction action = actionCatalog.get(actionId);
                    if (action != null && !action.dangerous) {
                        nextChoices.add(new ActionChoice(action.id, action.label));
                    }
                }
            }
            StringBuilder fingerprint = new StringBuilder()
                .append(nextWidgetId).append('|')
                .append(nextRevision).append('|')
                .append(nextSelectedId).append('|')
                .append(nextCustomElementId).append('|')
                .append(nextCustomLabel);
            JSONArray options = node.optJSONArray("children");
            if (override == null && options != null) {
                for (int i = 0; i < options.length(); i++) {
                    JSONObject option = options.optJSONObject(i);
                    if (option == null || !option.optBoolean("enabled", true)) continue;
                    String id = option.optString("id", "");
                    if (id.isEmpty()) continue;
                    String label = option.optString("label", id);
                    nextChoices.add(new ActionChoice(id, label));
                    fingerprint.append('|').append(id).append('=').append(label);
                }
            }
            if (override != null) {
                for (ActionChoice choice : nextChoices) {
                    fingerprint.append('|').append(choice.id).append('=').append(choice.label);
                }
            }
            String nextKey = fingerprint.toString();
            if (nextKey.equals(configurationKey)) return;
            if (actionSlotPopupOwner == this) dismissActionSlotPopup();

            configurationKey = nextKey;
            widgetId = nextWidgetId;
            contextRevision = nextRevision;
            selectedId = nextSelectedId;
            customElementId = nextCustomElementId;
            configElementId = override == null ? "" : override.id;
            customLabel = nextCustomLabel;
            choices.clear();
            choices.addAll(nextChoices);
            if (findChoice(selectedId) == null) {
                selectedId = choices.isEmpty() ? "" : choices.get(0).id;
            }
            updateButtons();
        }

        private void triggerSelectedAction() {
            if (selectedId.isEmpty()) return;
            if (!activity.enqueueHudAction(selectedId, contextRevision)) {
                Toast.makeText(activity, "页面或动作已变化，请重试", Toast.LENGTH_SHORT).show();
            }
        }

        private void showChoices() {
            if (choices.size() < 2) return;
            dismissActionSlotPopup();
            LinearLayout list = new LinearLayout(activity);
            list.setOrientation(VERTICAL);
            list.setPadding(dp(4), dp(4), dp(4), dp(4));
            list.setBackground(panelBackground(false));
            for (final ActionChoice choice : choices) {
                Button option = actionSlotButton(false);
                option.setText((choice.id.equals(selectedId) ? "✓ " : "") + choice.label);
                option.setOnClickListener(view -> {
                    boolean accepted = !configElementId.isEmpty() ?
                        selectConfiguredAction(configElementId, choice.id) :
                        activity.submitLuaUiInteraction(widgetId, "select:" + choice.id);
                    if (accepted) {
                        selectedId = choice.id;
                        updateButtons();
                        dismissActionSlotPopup();
                    } else {
                        Toast.makeText(activity, "按钮选择未被游戏接受",
                            Toast.LENGTH_SHORT).show();
                    }
                });
                list.addView(option, new LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT, dp(44)));
            }
            ScrollView scroll = new ScrollView(activity);
            scroll.addView(list, new ScrollView.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            int height = Math.min(dp(300), dp(8 + 44 * choices.size()));
            final PopupWindow popup = new PopupWindow(scroll, dp(180), height, true);
            actionSlotPopup = popup;
            actionSlotPopupOwner = this;
            popup.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
            popup.setOutsideTouchable(true);
            popup.setElevation(dp(8));
            popup.setOnDismissListener(() -> {
                if (actionSlotPopup == popup) {
                    actionSlotPopup = null;
                    actionSlotPopupOwner = null;
                }
            });
            popup.showAsDropDown(selector, -dp(143), dp(3));
        }

        private ActionChoice findChoice(String id) {
            for (ActionChoice choice : choices) {
                if (choice.id.equals(id)) return choice;
            }
            return null;
        }

        private void updateButtons() {
            ActionChoice selected = findChoice(selectedId);
            boolean enabled = selected != null;
            trigger.setText(enabled ? (customLabel.isEmpty() ? selected.label : customLabel) : "—");
            trigger.setEnabled(enabled);
            trigger.setBackground(actionSlotBackground(false, enabled));
            selector.setVisibility(choices.size() > 1 ? VISIBLE : GONE);
            selector.setEnabled(choices.size() > 1);
            selector.setBackground(actionSlotBackground(true, choices.size() > 1));
        }

        String displayName() {
            ActionChoice selected = findChoice(selectedId);
            if (!customLabel.isEmpty()) return customLabel;
            return selected == null ? widgetId : selected.label;
        }

        List<String> configuredActionIds() {
            ArrayList<String> result = new ArrayList<>();
            for (ActionChoice choice : choices) result.add(choice.id);
            return result;
        }

        private Button actionSlotButton(boolean compact) {
            Button button = new Button(activity);
            button.setAllCaps(false);
            button.setTextColor(Color.WHITE);
            button.setTextSize(compact ? 14f : 12f);
            button.setGravity(Gravity.CENTER);
            button.setMinWidth(0);
            button.setMinHeight(0);
            button.setMinimumWidth(0);
            button.setMinimumHeight(0);
            button.setPadding(compact ? 0 : dp(6), 0, compact ? 0 : dp(6), 0);
            return button;
        }
    }

    private StateListDrawable actionSlotBackground(boolean selector, boolean enabled) {
        StateListDrawable states = new StateListDrawable();
        int normal = !enabled ? 0x9930383E : selector ? 0xE02C3E49 : 0xD0202A33;
        int pressed = !enabled ? normal : selector ? 0xFF3C6478 : 0xEE31566A;
        int stroke = !enabled ? 0x667A8994 : selector ? 0xCC8BB7C8 : 0xAA78909C;
        states.addState(new int[] { android.R.attr.state_pressed },
            roundedActionSlotShape(pressed, stroke));
        states.addState(new int[] {}, roundedActionSlotShape(normal, stroke));
        return states;
    }

    private GradientDrawable roundedActionSlotShape(int fill, int stroke) {
        GradientDrawable shape = new GradientDrawable();
        shape.setColor(fill);
        shape.setCornerRadius(dp(9));
        shape.setStroke(dp(1), stroke);
        return shape;
    }

    private static final class ActionChoice {
        final String id;
        final String label;

        ActionChoice(String id, String label) {
            this.id = id;
            this.label = label;
        }
    }

    private static final class HudInfo {
        String id;
        String layoutElementId;
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
        boolean customAction;

        static HudInfo fromJson(JSONObject json) {
            HudInfo info = new HudInfo();
            info.id = json.optString("id", "");
            info.layoutElementId = "surface:" + info.id;
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

        static HudInfo forCustomAction(String surfaceId, LuaHudLayoutStore.Element element) {
            HudInfo info = new HudInfo();
            info.id = surfaceId;
            info.layoutElementId = element.id;
            info.title = element.label.isEmpty() ? "自定义按键" : element.label;
            info.anchor = "top_left";
            info.alpha = element.opacity;
            info.defaultWidth = element.width;
            info.defaultHeight = element.height;
            info.interactive = true;
            info.background = false;
            info.titleBar = false;
            info.movable = true;
            info.scalable = true;
            info.userToggleable = true;
            info.customAction = true;
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

        static HudLayout fromElement(LuaHudLayoutStore.Element element) {
            HudLayout layout = new HudLayout();
            layout.x = element.x;
            layout.y = element.y;
            layout.width = element.width;
            layout.height = element.height;
            layout.opacity = element.opacity;
            layout.visible = element.visible;
            return layout;
        }

        void copyTo(LuaHudLayoutStore.Element element) {
            element.x = x;
            element.y = y;
            element.width = width;
            element.height = height;
            element.opacity = opacity;
            element.visible = visible;
        }
    }

    static final class HudAction {
        final String id;
        final String label;
        final String group;
        final boolean repeatable;
        final boolean dangerous;

        HudAction(String id, String label, String group, boolean repeatable, boolean dangerous) {
            this.id = id;
            this.label = label;
            this.group = group;
            this.repeatable = repeatable;
            this.dangerous = dangerous;
        }
    }

    static final class ButtonBinding {
        final String configId;
        final String widgetId;
        final String title;
        final boolean custom;
        final String label;
        final List<String> actions;

        ButtonBinding(String configId, String widgetId, String title, boolean custom,
                String label, List<String> actions) {
            this.configId = configId;
            this.widgetId = widgetId;
            this.title = title;
            this.custom = custom;
            this.label = label;
            this.actions = actions;
        }
    }

    static final class ElementBinding {
        final String id;
        final String title;
        final boolean visible;

        ElementBinding(String id, String title, boolean visible) {
            this.id = id;
            this.title = title;
            this.visible = visible;
        }
    }

    private interface SliderCallback {
        void onChanged(int value);
    }

}
