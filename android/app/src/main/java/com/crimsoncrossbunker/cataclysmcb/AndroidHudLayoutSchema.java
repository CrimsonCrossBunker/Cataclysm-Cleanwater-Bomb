package com.crimsoncrossbunker.cataclysmcb;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/** On-demand, read-only projection of one C++ Widget layout tree. */
final class AndroidHudLayoutSchema {
    static final int SCHEMA = 1;

    static final class Node {
        String id = "";
        String path = "";
        String label = "";
        String style = "";
        String arrangement = "";
        int originalWidthColumns;
        int originalLabelColumns;
        int originalGapColumns;
        String separator = "";
        boolean labelScope;
        boolean conditional;
        boolean conditionalBranches;
        final ArrayList<Node> children = new ArrayList<>();

        String displayName() {
            return label.isEmpty() ? id : label;
        }
    }

    String sourceId = "";
    boolean available;
    int defaultColumns = AndroidHudInfoFormat.MIN_COLUMNS;
    String warning = "";
    Node root;

    private AndroidHudLayoutSchema() {
    }

    static AndroidHudLayoutSchema parse(String raw) throws JSONException {
        JSONObject json = new JSONObject(raw);
        if (json.optInt("schema", 0) != SCHEMA) {
            throw new JSONException("Unsupported Widget layout schema");
        }
        AndroidHudLayoutSchema result = new AndroidHudLayoutSchema();
        result.sourceId = AndroidHudModel.safeId(
            json.optString("sourceId", ""));
        result.available = json.optBoolean("available", false);
        result.defaultColumns = Math.max(AndroidHudInfoFormat.MIN_COLUMNS,
            Math.min(AndroidHudInfoFormat.MAX_COLUMNS,
                json.optInt("defaultColumns",
                    AndroidHudInfoFormat.MIN_COLUMNS)));
        result.warning = AndroidHudModel.boundedText(
            json.optString("warning", ""), 240);
        int[] count = { 0 };
        result.root = decodeNode(json.optJSONObject("root"), count, 0);
        if (result.root == null) {
            result.available = false;
        }
        return result;
    }

    List<Node> flattened() {
        ArrayList<Node> result = new ArrayList<>();
        flatten(root, result);
        return result;
    }

    Set<String> paths() {
        HashSet<String> result = new HashSet<>();
        for (Node node : flattened()) {
            result.add(node.path);
        }
        return result;
    }

    String breadcrumb(Node target) {
        ArrayList<String> labels = new ArrayList<>();
        if (!findBreadcrumb(root, target == null ? "" : target.path, labels)) {
            return target == null ? "" : target.displayName();
        }
        return join(labels, " › ");
    }

    private static Node decodeNode(JSONObject json, int[] count, int depth) {
        if (json == null || depth > 32 || count[0] >= 4096) {
            return null;
        }
        Node result = new Node();
        result.id = AndroidHudModel.safeId(json.optString("id", ""));
        result.path = safePath(json.optString("path", ""));
        if (result.id.isEmpty() || result.path.isEmpty()) {
            return null;
        }
        count[0]++;
        result.label = AndroidHudModel.boundedText(
            json.optString("label", ""), 160);
        result.style = AndroidHudModel.safeId(
            json.optString("style", ""));
        result.arrangement = AndroidHudModel.safeId(
            json.optString("arrangement", ""));
        result.originalWidthColumns = Math.max(0,
            Math.min(80, json.optInt("originalWidthColumns", 0)));
        result.originalLabelColumns = Math.max(0,
            Math.min(40, json.optInt("originalLabelColumns", 0)));
        result.originalGapColumns = Math.max(0,
            Math.min(8, json.optInt("originalGapColumns", 0)));
        result.separator = safeSeparator(json.optString("separator", ""));
        result.labelScope = json.optBoolean("labelScope", false);
        result.conditional = json.optBoolean("conditional", false);
        result.conditionalBranches =
            json.optBoolean("conditionalBranches", false);
        JSONArray children = json.optJSONArray("children");
        if (children != null) {
            for (int i = 0; i < children.length() && count[0] < 4096; ++i) {
                Node child = decodeNode(
                    children.optJSONObject(i), count, depth + 1);
                if (child != null) {
                    result.children.add(child);
                }
            }
        }
        return result;
    }

    private static void flatten(Node node, List<Node> target) {
        if (node == null) {
            return;
        }
        target.add(node);
        for (Node child : node.children) {
            flatten(child, target);
        }
    }

    private static boolean findBreadcrumb(Node node, String path,
            List<String> target) {
        if (node == null) {
            return false;
        }
        target.add(node.displayName());
        if (node.path.equals(path)) {
            return true;
        }
        for (Node child : node.children) {
            if (findBreadcrumb(child, path, target)) {
                return true;
            }
        }
        target.remove(target.size() - 1);
        return false;
    }

    private static String join(List<String> values, String separator) {
        StringBuilder result = new StringBuilder();
        for (String value : values) {
            if (result.length() > 0) {
                result.append(separator);
            }
            result.append(value);
        }
        return result.toString();
    }

    private static String safePath(String raw) {
        if (raw == null || raw.isEmpty() || raw.length() > 2048) {
            return "";
        }
        for (int i = 0; i < raw.length(); ++i) {
            char c = raw.charAt(i);
            if (!Character.isLetterOrDigit(c) && c != '_' && c != '-' &&
                    c != '.' && c != ':' && c != '@' && c != '/') {
                return "";
            }
        }
        return raw;
    }

    private static String safeSeparator(String raw) {
        if (raw == null || raw.length() > 32 ||
                raw.indexOf('\r') >= 0 || raw.indexOf('\n') >= 0) {
            return "";
        }
        return raw;
    }
}
