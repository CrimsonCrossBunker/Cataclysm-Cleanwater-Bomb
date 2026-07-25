package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.util.Locale;

/** Small dependency-free ARGB/HSV color picker shared by every HUD color field. */
final class AndroidHudColorPickerDialog {
    interface Listener {
        void selected(int color);
    }

    private AndroidHudColorPickerDialog() {
    }

    static void show(Context context, String title, int initialColor, Listener listener) {
        LinearLayout content = new LinearLayout(context);
        content.setOrientation(LinearLayout.VERTICAL);
        int padding = dp(context, 18);
        content.setPadding(padding, dp(context, 8), padding, dp(context, 8));

        TextView preview = new TextView(context);
        preview.setText("HUD 颜色预览");
        preview.setGravity(Gravity.CENTER);
        content.addView(preview, new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(context, 56)));

        EditText hex = new EditText(context);
        hex.setHint("#AARRGGBB 或 #RRGGBB");
        hex.setSingleLine(true);
        hex.setInputType(InputType.TYPE_CLASS_TEXT |
            InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS);
        content.addView(hex, row());

        float[] initialHsv = new float[3];
        Color.colorToHSV(initialColor, initialHsv);
        SeekRow hue = seekRow(context, "色相", 360, Math.round(initialHsv[0]), "°");
        SeekRow saturation = seekRow(context, "饱和度", 100,
            Math.round(initialHsv[1] * 100), "%");
        SeekRow brightness = seekRow(context, "亮度", 100,
            Math.round(initialHsv[2] * 100), "%");
        SeekRow alpha = seekRow(context, "不透明度", 255,
            Color.alpha(initialColor), "/255");
        content.addView(hue.root, row());
        content.addView(saturation.root, row());
        content.addView(brightness.root, row());
        content.addView(alpha.root, row());
        TextView alphaHelp = new TextView(context);
        alphaHelp.setText("不透明度：0 = 完全透明，255 = 完全不透明");
        alphaHelp.setTextSize(12f);
        content.addView(alphaHelp, row());

        int[] selected = { initialColor };
        boolean[] syncing = { false };

        Runnable updateFromSliders = () -> {
            float[] hsv = {
                hue.seek.getProgress(),
                saturation.seek.getProgress() / 100f,
                brightness.seek.getProgress() / 100f
            };
            selected[0] = Color.HSVToColor(alpha.seek.getProgress(), hsv);
            applyPreview(preview, selected[0]);
            syncing[0] = true;
            hex.setText(toHex(selected[0]));
            hex.setSelection(hex.length());
            syncing[0] = false;
        };
        SeekBar.OnSeekBarChangeListener sliderListener =
            new SeekBar.OnSeekBarChangeListener() {
                @Override
                public void onProgressChanged(SeekBar seekBar, int progress,
                        boolean fromUser) {
                    if (seekBar == hue.seek) {
                        hue.updateValue(progress);
                    } else if (seekBar == saturation.seek) {
                        saturation.updateValue(progress);
                    } else if (seekBar == brightness.seek) {
                        brightness.updateValue(progress);
                    } else if (seekBar == alpha.seek) {
                        alpha.updateValue(progress);
                    }
                    if (fromUser && !syncing[0]) {
                        updateFromSliders.run();
                    }
                }

                @Override public void onStartTrackingTouch(SeekBar seekBar) {
                }

                @Override public void onStopTrackingTouch(SeekBar seekBar) {
                }
            };
        hue.seek.setOnSeekBarChangeListener(sliderListener);
        saturation.seek.setOnSeekBarChangeListener(sliderListener);
        brightness.seek.setOnSeekBarChangeListener(sliderListener);
        alpha.seek.setOnSeekBarChangeListener(sliderListener);

        hex.addTextChangedListener(new TextWatcher() {
            @Override public void beforeTextChanged(CharSequence text, int start,
                    int count, int after) {
            }

            @Override public void onTextChanged(CharSequence text, int start,
                    int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable text) {
                if (syncing[0]) {
                    return;
                }
                Integer parsed = parseColor(text == null ? "" : text.toString());
                if (parsed == null) {
                    return;
                }
                selected[0] = parsed;
                float[] hsv = new float[3];
                Color.colorToHSV(parsed, hsv);
                syncing[0] = true;
                hue.seek.setProgress(Math.round(hsv[0]));
                saturation.seek.setProgress(Math.round(hsv[1] * 100));
                brightness.seek.setProgress(Math.round(hsv[2] * 100));
                alpha.seek.setProgress(Color.alpha(parsed));
                syncing[0] = false;
                applyPreview(preview, parsed);
            }
        });

        syncing[0] = true;
        hex.setText(toHex(initialColor));
        hex.setSelection(hex.length());
        syncing[0] = false;
        applyPreview(preview, initialColor);

        ScrollView scroll = new ScrollView(context);
        scroll.setFillViewport(true);
        scroll.setClipToPadding(false);
        scroll.setVerticalScrollBarEnabled(true);
        scroll.setOverScrollMode(ScrollView.OVER_SCROLL_IF_CONTENT_SCROLLS);
        scroll.setPadding(0, 0, 0, dp(context, 20));
        scroll.addView(content, new ScrollView.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        AlertDialog dialog = new AlertDialog.Builder(context)
            .setTitle(title)
            .setView(scroll)
            .setPositiveButton("选择", (ignored, which) -> listener.selected(selected[0]))
            .setNegativeButton("取消", null)
            .create();
        dialog.setOnShowListener(ignored -> {
            if (dialog.getWindow() == null) {
                return;
            }
            int screenWidth = context.getResources().getDisplayMetrics().widthPixels;
            int screenHeight = context.getResources().getDisplayMetrics().heightPixels;
            dialog.getWindow().setLayout(
                Math.min(screenWidth, dp(context, 720)),
                Math.round(screenHeight * .92f));
        });
        dialog.show();
    }

    private static SeekRow seekRow(Context context, String label, int maximum,
            int current, String suffix) {
        LinearLayout root = new LinearLayout(context);
        root.setOrientation(LinearLayout.HORIZONTAL);
        root.setGravity(Gravity.CENTER_VERTICAL);
        TextView title = new TextView(context);
        title.setText(label);
        root.addView(title, new LinearLayout.LayoutParams(dp(context, 72),
            ViewGroup.LayoutParams.WRAP_CONTENT));
        SeekBar seek = new SeekBar(context);
        seek.setMax(maximum);
        seek.setProgress(Math.max(0, Math.min(maximum, current)));
        root.addView(seek, new LinearLayout.LayoutParams(
            0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        TextView value = new TextView(context);
        value.setGravity(Gravity.RIGHT | Gravity.CENTER_VERTICAL);
        value.setText(current + suffix);
        root.addView(value, new LinearLayout.LayoutParams(dp(context, 58),
            ViewGroup.LayoutParams.WRAP_CONTENT));
        return new SeekRow(root, seek, value, suffix);
    }

    private static void applyPreview(TextView preview, int color) {
        preview.setBackgroundColor(color);
        double luminance = .299 * Color.red(color) + .587 * Color.green(color) +
            .114 * Color.blue(color);
        preview.setTextColor(luminance >= 150 ? Color.BLACK : Color.WHITE);
    }

    private static Integer parseColor(String raw) {
        String value = raw == null ? "" : raw.trim();
        if (value.startsWith("#")) {
            value = value.substring(1);
        }
        try {
            if (value.length() == 6) {
                return (int)(0xFF000000L | Long.parseLong(value, 16));
            }
            if (value.length() == 8) {
                return (int)Long.parseLong(value, 16);
            }
        } catch (NumberFormatException ignored) {
        }
        return null;
    }

    private static String toHex(int color) {
        return String.format(Locale.ROOT, "#%08X", color);
    }

    private static LinearLayout.LayoutParams row() {
        return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
    }

    private static int dp(Context context, int value) {
        return Math.round(value * context.getResources().getDisplayMetrics().density);
    }

    private static final class SeekRow {
        final LinearLayout root;
        final SeekBar seek;
        final TextView value;
        final String suffix;

        SeekRow(LinearLayout root, SeekBar seek, TextView value, String suffix) {
            this.root = root;
            this.seek = seek;
            this.value = value;
            this.suffix = suffix;
        }

        void updateValue(int progress) {
            value.setText(progress + suffix);
        }
    }
}
