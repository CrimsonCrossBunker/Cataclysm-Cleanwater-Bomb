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
    private final Renderer fallback = new TextRenderer();

    AndroidHudRendererRegistry() {
        renderers.put("text", fallback);
        renderers.put("log", new LogRenderer());
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

    private static final class TextRenderer implements Renderer {
        @Override
        public View create(Context context) {
            TextView text = baseText(context);
            text.setTypeface(Typeface.MONOSPACE);
            return text;
        }

        @Override
        public void bind(View view, AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element, AndroidHudSnapshot snapshot,
                boolean preview, MinimapPublisher minimapPublisher) {
            TextView text = (TextView)view;
            String title = element.label.isEmpty() ? source.title : element.label;
            String value = snapshot.value(source.id, preview);
            text.setText(element.style.showLabel ? title + "  " + value : value);
            text.setTextSize(element.style.fontSizeSp);
            text.setTextColor(element.style.textColor);
            text.setGravity(alignment(element.style.alignment) | Gravity.CENTER_VERTICAL);
            text.setSingleLine(!source.multiline);
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
            if (element.style.showLabel) {
                content.append(element.label.isEmpty() ? source.title : element.label).append('\n');
            }
            if (preview) {
                content.append("示例日志：布局可在非当前场景编辑");
            } else {
                for (AndroidHudSnapshot.Message message : snapshot.messages) {
                    int messageStart = content.length();
                    if (message.runs.isEmpty()) {
                        content.append(message.text);
                    } else {
                        for (AndroidHudSnapshot.Run run : message.runs) {
                            int start = content.length();
                            content.append(run.text);
                            content.setSpan(new ForegroundColorSpan(run.color), start,
                                content.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
                            if (run.bold) {
                                content.setSpan(new StyleSpan(Typeface.BOLD), start,
                                    content.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
                            }
                        }
                    }
                    if (content.length() > messageStart) {
                        content.append('\n');
                    }
                }
            }
            text.setText(content);
            text.setTextSize(element.style.fontSizeSp);
            text.setTextColor(element.style.textColor);
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
            ((OvermapGridView)view).bind(snapshot, preview, element.style.textColor);
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
            int radius = 10;
            try {
                radius = Integer.parseInt(element.providerSettings.get("radius"));
            } catch (NumberFormatException | NullPointerException ignored) {
            }
            ((ThreatGridView)view).bind(snapshot, preview, Math.max(3, Math.min(30, radius)));
        }
    }

    private static TextView baseText(Context context) {
        TextView text = new TextView(context);
        int padding = Math.round(6 * context.getResources().getDisplayMetrics().density);
        text.setPadding(padding, padding, padding, padding);
        text.setTextColor(Color.WHITE);
        text.setGravity(Gravity.LEFT | Gravity.CENTER_VERTICAL);
        text.setLineSpacing(0, 1.05f);
        return text;
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

        OvermapGridView(Context context) {
            super(context);
            paint.setTypeface(Typeface.MONOSPACE);
            paint.setTextAlign(Paint.Align.CENTER);
        }

        void bind(AndroidHudSnapshot value, boolean isPreview, int textColor) {
            snapshot = value;
            preview = isPreview;
            fallbackColor = textColor;
            invalidate();
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            float cell = Math.min(getWidth(), getHeight()) / 7f;
            float left = (getWidth() - cell * 7f) / 2f;
            float top = (getHeight() - cell * 7f) / 2f;
            paint.setTextSize(cell * .68f);
            for (int index = 0; index < 49; ++index) {
                AndroidHudSnapshot.Cell source = !preview && index < snapshot.overmap.size() ?
                    snapshot.overmap.get(index) : null;
                String symbol = source == null ? (preview ? "·" : "#") : source.symbol;
                paint.setColor(source == null ? fallbackColor : source.color);
                float x = left + (index % 7 + .5f) * cell;
                float y = top + (index / 7 + .72f) * cell;
                canvas.drawText(symbol, x, y, paint);
            }
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
