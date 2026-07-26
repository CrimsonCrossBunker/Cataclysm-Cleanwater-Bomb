package com.crimsoncrossbunker.cataclysmcb;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.style.ForegroundColorSpan;
import android.text.style.StyleSpan;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

/** Registry of independent information renderers. */
final class AndroidHudRendererRegistry {
    interface MinimapPublisher {
        void publish(View view, boolean visible);
    }

    private interface Renderer {
        View create(Context context);
        void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher);
    }

    private final Map<String, Renderer> renderers = new HashMap<>();
    private final Renderer fallback = new RichTextRenderer();

    AndroidHudRendererRegistry() {
        renderers.put("terminal_widget", new TerminalRenderer());
        renderers.put("rich_text", fallback);
        renderers.put("message_log", new LogRenderer());
        renderers.put("pixel_minimap", new PixelMinimapRenderer());
        renderers.put("overmap_grid", new OvermapRenderer());
        renderers.put("threat_grid", new ThreatRenderer());
    }

    View create(Context context, AndroidHudModel.InfoSource source) {
        return renderer(source).create(context);
    }

    void bind(View view, AndroidHudModel.InfoSource source, AndroidHudModel.Element element,
            AndroidHudSnapshot snapshot, boolean preview, MinimapPublisher minimapPublisher) {
        renderer(source).bind(view, source, element, snapshot, preview, minimapPublisher);
    }

    private Renderer renderer(AndroidHudModel.InfoSource source) {
        Renderer renderer = source == null ? null : renderers.get(source.renderer);
        return renderer == null ? fallback : renderer;
    }

    private static final class TerminalRenderer implements Renderer {
        @Override
        public View create(Context context) {
            return new AndroidHudTerminalView(context);
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            int columns = AndroidHudInfoFormat.columns(source, element);
            int labelColumns = AndroidHudInfoFormat.labelColumns(source, element);
            ((AndroidHudTerminalView)view).bind(
                snapshot.terminalValue(source.id, columns, labelColumns, preview),
                element.style, AndroidHudInfoFormat.nativeAppearance(element));
        }
    }

    private static final class RichTextRenderer implements Renderer {
        @Override
        public View create(Context context) {
            return baseText(context);
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            TextView text = (TextView)view;
            SpannableStringBuilder content = new SpannableStringBuilder();
            content.append(preview ? "示例数据" : "—");
            text.setText(content);
            applyTextStyle(text, element.style, false);
            text.setGravity(alignment(element.style.alignment) | Gravity.CENTER_VERTICAL);
            text.setSingleLine(source == null || !source.multiline &&
                !AndroidHudModel.OVERFLOW_SCROLL.equals(element.overflowMode));
        }
    }

    private static final class LogRenderer implements Renderer {
        @Override
        public View create(Context context) {
            return baseText(context);
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            TextView text = (TextView)view;
            SpannableStringBuilder content = new SpannableStringBuilder();
            if (preview) {
                content.append("示例日志：布局可在非当前场景编辑");
            } else {
                for (AndroidHudSnapshot.RichText message : snapshot.messages) {
                    int messageStart = content.length();
                    appendRichText(content, message, element.style.sourceColors);
                    if (content.length() > messageStart) {
                        content.append('\n');
                    }
                }
            }
            text.setText(content);
            applyTextStyle(text, element.style, true);
            text.setGravity(alignment(element.style.alignment));
        }
    }

    private static final class PixelMinimapRenderer implements Renderer {
        @Override
        public View create(Context context) {
            View result = new View(context);
            result.setBackgroundColor(Color.TRANSPARENT);
            return result;
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            minimapPublisher.publish(view, !preview && snapshot.ready && element.visible);
        }
    }

    private static final class OvermapRenderer implements Renderer {
        @Override
        public View create(Context context) {
            return new OvermapGridView(context);
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            ((OvermapGridView)view).bind(snapshot, preview, element.style);
        }
    }

    private static final class ThreatRenderer implements Renderer {
        @Override
        public View create(Context context) {
            return new ThreatGridView(context);
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            int radius = element.infoPresentation.radarRadius;
            ((ThreatGridView)view).bind(snapshot, preview, Math.max(3, Math.min(30, radius)));
        }
    }

    private static TextView baseText(Context context) {
        TextView text = new TextView(context);
        // Element Style owns all content padding.  TextView's defaults must
        // not add a second, invisible inset around imported layouts.
        text.setIncludeFontPadding(false);
        text.setPadding(0, 0, 0, 0);
        text.setTextColor(Color.WHITE);
        text.setGravity(Gravity.LEFT | Gravity.CENTER_VERTICAL);
        text.setLineSpacing(0, 1.05f);
        return text;
    }

    private static void appendRichText(SpannableStringBuilder target,
            AndroidHudSnapshot.RichText value, boolean sourceColors) {
        if (!sourceColors || value.runs.isEmpty()) {
            target.append(value.text);
            return;
        }
        for (AndroidHudSnapshot.Run run : value.runs) {
            int start = target.length();
            target.append(run.text);
            target.setSpan(new ForegroundColorSpan(run.color), start,
                target.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            if (run.bold) {
                target.setSpan(new StyleSpan(Typeface.BOLD), start,
                    target.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            }
        }
    }

    static void applyTextStyle(TextView text, AndroidHudModel.Style style,
            boolean monospace) {
        int typefaceStyle = Typeface.NORMAL;
        if (style.textBold) {
            typefaceStyle |= Typeface.BOLD;
        }
        if (style.textItalic) {
            typefaceStyle |= Typeface.ITALIC;
        }
        text.setTypeface(monospace ? Typeface.MONOSPACE : Typeface.DEFAULT, typefaceStyle);
        text.setTextSize(style.fontSizeSp);
        text.setTextColor(style.textColor);
        float scale = text.getResources().getDisplayMetrics().scaledDensity;
        if (AndroidHudModel.TEXT_EFFECT_OUTLINE.equals(style.textEffect) &&
                style.textOutlineWidthSp > 0f) {
            text.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
            text.setShadowLayer(style.textOutlineWidthSp * scale,
                0f, 0f, style.textOutlineColor);
        } else if (AndroidHudModel.TEXT_EFFECT_SHADOW.equals(style.textEffect) &&
                style.textShadowRadiusSp > 0f) {
            text.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
            text.setShadowLayer(style.textShadowRadiusSp * scale,
                style.textShadowOffsetXSp * scale,
                style.textShadowOffsetYSp * scale,
                style.textShadowColor);
        } else {
            text.getPaint().clearShadowLayer();
            text.setLayerType(View.LAYER_TYPE_NONE, null);
        }
    }

    private static int alignment(String alignment) {
        if ("center".equals(alignment)) {
            return Gravity.CENTER_HORIZONTAL;
        }
        if ("right".equals(alignment)) {
            return Gravity.RIGHT;
        }
        return Gravity.LEFT;
    }

    private static final class OvermapGridView extends View {
        private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private AndroidHudSnapshot snapshot = AndroidHudSnapshot.empty();
        private boolean preview;
        private int fallbackColor;
        private int outlineColor;
        private float outlineWidth;
        private String textEffect = AndroidHudModel.TEXT_EFFECT_NONE;
        private int shadowColor;
        private float shadowRadius;
        private float shadowOffsetX;
        private float shadowOffsetY;
        private boolean sourceColors;

        OvermapGridView(Context context) {
            super(context);
            paint.setTypeface(Typeface.MONOSPACE);
            paint.setTextAlign(Paint.Align.CENTER);
        }

        void bind(AndroidHudSnapshot value, boolean isPreview,
                AndroidHudModel.Style style) {
            snapshot = value;
            preview = isPreview;
            fallbackColor = style.textColor;
            outlineColor = style.textOutlineColor;
            outlineWidth = style.textOutlineWidthSp *
                getResources().getDisplayMetrics().scaledDensity;
            textEffect = style.textEffect;
            sourceColors = style.sourceColors;
            float scale = getResources().getDisplayMetrics().scaledDensity;
            shadowColor = style.textShadowColor;
            shadowRadius = style.textShadowRadiusSp * scale;
            shadowOffsetX = style.textShadowOffsetXSp * scale;
            shadowOffsetY = style.textShadowOffsetYSp * scale;
            if (AndroidHudModel.TEXT_EFFECT_SHADOW.equals(textEffect) &&
                    style.textShadowRadiusSp > 0f) {
                setLayerType(View.LAYER_TYPE_SOFTWARE, null);
            } else {
                setLayerType(View.LAYER_TYPE_NONE, null);
            }
            int typefaceStyle = Typeface.NORMAL;
            if (style.textBold) {
                typefaceStyle |= Typeface.BOLD;
            }
            if (style.textItalic) {
                typefaceStyle |= Typeface.ITALIC;
            }
            paint.setTypeface(Typeface.create(Typeface.MONOSPACE, typefaceStyle));
            invalidate();
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            float cell = Math.min(getWidth(), getHeight()) / 7f;
            float left = (getWidth() - cell * 7f) / 2f;
            float top = (getHeight() - cell * 7f) / 2f;
            paint.setTextSize(cell * .68f);
            if (AndroidHudModel.TEXT_EFFECT_SHADOW.equals(textEffect) &&
                    shadowRadius > 0f) {
                paint.setShadowLayer(shadowRadius, shadowOffsetX,
                    shadowOffsetY, shadowColor);
            } else {
                paint.clearShadowLayer();
            }
            for (int index = 0; index < 49; ++index) {
                AndroidHudSnapshot.Cell source = !preview && index < snapshot.overmap.size() ?
                    snapshot.overmap.get(index) : null;
                String symbol = source == null ? (preview ? "·" : "#") : source.symbol;
                paint.setColor(source == null || !sourceColors ?
                    fallbackColor : source.color);
                float x = left + (index % 7 + .5f) * cell;
                float y = top + (index / 7 + .72f) * cell;
                if (AndroidHudModel.TEXT_EFFECT_OUTLINE.equals(textEffect) &&
                        outlineWidth > 0f) {
                    int fill = paint.getColor();
                    paint.setStyle(Paint.Style.STROKE);
                    paint.setStrokeWidth(Math.max(1f, outlineWidth * 2f));
                    paint.setColor(outlineColor);
                    canvas.drawText(symbol, x, y, paint);
                    paint.setStyle(Paint.Style.FILL);
                    paint.setColor(fill);
                }
                canvas.drawText(symbol, x, y, paint);
            }
            paint.clearShadowLayer();
            paint.setStyle(Paint.Style.STROKE);
            paint.setStrokeWidth(Math.max(2f, cell * .05f));
            paint.setColor(0xFFFFFFFF);
            canvas.drawRect(left + 3 * cell, top + 3 * cell,
                left + 4 * cell, top + 4 * cell, paint);
            paint.setStyle(Paint.Style.FILL);
        }
    }

    private static final class ThreatGridView extends View {
        private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private AndroidHudSnapshot snapshot = AndroidHudSnapshot.empty();
        private boolean preview;
        private int radius = 10;

        ThreatGridView(Context context) {
            super(context);
        }

        void bind(AndroidHudSnapshot value, boolean isPreview, int requestedRadius) {
            snapshot = value;
            preview = isPreview;
            radius = requestedRadius;
            invalidate();
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            int side = radius * 2 + 1;
            float cell = Math.min(getWidth(), getHeight()) / (float)side;
            float left = (getWidth() - side * cell) / 2f;
            float top = (getHeight() - side * cell) / 2f;
            paint.setStyle(Paint.Style.STROKE);
            paint.setStrokeWidth(Math.max(1f, cell * .06f));
            paint.setColor(0x445A7184);
            for (int i = 0; i <= side; ++i) {
                canvas.drawLine(left + i * cell, top, left + i * cell, top + side * cell, paint);
                canvas.drawLine(left, top + i * cell, left + side * cell, top + i * cell, paint);
            }
            paint.setStyle(Paint.Style.FILL);
            paint.setColor(0xFF66D9EF);
            canvas.drawRect(left + radius * cell, top + radius * cell,
                left + (radius + 1) * cell, top + (radius + 1) * cell, paint);
            if (preview) {
                paint.setColor(0xFFFF7043);
                canvas.drawRect(left + (radius + 3) * cell, top + (radius - 2) * cell,
                    left + (radius + 4) * cell, top + (radius - 1) * cell, paint);
                return;
            }
            paint.setColor(0xFFFF5252);
            for (AndroidHudSnapshot.Contact contact : snapshot.hostiles) {
                int x = Math.max(-radius, Math.min(radius, contact.dx));
                int y = Math.max(-radius, Math.min(radius, contact.dy));
                canvas.drawRect(left + (radius + x) * cell, top + (radius + y) * cell,
                    left + (radius + x + 1) * cell, top + (radius + y + 1) * cell, paint);
            }
        }
    }
}
