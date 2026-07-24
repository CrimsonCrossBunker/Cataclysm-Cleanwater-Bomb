package com.crimsoncrossbunker.cataclysmcb;

import android.content.SharedPreferences;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Versioned persistence for the Android Lua HUD.
 *
 * Scenes are fixed input-context categories.  Each orientation has one
 * active layout, and a layout owns surface placement plus optional custom
 * action buttons/action-slot overrides.  The official layout is synthesized
 * from Lua and is never mutated; editing it creates a user layout.
 */
final class LuaHudLayoutStore {
    static final int SCHEMA = 2;
    static final String OFFICIAL_LAYOUT_ID = "official.default";
    static final String DEFAULT_SCENE = "DEFAULTMODE";

    static final String TYPE_LUA_SURFACE = "lua_surface";
    static final String TYPE_ACTION_BUTTON = "action_button";
    static final String TYPE_ACTION_OVERRIDE = "action_override";

    private static final String TAG = "LuaHudLayoutStore";
    private static final String PREF_V2 = "hud_layouts_v2";
    private static final String PREF_V1 = "hud_layouts_v1";
    private static final int MAX_PACKAGE_CHARS = 1024 * 1024;
    private static final int MAX_SCENES = 32;
    private static final int MAX_LAYOUTS_PER_SCENE = 32;
    private static final int MAX_ELEMENTS_PER_LAYOUT = 192;
    private static final int MAX_ACTIONS_PER_BUTTON = 32;

    static final class Element {
        String id = "";
        String type = TYPE_LUA_SURFACE;
        String sourceId = "";
        String label = "";
        String selectedAction = "";
        final ArrayList<String> actions = new ArrayList<>();
        float x;
        float y;
        float width = .20f;
        float height = .10f;
        float opacity = .90f;
        boolean visible = true;

        Element copy() {
            Element result = new Element();
            result.id = id;
            result.type = type;
            result.sourceId = sourceId;
            result.label = label;
            result.selectedAction = selectedAction;
            result.actions.addAll(actions);
            result.x = x;
            result.y = y;
            result.width = width;
            result.height = height;
            result.opacity = opacity;
            result.visible = visible;
            return result;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("type", type);
            if (!sourceId.isEmpty()) json.put("source", sourceId);
            if (!label.isEmpty()) json.put("label", label);
            if (!selectedAction.isEmpty()) json.put("selected", selectedAction);
            if (!actions.isEmpty()) {
                JSONArray actionArray = new JSONArray();
                for (String action : actions) actionArray.put(action);
                json.put("actions", actionArray);
            }
            json.put("x", x);
            json.put("y", y);
            json.put("width", width);
            json.put("height", height);
            json.put("opacity", opacity);
            json.put("visible", visible);
            return json;
        }

        static Element fromJson(JSONObject json) {
            if (json == null) return null;
            String type = json.optString("type", "");
            if (!TYPE_LUA_SURFACE.equals(type) && !TYPE_ACTION_BUTTON.equals(type) &&
                    !TYPE_ACTION_OVERRIDE.equals(type)) {
                return null;
            }
            Element result = new Element();
            result.id = safeId(json.optString("id", ""));
            result.type = type;
            result.sourceId = safeId(json.optString("source", ""));
            result.label = boundedText(json.optString("label", ""), 80);
            result.selectedAction = safeActionId(json.optString("selected", ""));
            if (result.id.isEmpty()) return null;
            if (TYPE_LUA_SURFACE.equals(type) && result.sourceId.isEmpty()) return null;
            JSONArray actionArray = json.optJSONArray("actions");
            if (actionArray != null) {
                for (int i = 0; i < actionArray.length() &&
                        result.actions.size() < MAX_ACTIONS_PER_BUTTON; ++i) {
                    String action = safeActionId(actionArray.optString(i, ""));
                    if (!action.isEmpty() && !result.actions.contains(action)) {
                        result.actions.add(action);
                    }
                }
            }
            if (!result.actions.contains(result.selectedAction)) {
                result.selectedAction = result.actions.isEmpty() ? "" : result.actions.get(0);
            }
            result.width = clamp((float)json.optDouble("width", .20), .06f, .95f);
            result.height = clamp((float)json.optDouble("height", .10), .05f, .95f);
            result.x = clamp((float)json.optDouble("x", 0), 0f, 1f - result.width);
            result.y = clamp((float)json.optDouble("y", 0), 0f, 1f - result.height);
            result.opacity = clamp((float)json.optDouble("opacity", .90), .20f, 1f);
            result.visible = json.optBoolean("visible", true);
            return result;
        }
    }

    static final class Layout {
        String id = "";
        String name = "";
        String orientation = "landscape";
        boolean official;
        final LinkedHashMap<String, Element> elements = new LinkedHashMap<>();

        Layout copy() {
            Layout result = new Layout();
            result.id = id;
            result.name = name;
            result.orientation = orientation;
            result.official = official;
            for (Element element : elements.values()) {
                result.elements.put(element.id, element.copy());
            }
            return result;
        }

        JSONObject toJson() throws JSONException {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("name", name);
            json.put("orientation", orientation);
            JSONArray entries = new JSONArray();
            for (Element element : elements.values()) entries.put(element.toJson());
            json.put("elements", entries);
            return json;
        }

        static Layout fromJson(JSONObject json) {
            if (json == null) return null;
            Layout result = new Layout();
            result.id = safeId(json.optString("id", ""));
            result.name = boundedText(json.optString("name", "自定义布局"), 80);
            result.orientation = safeOrientation(json.optString("orientation", "landscape"));
            if (result.id.isEmpty() || OFFICIAL_LAYOUT_ID.equals(result.id)) return null;
            JSONArray entries = json.optJSONArray("elements");
            if (entries != null) {
                for (int i = 0; i < entries.length() &&
                        result.elements.size() < MAX_ELEMENTS_PER_LAYOUT; ++i) {
                    Element element = Element.fromJson(entries.optJSONObject(i));
                    if (element != null) result.elements.put(element.id, element);
                }
            }
            return result;
        }
    }

    private final SharedPreferences preferences;
    private final LinkedHashMap<String, String> sceneTitles = new LinkedHashMap<>();
    private final LinkedHashMap<String, ArrayList<Layout>> sceneLayouts = new LinkedHashMap<>();
    private final LinkedHashMap<String, String> activeLayouts = new LinkedHashMap<>();

    LuaHudLayoutStore(SharedPreferences preferences) {
        this.preferences = preferences;
        sceneTitles.put(DEFAULT_SCENE, "游戏地图");
        if (!loadV2()) {
            migrateV1();
            save();
        }
    }

    synchronized void rememberScene(String scene, String title) {
        scene = safeScene(scene);
        if (scene.isEmpty() || sceneTitles.size() >= MAX_SCENES && !sceneTitles.containsKey(scene)) {
            return;
        }
        String acceptedTitle = boundedText(title, 80);
        if (acceptedTitle.isEmpty()) acceptedTitle = sceneTitleFallback(scene);
        if (!acceptedTitle.equals(sceneTitles.get(scene))) {
            sceneTitles.put(scene, acceptedTitle);
            save();
        }
    }

    synchronized List<String> scenes() {
        return new ArrayList<>(sceneTitles.keySet());
    }

    synchronized String sceneTitle(String scene) {
        String title = sceneTitles.get(scene);
        return title == null ? sceneTitleFallback(scene) : title;
    }

    synchronized List<Layout> layouts(String scene, String orientation) {
        ArrayList<Layout> result = new ArrayList<>();
        Layout official = new Layout();
        official.id = OFFICIAL_LAYOUT_ID;
        official.name = "官方默认";
        official.orientation = safeOrientation(orientation);
        official.official = true;
        result.add(official);
        ArrayList<Layout> saved = sceneLayouts.get(safeScene(scene));
        if (saved != null) {
            for (Layout layout : saved) {
                if (layout.orientation.equals(official.orientation)) result.add(layout.copy());
            }
        }
        return result;
    }

    synchronized String activeLayoutId(String scene, String orientation) {
        String id = activeLayouts.get(activeKey(scene, orientation));
        return findLayoutInternal(scene, orientation, id) == null ? OFFICIAL_LAYOUT_ID : id;
    }

    synchronized Layout activeLayout(String scene, String orientation) {
        String id = activeLayoutId(scene, orientation);
        Layout found = findLayoutInternal(scene, orientation, id);
        if (found != null) return found.copy();
        Layout official = new Layout();
        official.id = OFFICIAL_LAYOUT_ID;
        official.name = "官方默认";
        official.orientation = safeOrientation(orientation);
        official.official = true;
        return official;
    }

    synchronized Layout findLayout(String scene, String orientation, String id) {
        Layout found = findLayoutInternal(scene, orientation, id);
        return found == null ? null : found.copy();
    }

    synchronized Layout createLayout(String scene, String orientation, String name,
            List<Element> seedElements) {
        scene = safeScene(scene);
        orientation = safeOrientation(orientation);
        if (scene.isEmpty()) scene = DEFAULT_SCENE;
        rememberScene(scene, sceneTitleFallback(scene));
        ArrayList<Layout> layouts = sceneLayouts.get(scene);
        if (layouts == null) {
            layouts = new ArrayList<>();
            sceneLayouts.put(scene, layouts);
        }
        if (layouts.size() >= MAX_LAYOUTS_PER_SCENE) return null;
        Layout created = new Layout();
        created.id = "user." + UUID.randomUUID().toString();
        created.name = uniqueName(layouts, boundedText(name, 80));
        created.orientation = orientation;
        if (seedElements != null) {
            for (Element seed : seedElements) {
                if (seed == null || created.elements.size() >= MAX_ELEMENTS_PER_LAYOUT) break;
                Element copy = seed.copy();
                if (!copy.id.isEmpty()) created.elements.put(copy.id, copy);
            }
        }
        layouts.add(created);
        activeLayouts.put(activeKey(scene, orientation), created.id);
        save();
        return created.copy();
    }

    synchronized boolean setActive(String scene, String orientation, String id) {
        if (!OFFICIAL_LAYOUT_ID.equals(id) &&
                findLayoutInternal(scene, orientation, id) == null) {
            return false;
        }
        activeLayouts.put(activeKey(scene, orientation), id);
        save();
        return true;
    }

    synchronized boolean renameLayout(String scene, String orientation, String id, String name) {
        Layout layout = findLayoutInternal(scene, orientation, id);
        if (layout == null) return false;
        ArrayList<Layout> siblings = sceneLayouts.get(safeScene(scene));
        layout.name = uniqueName(siblings, boundedText(name, 80), id);
        save();
        return true;
    }

    synchronized boolean deleteLayout(String scene, String orientation, String id) {
        ArrayList<Layout> layouts = sceneLayouts.get(safeScene(scene));
        if (layouts == null) return false;
        for (int i = 0; i < layouts.size(); ++i) {
            Layout layout = layouts.get(i);
            if (layout.id.equals(id) && layout.orientation.equals(safeOrientation(orientation))) {
                layouts.remove(i);
                if (id.equals(activeLayouts.get(activeKey(scene, orientation)))) {
                    activeLayouts.put(activeKey(scene, orientation), OFFICIAL_LAYOUT_ID);
                }
                save();
                return true;
            }
        }
        return false;
    }

    synchronized boolean putElement(String scene, String orientation, String layoutId,
            Element element) {
        Layout layout = findLayoutInternal(scene, orientation, layoutId);
        if (layout == null || element == null || element.id.isEmpty()) return false;
        if (!layout.elements.containsKey(element.id) &&
                layout.elements.size() >= MAX_ELEMENTS_PER_LAYOUT) {
            return false;
        }
        layout.elements.put(element.id, element.copy());
        save();
        return true;
    }

    synchronized boolean putElements(String scene, String orientation, String layoutId,
            List<Element> elements) {
        Layout layout = findLayoutInternal(scene, orientation, layoutId);
        if (layout == null || elements == null) return false;
        for (Element element : elements) {
            if (element == null || element.id.isEmpty()) continue;
            if (!layout.elements.containsKey(element.id) &&
                    layout.elements.size() >= MAX_ELEMENTS_PER_LAYOUT) {
                return false;
            }
            layout.elements.put(element.id, element.copy());
        }
        save();
        return true;
    }

    synchronized boolean removeElement(String scene, String orientation, String layoutId,
            String elementId) {
        Layout layout = findLayoutInternal(scene, orientation, layoutId);
        if (layout == null || layout.elements.remove(elementId) == null) return false;
        save();
        return true;
    }

    synchronized String exportPackage() {
        try {
            return toJson().toString(2);
        } catch (JSONException e) {
            Log.w(TAG, "Could not export Lua HUD layouts", e);
            return "";
        }
    }

    synchronized boolean importPackage(String raw) {
        if (raw == null || raw.isEmpty() || raw.length() > MAX_PACKAGE_CHARS) return false;
        try {
            JSONObject imported = new JSONObject(raw);
            if (imported.optInt("schema", 0) != SCHEMA) return false;
            JSONObject scenesObject = imported.optJSONObject("scenes");
            if (scenesObject == null) return false;
            int importedLayouts = 0;
            LinkedHashMap<String, String> importedIds = new LinkedHashMap<>();
            Iterator<String> sceneKeys = scenesObject.keys();
            while (sceneKeys.hasNext() && sceneTitles.size() < MAX_SCENES) {
                String sourceScene = sceneKeys.next();
                String scene = safeScene(sourceScene);
                JSONObject sceneObject = scenesObject.optJSONObject(sourceScene);
                if (scene.isEmpty() || sceneObject == null) continue;
                rememberScene(scene, sceneObject.optString("title", sceneTitleFallback(scene)));
                JSONArray layoutsArray = sceneObject.optJSONArray("layouts");
                if (layoutsArray == null) continue;
                ArrayList<Layout> target = sceneLayouts.get(scene);
                if (target == null) {
                    target = new ArrayList<>();
                    sceneLayouts.put(scene, target);
                }
                for (int i = 0; i < layoutsArray.length() &&
                        target.size() < MAX_LAYOUTS_PER_SCENE; ++i) {
                    Layout layout = Layout.fromJson(layoutsArray.optJSONObject(i));
                    if (layout == null) continue;
                    String sourceId = layout.id;
                    layout.id = uniqueLayoutId(scene, layout.id);
                    layout.name = uniqueName(target, layout.name);
                    target.add(layout);
                    importedIds.put(activeKey(scene, layout.orientation) + "|" + sourceId,
                        layout.id);
                    activeLayouts.put(activeKey(scene, layout.orientation), layout.id);
                    importedLayouts++;
                }
            }
            if (importedLayouts == 0) return false;
            JSONObject importedActive = imported.optJSONObject("active");
            if (importedActive != null) {
                Iterator<String> keys = importedActive.keys();
                while (keys.hasNext()) {
                    String key = keys.next();
                    String mapped = importedIds.get(key + "|" +
                        safeId(importedActive.optString(key, "")));
                    if (mapped != null) activeLayouts.put(key, mapped);
                }
            }
            save();
            return true;
        } catch (JSONException e) {
            Log.w(TAG, "Rejected Lua HUD layout package", e);
            return false;
        }
    }

    private boolean loadV2() {
        String raw = preferences.getString(PREF_V2, "");
        if (raw == null || raw.isEmpty() || raw.length() > MAX_PACKAGE_CHARS) return false;
        try {
            JSONObject root = new JSONObject(raw);
            if (root.optInt("schema", 0) != SCHEMA) return false;
            JSONObject scenesObject = root.optJSONObject("scenes");
            if (scenesObject != null) {
                Iterator<String> keys = scenesObject.keys();
                while (keys.hasNext() && sceneTitles.size() < MAX_SCENES) {
                    String sourceScene = keys.next();
                    String scene = safeScene(sourceScene);
                    JSONObject sceneObject = scenesObject.optJSONObject(sourceScene);
                    if (scene.isEmpty() || sceneObject == null) continue;
                    sceneTitles.put(scene, boundedText(sceneObject.optString(
                        "title", sceneTitleFallback(scene)), 80));
                    JSONArray array = sceneObject.optJSONArray("layouts");
                    ArrayList<Layout> layouts = new ArrayList<>();
                    if (array != null) {
                        for (int i = 0; i < array.length() &&
                                layouts.size() < MAX_LAYOUTS_PER_SCENE; ++i) {
                            Layout layout = Layout.fromJson(array.optJSONObject(i));
                            if (layout != null) layouts.add(layout);
                        }
                    }
                    sceneLayouts.put(scene, layouts);
                }
            }
            JSONObject activeObject = root.optJSONObject("active");
            if (activeObject != null) {
                Iterator<String> keys = activeObject.keys();
                while (keys.hasNext()) {
                    String key = keys.next();
                    activeLayouts.put(key, safeId(activeObject.optString(key, "")));
                }
            }
            return true;
        } catch (JSONException e) {
            Log.w(TAG, "Ignoring invalid Lua HUD schema 2 store", e);
            return false;
        }
    }

    private void migrateV1() {
        String raw = preferences.getString(PREF_V1, "");
        if (raw == null || raw.isEmpty() || raw.length() > MAX_PACKAGE_CHARS) return;
        try {
            JSONObject entries = new JSONObject(raw).optJSONObject("entries");
            if (entries == null) return;
            LinkedHashMap<String, ArrayList<Element>> byOrientation = new LinkedHashMap<>();
            Iterator<String> keys = entries.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                int separator = key.indexOf('|');
                if (separator <= 0 || separator >= key.length() - 1) continue;
                String orientation = safeOrientation(key.substring(0, separator));
                String source = safeId(key.substring(separator + 1));
                JSONObject old = entries.optJSONObject(key);
                if (source.isEmpty() || old == null) continue;
                Element element = new Element();
                element.id = "surface:" + source;
                element.type = TYPE_LUA_SURFACE;
                element.sourceId = source;
                element.width = clamp((float)old.optDouble("width", .28), .06f, .95f);
                element.height = clamp((float)old.optDouble("height", .18), .05f, .95f);
                element.x = clamp((float)old.optDouble("x", 0), 0f, 1f - element.width);
                element.y = clamp((float)old.optDouble("y", 0), 0f, 1f - element.height);
                element.opacity = clamp((float)old.optDouble("opacity", .85), .20f, 1f);
                element.visible = old.optBoolean("visible", true);
                ArrayList<Element> elements = byOrientation.get(orientation);
                if (elements == null) {
                    elements = new ArrayList<>();
                    byOrientation.put(orientation, elements);
                }
                elements.add(element);
            }
            for (Map.Entry<String, ArrayList<Element>> entry : byOrientation.entrySet()) {
                createLayout(DEFAULT_SCENE, entry.getKey(), "旧版布局", entry.getValue());
            }
        } catch (JSONException e) {
            Log.w(TAG, "Could not migrate Lua HUD schema 1 store", e);
        }
    }

    private JSONObject toJson() throws JSONException {
        JSONObject root = new JSONObject();
        root.put("schema", SCHEMA);
        JSONObject activeObject = new JSONObject();
        for (Map.Entry<String, String> entry : activeLayouts.entrySet()) {
            activeObject.put(entry.getKey(), entry.getValue());
        }
        root.put("active", activeObject);
        JSONObject scenesObject = new JSONObject();
        for (Map.Entry<String, String> scene : sceneTitles.entrySet()) {
            JSONObject sceneObject = new JSONObject();
            sceneObject.put("title", scene.getValue());
            JSONArray layoutsArray = new JSONArray();
            ArrayList<Layout> layouts = sceneLayouts.get(scene.getKey());
            if (layouts != null) {
                for (Layout layout : layouts) layoutsArray.put(layout.toJson());
            }
            sceneObject.put("layouts", layoutsArray);
            scenesObject.put(scene.getKey(), sceneObject);
        }
        root.put("scenes", scenesObject);
        return root;
    }

    private void save() {
        try {
            String encoded = toJson().toString();
            if (encoded.length() <= MAX_PACKAGE_CHARS) {
                preferences.edit().putString(PREF_V2, encoded).commit();
            }
        } catch (JSONException e) {
            Log.w(TAG, "Could not save Lua HUD layouts", e);
        }
    }

    private Layout findLayoutInternal(String scene, String orientation, String id) {
        if (id == null || OFFICIAL_LAYOUT_ID.equals(id)) return null;
        ArrayList<Layout> layouts = sceneLayouts.get(safeScene(scene));
        if (layouts == null) return null;
        orientation = safeOrientation(orientation);
        for (Layout layout : layouts) {
            if (layout.id.equals(id) && layout.orientation.equals(orientation)) return layout;
        }
        return null;
    }

    private String uniqueLayoutId(String scene, String requested) {
        String candidate = safeId(requested);
        if (candidate.isEmpty() || OFFICIAL_LAYOUT_ID.equals(candidate)) candidate = "imported";
        while (findLayoutAnyOrientation(scene, candidate) != null) {
            candidate = "imported." + UUID.randomUUID().toString();
        }
        return candidate;
    }

    private Layout findLayoutAnyOrientation(String scene, String id) {
        ArrayList<Layout> layouts = sceneLayouts.get(scene);
        if (layouts == null) return null;
        for (Layout layout : layouts) if (layout.id.equals(id)) return layout;
        return null;
    }

    private static String uniqueName(List<Layout> siblings, String requested) {
        return uniqueName(siblings, requested, "");
    }

    private static String uniqueName(List<Layout> siblings, String requested, String ignoredId) {
        String base = requested == null || requested.trim().isEmpty() ? "自定义布局" : requested.trim();
        String candidate = base;
        for (int suffix = 2; nameExists(siblings, candidate, ignoredId); ++suffix) {
            candidate = base + " " + suffix;
        }
        return candidate;
    }

    private static boolean nameExists(List<Layout> siblings, String name, String ignoredId) {
        if (siblings == null) return false;
        for (Layout layout : siblings) {
            if (!layout.id.equals(ignoredId) && layout.name.equals(name)) return true;
        }
        return false;
    }

    private static String activeKey(String scene, String orientation) {
        return safeScene(scene) + "|" + safeOrientation(orientation);
    }

    private static String sceneTitleFallback(String scene) {
        return DEFAULT_SCENE.equals(scene) ? "游戏地图" : scene;
    }

    private static String safeOrientation(String value) {
        return "portrait".equals(value) ? "portrait" : "landscape";
    }

    private static String safeScene(String value) {
        return safeToken(value, 96);
    }

    private static String safeId(String value) {
        return safeToken(value, 160);
    }

    private static String safeActionId(String value) {
        return safeToken(value, 128);
    }

    private static String safeToken(String value, int maximum) {
        if (value == null || value.isEmpty() || value.length() > maximum) return "";
        for (int i = 0; i < value.length(); ++i) {
            char c = value.charAt(i);
            if (!(Character.isLetterOrDigit(c) || c == '_' || c == '-' || c == '.' ||
                    c == ':' || c == '/')) {
                return "";
            }
        }
        return value;
    }

    private static String boundedText(String value, int maximum) {
        if (value == null) return "";
        String trimmed = value.trim();
        return trimmed.length() <= maximum ? trimmed : trimmed.substring(0, maximum);
    }

    private static float clamp(float value, float minimum, float maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }
}
