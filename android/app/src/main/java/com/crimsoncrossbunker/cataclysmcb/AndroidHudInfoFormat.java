package com.crimsoncrossbunker.cataclysmcb;

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
        int configured = element == null ? AUTO_LABEL_COLUMNS :
            element.infoPresentation.labelColumns;
        if (configured < MIN_LABEL_COLUMNS) {
            configured = source.defaultLabelColumns;
        }
        int maximum = Math.min(MAX_LABEL_COLUMNS,
            Math.max(MIN_LABEL_COLUMNS, columns(source, element) - 1));
        return configured >= MIN_LABEL_COLUMNS && configured <= maximum ?
            configured : AUTO_LABEL_COLUMNS;
    }

    static boolean hasCustomColumns(AndroidHudModel.Element element) {
        return element != null && element.infoPresentation.columns > 0;
    }

    static boolean hasCustomLabelColumns(AndroidHudModel.Element element) {
        return element != null && element.infoPresentation.labelColumns >= 0;
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

    static String subscription(AndroidHudModel.InfoSource source,
            AndroidHudModel.Element element) {
        if (source == null || source.id.isEmpty()) {
            return "";
        }
        if (!isTerminal(source)) {
            return source.id;
        }
        return source.id + '\t' + columns(source, element) + '\t' +
            labelColumns(source, element);
    }

    private static int clamp(int value, int minimum, int maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }

    private static boolean validWidth(float value) {
        return value > 0f && !Float.isInfinite(value) && !Float.isNaN(value);
    }
}
