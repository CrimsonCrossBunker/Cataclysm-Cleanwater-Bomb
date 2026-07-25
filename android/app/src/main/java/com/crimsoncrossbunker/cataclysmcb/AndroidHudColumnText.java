package com.crimsoncrossbunker.cataclysmcb;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.style.ReplacementSpan;

/**
 * Makes CCB terminal-layout text keep the same cell geometry in an Android
 * TextView.
 *
 * Typeface.MONOSPACE does not include CJK glyphs on Android.  Those glyphs
 * come from a fallback font whose advance is not exactly two monospace cells,
 * while CCB's widget layout uses mk_wcwidth() and reserves two cells for them.
 * Pinning padding runs and fallback glyph advances here keeps labels, values
 * and nested widget columns on the same grid without flattening rich-text
 * colors or replacing TextView.
 */
final class AndroidHudColumnText {
    private AndroidHudColumnText() {
    }

    static void apply(SpannableStringBuilder text) {
        int offset = 0;
        while (offset < text.length()) {
            int codePoint = Character.codePointAt(text, offset);
            int next = offset + Character.charCount(codePoint);
            if (codePoint == ' ') {
                int runEnd = next;
                int columns = 1;
                while (runEnd < text.length() &&
                        Character.codePointAt(text, runEnd) == ' ') {
                    runEnd++;
                    columns++;
                }
                text.setSpan(new FixedCellSpan(columns, false), offset, runEnd,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
                offset = runEnd;
                continue;
            }
            int columns = cellColumns(codePoint);
            if (codePoint > 0x7e && columns > 0) {
                text.setSpan(new FixedCellSpan(columns, true), offset, next,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            }
            offset = next;
        }
    }

    static int cellColumns(CharSequence text) {
        int columns = 0;
        int offset = 0;
        while (offset < text.length()) {
            int codePoint = Character.codePointAt(text, offset);
            columns += Math.max(0, cellColumns(codePoint));
            offset += Character.charCount(codePoint);
        }
        return columns;
    }

    /**
     * Mirrors the double-width branch of src/wcwidth.cpp::mk_wcwidth().
     * Combining marks are excluded first because some live inside broad CJK
     * ranges but occupy no terminal cell.
     */
    static int cellColumns(int codePoint) {
        if (codePoint == 0) {
            return 0;
        }
        if (codePoint < 32 || (codePoint >= 0x7f && codePoint < 0xa0)) {
            return -1;
        }
        int type = Character.getType(codePoint);
        if (type == Character.NON_SPACING_MARK ||
                type == Character.ENCLOSING_MARK ||
                type == Character.FORMAT) {
            return 0;
        }
        if (codePoint >= 0x1100 &&
                (codePoint <= 0x115f ||
                 codePoint == 0x2329 || codePoint == 0x232a ||
                 (codePoint >= 0x2e80 && codePoint <= 0xa4cf &&
                  codePoint != 0x303f) ||
                 (codePoint >= 0xac00 && codePoint <= 0xd7a3) ||
                 (codePoint >= 0xf900 && codePoint <= 0xfaff) ||
                 (codePoint >= 0xfe10 && codePoint <= 0xfe19) ||
                 (codePoint >= 0xfe30 && codePoint <= 0xfe6f) ||
                 (codePoint >= 0xff00 && codePoint <= 0xff60) ||
                 (codePoint >= 0xffe0 && codePoint <= 0xffe6) ||
                 (codePoint >= 0x20000 && codePoint <= 0x2fffd) ||
                 (codePoint >= 0x30000 && codePoint <= 0x3fffd))) {
            return 2;
        }
        return 1;
    }

    private static float monospaceCellWidth(Paint paint) {
        float width = paint.measureText("0");
        return width > 0f ? width : paint.getTextSize();
    }

    private static final class FixedCellSpan extends ReplacementSpan {
        private final int columns;
        private final boolean drawContent;

        FixedCellSpan(int columns, boolean drawContent) {
            this.columns = Math.max(0, columns);
            this.drawContent = drawContent;
        }

        @Override
        public int getSize(Paint paint, CharSequence text, int start, int end,
                Paint.FontMetricsInt fontMetrics) {
            if (fontMetrics != null) {
                paint.getFontMetricsInt(fontMetrics);
            }
            return Math.round(monospaceCellWidth(paint) * columns);
        }

        @Override
        public void draw(Canvas canvas, CharSequence text, int start, int end,
                float x, int top, int baseline, int bottom, Paint paint) {
            if (!drawContent) {
                return;
            }
            float allocatedWidth = monospaceCellWidth(paint) * columns;
            float glyphWidth = paint.measureText(text, start, end);
            if (glyphWidth <= 0f) {
                return;
            }
            if (glyphWidth <= allocatedWidth) {
                float drawX = x + (allocatedWidth - glyphWidth) * 0.5f;
                canvas.drawText(text, start, end, drawX, baseline, paint);
                return;
            }

            int saveCount = canvas.save();
            canvas.scale(allocatedWidth / glyphWidth, 1f, x, baseline);
            canvas.drawText(text, start, end, x, baseline, paint);
            canvas.restoreToCount(saveCount);
        }
    }
}
