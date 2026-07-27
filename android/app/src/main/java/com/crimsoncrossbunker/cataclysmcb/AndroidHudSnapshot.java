package com.crimsoncrossbunker.cataclysmcb;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/** Immutable Java-side projection of the game-thread HUD snapshot. */
final class AndroidHudSnapshot {
    static final int SCHEMA = 3;

    static final class Message {
        String text = "";
        final ArrayList<Run> runs = new ArrayList<>();
    }

    static final class Run {
        String text = "";
        int color = 0xFFFFFFFF;
        boolean bold;
    }

    static final class Cell {
        String symbol = "";
        int color = 0xFF30343A;
    }

    static final class Contact {
        String name = "";
        int dx;
        int dy;
        int distance;
    }

    boolean ready;
    int revision = -1;
    int contextRevision = -1;
    String inputCategory = "";
    String sceneId = "";
    String sceneTitle = "";
    final LinkedHashMap<String, AndroidHudModel.ActionDescriptor> actions =
        new LinkedHashMap<>();
    final LinkedHashMap<String, AndroidHudModel.InfoSource> sources =
        new LinkedHashMap<>();
    final LinkedHashMap<String, String> values = new LinkedHashMap<>();
    final ArrayList<Message> messages = new ArrayList<>();
    final ArrayList<Cell> overmap = new ArrayList<>();
    final ArrayList<Contact> hostiles = new ArrayList<>();

    static AndroidHudSnapshot empty() {
        return new AndroidHudSnapshot();
    }

    static AndroidHudSnapshot parse(String raw) throws JSONException {
        JSONObject json = new JSONObject(raw);
        if (json.optInt("schema", 0) != SCHEMA) {
            throw new JSONException("Unsupported native HUD snapshot");
        }
        AndroidHudSnapshot result = new AndroidHudSnapshot();
        result.ready = json.optBoolean("ready", false);
        result.revision = json.optInt("revision", -1);
        result.contextRevision = json.optInt("contextRevision", -1);
        result.inputCategory = AndroidHudModel.safeId(json.optString("inputCategory", ""));
        result.sceneId = AndroidHudModel.safeId(json.optString("sceneId", ""));
        result.sceneTitle = AndroidHudModel.boundedText(json.optString("sceneTitle", ""), 100);

        JSONArray actions = json.optJSONArray("actions");
        if (actions != null) {
            for (int i = 0; i < actions.length() && i < 1024; ++i) {
                AndroidHudModel.ActionDescriptor action =
                    AndroidHudModel.ActionDescriptor.fromJson(actions.optJSONObject(i));
                if (action != null) {
                    result.actions.put(action.id, action);
                }
            }
        }
        JSONArray sources = json.optJSONArray("infoSources");
        if (sources != null) {
            for (int i = 0; i < sources.length() && i < 4096; ++i) {
                AndroidHudModel.InfoSource source =
                    AndroidHudModel.InfoSource.fromJson(sources.optJSONObject(i));
                if (source != null) {
                    result.sources.put(source.id, source);
                }
            }
        }
        JSONArray values = json.optJSONArray("values");
        if (values != null) {
            for (int i = 0; i < values.length() && i < 512; ++i) {
                JSONObject value = values.optJSONObject(i);
                if (value == null) {
                    continue;
                }
                String id = AndroidHudModel.safeId(value.optString("sourceId", ""));
                if (!id.isEmpty()) {
                    result.values.put(id, value.optString("text", ""));
                }
            }
        }
        decodeMessages(json.optJSONArray("messages"), result.messages);
        decodeCells(json.optJSONArray("overmap"), result.overmap);
        decodeContacts(json.optJSONArray("hostiles"), result.hostiles);
        return result;
    }

    String value(String sourceId, boolean preview) {
        AndroidHudModel.InfoSource source = sources.get(sourceId);
        if (preview && source != null) {
            return source.multiline ? "示例数据\n离线布局预览" : "示例数据";
        }
        String value = values.get(sourceId);
        if (value != null && !value.trim().isEmpty()) {
            return value;
        }
        return "—";
    }

    List<AndroidHudModel.ActionDescriptor> actionList() {
        return new ArrayList<>(actions.values());
    }

    private static void decodeMessages(JSONArray encoded, List<Message> target) {
        if (encoded == null) {
            return;
        }
        for (int i = 0; i < encoded.length() && i < 32; ++i) {
            JSONObject entry = encoded.optJSONObject(i);
            if (entry == null) {
                continue;
            }
            Message message = new Message();
            message.text = entry.optString("text", "");
            JSONArray runs = entry.optJSONArray("runs");
            if (runs != null) {
                for (int j = 0; j < runs.length() && j < 128; ++j) {
                    JSONObject encodedRun = runs.optJSONObject(j);
                    if (encodedRun == null) {
                        continue;
                    }
                    Run run = new Run();
                    run.text = encodedRun.optString("text", "");
                    run.color = (int)encodedRun.optLong("color", 0xFFFFFFFFL);
                    run.bold = encodedRun.optBoolean("bold", false);
                    message.runs.add(run);
                }
            }
            target.add(message);
        }
    }

    private static void decodeCells(JSONArray encoded, List<Cell> target) {
        if (encoded == null) {
            return;
        }
        for (int i = 0; i < encoded.length() && i < 49; ++i) {
            JSONObject entry = encoded.optJSONObject(i);
            if (entry == null) {
                continue;
            }
            Cell cell = new Cell();
            cell.symbol = entry.optString("symbol", "#");
            cell.color = (int)entry.optLong("color", 0xFF30343AL);
            target.add(cell);
        }
    }

    private static void decodeContacts(JSONArray encoded, List<Contact> target) {
        if (encoded == null) {
            return;
        }
        for (int i = 0; i < encoded.length() && i < 64; ++i) {
            JSONObject entry = encoded.optJSONObject(i);
            if (entry == null) {
                continue;
            }
            Contact contact = new Contact();
            contact.name = AndroidHudModel.boundedText(entry.optString("name", ""), 100);
            contact.dx = entry.optInt("dx", 0);
            contact.dy = entry.optInt("dy", 0);
            contact.distance = entry.optInt("distance", 0);
            target.add(contact);
        }
    }

}
