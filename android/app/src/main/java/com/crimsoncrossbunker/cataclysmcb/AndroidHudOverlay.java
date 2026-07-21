package com.crimsoncrossbunker.cataclysmcb;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.os.Handler;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.text.style.StyleSpan;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Android-only HUD that sits above SDL's SurfaceView.  Layout information is
 * intentionally expressed in fractions of the usable screen, not pixels, so a
 * layout can survive display-size and orientation changes and be shared safely.
 */
final class AndroidHudOverlay extends FrameLayout {
    private static final String TAG = "AndroidHud";
    private static final String PREFS_NAME = "android_hud";
    private static final String PREF_LAYOUTS = "layouts_v3";
    private static final String PREF_LAYOUTS_V2 = "layouts_v2";
    private static final String PREF_LAYOUTS_V1 = "layouts_v1";
    private static final int LAYOUT_SCHEMA_VERSION = 3;
    private static final int SNAPSHOT_SCHEMA_VERSION = 2;
    private static final int DEFAULT_LAYOUTS_VERSION = 2;
    private static final long SNAPSHOT_INTERVAL_MS = 100L;
    private static final long EDIT_LONG_PRESS_MS = 650L;

    private static final String TYPE_STATUS = "status";
    private static final String TYPE_BODY = "body";
    private static final String TYPE_EQUIPMENT = "equipment";
    private static final String TYPE_ENVIRONMENT = "environment";
    private static final String TYPE_MESSAGES = "messages";
    private static final String TYPE_PIXEL_MINIMAP = "pixel_minimap";
    private static final String TYPE_OVERMAP = "overmap";
    private static final String TYPE_DANGER_COMPASS = "danger_compass";
    private static final String TYPE_ACTIONS = "actions";

    private static final LinkedHashMap<String, String> COMPONENT_LABELS = createComponentLabels();
    private static final LinkedHashMap<String, String> CONTEXT_LABELS = createContextLabels();

    private final CataclysmDDA activity;
    private final SharedPreferences preferences;
    private final Handler handler = new Handler();
    private final List<HudComponent> components = new ArrayList<>();
    private final Map<String, RenderedComponent> rendered = new HashMap<>();
    private final LinkedHashMap<String, ActionInfo> actionInfos = new LinkedHashMap<>();
    private final LinearLayout editorBar;
    private final Runnable snapshotPoller = new Runnable() {
        @Override
        public void run() {
            refreshSnapshot();
            if (started) {
                handler.postDelayed(this, SNAPSHOT_INTERVAL_MS);
            }
        }
    };
    private final Runnable blankLongPress = new Runnable() {
        @Override
        public void run() {
            if (blankTouchActive && !editing) {
                enterEditMode();
                activity.cancelActiveGameTouch();
                Toast.makeText(activity, "HUD 编辑模式：拖动移动，右下角拖动缩放，长按组件编辑", Toast.LENGTH_SHORT).show();
            }
        }
    };

    private JSONObject layoutStore;
    private JSONObject state = new JSONObject();
    private String activeLayoutId;
    private boolean started;
    private boolean editing;
    private boolean blankTouchActive;
    private long lastSnapshotRevision = -1;
    private int contextRevision;
    private String currentContext = "DEFAULTMODE";

    AndroidHudOverlay(CataclysmDDA activity) {
        super(activity);
        this.activity = activity;
        this.preferences = activity.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        setClipChildren(false);
        setClipToPadding(false);
        setClickable(false);
        loadLayoutStore();
        editorBar = createEditorBar();
        addView(editorBar, new FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT, Gravity.TOP));
        editorBar.setVisibility(GONE);
        loadActiveLayout();
    }

    void start() {
        if (started) {
            return;
        }
        started = true;
        handler.post(snapshotPoller);
    }

    void stop() {
        started = false;
        handler.removeCallbacks(snapshotPoller);
        handler.removeCallbacks(blankLongPress);
        activity.setHudMinimapRect(0, 0, 0, 0, false);
    }

    /** Called by the Activity before it dispatches a touch to SDL. */
    void observeGlobalTouchEvent(MotionEvent event) {
        if (editing) {
            return;
        }
        switch (event.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
                blankTouchActive = !isTouchInsideHud(event.getRawX(), event.getRawY());
                if (blankTouchActive) {
                    handler.postDelayed(blankLongPress, EDIT_LONG_PRESS_MS);
                }
                break;
            case MotionEvent.ACTION_MOVE:
                // Movement remains owned by SDL; a moving pointer is never an edit request.
                handler.removeCallbacks(blankLongPress);
                break;
            case MotionEvent.ACTION_CANCEL:
            case MotionEvent.ACTION_UP:
                blankTouchActive = false;
                handler.removeCallbacks(blankLongPress);
                break;
            default:
                break;
        }
    }

    void openSettings() {
        final String[] choices = {
            "编辑当前 HUD",
            "管理 Lua HUD",
            "选择布局/预设",
            "为当前页面另存布局",
            "导入布局文件",
            "导出布局文件",
            "分享当前布局",
            "恢复官方默认布局"
        };
        new AlertDialog.Builder(activity)
            .setTitle("Android HUD")
            .setItems(choices, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    switch (which) {
                        case 0:
                            enterEditMode();
                            break;
                        case 1:
                            activity.showLuaHudManager();
                            break;
                        case 2:
                            showLayoutPicker();
                            break;
                        case 3:
                            showSaveAsDialog();
                            break;
                        case 4:
                            activity.importHudLayout();
                            break;
                        case 5:
                            activity.exportHudLayout(exportCurrentLayout());
                            break;
                        case 6:
                            activity.shareHudLayout(exportCurrentLayout());
                            break;
                        case 7:
                            confirmResetDefaults();
                            break;
                        default:
                            break;
                    }
                }
            })
            .show();
    }

    void importLayoutJson(String rawJson) {
        if (rawJson == null || rawJson.trim().isEmpty()) {
            Toast.makeText(activity, "布局文件为空", Toast.LENGTH_SHORT).show();
            return;
        }
        try {
            JSONObject imported = new JSONObject(rawJson);
            JSONObject importedLayouts = imported.optJSONObject("layouts");
            if (importedLayouts == null) {
                // Accept a single-layout export too.
                if (!imported.has("components")) {
                    throw new JSONException("Missing layouts or components");
                }
                importedLayouts = new JSONObject();
                importedLayouts.put("imported", imported);
                imported.put("layouts", importedLayouts);
                imported.put("active", "imported");
            }

            JSONObject acceptedLayouts = new JSONObject();
            java.util.Iterator<String> keys = importedLayouts.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                JSONObject accepted = sanitizeLayout(importedLayouts.optJSONObject(key));
                if (accepted != null) {
                    acceptedLayouts.put(key, accepted);
                }
            }
            if (acceptedLayouts.length() == 0) {
                throw new JSONException("No supported HUD components");
            }

            String desiredActive = imported.optString("active", "");
            JSONObject localLayouts = layoutStore.optJSONObject("layouts");
            if (localLayouts == null) {
                localLayouts = new JSONObject();
                layoutStore.put("layouts", localLayouts);
            }
            String selectedImportedLayout = null;
            java.util.Iterator<String> acceptedKeys = acceptedLayouts.keys();
            while (acceptedKeys.hasNext()) {
                String sourceId = acceptedKeys.next();
                String targetId = sourceId;
                while (localLayouts.has(targetId)) {
                    targetId = "imported-" + UUID.randomUUID().toString();
                }
                localLayouts.put(targetId, acceptedLayouts.getJSONObject(sourceId));
                if (selectedImportedLayout == null || sourceId.equals(desiredActive)) {
                    selectedImportedLayout = targetId;
                }
            }
            activeLayoutId = selectedImportedLayout;
            layoutStore.put("schema", LAYOUT_SCHEMA_VERSION);
            layoutStore.put("active", activeLayoutId);
            JSONObject overrides = layoutStore.optJSONObject("contextLayouts");
            if (overrides == null) {
                overrides = new JSONObject();
                layoutStore.put("contextLayouts", overrides);
            }
            overrides.put(currentContext, activeLayoutId);
            saveLayoutStore();
            loadActiveLayout();
            Toast.makeText(activity, "已导入 HUD 布局", Toast.LENGTH_SHORT).show();
        } catch (JSONException e) {
            Log.w(TAG, "HUD layout import rejected", e);
            Toast.makeText(activity, "无法导入布局：格式或组件不兼容", Toast.LENGTH_LONG).show();
        }
    }

    private void loadLayoutStore() {
        String raw = preferences.getString(PREF_LAYOUTS, null);
        if (raw != null) {
            try {
                JSONObject candidate = new JSONObject(raw);
                if (candidate.optInt("schema", 0) == LAYOUT_SCHEMA_VERSION &&
                        candidate.optJSONObject("layouts") != null) {
                    layoutStore = candidate;
                    upgradeDefaultLayouts(candidate);
                    activeLayoutId = layoutForContext(currentContext);
                    candidate.put("active", activeLayoutId);
                    saveLayoutStore();
                    return;
                }
            } catch (JSONException e) {
                Log.w(TAG, "Ignoring invalid saved HUD layout", e);
            }
        }
        layoutStore = createDefaultStore();
        migrateV2Layout();
        migrateV1Layout();
        activeLayoutId = layoutForContext(currentContext);
        try {
            layoutStore.put("active", activeLayoutId);
        } catch (JSONException e) {
            throw new IllegalStateException("Could not select default HUD layout", e);
        }
        saveLayoutStore();
    }

    private void upgradeDefaultLayouts(JSONObject store) throws JSONException {
        if (store.optInt("defaultLayoutsVersion", 0) >= DEFAULT_LAYOUTS_VERSION) {
            return;
        }
        JSONObject layouts = store.optJSONObject("layouts");
        JSONObject overrides = store.optJSONObject("contextLayouts");
        if (layouts != null && overrides != null) {
            java.util.Iterator<String> contexts = overrides.keys();
            while (contexts.hasNext()) {
                String context = contexts.next();
                String layoutId = overrides.optString(context, "");
                // Regenerate only automatically-created per-context layouts.
                // Saved-as, imported and legacy layouts keep their components.
                if (layoutId.equals("context:" + context)) {
                    layouts.put(layoutId, createLayoutForContext(context));
                }
            }
        }
        store.put("defaultLayoutsVersion", DEFAULT_LAYOUTS_VERSION);
    }

    private void migrateV2Layout() {
        String old = preferences.getString(PREF_LAYOUTS_V2, null);
        if (old == null) {
            return;
        }
        try {
            JSONObject previous = new JSONObject(old);
            if (previous.optInt("schema", 0) != 2) {
                return;
            }
            JSONObject previousLayouts = previous.optJSONObject("layouts");
            JSONObject layouts = layoutStore.getJSONObject("layouts");
            if (previousLayouts == null) {
                return;
            }
            java.util.Iterator<String> keys = previousLayouts.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                JSONObject migrated = sanitizeLayout(previousLayouts.optJSONObject(key));
                if (migrated != null) {
                    layouts.put(key, migrated);
                }
            }

            JSONObject previousOverrides = previous.optJSONObject("contextLayouts");
            JSONObject overrides = layoutStore.getJSONObject("contextLayouts");
            if (previousOverrides != null) {
                java.util.Iterator<String> contexts = previousOverrides.keys();
                while (contexts.hasNext()) {
                    String context = contexts.next();
                    String layoutId = previousOverrides.optString(context, "");
                    if (layouts.has(layoutId)) {
                        overrides.put(context, layoutId);
                    }
                }
            }
        } catch (JSONException e) {
            Log.w(TAG, "Could not migrate v2 HUD layouts", e);
        }
    }

    private void migrateV1Layout() {
        String old = preferences.getString(PREF_LAYOUTS_V1, null);
        if (old == null) {
            return;
        }
        try {
            JSONObject previous = new JSONObject(old);
            JSONObject previousLayouts = previous.optJSONObject("layouts");
            JSONObject layouts = layoutStore.getJSONObject("layouts");
            if (previousLayouts == null) {
                return;
            }
            java.util.Iterator<String> keys = previousLayouts.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                JSONObject migrated = sanitizeLayout(previousLayouts.optJSONObject(key));
                if (migrated != null) {
                    layouts.put("legacy-" + key, migrated);
                }
            }
        } catch (JSONException e) {
            Log.w(TAG, "Could not migrate v1 HUD layouts", e);
        }
    }

    private JSONObject createDefaultStore() {
        JSONObject store = new JSONObject();
        try {
            store.put("schema", LAYOUT_SCHEMA_VERSION);
            store.put("defaultLayoutsVersion", DEFAULT_LAYOUTS_VERSION);
            store.put("active", "");
            store.put("layouts", new JSONObject());
            store.put("contextLayouts", new JSONObject());
        } catch (JSONException e) {
            throw new IllegalStateException("Could not create default HUD layouts", e);
        }
        return store;
    }

    private JSONObject createMapLayout() throws JSONException {
        JSONObject layout = new JSONObject();
        layout.put("name", "官方 · 游戏地图");
        JSONArray list = new JSONArray();
        list.put(newComponent(TYPE_STATUS, .02f, .03f, .27f, .14f, null).toJson());
        list.put(newComponent(TYPE_BODY, .02f, .19f, .23f, .38f, null).toJson());
        list.put(newComponent(TYPE_EQUIPMENT, .02f, .60f, .31f, .12f, null).toJson());
        list.put(newComponent(TYPE_PIXEL_MINIMAP, .74f, .03f, .24f, .31f, null).toJson());
        list.put(newComponent(TYPE_MESSAGES, .30f, .74f, .38f, .22f, null).toJson());
        list.put(newComponent(TYPE_ACTIONS, .66f, .56f, .32f, .40f, null).toJson());
        layout.put("components", list);
        return layout;
    }

    private JSONObject createTargetLayout() throws JSONException {
        JSONObject layout = new JSONObject();
        layout.put("name", "官方 · 瞄准与投掷");
        JSONArray list = new JSONArray();
        list.put(newComponent(TYPE_DANGER_COMPASS, .02f, .03f, .23f, .31f, null).toJson());
        list.put(newComponent(TYPE_EQUIPMENT, .02f, .37f, .28f, .12f, null).toJson());
        list.put(newComponent(TYPE_ACTIONS, .60f, .48f, .38f, .50f, null).toJson());
        layout.put("components", list);
        return layout;
    }

    private JSONObject createActionLayout(String name, float x, float y, float width, float height)
            throws JSONException {
        JSONObject layout = new JSONObject();
        layout.put("name", "官方 · " + name);
        JSONArray list = new JSONArray();
        list.put(newComponent(TYPE_ACTIONS, x, y, width, height, null).toJson());
        layout.put("components", list);
        return layout;
    }

    private JSONObject createTouchLayout(String name) throws JSONException {
        JSONObject layout = new JSONObject();
        layout.put("name", "官方 · " + name);
        layout.put("components", new JSONArray());
        return layout;
    }

    private String layoutForContext(String context) {
        if (context == null || context.isEmpty()) {
            context = "default";
        }
        JSONObject overrides = layoutStore.optJSONObject("contextLayouts");
        String override = overrides == null ? "" : overrides.optString(context, "");
        JSONObject layouts = layoutStore.optJSONObject("layouts");
        if (!override.isEmpty() && layouts != null && layouts.has(override)) {
            return override;
        }
        String layoutId = "context:" + context;
        if (layouts != null && layouts.has(layoutId)) {
            return layoutId;
        }
        try {
            if (layouts == null) {
                layouts = new JSONObject();
                layoutStore.put("layouts", layouts);
            }
            if (overrides == null) {
                overrides = new JSONObject();
                layoutStore.put("contextLayouts", overrides);
            }
            layouts.put(layoutId, createLayoutForContext(context));
            overrides.put(context, layoutId);
            return layoutId;
        } catch (JSONException e) {
            throw new IllegalStateException("Could not create HUD layout for " + context, e);
        }
    }

    private JSONObject createLayoutForContext(String context) throws JSONException {
        if (isDeveloperContext(context)) {
            JSONObject layout = new JSONObject();
            layout.put("name", "开发页面 · " + contextDisplayName(context));
            layout.put("components", new JSONArray());
            return layout;
        }
        if ("DEFAULTMODE".equals(context)) {
            return createMapLayout();
        }
        if ("TARGET".equals(context)) {
            return createTargetLayout();
        }
        if (needsDefaultActionPanel(context)) {
            return createActionLayout(contextDisplayName(context), .58f, .55f, .40f, .43f);
        }
        return createTouchLayout(contextDisplayName(context));
    }

    private boolean needsDefaultActionPanel(String context) {
        return "LOOK".equals(context) || "OVERMAP".equals(context) ||
            "OVERMAP_NOTES".equals(context) || "VEH_SHAPES".equals(context) ||
            "IUSE_SOFTWARE_KITTEN".equals(context) || "LIGHTSON".equals(context) ||
            "MINESWEEPER".equals(context) || "SNAKE".equals(context) ||
            "SOKOBAN".equals(context);
    }

    private boolean isDeveloperContext(String context) {
        return context.startsWith("DEBUG") || context.startsWith("EDITMAP") ||
            context.startsWith("EDIT_") || context.startsWith("EGET_") ||
            context.startsWith("MAPGEN_") || "OVERMAP_EDITOR".equals(context) ||
            context.startsWith("WISH_");
    }

    private String contextDisplayName(String context) {
        String label = CONTEXT_LABELS.get(context);
        return label == null ? context : label;
    }

    private HudComponent newComponent(String type, float x, float y, float width, float height,
            List<String> actions) {
        HudComponent component = new HudComponent();
        component.instanceId = type + "-" + UUID.randomUUID().toString();
        component.type = type;
        component.x = x;
        component.y = y;
        component.width = width;
        component.height = height;
        component.opacity = 88;
        component.actions = new ArrayList<>();
        if (actions != null) {
            component.actions.addAll(actions);
        }
        return component;
    }

    private void loadActiveLayout() {
        components.clear();
        JSONObject layout = getActiveLayout();
        JSONArray list = layout != null ? layout.optJSONArray("components") : null;
        if (list != null) {
            for (int i = 0; i < list.length(); i++) {
                HudComponent component = HudComponent.fromJson(list.optJSONObject(i));
                if (component != null && COMPONENT_LABELS.containsKey(component.type)) {
                    components.add(component);
                }
            }
        }
        renderLayout();
    }

    private JSONObject getActiveLayout() {
        JSONObject layouts = layoutStore.optJSONObject("layouts");
        if (layouts == null) {
            return null;
        }
        JSONObject layout = layouts.optJSONObject(activeLayoutId);
        if (layout == null) {
            java.util.Iterator<String> keys = layouts.keys();
            if (keys.hasNext()) {
                activeLayoutId = keys.next();
                layout = layouts.optJSONObject(activeLayoutId);
            }
        }
        return layout;
    }

    private void renderLayout() {
        for (RenderedComponent component : rendered.values()) {
            if (component.content instanceof PixelMinimapView) {
                ((PixelMinimapView) component.content).publishRect(false);
            }
            removeView(component.host);
        }
        rendered.clear();
        for (HudComponent component : components) {
            addRenderedComponent(component);
        }
        editorBar.bringToFront();
        updateRenderedState();
    }

    private void addRenderedComponent(final HudComponent component) {
        HudHostView host = new HudHostView(activity);
        host.setComponent(component);
        host.setBackground(backgroundFor(component));
        host.setAlpha(component.opacity / 100f);
        View content = createComponentContent(component);
        host.addView(content, new FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        addView(host);
        rendered.put(component.instanceId, new RenderedComponent(component, host, content));
        configureEditorInteraction(rendered.get(component.instanceId));
        positionComponent(host, component);
    }

    private View createComponentContent(HudComponent component) {
        if (TYPE_PIXEL_MINIMAP.equals(component.type)) {
            return new PixelMinimapView(activity);
        }
        if (TYPE_DANGER_COMPASS.equals(component.type)) {
            return new DangerCompassView(activity);
        }
        if (TYPE_OVERMAP.equals(component.type)) {
            return new OvermapView(activity);
        }
        if (TYPE_ACTIONS.equals(component.type)) {
            return new ActionPadView(activity, component.actions);
        }
        TextView text = new TextView(activity);
        text.setTextColor(Color.WHITE);
        text.setTextSize(13f);
        text.setGravity(Gravity.CENTER_VERTICAL);
        int pad = dp(7);
        text.setPadding(pad, pad, pad, pad);
        text.setLineSpacing(0, 1.0f);
        return text;
    }

    private void positionComponent(View view, HudComponent component) {
        if (getWidth() <= 0 || getHeight() <= 0) {
            view.post(new Runnable() {
                @Override
                public void run() {
                    RenderedComponent renderedComponent = rendered.get(component.instanceId);
                    if (renderedComponent != null) {
                        positionComponent(renderedComponent.host, component);
                    }
                }
            });
            return;
        }
        int width = Math.max(dp(96), Math.round(component.width * getWidth()));
        int height = Math.max(dp(52), Math.round(component.height * getHeight()));
        int left = Math.round(component.x * getWidth());
        int top = Math.round(component.y * getHeight());
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(width, height);
        params.leftMargin = Math.max(0, Math.min(left, Math.max(0, getWidth() - width)));
        params.topMargin = Math.max(0, Math.min(top, Math.max(0, getHeight() - height)));
        view.setLayoutParams(params);
        if (view instanceof HudHostView) {
            View content = ((HudHostView) view).getChildAt(0);
            if (content instanceof PixelMinimapView) {
                content.post(new Runnable() {
                    @Override public void run() {
                        ((PixelMinimapView) content).publishRect(true);
                    }
                });
            }
        }
    }

    private void updateRenderedState() {
        JSONObject currentState = state.optJSONObject("state");
        if (currentState == null) {
            currentState = new JSONObject();
        }
        for (RenderedComponent component : rendered.values()) {
            if (component.content instanceof TextView) {
                ((TextView) component.content).setText(textForComponent(component.model.type, currentState));
            } else if (component.content instanceof DangerCompassView) {
                ((DangerCompassView) component.content).setContacts(currentState.optJSONArray("hostiles"));
            } else if (component.content instanceof OvermapView) {
                ((OvermapView) component.content).setCells(currentState.optJSONArray("overmap"));
            } else if (component.content instanceof ActionPadView) {
                ((ActionPadView) component.content).setActionMetadata(actionInfos, currentContext,
                    contextRevision);
            }
            component.host.setBackground(backgroundFor(component.model));
            component.host.setAlpha(component.model.opacity / 100f);
        }
    }

    private CharSequence textForComponent(String type, JSONObject currentState) {
        if (TYPE_STATUS.equals(type)) {
            int stamina = currentState.optInt("stamina", 0);
            int staminaMax = Math.max(1, currentState.optInt("staminaMax", 1));
            int percent = Math.round(stamina * 100f / staminaMax);
            return "状态\n体力 " + percent + "%  疼痛 " + currentState.optInt("pain", 0) +
                "\n安全模式 " + safeModeName(currentState.optInt("safeMode", 0));
        }
        if (TYPE_BODY.equals(type)) {
            StringBuilder body = new StringBuilder("身体\n");
            JSONArray parts = currentState.optJSONArray("bodyParts");
            if (parts == null || parts.length() == 0) {
                return body.append("等待游戏状态…").toString();
            }
            int visible = Math.min(parts.length(), 8);
            for (int i = 0; i < visible; i++) {
                JSONObject part = parts.optJSONObject(i);
                if (part == null) {
                    continue;
                }
                int maximum = Math.max(1, part.optInt("maximum", 1));
                int percentage = Math.round(part.optInt("current", 0) * 100f / maximum);
                body.append(bodyPartName(part.optString("id", ""))).append(" ")
                    .append(percentage).append("%");
                if (i + 1 < visible) {
                    body.append("\n");
                }
            }
            return body.toString();
        }
        if (TYPE_EQUIPMENT.equals(type)) {
            String weapon = currentState.optString("weapon", "");
            return "装备\n" + (weapon.isEmpty() ? "徒手" : weapon);
        }
        if (TYPE_ENVIRONMENT.equals(type)) {
            JSONArray hostiles = currentState.optJSONArray("hostiles");
            int count = hostiles == null ? 0 : hostiles.length();
            return "周边\n可见威胁 " + count + "  个\n雷达只显示当前可见目标";
        }
        if (TYPE_MESSAGES.equals(type)) {
            return formattedMessages(currentState);
        }
        return COMPONENT_LABELS.get(type);
    }

    private CharSequence formattedMessages(JSONObject currentState) {
        SpannableStringBuilder text = new SpannableStringBuilder("消息\n");
        JSONArray messages = currentState.optJSONArray("formattedMessages");
        if (messages == null || messages.length() == 0) {
            JSONArray plainMessages = currentState.optJSONArray("messages");
            if (plainMessages == null || plainMessages.length() == 0) {
                return text.append("暂无消息");
            }
            for (int i = 0; i < plainMessages.length(); i++) {
                if (i > 0) text.append('\n');
                text.append(plainMessages.optString(i));
            }
            return text;
        }

        for (int i = 0; i < messages.length(); i++) {
            if (i > 0) text.append('\n');
            JSONObject message = messages.optJSONObject(i);
            if (message == null) continue;
            JSONArray runs = message.optJSONArray("runs");
            if (runs == null || runs.length() == 0) {
                text.append(message.optString("text"));
                continue;
            }
            for (int j = 0; j < runs.length(); j++) {
                JSONObject run = runs.optJSONObject(j);
                if (run == null) continue;
                int start = text.length();
                text.append(run.optString("text"));
                int end = text.length();
                if (end <= start) continue;
                text.setSpan(new ForegroundColorSpan(run.optInt("color", Color.WHITE)),
                    start, end, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
                if (run.optBoolean("bold", false)) {
                    text.setSpan(new StyleSpan(Typeface.BOLD), start, end,
                        Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
                }
            }
        }
        return text;
    }

    private void refreshSnapshot() {
        String raw = activity.getHudSnapshot();
        if (raw == null || raw.isEmpty()) {
            return;
        }
        try {
            JSONObject snapshot = new JSONObject(raw);
            if (snapshot.optInt("schema", 0) != SNAPSHOT_SCHEMA_VERSION) {
                return;
            }
            long revision = snapshot.optLong("revision", -1);
            if (revision == lastSnapshotRevision) {
                return;
            }
            lastSnapshotRevision = revision;
            state = snapshot;
            String nextContext = snapshot.optString("context", "DEFAULTMODE");
            contextRevision = snapshot.optInt("contextRevision", 0);
            actionInfos.clear();
            JSONArray metadata = snapshot.optJSONArray("actions");
            if (metadata != null) {
                for (int i = 0; i < metadata.length(); i++) {
                    ActionInfo info = ActionInfo.fromJson(metadata.optJSONObject(i));
                    if (info != null) {
                        actionInfos.put(info.id, info);
                    }
                }
            }
            if (!nextContext.equals(currentContext)) {
                currentContext = nextContext;
                activeLayoutId = layoutForContext(currentContext);
                try {
                    layoutStore.put("active", activeLayoutId);
                } catch (JSONException ignored) {
                }
                saveLayoutStore();
                loadActiveLayout();
            } else {
                updateRenderedState();
            }
        } catch (JSONException e) {
            Log.w(TAG, "Ignoring malformed native HUD snapshot", e);
        }
    }

    private LinearLayout createEditorBar() {
        LinearLayout bar = new LinearLayout(activity);
        bar.setOrientation(LinearLayout.HORIZONTAL);
        bar.setGravity(Gravity.CENTER_VERTICAL);
        bar.setPadding(dp(4), dp(4), dp(4), dp(4));
        bar.setBackgroundColor(0xEE20242A);
        addEditorButton(bar, "+ 组件", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showAddComponentDialog();
            }
        });
        addEditorButton(bar, "布局", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showLayoutPicker();
            }
        });
        addEditorButton(bar, "保存", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                saveActiveLayout();
                Toast.makeText(activity, "HUD 布局已保存", Toast.LENGTH_SHORT).show();
            }
        });
        addEditorButton(bar, "完成", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                leaveEditMode();
            }
        });
        return bar;
    }

    private void addEditorButton(LinearLayout bar, String label, View.OnClickListener listener) {
        Button button = new Button(activity);
        button.setAllCaps(false);
        button.setText(label);
        button.setTextSize(12f);
        button.setOnClickListener(listener);
        bar.addView(button, new LinearLayout.LayoutParams(0, dp(44), 1f));
    }

    private void enterEditMode() {
        if (editing) {
            return;
        }
        editing = true;
        activity.setLuaHudEditing(true);
        setClickable(true);
        editorBar.setVisibility(VISIBLE);
        for (RenderedComponent component : rendered.values()) {
            configureEditorInteraction(component);
        }
        updateRenderedState();
        editorBar.bringToFront();
    }

    private void leaveEditMode() {
        if (!editing) {
            return;
        }
        saveActiveLayout();
        editing = false;
        activity.setLuaHudEditing(false);
        setClickable(false);
        editorBar.setVisibility(GONE);
        for (RenderedComponent component : rendered.values()) {
            configureEditorInteraction(component);
        }
        updateRenderedState();
    }

    @SuppressLint("ClickableViewAccessibility")
    private void configureEditorInteraction(final RenderedComponent renderedComponent) {
        renderedComponent.host.setEditing(editing);
        if (!editing) {
            renderedComponent.host.setOnTouchListener(null);
            return;
        }
        renderedComponent.host.setOnTouchListener(new EditorTouchListener(renderedComponent));
    }

    private void showAddComponentDialog() {
        final List<String> types = new ArrayList<>(COMPONENT_LABELS.keySet());
        String[] labels = new String[types.size()];
        for (int i = 0; i < types.size(); i++) {
            labels[i] = COMPONENT_LABELS.get(types.get(i));
        }
        new AlertDialog.Builder(activity)
            .setTitle("添加官方 HUD 组件")
            .setItems(labels, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String type = types.get(which);
                    HudComponent component = newComponent(type, .38f, .35f, .25f, .18f, null);
                    components.add(component);
                    addRenderedComponent(component);
                    saveActiveLayout();
                }
            })
            .show();
    }

    private void showComponentMenu(final HudComponent component) {
        List<String> choices = new ArrayList<>();
        choices.add("调整尺寸和透明度");
        choices.add("删除组件");
        new AlertDialog.Builder(activity)
            .setTitle(COMPONENT_LABELS.get(component.type))
            .setItems(choices.toArray(new String[choices.size()]), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String selected = choices.get(which);
                    if ("调整尺寸和透明度".equals(selected)) {
                        showStyleEditor(component);
                    } else if ("删除组件".equals(selected)) {
                        removeComponent(component);
                    }
                }
            })
            .show();
    }

    private void showStyleEditor(final HudComponent component) {
        LinearLayout layout = new LinearLayout(activity);
        layout.setOrientation(LinearLayout.VERTICAL);
        int padding = dp(18);
        layout.setPadding(padding, padding, padding, padding);

        final float[] values = { component.width, component.height, component.opacity / 100f };
        addSlider(layout, "宽度", 10, 75, Math.round(values[0] * 100), new SliderCallback() {
            @Override
            public void onChanged(int value) {
                values[0] = value / 100f;
            }
        });
        addSlider(layout, "高度", 8, 75, Math.round(values[1] * 100), new SliderCallback() {
            @Override
            public void onChanged(int value) {
                values[1] = value / 100f;
            }
        });
        addSlider(layout, "不透明度", 25, 100, Math.round(values[2] * 100), new SliderCallback() {
            @Override
            public void onChanged(int value) {
                values[2] = value / 100f;
            }
        });
        new AlertDialog.Builder(activity)
            .setTitle("组件样式")
            .setView(layout)
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    component.width = clamp(values[0], .10f, .75f);
                    component.height = clamp(values[1], .08f, .75f);
                    component.opacity = Math.round(clamp(values[2], .25f, 1f) * 100);
                    renderLayout();
                    saveActiveLayout();
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void addSlider(LinearLayout layout, String label, final int min, final int max,
            int value, final SliderCallback callback) {
        final String suffix = label.contains("动画") ? " ms" : "%";
        TextView title = new TextView(activity);
        title.setText(label);
        layout.addView(title);
        LinearLayout row = new LinearLayout(activity);
        row.setOrientation(LinearLayout.HORIZONTAL);
        final TextView number = new TextView(activity);
        number.setGravity(Gravity.CENTER);
        number.setMinWidth(dp(52));
        SeekBar seekBar = new SeekBar(activity);
        seekBar.setMax(max - min);
        seekBar.setProgress(Math.max(0, Math.min(max - min, value - min)));
        number.setText(String.valueOf(value) + suffix);
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                int actual = min + progress;
                number.setText(String.valueOf(actual) + suffix);
                callback.onChanged(actual);
            }

            @Override public void onStartTrackingTouch(SeekBar seekBar) { }
            @Override public void onStopTrackingTouch(SeekBar seekBar) { }
        });
        row.addView(seekBar, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        row.addView(number);
        layout.addView(row);
    }

    private void removeComponent(HudComponent component) {
        components.remove(component);
        RenderedComponent removed = rendered.remove(component.instanceId);
        if (removed != null) {
            removeView(removed.host);
        }
        saveActiveLayout();
    }

    private void showLayoutPicker() {
        JSONObject layouts = layoutStore.optJSONObject("layouts");
        if (layouts == null) {
            return;
        }
        final List<String> ids = new ArrayList<>();
        final List<String> labels = new ArrayList<>();
        java.util.Iterator<String> keys = layouts.keys();
        while (keys.hasNext()) {
            String id = keys.next();
            JSONObject layout = layouts.optJSONObject(id);
            if (layout != null) {
                ids.add(id);
                labels.add(layout.optString("name", id));
            }
        }
        new AlertDialog.Builder(activity)
            .setTitle("选择 HUD 布局")
            .setItems(labels.toArray(new String[labels.size()]), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    activeLayoutId = ids.get(which);
                    try {
                        layoutStore.put("active", activeLayoutId);
                        JSONObject overrides = layoutStore.optJSONObject("contextLayouts");
                        if (overrides == null) {
                            overrides = new JSONObject();
                            layoutStore.put("contextLayouts", overrides);
                        }
                        overrides.put(currentContext, activeLayoutId);
                    } catch (JSONException e) {
                        Log.w(TAG, "Could not select HUD layout", e);
                    }
                    saveLayoutStore();
                    loadActiveLayout();
                }
            })
            .show();
    }

    private void showSaveAsDialog() {
        final EditText name = new EditText(activity);
        name.setHint("布局名称");
        new AlertDialog.Builder(activity)
            .setTitle("另存 HUD 布局")
            .setView(name)
            .setPositiveButton("保存", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String label = name.getText().toString().trim();
                    if (label.isEmpty()) {
                        return;
                    }
                    String id = "custom-" + UUID.randomUUID().toString();
                    try {
                        JSONObject copy = new JSONObject(getActiveLayout().toString());
                        copy.put("name", label);
                        layoutStore.getJSONObject("layouts").put(id, copy);
                        layoutStore.put("active", id);
                        JSONObject overrides = layoutStore.optJSONObject("contextLayouts");
                        if (overrides == null) {
                            overrides = new JSONObject();
                            layoutStore.put("contextLayouts", overrides);
                        }
                        overrides.put(currentContext, id);
                        activeLayoutId = id;
                        saveLayoutStore();
                        loadActiveLayout();
                    } catch (JSONException e) {
                        Log.w(TAG, "Could not save HUD layout copy", e);
                    }
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void confirmResetDefaults() {
        new AlertDialog.Builder(activity)
            .setTitle("恢复官方默认 HUD")
            .setMessage("这会删除当前设备上的自定义 HUD 布局。")
            .setPositiveButton("恢复", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    layoutStore = createDefaultStore();
                    activeLayoutId = layoutForContext(currentContext);
                    saveLayoutStore();
                    loadActiveLayout();
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void saveActiveLayout() {
        JSONObject layout = getActiveLayout();
        if (layout == null) {
            return;
        }
        JSONArray serialized = new JSONArray();
        for (HudComponent component : components) {
            serialized.put(component.toJson());
        }
        try {
            layout.put("components", serialized);
            layoutStore.put("active", activeLayoutId);
            saveLayoutStore();
        } catch (JSONException e) {
            Log.w(TAG, "Could not save active HUD layout", e);
        }
    }

    private void saveLayoutStore() {
        preferences.edit().putString(PREF_LAYOUTS, layoutStore.toString()).apply();
    }

    private String exportCurrentLayout() {
        try {
            saveActiveLayout();
            JSONObject exported = new JSONObject();
            exported.put("schema", LAYOUT_SCHEMA_VERSION);
            exported.put("active", activeLayoutId);
            JSONObject layouts = new JSONObject();
            layouts.put(activeLayoutId, new JSONObject(getActiveLayout().toString()));
            exported.put("layouts", layouts);
            return exported.toString(2);
        } catch (JSONException e) {
            Log.w(TAG, "Could not export HUD layout", e);
            return "";
        }
    }

    private JSONObject sanitizeLayout(JSONObject source) throws JSONException {
        if (source == null) {
            return null;
        }
        JSONObject output = new JSONObject();
        output.put("name", source.optString("name", "导入布局"));
        JSONArray outputComponents = new JSONArray();
        JSONArray sourceComponents = source.optJSONArray("components");
        if (sourceComponents != null) {
            for (int i = 0; i < sourceComponents.length(); i++) {
                HudComponent component = HudComponent.fromJson(sourceComponents.optJSONObject(i));
                if (component != null && COMPONENT_LABELS.containsKey(component.type)) {
                    outputComponents.put(component.toJson());
                }
            }
        }
        output.put("components", outputComponents);
        return output;
    }

    private boolean isTouchInsideHud(float rawX, float rawY) {
        int[] location = new int[2];
        for (RenderedComponent component : rendered.values()) {
            component.host.getLocationOnScreen(location);
            if (rawX >= location[0] && rawX <= location[0] + component.host.getWidth() &&
                    rawY >= location[1] && rawY <= location[1] + component.host.getHeight()) {
                return true;
            }
        }
        return false;
    }

    private GradientDrawable makePanelBackground(boolean highlighted) {
        GradientDrawable background = new GradientDrawable();
        background.setColor(highlighted ? 0xDD253B55 : 0xB8141A20);
        background.setCornerRadius(dp(8));
        if (highlighted) {
            background.setStroke(dp(2), 0xFF80D8FF);
        } else {
            background.setStroke(dp(1), 0x805D748A);
        }
        return background;
    }

    private GradientDrawable backgroundFor(HudComponent component) {
        if (TYPE_PIXEL_MINIMAP.equals(component.type) && !editing) {
            GradientDrawable transparent = new GradientDrawable();
            transparent.setColor(Color.TRANSPARENT);
            return transparent;
        }
        return makePanelBackground(editing);
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    private static float clamp(float value, float min, float max) {
        return Math.max(min, Math.min(max, value));
    }

    private static String safeModeName(int safeMode) {
        switch (safeMode) {
            case 1: return "开启";
            case 2: return "警戒停止";
            default: return "关闭";
        }
    }

    private static String bodyPartName(String id) {
        if ("head".equals(id)) return "头";
        if ("torso".equals(id)) return "躯干";
        if ("arm_l".equals(id)) return "左臂";
        if ("arm_r".equals(id)) return "右臂";
        if ("leg_l".equals(id)) return "左腿";
        if ("leg_r".equals(id)) return "右腿";
        return id;
    }

    private static LinkedHashMap<String, String> createComponentLabels() {
        LinkedHashMap<String, String> labels = new LinkedHashMap<>();
        labels.put(TYPE_STATUS, "状态摘要");
        labels.put(TYPE_BODY, "身体健康");
        labels.put(TYPE_EQUIPMENT, "装备状态");
        labels.put(TYPE_ENVIRONMENT, "周边信息");
        labels.put(TYPE_MESSAGES, "消息日志");
        labels.put(TYPE_PIXEL_MINIMAP, "局部像素地图");
        labels.put(TYPE_OVERMAP, "大地图地形");
        labels.put(TYPE_DANGER_COMPASS, "危险罗盘");
        labels.put(TYPE_ACTIONS, "直接动作按钮组");
        return labels;
    }

    private static LinkedHashMap<String, String> createContextLabels() {
        LinkedHashMap<String, String> labels = new LinkedHashMap<>();
        labels.put("DEFAULTMODE", "游戏地图");
        labels.put("TARGET", "瞄准与投掷");
        labels.put("LOOK", "周围查看");
        labels.put("OVERMAP", "大地图");
        labels.put("OVERMAP_NOTES", "大地图笔记");
        labels.put("LIST_SURROUNDINGS", "周边列表");
        labels.put("MAIN_MENU", "主菜单");
        labels.put("PICK_WORLD_DIALOG", "世界选择");
        labels.put("MODMANAGER_DIALOG", "世界模组");
        labels.put("WORLDGEN_CONFIRM_DIALOG", "世界生成确认");
        labels.put("LOAD_DELETE_CANCEL", "存档选择");
        labels.put("NEW_CHAR_DESCRIPTION", "人物描述");
        labels.put("NEW_CHAR_PROFESSIONS", "职业选择");
        labels.put("NEW_CHAR_SCENARIOS", "场景选择");
        labels.put("NEW_CHAR_SKILLS", "技能选择");
        labels.put("NEW_CHAR_TRAITS", "特质选择");
        labels.put("CALENDAR_UI", "日期选择");
        labels.put("MELEE_STYLE_PICKER", "武术流派选择");
        labels.put("DEFENSE_SETUP", "防守模式设置");
        labels.put("INVENTORY", "物品栏");
        labels.put("ADVANCED_INVENTORY", "高级物品管理");
        labels.put("PICKUP", "拾取物品");
        labels.put("ITEM_ACTIONS", "物品操作");
        labels.put("SORT_ARMOR", "护甲排序");
        labels.put("VENDING_MACHINE", "售货机");
        labels.put("APP_INTERACT", "设备操作");
        labels.put("VEH_INTERACT", "载具操作");
        labels.put("VEHICLE", "载具菜单");
        labels.put("VEH_SHAPES", "载具形状编辑");
        labels.put("CRAFTING", "制作");
        labels.put("CONSTRUCTION", "建造");
        labels.put("STUDY_ZONE_UI", "学习区域");
        labels.put("ZONES_MANAGER", "区域管理");
        labels.put("PLAYER_INFO", "人物信息");
        labels.put("BIONICS", "生化装置");
        labels.put("MUTATIONS", "变异");
        labels.put("SPELL_MENU", "法术");
        labels.put("MEDICAL", "医疗");
        labels.put("MORALE", "士气");
        labels.put("DIARY", "日记");
        labels.put("PROFICIENCY_WINDOW", "熟练度");
        labels.put("MA_DETAILS_UI", "武术详情");
        labels.put("BLOOD_TEST_RESULTS", "血液检测结果");
        labels.put("DIALOGUE_CHOOSE_RESPONSE", "对话选择");
        labels.put("FACTIONS", "阵营");
        labels.put("FACTION_MANAGER", "营地管理");
        labels.put("CARAVAN", "商队");
        labels.put("MISSION_UI", "任务");
        labels.put("DISP_NPCS", "NPC 列表");
        labels.put("OPTIONS", "游戏选项");
        labels.put("HELP_KEYBINDINGS", "按键帮助");
        labels.put("DISPLAY_HELP", "帮助");
        labels.put("AUTO_PICKUP", "自动拾取规则");
        labels.put("AUTO_PICKUP_TEST", "自动拾取测试");
        labels.put("AUTO_NOTES", "自动笔记");
        labels.put("SAFEMODE", "安全模式规则");
        labels.put("SAFEMODE_TEST", "安全模式测试");
        labels.put("COLORS", "颜色设置");
        labels.put("PANEL_MGMT", "面板管理");
        labels.put("SCORES_UI", "分数");
        labels.put("MESSAGE_LOG", "消息日志");
        labels.put("EXTENDED_DESCRIPTION", "详细说明");
        labels.put("SCROLLABLE_TEXT", "滚动文本");
        labels.put("UILIST", "通用列表");
        labels.put("YESNO", "确认选择");
        labels.put("YESNOQUIT", "确认或取消");
        labels.put("YES_NO_ALWAYS_NEVER", "确认选项");
        labels.put("YES_QUERY", "确认询问");
        labels.put("POPUP_WAIT", "提示信息");
        labels.put("WAIT_FOR_ANY_KEY", "等待输入");
        labels.put("CANCEL_ACTIVITY_OR_IGNORE_QUERY", "活动中断询问");
        labels.put("FRIENDS_ME_CANCEL", "友军操作确认");
        labels.put("STRING_INPUT", "文本输入");
        labels.put("STRING_EDITOR", "文本编辑");
        labels.put("INSERT_TABLE", "表格输入");
        labels.put("IUSE_SOFTWARE_KITTEN", "电子宠物");
        labels.put("LIGHTSON", "点灯游戏");
        labels.put("MINESWEEPER", "扫雷");
        labels.put("SNAKE", "贪吃蛇");
        labels.put("SOKOBAN", "推箱子");
        return labels;
    }

    private interface SliderCallback {
        void onChanged(int value);
    }

    private final class EditorTouchListener implements View.OnTouchListener {
        private final RenderedComponent renderedComponent;
        private final Handler pressHandler = new Handler();
        private float downRawX;
        private float downRawY;
        private float startX;
        private float startY;
        private float startWidth;
        private float startHeight;
        private boolean resizing;
        private boolean moved;
        private final Runnable longPress = new Runnable() {
            @Override
            public void run() {
                if (!moved) {
                    showComponentMenu(renderedComponent.model);
                }
            }
        };

        EditorTouchListener(RenderedComponent renderedComponent) {
            this.renderedComponent = renderedComponent;
        }

        @Override
        public boolean onTouch(View view, MotionEvent event) {
            HudComponent component = renderedComponent.model;
            switch (event.getActionMasked()) {
                case MotionEvent.ACTION_DOWN:
                    downRawX = event.getRawX();
                    downRawY = event.getRawY();
                    startX = component.x;
                    startY = component.y;
                    startWidth = component.width;
                    startHeight = component.height;
                    resizing = event.getX() >= view.getWidth() - dp(30) &&
                        event.getY() >= view.getHeight() - dp(30);
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
                        component.width = clamp(startWidth + dx, .10f, .75f);
                        component.height = clamp(startHeight + dy, .08f, .75f);
                    } else {
                        component.x = clamp(startX + dx, 0f, 1f - component.width);
                        component.y = clamp(startY + dy, 0f, 1f - component.height);
                    }
                    positionComponent(view, component);
                    return true;
                case MotionEvent.ACTION_CANCEL:
                case MotionEvent.ACTION_UP:
                    pressHandler.removeCallbacks(longPress);
                    if (moved) {
                        saveActiveLayout();
                    }
                    return true;
                default:
                    return true;
            }
        }
    }

    private static final class HudComponent {
        String instanceId;
        String type;
        float x;
        float y;
        float width;
        float height;
        int opacity;
        List<String> actions = new ArrayList<>();

        JSONObject toJson() {
            JSONObject json = new JSONObject();
            try {
                json.put("instanceId", instanceId);
                json.put("type", type);
                json.put("x", x);
                json.put("y", y);
                json.put("width", width);
                json.put("height", height);
                json.put("opacity", opacity);
                JSONArray actionArray = new JSONArray();
                for (String action : actions) {
                    actionArray.put(action);
                }
                json.put("actions", actionArray);
            } catch (JSONException e) {
                throw new IllegalStateException("Could not serialize HUD component", e);
            }
            return json;
        }

        static HudComponent fromJson(JSONObject json) {
            if (json == null) {
                return null;
            }
            String type = json.optString("type", "");
            if (!COMPONENT_LABELS.containsKey(type)) {
                return null;
            }
            HudComponent component = new HudComponent();
            component.instanceId = json.optString("instanceId", type + "-" + UUID.randomUUID().toString());
            component.type = type;
            component.x = clamp((float) json.optDouble("x", .35), 0f, .9f);
            component.y = clamp((float) json.optDouble("y", .35), 0f, .9f);
            component.width = clamp((float) json.optDouble("width", .25), .10f, .75f);
            component.height = clamp((float) json.optDouble("height", .18), .08f, .75f);
            component.x = Math.min(component.x, 1f - component.width);
            component.y = Math.min(component.y, 1f - component.height);
            component.opacity = Math.max(25, Math.min(100, json.optInt("opacity", 88)));
            JSONArray actions = json.optJSONArray("actions");
            if (actions != null) {
                for (int i = 0; i < actions.length(); i++) {
                    String action = actions.optString(i);
                    if (action != null && !action.isEmpty()) {
                        component.actions.add(action);
                    }
                }
            }
            return component;
        }
    }

    private static final class RenderedComponent {
        final HudComponent model;
        final HudHostView host;
        final View content;

        RenderedComponent(HudComponent model, HudHostView host, View content) {
            this.model = model;
            this.host = host;
            this.content = content;
        }
    }

    private static final class HudHostView extends FrameLayout {
        private boolean editing;
        private HudComponent component;

        HudHostView(Context context) {
            super(context);
            setClipChildren(false);
        }

        void setComponent(HudComponent component) {
            this.component = component;
        }

        void setEditing(boolean editing) {
            this.editing = editing;
        }

        @Override
        public boolean onInterceptTouchEvent(MotionEvent event) {
            return editing;
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            if (editing && component != null) {
                Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
                paint.setColor(Color.WHITE);
                paint.setTextSize(22f);
                canvas.drawText("↘", getWidth() - 26, getHeight() - 8, paint);
            }
        }
    }

    private static final class ActionInfo {
        String id;
        String label;
        String group;
        boolean repeatable;
        boolean dangerous;

        static ActionInfo fromJson(JSONObject json) {
            if (json == null || json.optString("id", "").isEmpty()) return null;
            ActionInfo info = new ActionInfo();
            info.id = json.optString("id");
            info.label = json.optString("label", info.id);
            info.group = json.optString("group", "context");
            info.repeatable = json.optBoolean("repeatable", false);
            info.dangerous = json.optBoolean("dangerous", false);
            return info;
        }
    }

    private final class ActionPadView extends ScrollView {
        private final TableLayout buttonTable;
        private int renderedContextRevision = -1;

        ActionPadView(Context context, List<String> actions) {
            super(context);
            setFillViewport(true);
            setVerticalScrollBarEnabled(true);
            buttonTable = new TableLayout(context);
            buttonTable.setStretchAllColumns(true);
            addView(buttonTable, new ScrollView.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        }

        void setActionMetadata(LinkedHashMap<String, ActionInfo> actions, String context,
                int revision) {
            if (revision == renderedContextRevision) return;
            renderedContextRevision = revision;
            buttonTable.removeAllViews();
            List<View> views = new ArrayList<>();
            for (ActionInfo info : actions.values()) {
                views.add(createActionButton(info));
            }
            addButtonGrid(views);
            scrollTo(0, 0);
        }

        private void addButtonGrid(List<View> views) {
            TableRow row = null;
            for (int i = 0; i < views.size(); i++) {
                if (i % 3 == 0) {
                    row = new TableRow(activity);
                    buttonTable.addView(row, new TableLayout.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
                }
                row.addView(views.get(i), new TableRow.LayoutParams(0, dp(42), 1f));
            }
        }

        @SuppressLint("ClickableViewAccessibility")
        private Button createActionButton(final ActionInfo info) {
            final Button button = makeButton(info.label);
            if (info.dangerous) button.setTextColor(0xFFFF6B6B);
            if (!info.repeatable) {
                button.setOnClickListener(new View.OnClickListener() {
                    @Override public void onClick(View view) {
                        dispatch(info);
                    }
                });
                return button;
            }
            final boolean[] repeated = { false };
            final Runnable repeater = new Runnable() {
                @Override public void run() {
                    repeated[0] = true;
                    if (dispatch(info)) handler.postDelayed(this, 90L);
                }
            };
            button.setOnTouchListener(new View.OnTouchListener() {
                @Override public boolean onTouch(View view, MotionEvent event) {
                    if (event.getActionMasked() == MotionEvent.ACTION_DOWN) {
                        repeated[0] = false;
                        handler.postDelayed(repeater, 350L);
                        return false;
                    }
                    if (event.getActionMasked() == MotionEvent.ACTION_UP ||
                            event.getActionMasked() == MotionEvent.ACTION_CANCEL) {
                        handler.removeCallbacks(repeater);
                        return false;
                    }
                    return false;
                }
            });
            button.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View view) {
                    if (!repeated[0]) dispatch(info);
                }
            });
            return button;
        }

        private Button makeButton(String label) {
            Button button = new Button(activity);
            button.setAllCaps(false);
            button.setText(label);
            button.setTextSize(10f);
            button.setPadding(0, 0, 0, 0);
            return button;
        }

        private boolean dispatch(ActionInfo info) {
            if (!activity.enqueueHudAction(info.id, contextRevision)) {
                Toast.makeText(activity, "页面已切换，请重新操作", Toast.LENGTH_SHORT).show();
                return false;
            }
            return true;
        }
    }

    private final class PixelMinimapView extends View {
        PixelMinimapView(Context context) { super(context); setWillNotDraw(true); }
        void publishRect(boolean visible) {
            int[] location = new int[2];
            getLocationOnScreen(location);
            activity.setHudMinimapRect(location[0], location[1], getWidth(), getHeight(), visible && isShown());
        }
        @Override protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
            super.onLayout(changed, left, top, right, bottom);
            publishRect(true);
        }
        @Override protected void onDetachedFromWindow() {
            publishRect(false);
            super.onDetachedFromWindow();
        }
    }

    private static final class DangerCompassView extends View {
        private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private JSONArray contacts = new JSONArray();

        DangerCompassView(Context context) {
            super(context);
            paint.setStrokeWidth(2f);
        }

        void setContacts(JSONArray contacts) {
            this.contacts = contacts == null ? new JSONArray() : contacts;
            invalidate();
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            float size = Math.min(getWidth(), getHeight()) - 16f;
            float radius = Math.max(12f, size / 2f);
            float cx = getWidth() / 2f;
            float cy = getHeight() / 2f;
            paint.setStyle(Paint.Style.STROKE);
            paint.setColor(0xFF5B9BD5);
            canvas.drawCircle(cx, cy, radius, paint);
            canvas.drawCircle(cx, cy, radius * .5f, paint);
            canvas.drawLine(cx - radius, cy, cx + radius, cy, paint);
            canvas.drawLine(cx, cy - radius, cx, cy + radius, paint);
            paint.setStyle(Paint.Style.FILL);
            paint.setColor(0xFF80D8FF);
            canvas.drawCircle(cx, cy, 5f, paint);
            for (int i = 0; i < contacts.length(); i++) {
                JSONObject contact = contacts.optJSONObject(i);
                if (contact == null) {
                    continue;
                }
                float dx = contact.optInt("dx", 0);
                float dy = contact.optInt("dy", 0);
                float distance = Math.max(1f, contact.optInt("distance", 1));
                float scale = Math.min(1f, distance / 60f);
                float nx = dx / distance * radius * scale;
                float ny = dy / distance * radius * scale;
                paint.setColor(0xFFFF6B6B);
                canvas.drawCircle(cx + nx, cy + ny, 5f, paint);
            }
            paint.setColor(Color.WHITE);
            paint.setTextSize(12f);
            canvas.drawText("危险罗盘", 8f, 16f, paint);
        }
    }

    private static final class OvermapView extends View {
        private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private JSONArray cells = new JSONArray();
        OvermapView(Context context) { super(context); }
        void setCells(JSONArray cells) { this.cells = cells == null ? new JSONArray() : cells; invalidate(); }
        @Override protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            int side = 7;
            float cellW = getWidth() / (float) side;
            float cellH = getHeight() / (float) side;
            for (int i = 0; i < side * side; i++) {
                JSONObject cell = i < cells.length() ? cells.optJSONObject(i) : null;
                paint.setColor(cell == null ? 0xFF30343A : cell.optInt("color", 0xFF606870));
                canvas.drawRect((i % side) * cellW, (i / side) * cellH,
                    (i % side + 1) * cellW, (i / side + 1) * cellH, paint);
                if (cell != null) {
                    paint.setColor(Color.WHITE);
                    paint.setTextSize(Math.min(cellW, cellH) * .7f);
                    canvas.drawText(cell.optString("symbol", "?"), (i % side) * cellW + 2,
                        (i / side + 1) * cellH - 2, paint);
                }
            }
        }
    }
}
