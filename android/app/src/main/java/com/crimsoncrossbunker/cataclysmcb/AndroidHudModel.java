package com.crimsoncrossbunker.cataclysmcb;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Set;

/**
 * Pure schema-5 domain model for the Android HUD.
 *
 * Coordinates use one 1920x1080 landscape canvas.  Root element coordinates
 * are canvas-relative; child coordinates are relative to their parent group's
 * origin but retain the same canvas units.  Resizing a group therefore changes
 * its clipping rectangle without scaling its children.
 */
final class AndroidHudModel {
    static final int SCHEMA = 5;
    static final int LEGACY_SCHEMA = 4;
    static final int CANVAS_WIDTH = 1920;
    static final int CANVAS_HEIGHT = 1080;
    static final int MAX_SCENES = 128;
    static final int MAX_LAYOUTS_PER_SCENE = 64;
    static final int MAX_ELEMENTS_PER_LAYOUT = 512;
    static final int MAX_ELEMENT_DEPTH = 8;
    static final int MAX_ACTIONS_PER_ELEMENT = 64;
    static final int MAX_PACKAGE_CHARS = 2 * 1024 * 1024;

    static final String KIND_PACKAGE = "package";
    static final String KIND_LAYOUT = "layout";
    static final String TYPE_GROUP = "group";
    static final String TYPE_INFO = "info";
    static final String TYPE_CONTROL = "control";
    static final String RISK_SAFE = "safe";
    static final String RISK_CONFIRM = "confirm";
    static final String RISK_DANGEROUS = "dangerous";
    static final String SELECTOR_MODE_MENU = "menu";
    static final String SELECTOR_MODE_CYCLE = "cycle";
    static final String OVERFLOW_FIXED = "fixed";
    static final String OVERFLOW_SCROLL = "scroll";
    static final String TEXT_EFFECT_NONE = "none";
    static final String TEXT_EFFECT_OUTLINE = "outline";
    static final String TEXT_EFFECT_SHADOW = "shadow";
    static final String INFO_APPEARANCE_NATIVE = "native";
    static final String INFO_APPEARANCE_CUSTOM = "custom";

    private AndroidHudModel() {
    }

    static final class PackageData {
        final LinkedHashMap<String, Scene> scenes = new LinkedHashMap<>();

        PackageData copy() {
            PackageData result = new PackageData();
            for (Scene scene : scenes.values()) {
                result.scenes.put(scene.id, scene.copy());
            }
            return result;
        }

        JSONObject toJson() throws JSONException {
            JSONObject root = new JSONObject();
            root.put("format", "cataclysm-android-hud");
            root.put("kind", KIND_PACKAGE);
            root.put("schema", SCHEMA);
            JSONArray encodedScenes = new JSONArray();
            for (Scene scene : scenes.values()) {
                encodedScenes.put(scene.toJson());
            }
            root.put("scenes", encodedScenes);
            return root;
        }

        static PackageData fromJson(JSONObject root) throws JSONException {
            int schema = root == null ? 0 : root.optInt("schema", 0);
            if (root == null || (schema != SCHEMA && schema != LEGACY_SCHEMA) ||
                    !KIND_PACKAGE.equals(root.optString("kind", KIND_PACKAGE))) {
                throw new JSONException("Unsupported Android HUD package");
            }
            PackageData result = new PackageData();
            JSONArray scenes = root.optJSONArray("scenes");
            if (scenes == null) {
                throw new JSONException("Missing scenes");
            }
            for (int i = 0; i < scenes.length() && result.scenes.size() < MAX_SCENES; ++i) {
                Scene scene = Scene.fromJson(scenes.optJSONObject(i));
                if (scene != null && !result.scenes.containsKey(scene.id)) {
                    result.scenes.put(scene.id, scene);
                }
            }
            return result;
        }
    }

    static final class Scene {
        String id = "";
        String title = "";
        String activeLayoutId = "";
        final LinkedHashMap<String, Layout> layouts = new LinkedHashMap<>();
        final LinkedHashMap<String, ActionDescriptor> actionCatalog = new LinkedHashMap<>();

        Scene copy() {
            Scene result = new Scene();
            result.id = id;
            result.title = title;
            result.activeLayoutId = activeLayoutId;
            for (Layout layout : layouts.values()) {
                result.layouts.put(layout.id, layout.copy());
            }
            for (ActionDescriptor action : actionCatalog.values()) {
                result.actionCatalog.put(action.id, action.copy());
            }
            return result;
        }

        Layout activeLayout() {
            Layout active = layouts.get(activeLayoutId);
            if (active != null) {
                return active;
            }
            return layouts.isEmpty() ? null : layouts.values().iterator().next();
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("title", title);
            json.put("activeLayoutId", activeLayoutId);
            JSONArray encodedLayouts = new JSONArray();
            for (Layout layout : layouts.values()) {
                encodedLayouts.put(layout.toJson());
            }
            json.put("layouts", encodedLayouts);
            JSONArray encodedActions = new JSONArray();
            for (ActionDescriptor action : actionCatalog.values()) {
                encodedActions.put(action.toJson());
            }
            json.put("lastKnownActions", encodedActions);
            return json;
        }

        static Scene fromJson(JSONObject json) throws JSONException {
            if (json == null) {
                return null;
            }
            Scene result = new Scene();
            result.id = safeId(json.optString("id", ""));
            result.title = boundedText(json.optString("title", result.id), 100);
            result.activeLayoutId = safeId(json.optString("activeLayoutId", ""));
            if (result.id.isEmpty()) {
                return null;
            }
            JSONArray layouts = json.optJSONArray("layouts");
            if (layouts != null) {
                for (int i = 0; i < layouts.length() &&
                        result.layouts.size() < MAX_LAYOUTS_PER_SCENE; ++i) {
                    Layout layout = Layout.fromJson(layouts.optJSONObject(i));
                    if (layout != null && !result.layouts.containsKey(layout.id)) {
                        result.layouts.put(layout.id, layout);
                    }
                }
            }
            JSONArray actions = json.optJSONArray("lastKnownActions");
            if (actions != null) {
                for (int i = 0; i < actions.length() && i < 1024; ++i) {
                    ActionDescriptor action = ActionDescriptor.fromJson(actions.optJSONObject(i));
                    if (action != null && !result.actionCatalog.containsKey(action.id)) {
                        result.actionCatalog.put(action.id, action);
                    }
                }
            }
            if (!result.layouts.containsKey(result.activeLayoutId)) {
                result.activeLayoutId = result.layouts.isEmpty() ? "" :
                    result.layouts.values().iterator().next().id;
            }
            return result;
        }
    }

    static final class Layout {
        String id = "";
        String name = "";
        final ArrayList<Element> elements = new ArrayList<>();

        Layout copy() {
            Layout result = new Layout();
            result.id = id;
            result.name = name;
            for (Element element : elements) {
                result.elements.add(element.copy());
            }
            return result;
        }

        Element find(String elementId) {
            return find(elements, elementId);
        }

        Element findParent(String elementId) {
            return findParent(elements, elementId);
        }

        List<Element> childrenOf(String groupId) {
            if (groupId == null || groupId.isEmpty()) {
                return elements;
            }
            Element group = find(groupId);
            return group != null && TYPE_GROUP.equals(group.type) ? group.children : null;
        }

        boolean remove(String elementId) {
            return remove(elements, elementId);
        }

        int elementCount() {
            return count(elements);
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("name", name);
            JSONArray encoded = new JSONArray();
            for (Element element : elements) {
                encoded.put(element.toJson());
            }
            json.put("elements", encoded);
            return json;
        }

        static Layout fromJson(JSONObject json) throws JSONException {
            if (json == null) {
                return null;
            }
            Layout result = new Layout();
            result.id = safeId(json.optString("id", ""));
            result.name = boundedText(json.optString("name", "自定义布局"), 100);
            if (result.id.isEmpty()) {
                return null;
            }
            JSONArray elements = json.optJSONArray("elements");
            Set<String> ids = new HashSet<>();
            int[] count = { 0 };
            if (elements != null) {
                decodeElements(elements, result.elements, ids, count, 0);
            }
            return result;
        }

        private static Element find(List<Element> roots, String id) {
            if (id == null || id.isEmpty()) {
                return null;
            }
            for (Element element : roots) {
                if (id.equals(element.id)) {
                    return element;
                }
                Element nested = find(element.children, id);
                if (nested != null) {
                    return nested;
                }
            }
            return null;
        }

        private static Element findParent(List<Element> roots, String id) {
            for (Element element : roots) {
                for (Element child : element.children) {
                    if (id.equals(child.id)) {
                        return element;
                    }
                }
                Element nested = findParent(element.children, id);
                if (nested != null) {
                    return nested;
                }
            }
            return null;
        }

        private static boolean remove(List<Element> roots, String id) {
            for (int i = 0; i < roots.size(); ++i) {
                if (id.equals(roots.get(i).id)) {
                    roots.remove(i);
                    return true;
                }
                if (remove(roots.get(i).children, id)) {
                    return true;
                }
            }
            return false;
        }

        private static int count(List<Element> roots) {
            int result = roots.size();
            for (Element element : roots) {
                result += count(element.children);
            }
            return result;
        }
    }

    static final class Element {
        String id = "";
        String type = TYPE_INFO;
        String label = "";
        boolean visible = true;
        String overflowMode = OVERFLOW_FIXED;
        final Frame frame = new Frame();
        final Style style = new Style();
        final ControlAppearance controlAppearance = new ControlAppearance();

        // Group payload.
        boolean clipChildren = true;
        final ArrayList<Element> children = new ArrayList<>();

        // Information payload.
        String sourceId = "";
        final InfoPresentation infoPresentation = new InfoPresentation();

        // Interactive payload shared by groups, information and controls.
        final ArrayList<String> actionIds = new ArrayList<>();
        final HashSet<String> authorizedDangerousActions = new HashSet<>();

        // Control presentation payload.
        String defaultActionId = "";
        String selectedActionId = "";
        String selectorMode = SELECTOR_MODE_MENU;

        Element copy() {
            Element result = new Element();
            result.id = id;
            result.type = type;
            result.label = label;
            result.visible = visible;
            result.overflowMode = overflowMode;
            result.frame.set(frame);
            result.style.set(style);
            result.controlAppearance.set(controlAppearance);
            result.clipChildren = clipChildren;
            for (Element child : children) {
                result.children.add(child.copy());
            }
            result.sourceId = sourceId;
            result.infoPresentation.set(infoPresentation);
            result.actionIds.addAll(actionIds);
            result.defaultActionId = defaultActionId;
            result.selectedActionId = selectedActionId;
            result.selectorMode = selectorMode;
            result.authorizedDangerousActions.addAll(authorizedDangerousActions);
            return result;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("type", type);
            if (!label.isEmpty()) {
                json.put("label", label);
            }
            if (!visible) {
                json.put("visible", false);
            }
            if (!OVERFLOW_FIXED.equals(overflowMode)) {
                json.put("overflow", overflowMode);
            }
            json.put("frame", frame.toJson());
            JSONObject encodedStyle = style.toJson();
            if (encodedStyle.length() > 0) {
                json.put("style", encodedStyle);
            }
            if (TYPE_GROUP.equals(type)) {
                if (!clipChildren) {
                    json.put("clipChildren", false);
                }
                JSONArray encodedChildren = new JSONArray();
                for (Element child : children) {
                    encodedChildren.put(child.toJson());
                }
                json.put("children", encodedChildren);
            } else if (TYPE_INFO.equals(type)) {
                json.put("sourceId", sourceId);
                JSONObject info = infoPresentation.toJson();
                if (info.length() > 0) {
                    json.put("info", info);
                }
            } else if (TYPE_CONTROL.equals(type)) {
                if (!defaultActionId.isEmpty()) {
                    json.put("defaultActionId", defaultActionId);
                }
                if (!selectedActionId.isEmpty() &&
                        !selectedActionId.equals(defaultActionId)) {
                    json.put("selectedActionId", selectedActionId);
                }
                if (!SELECTOR_MODE_MENU.equals(selectorMode)) {
                    json.put("selectorMode", selectorMode);
                }
                // Presence distinguishes schema-5 controls from pre-surface
                // controls even when every appearance field is at its default.
                json.put("controlAppearance", controlAppearance.toJson());
            }
            if (shouldEncodeActionBinding(this)) {
                JSONArray actions = new JSONArray();
                for (String action : actionIds) {
                    actions.put(action);
                }
                json.put("actionIds", actions);
                JSONArray authorized = new JSONArray();
                for (String action : actionIds) {
                    if (authorizedDangerousActions.contains(action)) {
                        authorized.put(action);
                    }
                }
                json.put("authorizedDangerousActions", authorized);
            }
            return json;
        }

        static Element fromJson(JSONObject json, Set<String> ids, int[] count, int depth)
                throws JSONException {
            if (json == null || depth > MAX_ELEMENT_DEPTH ||
                    count[0] >= MAX_ELEMENTS_PER_LAYOUT) {
                return null;
            }
            String id = safeId(json.optString("id", ""));
            String type = json.optString("type", "");
            if (id.isEmpty() || ids.contains(id) || !isElementType(type)) {
                return null;
            }
            Element result = new Element();
            result.id = id;
            result.type = type;
            result.label = boundedText(json.optString("label", ""), 100);
            result.visible = json.optBoolean("visible", true);
            result.overflowMode = OVERFLOW_SCROLL.equals(
                json.optString("overflow", OVERFLOW_FIXED)) ?
                OVERFLOW_SCROLL : OVERFLOW_FIXED;
            result.frame.set(Frame.fromJson(json.optJSONObject("frame")));
            JSONObject encodedStyle = json.optJSONObject("style");
            boolean hasExplicitContentPadding =
                Style.hasExplicitContentPadding(encodedStyle);
            result.style.set(Style.fromJson(encodedStyle));
            ids.add(id);
            count[0]++;

            if (TYPE_GROUP.equals(type)) {
                result.clipChildren = json.optBoolean("clipChildren", true);
                decodeElements(json.optJSONArray("children"), result.children, ids, count, depth + 1);
            } else if (TYPE_INFO.equals(type)) {
                result.sourceId = migrateSourceId(
                    safeId(json.optString("sourceId", "")));
                if (result.sourceId.isEmpty()) {
                    return null;
                }
                normalizeElementGeometry(result);
                result.infoPresentation.set(InfoPresentation.fromJson(
                    json.optJSONObject("info"),
                    json.optJSONObject("providerSettings"), result.style));
            }
            if (supportsActionBinding(type)) {
                decodeActionBinding(json, result);
            }
            if (TYPE_CONTROL.equals(type)) {
                JSONObject appearance = json.optJSONObject("controlAppearance");
                if (!hasExplicitContentPadding) {
                    if (appearance == null) {
                        // Pre-ControlAppearance controls were platform Buttons
                        // with implicit horizontal/vertical content padding.
                        // Make that old visual spacing explicit in Style.
                        result.style.setContentPadding(8f, 2f);
                    } else if (appearance.has("horizontalPaddingDp") ||
                            appearance.has("verticalPaddingDp")) {
                        // ControlAppearance briefly owned content padding.
                        // Consume those legacy fields once; new files keep all
                        // element content insets in the shared Style object.
                        float horizontal = clampFinite(
                            appearance.optDouble("horizontalPaddingDp", 8f), 0, 64);
                        float vertical = clampFinite(
                            appearance.optDouble("verticalPaddingDp", 2f), 0, 64);
                        result.style.setContentPadding(horizontal, vertical);
                    }
                }
                result.controlAppearance.set(appearance == null ?
                    ControlAppearance.fromLegacy(result.style) :
                    ControlAppearance.fromJson(appearance));
                if (appearance == null && "left".equals(result.style.alignment)) {
                    // Legacy platform Buttons always centered their text; the
                    // stored default alignment was never applied to controls.
                    result.style.alignment = "center";
                }
                result.defaultActionId = acceptedAction(
                    json.optString("defaultActionId", ""), result.actionIds);
                result.selectedActionId = acceptedAction(
                    json.optString("selectedActionId", ""), result.actionIds);
                if (result.defaultActionId.isEmpty() && !result.actionIds.isEmpty()) {
                    result.defaultActionId = result.actionIds.get(0);
                }
                if (result.selectedActionId.isEmpty()) {
                    result.selectedActionId = result.defaultActionId;
                }
                result.selectorMode = SELECTOR_MODE_CYCLE.equals(
                    json.optString("selectorMode", SELECTOR_MODE_MENU)) ?
                    SELECTOR_MODE_CYCLE : SELECTOR_MODE_MENU;
            }
            return result;
        }
    }

    /**
     * Typed information-only formatting.  Character columns are independent
     * from the element frame; zero/-1 mean source-native automatic values.
     */
    static final class InfoPresentation {
        int columns;
        int labelColumns = -1;
        int radarRadius = 10;
        String appearanceMode = INFO_APPEARANCE_NATIVE;

        void set(InfoPresentation other) {
            columns = other.columns;
            labelColumns = other.labelColumns;
            radarRadius = other.radarRadius;
            appearanceMode = other.appearanceMode;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            if (columns > 0) {
                json.put("columns", columns);
            }
            if (labelColumns >= 0) {
                json.put("labelColumns", labelColumns);
            }
            if (radarRadius != 10) {
                json.put("radarRadius", radarRadius);
            }
            if (!INFO_APPEARANCE_NATIVE.equals(appearanceMode)) {
                json.put("appearance", appearanceMode);
            }
            return json;
        }

        static InfoPresentation fromJson(JSONObject encoded,
                JSONObject legacySettings, Style style) {
            InfoPresentation result = new InfoPresentation();
            if (encoded != null) {
                result.columns = clampInteger(encoded.optInt("columns", 0), 0, 80);
                int labels = encoded.optInt("labelColumns", -1);
                result.labelColumns = labels >= 0 && labels <= 40 ? labels : -1;
                result.radarRadius =
                    clampInteger(encoded.optInt("radarRadius", 10), 3, 30);
                result.appearanceMode = INFO_APPEARANCE_CUSTOM.equals(
                    encoded.optString("appearance", INFO_APPEARANCE_NATIVE)) ?
                    INFO_APPEARANCE_CUSTOM : INFO_APPEARANCE_NATIVE;
                return result;
            }
            if (legacySettings == null) {
                return result;
            }

            result.columns = parseLegacyInteger(
                legacySettings.optString("layoutColumns", ""), 0, 8, 80);
            result.labelColumns = parseLegacyInteger(
                legacySettings.optString("labelColumns", ""), -1, 0, 40);
            result.radarRadius = parseLegacyInteger(
                legacySettings.optString("radius", ""), 10, 3, 30);
            if ("false".equalsIgnoreCase(
                    legacySettings.optString("terminalGrid", "")) ||
                    !style.sourceColors || style.textBold || style.textItalic ||
                    !TEXT_EFFECT_NONE.equals(style.textEffect)) {
                result.appearanceMode = INFO_APPEARANCE_CUSTOM;
            }
            return result;
        }

        private static int parseLegacyInteger(String raw, int fallback,
                int minimum, int maximum) {
            try {
                return clampInteger(Integer.parseInt(raw.trim()), minimum, maximum);
            } catch (NumberFormatException | NullPointerException ignored) {
                return fallback;
            }
        }

        private static int clampInteger(int value, int minimum, int maximum) {
            return Math.max(minimum, Math.min(maximum, value));
        }
    }

    static final class Frame {
        float x = 80f;
        float y = 80f;
        float width = 320f;
        float height = 120f;

        void set(Frame other) {
            x = other.x;
            y = other.y;
            width = other.width;
            height = other.height;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("x", x);
            json.put("y", y);
            json.put("width", width);
            json.put("height", height);
            return json;
        }

        static Frame fromJson(JSONObject json) {
            Frame result = new Frame();
            if (json == null) {
                return result;
            }
            result.width = clampFinite(json.optDouble("width", 320), 32, CANVAS_WIDTH);
            result.height = clampFinite(json.optDouble("height", 120), 32, CANVAS_HEIGHT);
            result.x = clampFinite(json.optDouble("x", 80), 0, CANVAS_WIDTH);
            result.y = clampFinite(json.optDouble("y", 80), 0, CANVAS_HEIGHT);
            return result;
        }
    }

    static final class Style {
        float opacity = .90f;
        float fontSizeSp = 10f;
        int textColor = 0xFFFFFFFF;
        int backgroundColor = 0xCC111820;
        int borderColor = 0x996E8CA3;
        int textOutlineColor = 0xFF000000;
        float textOutlineWidthSp = 1.5f;
        int textShadowColor = 0x99000000;
        float textShadowRadiusSp = 2f;
        float textShadowOffsetXSp = 1f;
        float textShadowOffsetYSp = 1f;
        float contentPaddingLeftDp;
        float contentPaddingTopDp;
        float contentPaddingRightDp;
        float contentPaddingBottomDp;
        String alignment = "left";
        String textEffect = TEXT_EFFECT_NONE;
        boolean showLabel;
        boolean background;
        boolean border;
        boolean textBold;
        boolean textItalic;
        boolean sourceColors = true;

        void set(Style other) {
            opacity = other.opacity;
            fontSizeSp = other.fontSizeSp;
            textColor = other.textColor;
            backgroundColor = other.backgroundColor;
            borderColor = other.borderColor;
            textOutlineColor = other.textOutlineColor;
            textOutlineWidthSp = other.textOutlineWidthSp;
            textShadowColor = other.textShadowColor;
            textShadowRadiusSp = other.textShadowRadiusSp;
            textShadowOffsetXSp = other.textShadowOffsetXSp;
            textShadowOffsetYSp = other.textShadowOffsetYSp;
            contentPaddingLeftDp = other.contentPaddingLeftDp;
            contentPaddingTopDp = other.contentPaddingTopDp;
            contentPaddingRightDp = other.contentPaddingRightDp;
            contentPaddingBottomDp = other.contentPaddingBottomDp;
            alignment = other.alignment;
            textEffect = other.textEffect;
            showLabel = other.showLabel;
            background = other.background;
            border = other.border;
            textBold = other.textBold;
            textItalic = other.textItalic;
            sourceColors = other.sourceColors;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            if (Float.compare(opacity, .90f) != 0) {
                json.put("opacity", opacity);
            }
            if (Float.compare(fontSizeSp, 10f) != 0) {
                json.put("fontSizeSp", fontSizeSp);
            }
            if (textColor != 0xFFFFFFFF) {
                json.put("textColor", textColor);
            }
            if (backgroundColor != 0xCC111820) {
                json.put("backgroundColor", backgroundColor);
            }
            if (borderColor != 0x996E8CA3) {
                json.put("borderColor", borderColor);
            }
            if (!TEXT_EFFECT_NONE.equals(textEffect)) {
                json.put("textEffect", textEffect);
            }
            if (TEXT_EFFECT_OUTLINE.equals(textEffect) ||
                    textOutlineColor != 0xFF000000 ||
                    Float.compare(textOutlineWidthSp, 1.5f) != 0) {
                json.put("textOutlineColor", textOutlineColor);
                json.put("textOutlineWidthSp", textOutlineWidthSp);
            }
            if (TEXT_EFFECT_SHADOW.equals(textEffect) ||
                    textShadowColor != 0x99000000 ||
                    Float.compare(textShadowRadiusSp, 2f) != 0 ||
                    Float.compare(textShadowOffsetXSp, 1f) != 0 ||
                    Float.compare(textShadowOffsetYSp, 1f) != 0) {
                json.put("textShadowColor", textShadowColor);
                json.put("textShadowRadiusSp", textShadowRadiusSp);
                json.put("textShadowOffsetXSp", textShadowOffsetXSp);
                json.put("textShadowOffsetYSp", textShadowOffsetYSp);
            }
            if (sameContentPadding()) {
                if (contentPaddingLeftDp != 0f) {
                    json.put("paddingDp", contentPaddingLeftDp);
                }
            } else if (hasContentPadding()) {
                JSONArray padding = new JSONArray();
                padding.put(contentPaddingLeftDp);
                padding.put(contentPaddingTopDp);
                padding.put(contentPaddingRightDp);
                padding.put(contentPaddingBottomDp);
                json.put("contentPadding", padding);
            }
            if (!"left".equals(alignment)) {
                json.put("alignment", alignment);
            }
            if (showLabel) {
                json.put("showLabel", true);
            }
            if (background) {
                json.put("background", true);
            }
            if (border) {
                json.put("border", true);
            }
            if (textBold) {
                json.put("textBold", true);
            }
            if (textItalic) {
                json.put("textItalic", true);
            }
            if (!sourceColors) {
                json.put("sourceColors", false);
            }
            return json;
        }

        static Style fromJson(JSONObject json) {
            Style result = new Style();
            if (json == null) {
                return result;
            }
            result.opacity = clampFinite(json.optDouble("opacity", .90), 0, 1);
            result.fontSizeSp = clampFinite(json.optDouble("fontSizeSp", 10), 8, 40);
            result.textColor = (int)json.optLong("textColor", 0xFFFFFFFFL);
            result.backgroundColor = (int)json.optLong("backgroundColor", 0xCC111820L);
            result.borderColor = (int)json.optLong("borderColor", 0x996E8CA3L);
            result.textOutlineColor =
                (int)json.optLong("textOutlineColor", 0xFF000000L);
            result.textOutlineWidthSp =
                clampFinite(json.optDouble("textOutlineWidthSp", 1.5), 0, 6);
            result.textShadowColor =
                (int)json.optLong("textShadowColor", 0x99000000L);
            result.textShadowRadiusSp =
                clampFinite(json.optDouble("textShadowRadiusSp", 2), 0, 12);
            result.textShadowOffsetXSp =
                clampFinite(json.optDouble("textShadowOffsetXSp", 1), -12, 12);
            result.textShadowOffsetYSp =
                clampFinite(json.optDouble("textShadowOffsetYSp", 1), -12, 12);
            float uniformPadding =
                clampFinite(json.optDouble("paddingDp", 0), 0, 64);
            result.contentPaddingLeftDp = uniformPadding;
            result.contentPaddingTopDp = uniformPadding;
            result.contentPaddingRightDp = uniformPadding;
            result.contentPaddingBottomDp = uniformPadding;
            JSONArray padding = json.optJSONArray("contentPadding");
            if (padding != null) {
                result.contentPaddingLeftDp =
                    clampFinite(padding.optDouble(0, uniformPadding), 0, 64);
                result.contentPaddingTopDp =
                    clampFinite(padding.optDouble(1, uniformPadding), 0, 64);
                result.contentPaddingRightDp =
                    clampFinite(padding.optDouble(2, uniformPadding), 0, 64);
                result.contentPaddingBottomDp =
                    clampFinite(padding.optDouble(3, uniformPadding), 0, 64);
            }
            String alignment = json.optString("alignment", "left");
            result.alignment = "center".equals(alignment) || "right".equals(alignment) ?
                alignment : "left";
            String legacyEffect = json.optBoolean("textOutline", false) ?
                TEXT_EFFECT_OUTLINE : TEXT_EFFECT_NONE;
            String textEffect = json.optString("textEffect", legacyEffect);
            result.textEffect = TEXT_EFFECT_OUTLINE.equals(textEffect) ||
                TEXT_EFFECT_SHADOW.equals(textEffect) ? textEffect : TEXT_EFFECT_NONE;
            result.showLabel = json.optBoolean("showLabel", false);
            result.background = json.optBoolean("background", false);
            result.border = json.optBoolean("border", false);
            result.textBold = json.optBoolean("textBold", false);
            result.textItalic = json.optBoolean("textItalic", false);
            result.sourceColors = json.optBoolean("sourceColors", true);
            return result;
        }

        void setContentPadding(float horizontal, float vertical) {
            contentPaddingLeftDp = horizontal;
            contentPaddingTopDp = vertical;
            contentPaddingRightDp = horizontal;
            contentPaddingBottomDp = vertical;
        }

        static boolean hasExplicitContentPadding(JSONObject json) {
            return json != null &&
                (json.has("paddingDp") || json.has("contentPadding"));
        }

        private boolean hasContentPadding() {
            return contentPaddingLeftDp != 0f || contentPaddingTopDp != 0f ||
                contentPaddingRightDp != 0f || contentPaddingBottomDp != 0f;
        }

        private boolean sameContentPadding() {
            return Float.compare(contentPaddingLeftDp, contentPaddingTopDp) == 0 &&
                Float.compare(contentPaddingLeftDp, contentPaddingRightDp) == 0 &&
                Float.compare(contentPaddingLeftDp, contentPaddingBottomDp) == 0;
        }
    }

    /**
     * Control-only visual state.  It is serialized separately from Style so
     * information/group containers do not accumulate button-specific fields.
     * A missing object means a pre-ControlAppearance layout and is migrated
     * from the legacy background/border fields.
     */
    static final class ControlAppearance {
        private static final boolean DEFAULT_SURFACE = true;
        private static final int DEFAULT_SURFACE_COLOR = 0xCC263746;
        private static final int DEFAULT_PRESSED_OVERLAY_COLOR = 0x33FFFFFF;
        private static final boolean DEFAULT_BORDER = false;
        private static final int DEFAULT_BORDER_COLOR = 0xFF6E8CA3;
        private static final float DEFAULT_BORDER_WIDTH_DP = 1f;
        private static final float DEFAULT_CORNER_RADIUS_DP = 8f;
        private static final boolean DEFAULT_SHADOW = false;
        private static final int DEFAULT_SHADOW_COLOR = 0x66000000;
        private static final float DEFAULT_SHADOW_RADIUS_DP = 6f;
        private static final float DEFAULT_SHADOW_OFFSET_X_DP = 0f;
        private static final float DEFAULT_SHADOW_OFFSET_Y_DP = 2f;
        private static final float DEFAULT_SELECTOR_WIDTH_DP = 38f;
        private static final float DEFAULT_BUTTON_GAP_DP = 2f;

        boolean surface = DEFAULT_SURFACE;
        int surfaceColor = DEFAULT_SURFACE_COLOR;
        int pressedOverlayColor = DEFAULT_PRESSED_OVERLAY_COLOR;
        boolean border = DEFAULT_BORDER;
        int borderColor = DEFAULT_BORDER_COLOR;
        float borderWidthDp = DEFAULT_BORDER_WIDTH_DP;
        float cornerRadiusDp = DEFAULT_CORNER_RADIUS_DP;
        boolean shadow = DEFAULT_SHADOW;
        int shadowColor = DEFAULT_SHADOW_COLOR;
        float shadowRadiusDp = DEFAULT_SHADOW_RADIUS_DP;
        float shadowOffsetXDp = DEFAULT_SHADOW_OFFSET_X_DP;
        float shadowOffsetYDp = DEFAULT_SHADOW_OFFSET_Y_DP;
        float selectorWidthDp = DEFAULT_SELECTOR_WIDTH_DP;
        float buttonGapDp = DEFAULT_BUTTON_GAP_DP;

        void set(ControlAppearance other) {
            surface = other.surface;
            surfaceColor = other.surfaceColor;
            pressedOverlayColor = other.pressedOverlayColor;
            border = other.border;
            borderColor = other.borderColor;
            borderWidthDp = other.borderWidthDp;
            cornerRadiusDp = other.cornerRadiusDp;
            shadow = other.shadow;
            shadowColor = other.shadowColor;
            shadowRadiusDp = other.shadowRadiusDp;
            shadowOffsetXDp = other.shadowOffsetXDp;
            shadowOffsetYDp = other.shadowOffsetYDp;
            selectorWidthDp = other.selectorWidthDp;
            buttonGapDp = other.buttonGapDp;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            putChanged(json, "surface", surface, DEFAULT_SURFACE);
            putChanged(json, "surfaceColor", surfaceColor, DEFAULT_SURFACE_COLOR);
            putChanged(json, "pressedOverlayColor", pressedOverlayColor,
                DEFAULT_PRESSED_OVERLAY_COLOR);
            putChanged(json, "border", border, DEFAULT_BORDER);
            putChanged(json, "borderColor", borderColor, DEFAULT_BORDER_COLOR);
            putChanged(json, "borderWidthDp", borderWidthDp, DEFAULT_BORDER_WIDTH_DP);
            putChanged(json, "cornerRadiusDp", cornerRadiusDp, DEFAULT_CORNER_RADIUS_DP);
            putChanged(json, "shadow", shadow, DEFAULT_SHADOW);
            putChanged(json, "shadowColor", shadowColor, DEFAULT_SHADOW_COLOR);
            putChanged(json, "shadowRadiusDp", shadowRadiusDp, DEFAULT_SHADOW_RADIUS_DP);
            putChanged(json, "shadowOffsetXDp", shadowOffsetXDp,
                DEFAULT_SHADOW_OFFSET_X_DP);
            putChanged(json, "shadowOffsetYDp", shadowOffsetYDp,
                DEFAULT_SHADOW_OFFSET_Y_DP);
            putChanged(json, "selectorWidthDp", selectorWidthDp,
                DEFAULT_SELECTOR_WIDTH_DP);
            putChanged(json, "buttonGapDp", buttonGapDp, DEFAULT_BUTTON_GAP_DP);
            return json;
        }

        static ControlAppearance fromJson(JSONObject json) {
            ControlAppearance result = new ControlAppearance();
            if (json == null) {
                return result;
            }
            result.surface = json.optBoolean("surface", DEFAULT_SURFACE);
            result.surfaceColor =
                (int)json.optLong("surfaceColor", DEFAULT_SURFACE_COLOR);
            result.pressedOverlayColor =
                (int)json.optLong("pressedOverlayColor",
                    DEFAULT_PRESSED_OVERLAY_COLOR);
            result.border = json.optBoolean("border", DEFAULT_BORDER);
            result.borderColor =
                (int)json.optLong("borderColor", DEFAULT_BORDER_COLOR);
            result.borderWidthDp = clampFinite(
                json.optDouble("borderWidthDp", DEFAULT_BORDER_WIDTH_DP), 0, 12);
            result.cornerRadiusDp = clampFinite(
                json.optDouble("cornerRadiusDp", DEFAULT_CORNER_RADIUS_DP), 0, 64);
            result.shadow = json.optBoolean("shadow", DEFAULT_SHADOW);
            result.shadowColor =
                (int)json.optLong("shadowColor", DEFAULT_SHADOW_COLOR);
            result.shadowRadiusDp = clampFinite(
                json.optDouble("shadowRadiusDp", DEFAULT_SHADOW_RADIUS_DP), 0, 32);
            result.shadowOffsetXDp = clampFinite(
                json.optDouble("shadowOffsetXDp", DEFAULT_SHADOW_OFFSET_X_DP), -32, 32);
            result.shadowOffsetYDp = clampFinite(
                json.optDouble("shadowOffsetYDp", DEFAULT_SHADOW_OFFSET_Y_DP), -32, 32);
            result.selectorWidthDp = clampFinite(
                json.optDouble("selectorWidthDp", DEFAULT_SELECTOR_WIDTH_DP), 24, 120);
            result.buttonGapDp = clampFinite(
                json.optDouble("buttonGapDp", DEFAULT_BUTTON_GAP_DP), 0, 32);
            return result;
        }

        static ControlAppearance fromLegacy(Style style) {
            ControlAppearance result = new ControlAppearance();
            // Legacy controls were android.widget.Button instances, so they
            // always had a platform button surface even when the separate host
            // container's "background" option was disabled.  Mapping that
            // host flag to the new button surface made every existing control
            // become plain text after migration.
            result.surface = true;
            if (style.background) {
                result.surfaceColor = style.backgroundColor;
            }
            result.border = style.border;
            result.borderColor = style.borderColor;
            // Platform Button shadows were never a user setting.  Migrating
            // them as disabled removes the old transparent-button ghost.
            result.shadow = false;
            return result;
        }

        private static void putChanged(JSONObject json, String key,
                boolean value, boolean defaultValue) throws JSONException {
            if (value != defaultValue) {
                json.put(key, value);
            }
        }

        private static void putChanged(JSONObject json, String key,
                int value, int defaultValue) throws JSONException {
            if (value != defaultValue) {
                json.put(key, value);
            }
        }

        private static void putChanged(JSONObject json, String key,
                float value, float defaultValue) throws JSONException {
            if (Float.compare(value, defaultValue) != 0) {
                json.put(key, value);
            }
        }
    }

    static final class ActionDescriptor {
        String id = "";
        String label = "";
        String group = "context";
        String risk = RISK_SAFE;
        boolean repeatable;

        ActionDescriptor copy() {
            ActionDescriptor result = new ActionDescriptor();
            result.id = id;
            result.label = label;
            result.group = group;
            result.risk = risk;
            result.repeatable = repeatable;
            return result;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("label", label);
            json.put("group", group);
            json.put("risk", risk);
            json.put("repeatable", repeatable);
            return json;
        }

        static ActionDescriptor fromJson(JSONObject json) {
            if (json == null) {
                return null;
            }
            ActionDescriptor result = new ActionDescriptor();
            result.id = safeActionId(json.optString("id", ""));
            result.label = boundedText(json.optString("label", result.id), 100);
            result.group = safeId(json.optString("group", "context"));
            if (result.group.isEmpty()) {
                result.group = "context";
            }
            String risk = json.optString("risk",
                json.optBoolean("dangerous", false) ? RISK_DANGEROUS : RISK_SAFE);
            result.risk = RISK_CONFIRM.equals(risk) || RISK_DANGEROUS.equals(risk) ?
                risk : RISK_SAFE;
            result.repeatable = json.optBoolean("repeatable", false);
            return result.id.isEmpty() ? null : result;
        }
    }

    static final class InfoSource {
        String id = "";
        String title = "";
        String category = "";
        String renderer = "rich_text";
        String catalogTier = "single";
        float defaultWidth = 320;
        float defaultHeight = 100;
        boolean multiline;
        boolean square;
        boolean terminalConfigurable;
        boolean composite;
        int defaultColumns;
        int defaultLabelColumns = -1;

        static InfoSource fromJson(JSONObject json) {
            if (json == null) {
                return null;
            }
            InfoSource result = new InfoSource();
            result.id = safeId(json.optString("id", ""));
            result.title = boundedText(json.optString("title", result.id), 100);
            result.category = boundedText(json.optString("category", "高级"), 100);
            result.renderer = safeId(json.optString("renderer", "rich_text"));
            String tier = safeId(json.optString("catalogTier", "single"));
            result.catalogTier = "recommended".equals(tier) ||
                "advanced".equals(tier) ? tier : "single";
            result.defaultWidth = clampFinite(json.optDouble("defaultWidth", 320), 32, CANVAS_WIDTH);
            result.defaultHeight = clampFinite(json.optDouble("defaultHeight", 100), 32,
                CANVAS_HEIGHT);
            result.multiline = json.optBoolean("multiline", false);
            result.square = json.optBoolean("square", false);
            result.terminalConfigurable =
                json.optBoolean("terminalConfigurable",
                    json.optBoolean("configurableWidgetLayout", false));
            result.composite = json.optBoolean("composite", false);
            result.defaultColumns = Math.max(
                AndroidHudInfoFormat.MIN_COLUMNS,
                Math.min(AndroidHudInfoFormat.MAX_COLUMNS,
                    json.optInt("defaultColumns",
                        json.optInt("defaultWidgetColumns",
                            AndroidHudInfoFormat.MIN_COLUMNS))));
            int labels = json.optInt("defaultLabelColumns", -1);
            result.defaultLabelColumns = labels >= 0 &&
                labels <= AndroidHudInfoFormat.MAX_LABEL_COLUMNS ? labels : -1;
            return result.id.isEmpty() || result.renderer.isEmpty() ? null : result;
        }
    }

    private static void decodeElements(JSONArray encoded, List<Element> target, Set<String> ids,
            int[] count, int depth) throws JSONException {
        if (encoded == null || depth > MAX_ELEMENT_DEPTH) {
            return;
        }
        for (int i = 0; i < encoded.length() && count[0] < MAX_ELEMENTS_PER_LAYOUT; ++i) {
            Element element = Element.fromJson(encoded.optJSONObject(i), ids, count, depth);
            if (element != null) {
                target.add(element);
            }
        }
    }

    private static boolean isElementType(String type) {
        return TYPE_GROUP.equals(type) || TYPE_INFO.equals(type) || TYPE_CONTROL.equals(type);
    }

    static boolean supportsActionBinding(String type) {
        return TYPE_GROUP.equals(type) || TYPE_INFO.equals(type) || TYPE_CONTROL.equals(type);
    }

    static boolean supportsActionBinding(Element element) {
        return element != null && supportsActionBinding(element.type);
    }

    static boolean shouldEncodeActionBinding(Element element) {
        return supportsActionBinding(element) &&
            (TYPE_CONTROL.equals(element.type) || !element.actionIds.isEmpty());
    }

    static boolean requiresSquareFrame(Element element) {
        return element != null && TYPE_INFO.equals(element.type) &&
            ("map.pixel".equals(element.sourceId) ||
             "map.overmap_grid".equals(element.sourceId) ||
             "radar.threat_grid".equals(element.sourceId));
    }

    static void normalizeElementGeometry(Element element) {
        if (requiresSquareFrame(element)) {
            element.frame.height = element.frame.width;
            element.overflowMode = OVERFLOW_FIXED;
        }
    }

    private static void decodeActionBinding(JSONObject json, Element result) {
        JSONArray actions = json.optJSONArray("actionIds");
        if (actions != null) {
            for (int i = 0; i < actions.length() &&
                    result.actionIds.size() < MAX_ACTIONS_PER_ELEMENT; ++i) {
                String action = safeActionId(actions.optString(i, ""));
                if (!action.isEmpty() && !result.actionIds.contains(action)) {
                    result.actionIds.add(action);
                }
            }
        }
        JSONArray authorized = json.optJSONArray("authorizedDangerousActions");
        if (authorized != null) {
            for (int i = 0; i < authorized.length(); ++i) {
                String action = acceptedAction(authorized.optString(i, ""),
                    result.actionIds);
                if (!action.isEmpty()) {
                    result.authorizedDangerousActions.add(action);
                }
            }
        }
    }

    static String safeId(String raw) {
        if (raw == null) {
            return "";
        }
        String value = raw.trim();
        if (value.isEmpty() || value.length() > 160) {
            return "";
        }
        for (int i = 0; i < value.length(); ++i) {
            char c = value.charAt(i);
            if (!Character.isLetterOrDigit(c) && c != '_' && c != '-' && c != '.' && c != ':') {
                return "";
            }
        }
        return value;
    }

    static String safeActionId(String raw) {
        return safeId(raw);
    }

    private static String migrateSourceId(String sourceId) {
        if (!sourceId.startsWith("widget.")) {
            return sourceId;
        }
        String widget = sourceId.substring("widget.".length());
        switch (widget) {
            case "ll_limbs_layout":
                return "sidebar.legacy.limbs";
            case "ll_movement_layout":
                return "sidebar.legacy.movement";
            case "ll_stats_layout":
                return "sidebar.legacy.stats";
            case "all_weariness_layout":
                return "sidebar.legacy.weariness";
            case "ll_needs_layout":
                return "sidebar.legacy.needs";
            case "ll_place_layout":
                return "sidebar.legacy.place";
            case "wind_temp_layout":
                return "sidebar.legacy.wind_temperature";
            case "oxygen_layout":
                return "sidebar.legacy.oxygen";
            case "weapon_style_layout":
                return "sidebar.legacy.weapon_style";
            case "vehicle_acf_label_layout":
                return "sidebar.legacy.vehicle";
            case "compass_all_danger_layout":
                return "sidebar.legacy.compass";
            case "ll_weight_carried_value":
                return "sidebar.legacy.carry_weight";
            case "rad_badge_desc":
                return "sidebar.legacy.radiation";
            default:
                return sourceId;
        }
    }

    static String boundedText(String raw, int maximum) {
        if (raw == null) {
            return "";
        }
        String value = raw.trim();
        return value.length() > maximum ? value.substring(0, maximum) : value;
    }

    static boolean matchesSearch(String query, String... fields) {
        String normalizedQuery = query == null ? "" : query.trim().toLowerCase(Locale.ROOT);
        if (normalizedQuery.isEmpty()) {
            return true;
        }
        StringBuilder searchable = new StringBuilder();
        if (fields != null) {
            for (String field : fields) {
                if (field != null && !field.isEmpty()) {
                    searchable.append(field).append('\n');
                }
            }
        }
        String haystack = searchable.toString().toLowerCase(Locale.ROOT);
        for (String keyword : normalizedQuery.split("\\s+")) {
            if (!haystack.contains(keyword)) {
                return false;
            }
        }
        return true;
    }

    private static String acceptedAction(String candidate, List<String> actions) {
        String accepted = safeActionId(candidate);
        return actions.contains(accepted) ? accepted : "";
    }

    static float clampFinite(double value, double minimum, double maximum) {
        if (Double.isNaN(value) || Double.isInfinite(value)) {
            return (float)minimum;
        }
        return (float)Math.max(minimum, Math.min(maximum, value));
    }
}
