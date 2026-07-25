package com.crimsoncrossbunker.cataclysmcb;

/**
 * Resolves CCB widget character-grid settings independently from the Android
 * element frame.  The frame remains the position, clipping and hit-test area;
 * these settings only affect native widget formatting.
 */
final class AndroidHudWidgetLayout {
    static final String SETTING_COLUMNS = "layoutColumns";
    static final String SETTING_LABEL_COLUMNS = "labelColumns";
    static final String SETTING_TERMINAL_GRID = "terminalGrid";
    static final int MIN_COLUMNS = 8;
    static final int MAX_COLUMNS = 80;
    static final int MIN_LABEL_COLUMNS = 0;
    static final int MAX_LABEL_COLUMNS = 40;
    static final int AUTO_LABEL_COLUMNS = -1;

    private AndroidHudWidgetLayout() {
    }

    static boolean supports(AndroidHudModel.InfoSource source) {
        return source != null && source.configurableWidgetLayout;
    }

    static int columns(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (!supports(source)) {
            return 0;
        }
        Integer configured = parse(element, SETTING_COLUMNS);
        return configured == null ? defaultColumns(source) :
            clamp(configured, MIN_COLUMNS, MAX_COLUMNS);
    }

    static int defaultColumns(AndroidHudModel.InfoSource source) {
        return clamp(source == null ? MIN_COLUMNS : source.defaultWidgetColumns,
            MIN_COLUMNS, MAX_COLUMNS);
    }

    static int labelColumns(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (!supports(source)) {
            return AUTO_LABEL_COLUMNS;
        }
        Integer configured = parse(element, SETTING_LABEL_COLUMNS);
        int maximum = Math.min(MAX_LABEL_COLUMNS,
            Math.max(MIN_LABEL_COLUMNS, columns(source, element) - 1));
        if (configured == null || configured < MIN_LABEL_COLUMNS ||
                configured > maximum) {
            return AUTO_LABEL_COLUMNS;
        }
        return configured;
    }

    static boolean hasCustomColumns(AndroidHudModel.Element element) {
        return parse(element, SETTING_COLUMNS) != null;
    }

    static boolean hasCustomLabelColumns(AndroidHudModel.Element element) {
        return parse(element, SETTING_LABEL_COLUMNS) != null;
    }

    static boolean terminalGrid(AndroidHudModel.Element element) {
        if (element == null) {
            return true;
        }
        String configured =
            element.providerSettings.get(SETTING_TERMINAL_GRID);
        return configured == null ||
            !"false".equalsIgnoreCase(configured.trim());
    }

    static String subscription(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (!supports(source)) {
            return source == null ? "" : source.id;
        }
        return source.id + '\t' + columns(source, element) + '\t' +
            labelColumns(source, element);
    }

    static Integer parse(AndroidHudModel.Element element, String key) {
        if (element == null || key == null) {
            return null;
        }
        String raw = element.providerSettings.get(key);
        if (raw == null || raw.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.valueOf(raw.trim());
        } catch (NumberFormatException ignored) {
            return null;
        }
    }

    private static int clamp(int value, int minimum, int maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }
}
