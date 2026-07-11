package com.lyhglytx.cataclysmcb;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.GradientDrawable;
import android.os.Handler;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.GridLayout;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
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
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * Android-only HUD that sits above SDL's SurfaceView.  Layout information is
 * intentionally expressed in fractions of the usable screen, not pixels, so a
 * layout can survive display-size and orientation changes and be shared safely.
 */
final class AndroidHudOverlay extends FrameLayout {
    private static final String TAG = "AndroidHud";
    private static final String PREFS_NAME = "android_hud";
    private static final String PREF_LAYOUTS = "layouts_v2";
    private static final String PREF_LAYOUTS_V1 = "layouts_v1";
    private static final int SCHEMA_VERSION = 2;
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
    private static final LinkedHashMap<String, String> ACTION_LABELS = createActionLabels();
    private static final List<String> DEFAULT_ACTIONS = Collections.unmodifiableList(Arrays.asList(
        "UP", "LEFT", "CONFIRM", "RIGHT", "DOWN", "QUIT", "inventory", "pickup", "examine",
        "wait", "look", "action_menu", "fire"
    ));

    private final CataclysmDDA activity;
    private final SharedPreferences preferences;
    private final Handler handler = new Handler();
    private final List<HudComponent> components = new ArrayList<>();
    private final Map<String, RenderedComponent> rendered = new HashMap<>();
    private final Set<String> availableActions = new HashSet<>();
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
            "选择布局/预设",
            "为当前页面另存布局",
            "折叠菜单与动画",
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
                            showLayoutPicker();
                            break;
                        case 2:
                            showSaveAsDialog();
                            break;
                        case 3:
                            showBehaviorSettings();
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

    private void showBehaviorSettings() {
        final String[] choices = { "锚定网格 + 缩放淡入", "底部抽屉 + 滑出", "锚定网格 + 无动画" };
        JSONObject settings = layoutStore.optJSONObject("settings");
        String surface = settings == null ? "grid" : settings.optString("groupSurface", "grid");
        String animation = settings == null ? "scale_fade" : settings.optString("animation", "scale_fade");
        int selected = "drawer".equals(surface) ? 1 : ("none".equals(animation) ? 2 : 0);
        new AlertDialog.Builder(activity)
            .setTitle("折叠菜单与动画")
            .setSingleChoiceItems(choices, selected, null)
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override public void onClick(DialogInterface dialog, int which) {
                    int checked = ((AlertDialog) dialog).getListView().getCheckedItemPosition();
                    try {
                        JSONObject next = layoutStore.optJSONObject("settings");
                        if (next == null) {
                            next = new JSONObject();
                            layoutStore.put("settings", next);
                        }
                        next.put("groupSurface", checked == 1 ? "drawer" : "grid");
                        next.put("animation", checked == 2 ? "none" :
                            (checked == 1 ? "slide" : "scale_fade"));
                        next.put("animationMs", 180);
                        saveLayoutStore();
                    } catch (JSONException e) {
                        Log.w(TAG, "Could not save HUD behavior", e);
                    }
                }
            })
            .setNeutralButton("动画速度", new DialogInterface.OnClickListener() {
                @Override public void onClick(DialogInterface dialog, int which) {
                    showAnimationSpeedDialog();
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void showAnimationSpeedDialog() {
        JSONObject settings = layoutStore.optJSONObject("settings");
        int current = settings == null ? 180 : settings.optInt("animationMs", 180);
        LinearLayout content = new LinearLayout(activity);
        content.setOrientation(LinearLayout.VERTICAL);
        content.setPadding(dp(18), dp(12), dp(18), dp(12));
        final int[] selected = { current };
        addSlider(content, "动画时长", 0, 400, current, new SliderCallback() {
            @Override public void onChanged(int value) { selected[0] = value; }
        });
        new AlertDialog.Builder(activity)
            .setTitle("动画速度（0 为关闭）")
            .setView(content)
            .setPositiveButton("保存", new DialogInterface.OnClickListener() {
                @Override public void onClick(DialogInterface dialog, int which) {
                    try {
                        JSONObject next = layoutStore.optJSONObject("settings");
                        if (next == null) {
                            next = new JSONObject();
                            layoutStore.put("settings", next);
                        }
                        next.put("animationMs", selected[0]);
                        if (selected[0] == 0) next.put("animation", "none");
                        saveLayoutStore();
                    } catch (JSONException e) {
                        Log.w(TAG, "Could not save animation duration", e);
                    }
                }
            })
            .setNegativeButton("取消", null)
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
            layoutStore.put("schema", SCHEMA_VERSION);
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
                if (candidate.optInt("schema", 0) == SCHEMA_VERSION &&
                        candidate.optJSONObject("layouts") != null) {
                    layoutStore = candidate;
                    activeLayoutId = candidate.optString("active", "map");
                    if (candidate.optJSONObject("layouts").has(activeLayoutId)) {
                        return;
                    }
                }
            } catch (JSONException e) {
                Log.w(TAG, "Ignoring invalid saved HUD layout", e);
            }
        }
        layoutStore = createDefaultStore();
        activeLayoutId = "map";
        migrateV1Layout();
        saveLayoutStore();
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
            JSONObject layouts = new JSONObject();
            layouts.put("map", createMapLayout());
            layouts.put("menu", createActionLayout("菜单", .58f, .58f, .40f, .39f));
            layouts.put("inventory", createActionLayout("物品", .56f, .54f, .42f, .44f));
            layouts.put("target", createTargetLayout());
            layouts.put("world", createActionLayout("地图与查看", .58f, .55f, .40f, .43f));
            layouts.put("crafting", createActionLayout("制作与建造", .55f, .52f, .43f, .46f));
            layouts.put("text", createActionLayout("文本输入", .52f, .63f, .46f, .35f));
            layouts.put("generic", createActionLayout("通用页面", .56f, .58f, .42f, .40f));
            store.put("schema", SCHEMA_VERSION);
            store.put("active", "map");
            store.put("layouts", layouts);
            store.put("contextLayouts", new JSONObject());
            JSONObject settings = new JSONObject();
            settings.put("groupSurface", "grid");
            settings.put("animation", "scale_fade");
            settings.put("animationMs", 180);
            store.put("settings", settings);
        } catch (JSONException e) {
            throw new IllegalStateException("Could not create default HUD layouts", e);
        }
        return store;
    }

    private JSONObject createMapLayout() throws JSONException {
        JSONObject layout = new JSONObject();
        layout.put("name", "官方地图 HUD");
        JSONArray list = new JSONArray();
        list.put(newComponent(TYPE_STATUS, .02f, .03f, .27f, .14f, null).toJson());
        list.put(newComponent(TYPE_BODY, .02f, .19f, .23f, .38f, null).toJson());
        list.put(newComponent(TYPE_EQUIPMENT, .02f, .60f, .31f, .12f, null).toJson());
        list.put(newComponent(TYPE_PIXEL_MINIMAP, .74f, .03f, .24f, .31f, null).toJson());
        list.put(newComponent(TYPE_MESSAGES, .30f, .74f, .38f, .22f, null).toJson());
        list.put(newComponent(TYPE_ACTIONS, .66f, .56f, .32f, .40f, DEFAULT_ACTIONS).toJson());
        layout.put("components", list);
        return layout;
    }

    private JSONObject createTargetLayout() throws JSONException {
        JSONObject layout = new JSONObject();
        layout.put("name", "官方瞄准 HUD");
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
        layout.put("name", "官方" + name + " HUD");
        JSONArray list = new JSONArray();
        list.put(newComponent(TYPE_ACTIONS, x, y, width, height, null).toJson());
        layout.put("components", list);
        return layout;
    }

    private String contextFamily(String context) {
        if ("DEFAULTMODE".equals(context)) return "map";
        if ("TARGET".equals(context)) return "target";
        if ("LOOK".equals(context) || "OVERMAP".equals(context) ||
                context.contains("MAP")) return "world";
        if (context.contains("INVENTORY") || "INVENTORY".equals(context) ||
                context.contains("ITEM")) return "inventory";
        if (context.contains("CRAFT") || context.contains("CONSTRUCTION")) return "crafting";
        if (context.contains("STRING") || context.contains("TEXT")) return "text";
        if (context.contains("MENU") || context.contains("DIALOG") ||
                context.contains("YES") || context.contains("UILIST") ||
                "MAIN_MENU".equals(context) || "OPTIONS".equals(context)) return "menu";
        return "generic";
    }

    private String layoutForContext(String context) {
        JSONObject overrides = layoutStore.optJSONObject("contextLayouts");
        String override = overrides == null ? "" : overrides.optString(context, "");
        JSONObject layouts = layoutStore.optJSONObject("layouts");
        if (!override.isEmpty() && layouts != null && layouts.has(override)) {
            return override;
        }
        return contextFamily(context);
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

    private String textForComponent(String type, JSONObject currentState) {
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
            StringBuilder messages = new StringBuilder("消息\n");
            JSONArray list = currentState.optJSONArray("messages");
            if (list == null || list.length() == 0) {
                return messages.append("暂无消息").toString();
            }
            for (int i = 0; i < list.length(); i++) {
                if (i > 0) {
                    messages.append("\n");
                }
                messages.append(list.optString(i));
            }
            return messages.toString();
        }
        return COMPONENT_LABELS.get(type);
    }

    private void refreshSnapshot() {
        String raw = activity.getHudSnapshot();
        if (raw == null || raw.isEmpty()) {
            return;
        }
        try {
            JSONObject snapshot = new JSONObject(raw);
            if (snapshot.optInt("schema", 0) != SCHEMA_VERSION) {
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
            availableActions.clear();
            actionInfos.clear();
            JSONArray actions = snapshot.optJSONArray("availableActions");
            if (actions != null) {
                for (int i = 0; i < actions.length(); i++) {
                    availableActions.add(actions.optString(i));
                }
            }
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
                    HudComponent component = newComponent(type, .38f, .35f, .25f, .18f,
                        TYPE_ACTIONS.equals(type) ? DEFAULT_ACTIONS : null);
                    components.add(component);
                    addRenderedComponent(component);
                    saveActiveLayout();
                }
            })
            .show();
    }

    private void showComponentMenu(final HudComponent component) {
        List<String> choices = new ArrayList<>();
        if (TYPE_ACTIONS.equals(component.type)) {
            choices.add("编辑直接动作按钮");
        }
        choices.add("调整尺寸和透明度");
        choices.add("删除组件");
        new AlertDialog.Builder(activity)
            .setTitle(COMPONENT_LABELS.get(component.type))
            .setItems(choices.toArray(new String[choices.size()]), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String selected = choices.get(which);
                    if ("编辑直接动作按钮".equals(selected)) {
                        showActionPicker(component);
                    } else if ("调整尺寸和透明度".equals(selected)) {
                        showStyleEditor(component);
                    } else if ("删除组件".equals(selected)) {
                        removeComponent(component);
                    }
                }
            })
            .show();
    }

    private void showActionPicker(final HudComponent component) {
        final List<String> ids = new ArrayList<>(actionInfos.keySet());
        final String[] labels = new String[ids.size()];
        final boolean[] checked = new boolean[ids.size()];
        for (int i = 0; i < ids.size(); i++) {
            ActionInfo info = actionInfos.get(ids.get(i));
            labels[i] = info == null ? ids.get(i) : info.label;
            checked[i] = component.actions.contains(ids.get(i));
        }
        new AlertDialog.Builder(activity)
            .setTitle("直接动作按钮")
            .setMultiChoiceItems(labels, checked, new DialogInterface.OnMultiChoiceClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which, boolean isChecked) {
                    checked[which] = isChecked;
                }
            })
            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    component.actions.clear();
                    for (int i = 0; i < ids.size(); i++) {
                        if (checked[i]) {
                            component.actions.add(ids.get(i));
                        }
                    }
                    renderLayout();
                    saveActiveLayout();
                }
            })
            .setNegativeButton("取消", null)
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
            exported.put("schema", SCHEMA_VERSION);
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

    private static LinkedHashMap<String, String> createActionLabels() {
        LinkedHashMap<String, String> labels = new LinkedHashMap<>();
        labels.put("UP", "向北");
        labels.put("RIGHTUP", "向东北");
        labels.put("RIGHT", "向东");
        labels.put("RIGHTDOWN", "向东南");
        labels.put("DOWN", "向南");
        labels.put("LEFTDOWN", "向西南");
        labels.put("LEFT", "向西");
        labels.put("LEFTUP", "向西北");
        labels.put("pause", "原地等待");
        labels.put("LEVEL_DOWN", "下楼");
        labels.put("LEVEL_UP", "上楼");
        labels.put("center", "居中视角");
        labels.put("cycle_move", "切换移动模式");
        labels.put("toggle_run", "切换奔跑");
        labels.put("toggle_crouch", "切换蹲伏");
        labels.put("toggle_prone", "切换卧倒");
        labels.put("open", "打开");
        labels.put("close", "关闭");
        labels.put("smash", "砸碎");
        labels.put("loot", "搜刮");
        labels.put("examine", "检查");
        labels.put("interact", "互动");
        labels.put("pickup", "拾取");
        labels.put("pickup_all", "全部拾取");
        labels.put("grab", "抓取");
        labels.put("haul", "搬运");
        labels.put("butcher", "屠宰");
        labels.put("chat", "交谈");
        labels.put("look", "观察");
        labels.put("inventory", "背包");
        labels.put("apply", "使用物品");
        labels.put("apply_wielded", "使用手持物品");
        labels.put("eat", "进食");
        labels.put("wield", "手持物品");
        labels.put("reload_weapon", "装填武器");
        labels.put("reload_wielded", "装填手持物品");
        labels.put("throw", "投掷");
        labels.put("throw_wielded", "投掷手持物品");
        labels.put("fire", "开火");
        labels.put("select_fire_mode", "射击模式");
        labels.put("wait", "等待菜单");
        labels.put("sleep", "睡眠");
        labels.put("safemode", "安全模式");
        labels.put("autosafe", "自动安全模式");
        labels.put("autoattack", "自动攻击");
        labels.put("ignore_enemy", "忽略敌人");
        labels.put("action_menu", "动作菜单");
        labels.put("messages", "消息记录");
        labels.put("map", "大地图");
        labels.put("missions", "任务");
        labels.put("help", "帮助");
        labels.put("main_menu", "主菜单");
        labels.put("zoom_in", "放大");
        labels.put("zoom_out", "缩小");
        labels.put("CONFIRM", "确认");
        labels.put("QUIT", "返回");
        labels.put("PAGE_UP", "上一页");
        labels.put("PAGE_DOWN", "下一页");
        labels.put("SCROLL_UP", "上滚");
        labels.put("SCROLL_DOWN", "下滚");
        labels.put("HOME", "顶部");
        labels.put("END", "底部");
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

    private final class ActionPadView extends TableLayout {
        private final List<String> pinnedActions = new ArrayList<>();
        private int renderedContextRevision = -1;
        private PopupWindow openGroup;

        ActionPadView(Context context, List<String> actions) {
            super(context);
            setStretchAllColumns(true);
            pinnedActions.addAll(actions);
        }

        void setActionMetadata(LinkedHashMap<String, ActionInfo> actions, String context,
                int revision) {
            if (revision == renderedContextRevision) return;
            renderedContextRevision = revision;
            removeAllViews();
            final List<ActionInfo> direct = new ArrayList<>();
            final LinkedHashMap<String, List<ActionInfo>> grouped = new LinkedHashMap<>();
            Set<String> used = new HashSet<>();
            for (String id : pinnedActions) {
                ActionInfo info = actions.get(id);
                if (info != null && used.add(id)) direct.add(info);
            }
            for (ActionInfo info : actions.values()) {
                if (used.contains(info.id)) continue;
                if ("primary".equals(info.group) || "navigation".equals(info.group)) {
                    direct.add(info);
                    used.add(info.id);
                } else {
                    if (!grouped.containsKey(info.group)) grouped.put(info.group, new ArrayList<ActionInfo>());
                    grouped.get(info.group).add(info);
                }
            }
            List<View> views = new ArrayList<>();
            for (ActionInfo info : direct) views.add(createActionButton(info, null));
            for (Map.Entry<String, List<ActionInfo>> entry : grouped.entrySet()) {
                views.add(createGroupButton(entry.getKey(), entry.getValue()));
            }
            addButtonGrid(views);
        }

        private void addButtonGrid(List<View> views) {
            TableRow row = null;
            for (int i = 0; i < views.size(); i++) {
                if (i % 3 == 0) {
                    row = new TableRow(activity);
                    addView(row, new TableLayout.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
                }
                row.addView(views.get(i), new TableRow.LayoutParams(0, dp(42), 1f));
            }
        }

        private Button createGroupButton(final String group, final List<ActionInfo> actions) {
            Button button = makeButton(groupLabel(group) + " (" + actions.size() + ")");
            button.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View anchor) { showActionGroup(anchor, group, actions); }
            });
            button.setOnLongClickListener(new View.OnLongClickListener() {
                @Override public boolean onLongClick(View view) {
                    showGroupSurfacePicker(group);
                    return true;
                }
            });
            return button;
        }

        private void showGroupSurfacePicker(final String group) {
            final String[] choices = { "跟随全局设置", "锚定网格", "底部抽屉" };
            new AlertDialog.Builder(activity)
                .setTitle(groupLabel(group) + "菜单样式")
                .setItems(choices, new DialogInterface.OnClickListener() {
                    @Override public void onClick(DialogInterface dialog, int which) {
                        try {
                            JSONObject settings = layoutStore.optJSONObject("settings");
                            if (settings == null) {
                                settings = new JSONObject();
                                layoutStore.put("settings", settings);
                            }
                            JSONObject overrides = settings.optJSONObject("groupSurfaces");
                            if (overrides == null) {
                                overrides = new JSONObject();
                                settings.put("groupSurfaces", overrides);
                            }
                            if (which == 0) overrides.remove(group);
                            else overrides.put(group, which == 2 ? "drawer" : "grid");
                            saveLayoutStore();
                        } catch (JSONException e) {
                            Log.w(TAG, "Could not save group menu style", e);
                        }
                    }
                }).show();
        }

        @SuppressLint("ClickableViewAccessibility")
        private Button createActionButton(final ActionInfo info, final PopupWindow owner) {
            final Button button = makeButton(info.label);
            if (info.dangerous) button.setTextColor(0xFFFF6B6B);
            button.setOnTouchListener(new View.OnTouchListener() {
                final Runnable repeater = new Runnable() {
                    @Override public void run() {
                        if (dispatch(info)) handler.postDelayed(this, 90L);
                    }
                };
                @Override public boolean onTouch(View view, MotionEvent event) {
                    if (event.getActionMasked() == MotionEvent.ACTION_DOWN) {
                        dispatch(info);
                        if (info.repeatable) handler.postDelayed(repeater, 350L);
                        if (owner != null && !info.repeatable) owner.dismiss();
                        return true;
                    }
                    if (event.getActionMasked() == MotionEvent.ACTION_UP ||
                            event.getActionMasked() == MotionEvent.ACTION_CANCEL) {
                        handler.removeCallbacks(repeater);
                        if (owner != null) owner.dismiss();
                        return true;
                    }
                    return true;
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

        private void showActionGroup(View anchor, String group, List<ActionInfo> actions) {
            if (openGroup != null) openGroup.dismiss();
            ScrollView scroll = new ScrollView(activity);
            GridLayout grid = new GridLayout(activity);
            grid.setColumnCount(3);
            grid.setPadding(dp(6), dp(6), dp(6), dp(6));
            scroll.addView(grid);
            JSONObject settings = layoutStore.optJSONObject("settings");
            String surface = settings == null ? "grid" : settings.optString("groupSurface", "grid");
            JSONObject groupSurfaces = settings == null ? null : settings.optJSONObject("groupSurfaces");
            if (groupSurfaces != null) surface = groupSurfaces.optString(group, surface);
            boolean drawer = "drawer".equals(surface);
            final PopupWindow popup = new PopupWindow(scroll,
                drawer ? Math.max(dp(320), getWidth()) : dp(330),
                drawer ? dp(260) : ViewGroup.LayoutParams.WRAP_CONTENT, true);
            popup.setBackgroundDrawable(makePanelBackground(false));
            popup.setOutsideTouchable(true);
            for (ActionInfo info : actions) {
                Button button = createActionButton(info, popup);
                GridLayout.LayoutParams params = new GridLayout.LayoutParams();
                params.width = drawer ? 0 : dp(105);
                params.height = dp(46);
                if (drawer) params.columnSpec = GridLayout.spec(GridLayout.UNDEFINED, 1f);
                grid.addView(button, params);
            }
            openGroup = popup;
            if (drawer) popup.showAtLocation(AndroidHudOverlay.this, Gravity.BOTTOM, 0, 0);
            else popup.showAsDropDown(anchor, 0, -anchor.getHeight());
            animatePopup(scroll, settings);
        }

        private void animatePopup(View view, JSONObject settings) {
            String animation = settings == null ? "scale_fade" : settings.optString("animation", "scale_fade");
            int duration = settings == null ? 180 : settings.optInt("animationMs", 180);
            if ("none".equals(animation)) return;
            view.setAlpha(0f);
            if ("slide".equals(animation)) {
                view.setTranslationY(dp(32));
                view.animate().alpha(1f).translationY(0f).setDuration(duration).start();
            } else {
                view.setScaleX(.86f);
                view.setScaleY(.86f);
                view.animate().alpha(1f).scaleX(1f).scaleY(1f).setDuration(duration).start();
            }
        }
    }

    private String groupLabel(String group) {
        if ("combat".equals(group)) return "战斗";
        if ("items".equals(group)) return "物品";
        if ("world".equals(group)) return "地图";
        if ("character".equals(group)) return "角色";
        if ("system".equals(group)) return "系统";
        if ("text".equals(group)) return "输入/筛选";
        return "当前页面";
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
