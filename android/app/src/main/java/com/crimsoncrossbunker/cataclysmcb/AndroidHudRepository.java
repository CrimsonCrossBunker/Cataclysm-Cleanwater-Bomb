package com.crimsoncrossbunker.cataclysmcb;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.AtomicFile;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * Atomic schema-6 repository.  It owns persistence, validation and package
 * import/export; Views only ever receive detached model copies.
 */
final class AndroidHudRepository {
    private static final String TAG = "AndroidHudRepository";
    private static final String STORE_NAME = "android-hud-layouts-v6.json";
    private static final String LEGACY_V5_STORE_NAME = "android-hud-layouts-v5.json";
    private static final String LEGACY_V4_STORE_NAME = "android-hud-layouts-v4.json";
    private static final String LEGACY_ARCHIVE_NAME = "android-hud-legacy-v1-v3.json";
    private static final String MIGRATION_PREFS = "android_hud_schema6";
    private static final String LEGACY_ARCHIVED = "legacy_archived";
    private static final String EMPTY_LAYOUT_NAME = "空白布局";

    enum ImportMode {
        MERGE,
        REPLACE
    }

    static final class ImportPlan {
        final AndroidHudModel.PackageData packageData;
        final AndroidHudModel.Scene sourceScene;
        final AndroidHudModel.Layout singleLayout;
        final boolean single;
        final int sceneCount;
        final int layoutCount;
        final int elementCount;

        ImportPlan(AndroidHudModel.PackageData packageData,
                AndroidHudModel.Scene sourceScene, AndroidHudModel.Layout singleLayout,
                boolean single, int sceneCount, int layoutCount, int elementCount) {
            this.packageData = packageData;
            this.sourceScene = sourceScene;
            this.singleLayout = singleLayout;
            this.single = single;
            this.sceneCount = sceneCount;
            this.layoutCount = layoutCount;
            this.elementCount = elementCount;
        }
    }

    private final Context context;
    private final AtomicFile store;
    private final AtomicFile legacyV5Store;
    private final AtomicFile legacyV4Store;
    private final AtomicFile legacyArchive;
    private AndroidHudModel.PackageData data;

    AndroidHudRepository(Context context) {
        this.context = context.getApplicationContext();
        File directory = new File(this.context.getFilesDir(), "hud");
        if (!directory.exists() && !directory.mkdirs()) {
            Log.w(TAG, "Could not create HUD storage directory");
        }
        store = new AtomicFile(new File(directory, STORE_NAME));
        legacyV5Store = new AtomicFile(new File(directory, LEGACY_V5_STORE_NAME));
        legacyV4Store = new AtomicFile(new File(directory, LEGACY_V4_STORE_NAME));
        legacyArchive = new AtomicFile(new File(directory, LEGACY_ARCHIVE_NAME));
        archiveLegacyOnce();
        data = readStore(store);
        boolean migratedLegacy = false;
        if (data == null) {
            data = readStore(legacyV5Store);
            migratedLegacy = data != null;
        }
        if (data == null) {
            data = readStore(legacyV4Store);
            migratedLegacy = data != null;
        }
        if (data == null) {
            data = new AndroidHudModel.PackageData();
        }
        if (migratedLegacy || !store.getBaseFile().exists()) {
            save();
        }
    }

    synchronized AndroidHudModel.PackageData snapshot() {
        return data.copy();
    }

    synchronized List<AndroidHudModel.Scene> scenes() {
        ArrayList<AndroidHudModel.Scene> result = new ArrayList<>();
        for (AndroidHudModel.Scene scene : data.scenes.values()) {
            result.add(scene.copy());
        }
        return result;
    }

    synchronized AndroidHudModel.Scene scene(String sceneId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        return scene == null ? null : scene.copy();
    }

    synchronized AndroidHudModel.Scene ensureScene(String sceneId, String title) {
        sceneId = AndroidHudModel.safeId(sceneId);
        if (sceneId.isEmpty()) {
            sceneId = "scene.unknown";
        }
        AndroidHudModel.Scene existing = data.scenes.get(sceneId);
        boolean changed = false;
        if (existing == null) {
            if (data.scenes.size() >= AndroidHudModel.MAX_SCENES) {
                return null;
            }
            existing = new AndroidHudModel.Scene();
            existing.id = sceneId;
            existing.title = acceptedTitle(title, sceneId);
            AndroidHudModel.Layout empty = emptyLayout();
            existing.layouts.put(empty.id, empty);
            existing.activeLayoutId = empty.id;
            data.scenes.put(existing.id, existing);
            changed = true;
        } else {
            String accepted = acceptedTitle(title, sceneId);
            if (!accepted.equals(existing.title)) {
                existing.title = accepted;
                changed = true;
            }
        }
        if (changed) {
            save();
        }
        return existing.copy();
    }

    synchronized boolean updateActionCatalog(String sceneId,
            List<AndroidHudModel.ActionDescriptor> actions) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        if (scene == null || actions == null) {
            return false;
        }
        LinkedHashMap<String, AndroidHudModel.ActionDescriptor> accepted = new LinkedHashMap<>();
        for (AndroidHudModel.ActionDescriptor action : actions) {
            if (action != null && !action.id.isEmpty() && accepted.size() < 1024) {
                accepted.put(action.id, action.copy());
            }
        }
        if (sameActions(scene.actionCatalog, accepted)) {
            return true;
        }
        scene.actionCatalog.clear();
        scene.actionCatalog.putAll(accepted);
        save();
        return true;
    }

    synchronized AndroidHudModel.Layout activeLayout(String sceneId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        AndroidHudModel.Layout layout = scene == null ? null : scene.activeLayout();
        return layout == null ? null : layout.copy();
    }

    synchronized AndroidHudModel.Layout layout(String sceneId, String layoutId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        AndroidHudModel.Layout layout = scene == null ? null :
            scene.layouts.get(AndroidHudModel.safeId(layoutId));
        return layout == null ? null : layout.copy();
    }

    synchronized AndroidHudModel.Layout createLayout(String sceneId, String name,
            String sourceLayoutId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        if (scene == null || scene.layouts.size() >= AndroidHudModel.MAX_LAYOUTS_PER_SCENE) {
            return null;
        }
        AndroidHudModel.Layout source = scene.layouts.get(
            AndroidHudModel.safeId(sourceLayoutId));
        AndroidHudModel.Layout created = source == null ? new AndroidHudModel.Layout() :
            source.copy();
        created.id = newLayoutId();
        created.name = uniqueLayoutName(scene,
            AndroidHudModel.boundedText(name, 100).isEmpty() ? EMPTY_LAYOUT_NAME : name, "");
        scene.layouts.put(created.id, created);
        scene.activeLayoutId = created.id;
        save();
        return created.copy();
    }

    synchronized AndroidHudModel.Layout createOfficialLayout(String sceneId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        AndroidHudOfficialTemplates.Seed seed =
            AndroidHudOfficialTemplates.forScene(sceneId);
        if (scene == null || seed == null ||
                scene.layouts.size() >= AndroidHudModel.MAX_LAYOUTS_PER_SCENE) {
            return null;
        }
        AndroidHudModel.Layout created = seed.layout.copy();
        created.id = uniqueLayoutId(scene, created.id);
        created.name = uniqueLayoutName(scene, created.name, "");
        scene.layouts.put(created.id, created);
        scene.activeLayoutId = created.id;
        save();
        return created.copy();
    }

    synchronized boolean activateLayout(String sceneId, String layoutId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        layoutId = AndroidHudModel.safeId(layoutId);
        if (scene == null || !scene.layouts.containsKey(layoutId)) {
            return false;
        }
        scene.activeLayoutId = layoutId;
        save();
        return true;
    }

    synchronized boolean renameLayout(String sceneId, String layoutId, String name) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        AndroidHudModel.Layout layout = scene == null ? null :
            scene.layouts.get(AndroidHudModel.safeId(layoutId));
        if (layout == null) {
            return false;
        }
        layout.name = uniqueLayoutName(scene, AndroidHudModel.boundedText(name, 100), layout.id);
        save();
        return true;
    }

    synchronized boolean deleteLayout(String sceneId, String layoutId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        layoutId = AndroidHudModel.safeId(layoutId);
        if (scene == null || !scene.layouts.containsKey(layoutId)) {
            return false;
        }
        scene.layouts.remove(layoutId);
        if (scene.layouts.isEmpty()) {
            AndroidHudModel.Layout empty = emptyLayout();
            scene.layouts.put(empty.id, empty);
        }
        if (!scene.layouts.containsKey(scene.activeLayoutId)) {
            scene.activeLayoutId = scene.layouts.values().iterator().next().id;
        }
        save();
        return true;
    }

    /** Atomic editor commit.  The caller supplies one validated detached draft. */
    synchronized boolean commitLayout(String sceneId, AndroidHudModel.Layout draft) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        if (scene == null || draft == null || !scene.layouts.containsKey(draft.id)) {
            return false;
        }
        AndroidHudModel.Layout accepted;
        try {
            accepted = AndroidHudModel.Layout.fromJson(draft.toJson());
        } catch (JSONException e) {
            Log.w(TAG, "Rejected invalid HUD editor draft", e);
            return false;
        }
        if (accepted == null || !accepted.id.equals(draft.id)) {
            return false;
        }
        accepted.name = uniqueLayoutName(scene, accepted.name, accepted.id);
        scene.layouts.put(accepted.id, accepted);
        scene.activeLayoutId = accepted.id;
        save();
        return true;
    }

    synchronized boolean updateSelectedAction(String sceneId, String layoutId,
            String elementId, String actionId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        AndroidHudModel.Layout layout = scene == null ? null :
            scene.layouts.get(AndroidHudModel.safeId(layoutId));
        AndroidHudModel.Element element = layout == null ? null :
            layout.find(AndroidHudModel.safeId(elementId));
        actionId = AndroidHudModel.safeActionId(actionId);
        if (element == null || !AndroidHudModel.TYPE_CONTROL.equals(element.type) ||
                !element.actionIds.contains(actionId)) {
            return false;
        }
        element.selectedActionId = actionId;
        save();
        return true;
    }

    synchronized String exportPackage() {
        try {
            return data.toJson().toString(2);
        } catch (JSONException e) {
            Log.w(TAG, "Could not export Android HUD package", e);
            return "";
        }
    }

    synchronized String exportLayout(String sceneId, String layoutId) {
        AndroidHudModel.Scene scene = data.scenes.get(AndroidHudModel.safeId(sceneId));
        AndroidHudModel.Layout layout = scene == null ? null :
            scene.layouts.get(AndroidHudModel.safeId(layoutId));
        if (scene == null || layout == null) {
            return "";
        }
        try {
            JSONObject root = new JSONObject();
            root.put("format", "cataclysm-android-hud");
            root.put("kind", AndroidHudModel.KIND_LAYOUT);
            root.put("schema", AndroidHudModel.SCHEMA);
            JSONObject sourceScene = new JSONObject();
            sourceScene.put("id", scene.id);
            sourceScene.put("title", scene.title);
            root.put("scene", sourceScene);
            root.put("layout", layout.toJson());
            return root.toString(2);
        } catch (JSONException e) {
            Log.w(TAG, "Could not export Android HUD layout", e);
            return "";
        }
    }

    synchronized ImportPlan inspectImport(String raw) throws JSONException {
        if (raw == null || raw.trim().isEmpty() ||
                raw.length() > AndroidHudModel.MAX_PACKAGE_CHARS) {
            throw new JSONException("HUD package is empty or too large");
        }
        JSONObject root = new JSONObject(raw);
        int schema = root.optInt("schema", 0);
        if (schema != AndroidHudModel.SCHEMA &&
                schema != AndroidHudModel.LEGACY_SCHEMA_V5 &&
                schema != AndroidHudModel.LEGACY_SCHEMA) {
            throw new JSONException("Only schema 4, 5 or 6 HUD files can be imported");
        }
        String kind = root.optString("kind", AndroidHudModel.KIND_PACKAGE);
        if (AndroidHudModel.KIND_LAYOUT.equals(kind)) {
            JSONObject encodedScene = root.optJSONObject("scene");
            AndroidHudModel.Scene sourceScene = new AndroidHudModel.Scene();
            sourceScene.id = AndroidHudModel.safeId(encodedScene == null ? "" :
                encodedScene.optString("id", ""));
            if (sourceScene.id.isEmpty()) {
                sourceScene.id = "scene.imported";
            }
            sourceScene.title = acceptedTitle(encodedScene == null ? "" :
                encodedScene.optString("title", ""), sourceScene.id);
            AndroidHudModel.Layout layout = AndroidHudModel.Layout.fromJson(
                root.optJSONObject("layout"), schema);
            if (layout == null) {
                throw new JSONException("Missing layout");
            }
            return new ImportPlan(null, sourceScene, layout, true, 1, 1,
                layout.elementCount());
        }
        AndroidHudModel.PackageData imported = AndroidHudModel.PackageData.fromJson(root);
        int layouts = 0;
        int elements = 0;
        for (AndroidHudModel.Scene scene : imported.scenes.values()) {
            layouts += scene.layouts.size();
            for (AndroidHudModel.Layout layout : scene.layouts.values()) {
                elements += layout.elementCount();
            }
        }
        if (layouts == 0) {
            throw new JSONException("The package contains no layouts");
        }
        return new ImportPlan(imported, null, null, false, imported.scenes.size(),
            layouts, elements);
    }

    synchronized boolean applyImport(ImportPlan plan, ImportMode mode) {
        if (plan == null) {
            return false;
        }
        if (plan.single) {
            return mergeSingle(plan.sourceScene, plan.singleLayout);
        }
        if (mode == ImportMode.REPLACE) {
            data = plan.packageData.copy();
            save();
            return true;
        }
        mergePackage(plan.packageData);
        save();
        return true;
    }

    File legacyArchiveFile() {
        return legacyArchive.getBaseFile();
    }

    private void mergePackage(AndroidHudModel.PackageData imported) {
        for (AndroidHudModel.Scene incoming : imported.scenes.values()) {
            AndroidHudModel.Scene target = data.scenes.get(incoming.id);
            if (target == null) {
                if (data.scenes.size() >= AndroidHudModel.MAX_SCENES) {
                    break;
                }
                data.scenes.put(incoming.id, incoming.copy());
                continue;
            }
            for (AndroidHudModel.Layout layout : incoming.layouts.values()) {
                if (target.layouts.size() >= AndroidHudModel.MAX_LAYOUTS_PER_SCENE) {
                    break;
                }
                AndroidHudModel.Layout copy = layout.copy();
                copy.id = uniqueLayoutId(target, copy.id);
                copy.name = uniqueLayoutName(target, copy.name, "");
                target.layouts.put(copy.id, copy);
            }
            for (AndroidHudModel.ActionDescriptor action : incoming.actionCatalog.values()) {
                if (!target.actionCatalog.containsKey(action.id)) {
                    target.actionCatalog.put(action.id, action.copy());
                }
            }
        }
    }

    private boolean mergeSingle(AndroidHudModel.Scene incomingScene,
            AndroidHudModel.Layout incomingLayout) {
        if (incomingScene == null || incomingLayout == null) {
            return false;
        }
        AndroidHudModel.Scene target = data.scenes.get(incomingScene.id);
        if (target == null) {
            if (data.scenes.size() >= AndroidHudModel.MAX_SCENES) {
                return false;
            }
            target = new AndroidHudModel.Scene();
            target.id = incomingScene.id;
            target.title = incomingScene.title;
            data.scenes.put(target.id, target);
        }
        if (target.layouts.size() >= AndroidHudModel.MAX_LAYOUTS_PER_SCENE) {
            return false;
        }
        AndroidHudModel.Layout copy = incomingLayout.copy();
        copy.id = uniqueLayoutId(target, copy.id);
        copy.name = uniqueLayoutName(target, copy.name, "");
        target.layouts.put(copy.id, copy);
        target.activeLayoutId = copy.id;
        save();
        return true;
    }

    private AndroidHudModel.PackageData readStore(AtomicFile candidate) {
        if (!candidate.getBaseFile().exists()) {
            return null;
        }
        try {
            String raw = readAtomic(candidate);
            if (raw.length() > AndroidHudModel.MAX_PACKAGE_CHARS) {
                throw new IOException("HUD store is too large");
            }
            return AndroidHudModel.PackageData.fromJson(new JSONObject(raw));
        } catch (IOException | JSONException e) {
            Log.w(TAG, "Ignoring invalid Android HUD store", e);
            return null;
        }
    }

    private void save() {
        try {
            writeAtomic(store, data.toJson().toString());
        } catch (IOException | JSONException e) {
            Log.e(TAG, "Could not atomically save Android HUD", e);
        }
    }

    private void archiveLegacyOnce() {
        SharedPreferences marker = context.getSharedPreferences(MIGRATION_PREFS,
            Context.MODE_PRIVATE);
        if (marker.getBoolean(LEGACY_ARCHIVED, false)) {
            return;
        }
        try {
            JSONObject archive = new JSONObject();
            archive.put("note", "Archived only; schema 1-3 are never activated by schema 5.");
            archive.put("schema", 0);
            JSONObject stores = new JSONObject();
            stores.put("android_hud", encodePreferences(
                context.getSharedPreferences("android_hud", Context.MODE_PRIVATE)));
            stores.put("extra_buttons", encodePreferences(
                context.getSharedPreferences("extra_buttons", Context.MODE_PRIVATE)));
            archive.put("stores", stores);
            writeAtomic(legacyArchive, archive.toString(2));
            marker.edit().putBoolean(LEGACY_ARCHIVED, true).apply();
        } catch (IOException | JSONException e) {
            Log.w(TAG, "Could not archive legacy HUD configuration", e);
        }
    }

    private static JSONObject encodePreferences(SharedPreferences preferences)
            throws JSONException {
        JSONObject encoded = new JSONObject();
        for (Map.Entry<String, ?> entry : preferences.getAll().entrySet()) {
            Object value = entry.getValue();
            if (value instanceof String || value instanceof Number || value instanceof Boolean) {
                encoded.put(entry.getKey(), value);
            } else if (value instanceof Set) {
                JSONArray values = new JSONArray();
                for (Object item : (Set<?>)value) {
                    values.put(String.valueOf(item));
                }
                encoded.put(entry.getKey(), values);
            }
        }
        return encoded;
    }

    private static String readAtomic(AtomicFile file) throws IOException {
        FileInputStream input = file.openRead();
        try {
            ByteArrayOutputStream output = new ByteArrayOutputStream();
            byte[] buffer = new byte[8192];
            int read;
            while ((read = input.read(buffer)) >= 0) {
                output.write(buffer, 0, read);
                if (output.size() > AndroidHudModel.MAX_PACKAGE_CHARS) {
                    throw new IOException("HUD file is too large");
                }
            }
            return output.toString(StandardCharsets.UTF_8.name());
        } finally {
            input.close();
        }
    }

    private static void writeAtomic(AtomicFile file, String content) throws IOException {
        FileOutputStream output = null;
        try {
            output = file.startWrite();
            output.write(content.getBytes(StandardCharsets.UTF_8));
            file.finishWrite(output);
        } catch (IOException error) {
            if (output != null) {
                file.failWrite(output);
            }
            throw error;
        }
    }

    private static AndroidHudModel.Layout emptyLayout() {
        AndroidHudModel.Layout result = new AndroidHudModel.Layout();
        result.id = newLayoutId();
        result.name = EMPTY_LAYOUT_NAME;
        return result;
    }

    private static String newLayoutId() {
        return "layout." + UUID.randomUUID().toString();
    }

    private static String acceptedTitle(String title, String fallback) {
        String accepted = AndroidHudModel.boundedText(title, 100);
        return accepted.isEmpty() ? fallback : accepted;
    }

    private static String uniqueLayoutId(AndroidHudModel.Scene scene, String requested) {
        String accepted = AndroidHudModel.safeId(requested);
        if (!accepted.isEmpty() && !scene.layouts.containsKey(accepted)) {
            return accepted;
        }
        return newLayoutId();
    }

    private static String uniqueLayoutName(AndroidHudModel.Scene scene, String requested,
            String ignoredId) {
        String base = AndroidHudModel.boundedText(requested, 100);
        if (base.isEmpty()) {
            base = "自定义布局";
        }
        String candidate = base;
        for (int suffix = 2; suffix < 1000; ++suffix) {
            boolean used = false;
            for (AndroidHudModel.Layout layout : scene.layouts.values()) {
                if (!layout.id.equals(ignoredId) && layout.name.equals(candidate)) {
                    used = true;
                    break;
                }
            }
            if (!used) {
                return candidate;
            }
            candidate = base + " " + suffix;
        }
        return base + " " + UUID.randomUUID().toString().substring(0, 8);
    }

    private static boolean sameActions(
            LinkedHashMap<String, AndroidHudModel.ActionDescriptor> left,
            LinkedHashMap<String, AndroidHudModel.ActionDescriptor> right) {
        if (!left.keySet().equals(right.keySet())) {
            return false;
        }
        for (String id : left.keySet()) {
            AndroidHudModel.ActionDescriptor a = left.get(id);
            AndroidHudModel.ActionDescriptor b = right.get(id);
            if (b == null || !a.label.equals(b.label) || !a.group.equals(b.group) ||
                    !a.risk.equals(b.risk) || a.repeatable != b.repeatable) {
                return false;
            }
        }
        return true;
    }
}
