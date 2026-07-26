package com.crimsoncrossbunker.cataclysmcb;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/** Immutable Java-side projection of the game-thread HUD snapshot. */
final class AndroidHudSnapshot {
    static final int SCHEMA = 4;

    static final class RichText {
        String text = "";
        final ArrayList<Run> runs = new ArrayList<>();

        static RichText plain(String value) {
            RichText result = new RichText();
            result.text = value;
            return result;
        }
    }

    static final class Run {
        String text = "";
        int color = 0xFFFFFFFF;
        boolean bold;
    }

    static final class TerminalCell {
        int column;
        int span = 1;
        String text = "";
        int color = 0xFFFFFFFF;
        boolean bold;
    }

    static final class TerminalRow {
        final ArrayList<TerminalCell> cells = new ArrayList<>();
    }

    static final class TerminalText {
        int columns = AndroidHudInfoFormat.MIN_COLUMNS;
        final ArrayList<TerminalRow> rows = new ArrayList<>();

        boolean hasVisibleContent() {
            for (TerminalRow row : rows) {
                if (!row.cells.isEmpty()) {
                    return true;
                }
            }
            return false;
        }

        static TerminalText plain(String text, int columns) {
            TerminalText result = new TerminalText();
            result.columns = Math.max(AndroidHudInfoFormat.MIN_COLUMNS,
                Math.min(AndroidHudInfoFormat.MAX_COLUMNS, columns));
            TerminalRow row = new TerminalRow();
            TerminalCell cell = new TerminalCell();
            cell.column = 0;
            // Java must not infer terminal width from UTF-16 length.  A
            // fallback occupies the whole logical row; real content always
            // receives exact columns and spans from C++.
            cell.span = result.columns;
            cell.text = text;
            row.cells.add(cell);
            result.rows.add(row);
            return result;
        }
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
    final LinkedHashMap<String, TerminalText> terminalValues = new LinkedHashMap<>();
    final ArrayList<RichText> messages = new ArrayList<>();
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
                    int layoutColumns = Math.max(0,
                        Math.min(AndroidHudInfoFormat.MAX_COLUMNS,
                            value.optInt("layoutColumns",
                                value.optInt("widgetWidth", 0))));
                    int labelColumns = value.has("labelColumns") ?
                        Math.max(AndroidHudInfoFormat.MIN_LABEL_COLUMNS,
                            Math.min(AndroidHudInfoFormat.MAX_LABEL_COLUMNS,
                                value.optInt("labelColumns", 0))) :
                        AndroidHudInfoFormat.AUTO_LABEL_COLUMNS;
                    result.terminalValues.put(
                        valueKey(id, layoutColumns, labelColumns),
                        decodeTerminal(value.optJSONObject("terminal")));
                }
            }
        }
        decodeRichTextArray(json.optJSONArray("messages"), result.messages);
        decodeCells(json.optJSONArray("overmap"), result.overmap);
        decodeContacts(json.optJSONArray("hostiles"), result.hostiles);
        return result;
    }

    TerminalText terminalValue(String sourceId, int layoutColumns,
            int labelColumns, boolean preview) {
        AndroidHudModel.InfoSource source = sources.get(sourceId);
        TerminalText value = terminalValues.get(
            valueKey(sourceId, layoutColumns, labelColumns));
        if (value == null && layoutColumns != 0) {
            value = terminalValues.get(valueKey(sourceId, 0,
                AndroidHudInfoFormat.AUTO_LABEL_COLUMNS));
        }
        if (value == null) {
            String prefix = sourceId + '\u001f';
            for (String key : terminalValues.keySet()) {
                if (key.startsWith(prefix)) {
                    value = terminalValues.get(key);
                    break;
                }
            }
        }
        if (value != null && value.hasVisibleContent()) {
            return value;
        }
        int columns = layoutColumns > 0 ? layoutColumns :
            source == null ? AndroidHudInfoFormat.MIN_COLUMNS :
            source.defaultColumns;
        return TerminalText.plain(preview ? "示例数据" : "—", columns);
    }

    private static String valueKey(String sourceId, int layoutColumns,
            int labelColumns) {
        return sourceId + '\u001f' + layoutColumns + '\u001f' + labelColumns;
    }

    List<AndroidHudModel.ActionDescriptor> actionList() {
        return new ArrayList<>(actions.values());
    }

    private static void decodeRichTextArray(JSONArray encoded, List<RichText> target) {
        if (encoded == null) {
            return;
        }
        for (int i = 0; i < encoded.length() && i < 32; ++i) {
            JSONObject entry = encoded.optJSONObject(i);
            if (entry == null) {
                continue;
            }
            target.add(decodeRichText(entry));
        }
    }

    private static RichText decodeRichText(JSONObject encoded) {
        RichText result = new RichText();
        result.text = encoded.optString("text", "");
        JSONArray runs = encoded.optJSONArray("runs");
        if (runs == null) {
            return result;
        }
        for (int i = 0; i < runs.length() && i < 128; ++i) {
            JSONObject encodedRun = runs.optJSONObject(i);
            if (encodedRun == null) {
                continue;
            }
            Run run = new Run();
            run.text = encodedRun.optString("text", "");
            run.color = (int)encodedRun.optLong("color", 0xFFFFFFFFL);
            run.bold = encodedRun.optBoolean("bold", false);
            result.runs.add(run);
        }
        return result;
    }

    private static TerminalText decodeTerminal(JSONObject encoded) {
        TerminalText result = new TerminalText();
        if (encoded == null) {
            return result;
        }
        result.columns = Math.max(AndroidHudInfoFormat.MIN_COLUMNS,
            Math.min(AndroidHudInfoFormat.MAX_COLUMNS,
                encoded.optInt("columns", AndroidHudInfoFormat.MIN_COLUMNS)));
        JSONArray rows = encoded.optJSONArray("rows");
        if (rows == null) {
            return result;
        }
        int totalCells = 0;
        for (int rowIndex = 0; rowIndex < rows.length() && rowIndex < 128; ++rowIndex) {
            JSONObject encodedRow = rows.optJSONObject(rowIndex);
            TerminalRow row = new TerminalRow();
            JSONArray cells = encodedRow == null ? null :
                encodedRow.optJSONArray("cells");
            if (cells != null) {
                for (int cellIndex = 0; cellIndex < cells.length() &&
                        totalCells < 4096; ++cellIndex) {
                    JSONObject encodedCell = cells.optJSONObject(cellIndex);
                    if (encodedCell == null) {
                        continue;
                    }
                    TerminalCell cell = new TerminalCell();
                    cell.column = Math.max(0, Math.min(result.columns - 1,
                        encodedCell.optInt("column", 0)));
                    cell.span = Math.max(1, Math.min(
                        result.columns - cell.column,
                        encodedCell.optInt("span", 1)));
                    cell.text = AndroidHudModel.boundedText(
                        encodedCell.optString("text", ""), 256);
                    if (cell.text.isEmpty()) {
                        continue;
                    }
                    cell.color = (int)encodedCell.optLong("color", 0xFFFFFFFFL);
                    cell.bold = encodedCell.optBoolean("bold", false);
                    row.cells.add(cell);
                    totalCells++;
                }
            }
            result.rows.add(row);
        }
        return result;
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
