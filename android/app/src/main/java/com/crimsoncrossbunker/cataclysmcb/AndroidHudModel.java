package com.crimsoncrossbunker.cataclysmcb;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Set;

/**
 * Pure schema-4 domain model for the Android HUD.
 *
 * Coordinates use one 1920x1080 landscape canvas.  Root element coordinates
 * are canvas-relative; child coordinates are relative to their parent group's
 * origin but retain the same canvas units.  Resizing a group therefore changes
 * its clipping rectangle without scaling its children.
 */
final class AndroidHudModel {
    static final int SCHEMA = 4;
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
            if (root == null || root.optInt("schema", 0) != SCHEMA ||
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

        // Group payload.
        boolean clipChildren = true;
        final ArrayList<Element> children = new ArrayList<>();

        // Information payload.
        String sourceId = "";
        final LinkedHashMap<String, String> providerSettings = new LinkedHashMap<>();

        // Interactive payload shared by information and control elements.
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
            result.clipChildren = clipChildren;
            for (Element child : children) {
                result.children.add(child.copy());
            }
            result.sourceId = sourceId;
            result.providerSettings.putAll(providerSettings);
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
            json.put("visible", visible);
            json.put("overflow", overflowMode);
            json.put("frame", frame.toJson());
            json.put("style", style.toJson());
            if (TYPE_GROUP.equals(type)) {
                json.put("clipChildren", clipChildren);
                JSONArray encodedChildren = new JSONArray();
                for (Element child : children) {
                    encodedChildren.put(child.toJson());
                }
                json.put("children", encodedChildren);
            } else if (TYPE_INFO.equals(type)) {
                json.put("sourceId", sourceId);
                JSONObject settings = new JSONObject();
                for (String key : providerSettings.keySet()) {
                    settings.put(key, providerSettings.get(key));
                }
                json.put("providerSettings", settings);
            } else if (TYPE_CONTROL.equals(type)) {
                json.put("defaultActionId", defaultActionId);
                json.put("selectedActionId", selectedActionId);
                json.put("selectorMode", selectorMode);
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
            result.style.set(Style.fromJson(json.optJSONObject("style")));
            ids.add(id);
            count[0]++;

            if (TYPE_GROUP.equals(type)) {
                result.clipChildren = json.optBoolean("clipChildren", true);
                decodeElements(json.optJSONArray("children"), result.children, ids, count, depth + 1);
            } else if (TYPE_INFO.equals(type)) {
                result.sourceId = safeId(json.optString("sourceId", ""));
                if (result.sourceId.isEmpty()) {
                    return null;
                }
                normalizeElementGeometry(result);
                JSONObject settings = json.optJSONObject("providerSettings");
                if (settings != null) {
                    Iterator<String> keys = settings.keys();
                    while (keys.hasNext() && result.providerSettings.size() < 32) {
                        String key = safeId(keys.next());
                        if (!key.isEmpty()) {
                            result.providerSettings.put(key,
                                boundedText(settings.optString(key, ""), 200));
                        }
                    }
                }
            }
            if (supportsActionBinding(type)) {
                decodeActionBinding(json, result);
            }
            if (TYPE_CONTROL.equals(type)) {
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
        String alignment = "left";
        boolean showLabel = true;
        boolean background;
        boolean border;
        boolean textBold;
        boolean textItalic;
        boolean textOutline;

        void set(Style other) {
            opacity = other.opacity;
            fontSizeSp = other.fontSizeSp;
            textColor = other.textColor;
            backgroundColor = other.backgroundColor;
            borderColor = other.borderColor;
            textOutlineColor = other.textOutlineColor;
            textOutlineWidthSp = other.textOutlineWidthSp;
            alignment = other.alignment;
            showLabel = other.showLabel;
            background = other.background;
            border = other.border;
            textBold = other.textBold;
            textItalic = other.textItalic;
            textOutline = other.textOutline;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("opacity", opacity);
            json.put("fontSizeSp", fontSizeSp);
            json.put("textColor", textColor);
            json.put("backgroundColor", backgroundColor);
            json.put("borderColor", borderColor);
            json.put("textOutlineColor", textOutlineColor);
            json.put("textOutlineWidthSp", textOutlineWidthSp);
            json.put("alignment", alignment);
            json.put("showLabel", showLabel);
            json.put("background", background);
            json.put("border", border);
            json.put("textBold", textBold);
            json.put("textItalic", textItalic);
            json.put("textOutline", textOutline);
            return json;
        }

        static Style fromJson(JSONObject json) {
            Style result = new Style();
            if (json == null) {
                return result;
            }
            result.opacity = clampFinite(json.optDouble("opacity", .90), .1, 1);
            result.fontSizeSp = clampFinite(json.optDouble("fontSizeSp", 10), 8, 40);
            result.textColor = (int)json.optLong("textColor", 0xFFFFFFFFL);
            result.backgroundColor = (int)json.optLong("backgroundColor", 0xCC111820L);
            result.borderColor = (int)json.optLong("borderColor", 0x996E8CA3L);
            result.textOutlineColor =
                (int)json.optLong("textOutlineColor", 0xFF000000L);
            result.textOutlineWidthSp =
                clampFinite(json.optDouble("textOutlineWidthSp", 1.5), .5, 6);
            String alignment = json.optString("alignment", "left");
            result.alignment = "center".equals(alignment) || "right".equals(alignment) ?
                alignment : "left";
            result.showLabel = json.optBoolean("showLabel", true);
            result.background = json.optBoolean("background", false);
            result.border = json.optBoolean("border", false);
            result.textBold = json.optBoolean("textBold", false);
            result.textItalic = json.optBoolean("textItalic", false);
            result.textOutline = json.optBoolean("textOutline", false);
            return result;
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
        String renderer = "text";
        float defaultWidth = 320;
        float defaultHeight = 100;
        boolean multiline;
        boolean square;

        static InfoSource fromJson(JSONObject json) {
            if (json == null) {
                return null;
            }
            InfoSource result = new InfoSource();
            result.id = safeId(json.optString("id", ""));
            result.title = boundedText(json.optString("title", result.id), 100);
            result.category = boundedText(json.optString("category", "高级"), 100);
            result.renderer = safeId(json.optString("renderer", "text"));
            result.defaultWidth = clampFinite(json.optDouble("defaultWidth", 320), 32, CANVAS_WIDTH);
            result.defaultHeight = clampFinite(json.optDouble("defaultHeight", 100), 32,
                CANVAS_HEIGHT);
            result.multiline = json.optBoolean("multiline", false);
            result.square = json.optBoolean("square", false);
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
        return TYPE_INFO.equals(type) || TYPE_CONTROL.equals(type);
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
