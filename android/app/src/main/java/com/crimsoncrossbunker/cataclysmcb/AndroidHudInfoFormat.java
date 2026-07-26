package com.crimsoncrossbunker.cataclysmcb;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * Resolves typed information formatting without consulting an element's
 * pixel frame.  CCB terminal columns are a content contract; the frame only
 * controls placement, clipping, scrolling and hit testing.
 */
final class AndroidHudInfoFormat {
    static final int MIN_COLUMNS = 8;
    static final int MAX_COLUMNS = 80;
    static final int MIN_LABEL_COLUMNS = 0;
    static final int MAX_LABEL_COLUMNS = 40;
    static final int AUTO_LABEL_COLUMNS = -1;

    private AndroidHudInfoFormat() {
    }

    static boolean isTerminal(AndroidHudModel.InfoSource source) {
        return source != null && "terminal_widget".equals(source.renderer);
    }

    static boolean isConfigurable(AndroidHudModel.InfoSource source) {
        return isTerminal(source) && source.terminalConfigurable;
    }

    static int defaultColumns(AndroidHudModel.InfoSource source) {
        return clamp(source == null ? MIN_COLUMNS : source.defaultColumns,
            MIN_COLUMNS, MAX_COLUMNS);
    }

    static int columns(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (!isTerminal(source)) {
            return 0;
        }
        if (AndroidHudModel.INFO_LAYOUT_ORIGINAL.equals(
                layoutMode(source, element))) {
            return defaultColumns(source);
        }
        int configured = element == null ? 0 :
            element.infoPresentation.columns;
        return configured > 0 ? clamp(configured, MIN_COLUMNS, MAX_COLUMNS) :
            defaultColumns(source);
    }

    static int labelColumns(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (!isConfigurable(source)) {
            return AUTO_LABEL_COLUMNS;
        }
        if (element != null) {
            for (AndroidHudModel.NodeOverride node :
                    element.infoPresentation.nodeOverrides) {
                if (node.labelColumns != null) {
                    return clamp(node.labelColumns, MIN_LABEL_COLUMNS,
                        Math.min(MAX_LABEL_COLUMNS,
                            Math.max(MIN_LABEL_COLUMNS,
                                columns(source, element) - 1)));
                }
            }
        }
        return source.defaultLabelColumns;
    }

    static boolean hasCustomColumns(AndroidHudModel.Element element) {
        return element != null && element.infoPresentation.columns > 0;
    }

    static boolean hasCustomLabelColumns(AndroidHudModel.Element element) {
        if (element == null) {
            return false;
        }
        for (AndroidHudModel.NodeOverride node :
                element.infoPresentation.nodeOverrides) {
            if (node.labelColumns != null) {
                return true;
            }
        }
        return false;
    }

    static boolean nativeAppearance(AndroidHudModel.Element element) {
        return element == null || !AndroidHudModel.INFO_APPEARANCE_CUSTOM.equals(
            element.infoPresentation.appearanceMode);
    }

    /**
     * Resolves one CCB terminal column from the active Android font.
     *
     * C++ is authoritative for terminal spans: narrow glyphs occupy one
     * column and CJK glyphs occupy two.  Android's MONOSPACE fallback often
     * gives Latin and CJK glyphs the same physical advance, so using the
     * Latin advance directly would insert a second, artificial CJK-width gap.
     */
    static float terminalCellWidth(float narrowGlyphWidth,
            float wideGlyphWidth) {
        float narrow = validWidth(narrowGlyphWidth) ? narrowGlyphWidth : 1f;
        float wideCell = validWidth(wideGlyphWidth) ?
            wideGlyphWidth / 2f : narrow;
        return Math.max(1f, Math.min(narrow, wideCell));
    }

    static String layoutMode(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (!isConfigurable(source) || element == null) {
            return AndroidHudModel.INFO_LAYOUT_ORIGINAL;
        }
        String mode = element.infoPresentation.layoutMode;
        return AndroidHudModel.INFO_LAYOUT_CUSTOM.equals(mode) ||
            AndroidHudModel.INFO_LAYOUT_LOOSE.equals(mode) ? mode :
            AndroidHudModel.INFO_LAYOUT_ORIGINAL;
    }

    static final class Request {
        final String key;
        final JSONObject json;

        Request(String key, JSONObject json) {
            this.key = key;
            this.json = json;
        }
    }

    static Request request(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (source == null || source.id.isEmpty()) {
            return null;
        }
        String mode = layoutMode(source, element);
        int columns = isTerminal(source) ?
            columns(source, element) : MIN_COLUMNS;
        ArrayList<AndroidHudModel.NodeOverride> overrides =
            new ArrayList<>();
        if (AndroidHudModel.INFO_LAYOUT_CUSTOM.equals(mode) &&
                element != null) {
            for (AndroidHudModel.NodeOverride node :
                    element.infoPresentation.nodeOverrides) {
                overrides.add(node.copy());
            }
            overrides.sort(Comparator.comparing(node -> node.path));
        }

        String canonical = canonicalConfiguration(
            source.id, mode, columns, overrides);
        String key = sha256(canonical);
        try {
            JSONObject request = new JSONObject();
            request.put("key", key);
            request.put("sourceId", source.id);
            request.put("layoutMode", mode);
            request.put("columns", columns);
            JSONArray encodedOverrides = new JSONArray();
            for (AndroidHudModel.NodeOverride node : overrides) {
                encodedOverrides.put(node.toJson());
            }
            request.put("nodeOverrides", encodedOverrides);
            return new Request(key, request);
        } catch (JSONException error) {
            return null;
        }
    }

    static String requestKey(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        Request request = request(source, element);
        return request == null ? "" : request.key;
    }

    private static String canonicalConfiguration(String sourceId,
            String layoutMode, int columns,
            List<AndroidHudModel.NodeOverride> overrides) {
        StringBuilder result = new StringBuilder();
        result.append("{\"columns\":").append(columns)
            .append(",\"layoutMode\":").append(JSONObject.quote(layoutMode))
            .append(",\"nodeOverrides\":[");
        boolean first = true;
        for (AndroidHudModel.NodeOverride node : overrides) {
            if (!first) {
                result.append(',');
            }
            first = false;
            result.append("{\"path\":").append(JSONObject.quote(node.path));
            if (node.gapColumns != null) {
                result.append(",\"gapColumns\":").append(node.gapColumns);
            }
            if (node.labelColumns != null) {
                result.append(",\"labelColumns\":").append(node.labelColumns);
            }
            if (node.separator != null) {
                result.append(",\"separator\":")
                    .append(JSONObject.quote(node.separator));
            }
            if (node.widthColumns != null) {
                result.append(",\"widthColumns\":").append(node.widthColumns);
            }
            result.append('}');
        }
        return result.append("],\"sourceId\":")
            .append(JSONObject.quote(sourceId)).append('}').toString();
    }

    private static String sha256(String value) {
        try {
            byte[] digest = MessageDigest.getInstance("SHA-256").digest(
                value.getBytes(StandardCharsets.UTF_8));
            StringBuilder result = new StringBuilder(64);
            for (byte part : digest) {
                result.append(String.format("%02x", part & 0xff));
            }
            return result.toString();
        } catch (NoSuchAlgorithmException impossible) {
            throw new IllegalStateException("SHA-256 unavailable", impossible);
        }
    }

    private static int clamp(int value, int minimum, int maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }

    private static boolean validWidth(float value) {
        return value > 0f && !Float.isInfinite(value) && !Float.isNaN(value);
    }
}
