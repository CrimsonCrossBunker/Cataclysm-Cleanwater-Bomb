package com.crimsoncrossbunker.cataclysmcb;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.view.View;

/**
 * Draws native CCB terminal cells at positions supplied by C++.
 *
 * This view intentionally contains no Unicode-width table.  C++ owns every
 * column and span, so editor and runtime rendering cannot drift from the
 * Widget layout engine when translations or fallback fonts change.
 */
final class AndroidHudTerminalView extends View {
    private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private AndroidHudSnapshot.TerminalText terminal =
        AndroidHudSnapshot.TerminalText.plain("—",
            AndroidHudInfoFormat.MIN_COLUMNS);
    private AndroidHudModel.Style style = new AndroidHudModel.Style();
    private boolean nativeAppearance = true;
    private float cellWidth = 1f;
    private float lineHeight = 1f;
    private float baselineOffset = 1f;

    AndroidHudTerminalView(Context context) {
        super(context);
        paint.setTypeface(Typeface.MONOSPACE);
        setBackgroundColor(0x00000000);
    }

    void bind(AndroidHudSnapshot.TerminalText value,
            AndroidHudModel.Style requestedStyle, boolean useNativeAppearance) {
        terminal = value == null ? AndroidHudSnapshot.TerminalText.plain(
            "—", AndroidHudInfoFormat.MIN_COLUMNS) : value;
        style = requestedStyle;
        nativeAppearance = useNativeAppearance;
        updateMetrics();
        if (!nativeAppearance &&
                AndroidHudModel.TEXT_EFFECT_SHADOW.equals(style.textEffect) &&
                style.textShadowRadiusSp > 0f) {
            setLayerType(View.LAYER_TYPE_SOFTWARE, null);
        } else {
            setLayerType(View.LAYER_TYPE_NONE, null);
        }
        requestLayout();
        invalidate();
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        updateMetrics();
        int rows = Math.max(1, terminal.rows.size());
        int desiredWidth = Math.max(getSuggestedMinimumWidth(),
            Math.round(terminal.columns * cellWidth));
        int desiredHeight = Math.max(getSuggestedMinimumHeight(),
            Math.round(rows * lineHeight));
        setMeasuredDimension(resolveSize(desiredWidth, widthMeasureSpec),
            resolveSize(desiredHeight, heightMeasureSpec));
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        updateMetrics();
        float logicalWidth = terminal.columns * cellWidth;
        float originX;
        if ("center".equals(style.alignment)) {
            originX = (getWidth() - logicalWidth) / 2f;
        } else if ("right".equals(style.alignment)) {
            originX = getWidth() - logicalWidth;
        } else {
            originX = 0f;
        }
        // A narrow hit-test frame clips content; it never feeds back into CCB
        // layout or changes where labels and values begin.
        originX = Math.max(0f, originX);

        for (int rowIndex = 0; rowIndex < terminal.rows.size(); ++rowIndex) {
            float baseline = rowIndex * lineHeight + baselineOffset;
            for (AndroidHudSnapshot.TerminalCell cell :
                    terminal.rows.get(rowIndex).cells) {
                drawCell(canvas, cell, originX, baseline);
            }
        }
        paint.clearShadowLayer();
        paint.setStyle(Paint.Style.FILL);
        paint.setTextScaleX(1f);
    }

    private void drawCell(Canvas canvas, AndroidHudSnapshot.TerminalCell cell,
            float originX, float baseline) {
        boolean custom = !nativeAppearance;
        int typefaceStyle = Typeface.NORMAL;
        if (cell.bold || custom && style.textBold) {
            typefaceStyle |= Typeface.BOLD;
        }
        if (custom && style.textItalic) {
            typefaceStyle |= Typeface.ITALIC;
        }
        paint.setTypeface(Typeface.create(Typeface.MONOSPACE, typefaceStyle));
        paint.setTextSize(sp(style.fontSizeSp));
        paint.setTextScaleX(1f);

        float targetWidth = Math.max(cellWidth, cell.span * cellWidth);
        float measured = Math.max(.01f, paint.measureText(cell.text));
        if (measured > targetWidth) {
            paint.setTextScaleX(targetWidth / measured);
            measured = targetWidth;
        }
        float x = originX + cell.column * cellWidth +
            Math.max(0f, (targetWidth - measured) / 2f);
        int fillColor = nativeAppearance || style.sourceColors ?
            cell.color : style.textColor;
        paint.setColor(fillColor);

        if (custom && AndroidHudModel.TEXT_EFFECT_SHADOW.equals(style.textEffect) &&
                style.textShadowRadiusSp > 0f) {
            paint.setShadowLayer(sp(style.textShadowRadiusSp),
                sp(style.textShadowOffsetXSp), sp(style.textShadowOffsetYSp),
                style.textShadowColor);
        } else {
            paint.clearShadowLayer();
        }
        if (custom && AndroidHudModel.TEXT_EFFECT_OUTLINE.equals(style.textEffect) &&
                style.textOutlineWidthSp > 0f) {
            paint.setStyle(Paint.Style.STROKE);
            paint.setStrokeWidth(Math.max(1f, sp(style.textOutlineWidthSp) * 2f));
            paint.setColor(style.textOutlineColor);
            canvas.drawText(cell.text, x, baseline, paint);
            paint.setStyle(Paint.Style.FILL);
            paint.setColor(fillColor);
        }
        canvas.drawText(cell.text, x, baseline, paint);
    }

    private void updateMetrics() {
        paint.setTypeface(Typeface.MONOSPACE);
        paint.setTextSize(sp(style.fontSizeSp));
        paint.setTextScaleX(1f);
        cellWidth = AndroidHudInfoFormat.terminalCellWidth(
            paint.measureText("M"), paint.measureText("界"));
        Paint.FontMetrics metrics = paint.getFontMetrics();
        float naturalHeight = Math.max(1f, metrics.descent - metrics.ascent);
        lineHeight = naturalHeight * 1.05f;
        baselineOffset = -metrics.ascent;
    }

    private float sp(float value) {
        return value * getResources().getDisplayMetrics().scaledDensity;
    }
}
