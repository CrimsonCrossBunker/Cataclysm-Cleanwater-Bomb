package com.crimsoncrossbunker.cataclysmcb;

import android.graphics.BlurMaskFilter;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;

/**
 * Draws the complete non-text appearance of one HUD control button.
 *
 * Keeping the surface in a Drawable makes Android draw it in the normal
 * background phase, before TextView draws its label.  The control view no
 * longer has to mix button chrome into TextView.onDraw(), and both the main
 * action and the optional selector use exactly the same implementation.
 */
final class AndroidHudControlSurfaceDrawable extends Drawable {
    private final Paint surfacePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint pressedPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint borderPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint shadowPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final RectF surfaceRect = new RectF();
    private final RectF shadowRect = new RectF();
    private final RectF borderRect = new RectF();
    private final AndroidHudModel.ControlAppearance appearance =
        new AndroidHudModel.ControlAppearance();
    private final float density;

    private boolean pressed;
    private boolean buttonShadowActive;
    private BlurMaskFilter shadowFilter;

    AndroidHudControlSurfaceDrawable(float density) {
        this.density = density;
    }

    void apply(AndroidHudModel.ControlAppearance value) {
        appearance.set(value);
        buttonShadowActive = appearance.surface &&
            Color.alpha(appearance.surfaceColor) > 0 && appearance.shadow &&
            appearance.shadowRadiusDp > 0f &&
            Color.alpha(appearance.shadowColor) > 0;
        shadowFilter = buttonShadowActive ? new BlurMaskFilter(
            dp(appearance.shadowRadiusDp), BlurMaskFilter.Blur.NORMAL) : null;
        invalidateSelf();
    }

    boolean usesBlur() {
        return buttonShadowActive;
    }

    int shadowInsetLeftPixels() {
        return Math.round(shadowInsetLeft());
    }

    int shadowInsetTopPixels() {
        return Math.round(shadowInsetTop());
    }

    int shadowInsetRightPixels() {
        return Math.round(shadowInsetRight());
    }

    int shadowInsetBottomPixels() {
        return Math.round(shadowInsetBottom());
    }

    @Override
    public void draw(Canvas canvas) {
        updateSurfaceRect(getBounds());
        if (surfaceRect.isEmpty()) {
            return;
        }
        float cornerRadius = Math.max(0f, dp(appearance.cornerRadiusDp));

        if (buttonShadowActive) {
            shadowRect.set(surfaceRect);
            shadowRect.offset(dp(appearance.shadowOffsetXDp),
                dp(appearance.shadowOffsetYDp));
            shadowPaint.setStyle(Paint.Style.FILL);
            shadowPaint.setColor(appearance.shadowColor);
            shadowPaint.setMaskFilter(shadowFilter);
            canvas.drawRoundRect(shadowRect, cornerRadius, cornerRadius, shadowPaint);
            shadowPaint.clearShadowLayer();
            shadowPaint.setMaskFilter(null);
        }

        if (appearance.surface) {
            surfacePaint.setStyle(Paint.Style.FILL);
            surfacePaint.setColor(appearance.surfaceColor);
            canvas.drawRoundRect(surfaceRect, cornerRadius, cornerRadius, surfacePaint);
            if (pressed && Color.alpha(appearance.pressedOverlayColor) > 0) {
                pressedPaint.setStyle(Paint.Style.FILL);
                pressedPaint.setColor(appearance.pressedOverlayColor);
                canvas.drawRoundRect(surfaceRect, cornerRadius, cornerRadius, pressedPaint);
            }
        }

        if (appearance.border && appearance.borderWidthDp > 0f &&
                Color.alpha(appearance.borderColor) > 0) {
            float borderWidth = dp(appearance.borderWidthDp);
            borderRect.set(surfaceRect);
            borderRect.inset(borderWidth / 2f, borderWidth / 2f);
            if (!borderRect.isEmpty()) {
                borderPaint.setStyle(Paint.Style.STROKE);
                borderPaint.setStrokeWidth(borderWidth);
                borderPaint.setColor(appearance.borderColor);
                canvas.drawRoundRect(borderRect,
                    Math.max(0f, cornerRadius - borderWidth / 2f),
                    Math.max(0f, cornerRadius - borderWidth / 2f),
                    borderPaint);
            }
        }
    }

    @Override
    public boolean isStateful() {
        return true;
    }

    @Override
    protected boolean onStateChange(int[] state) {
        boolean nextPressed = false;
        if (state != null) {
            for (int value : state) {
                if (value == android.R.attr.state_pressed) {
                    nextPressed = true;
                    break;
                }
            }
        }
        if (pressed == nextPressed) {
            return false;
        }
        pressed = nextPressed;
        invalidateSelf();
        return true;
    }

    @Override
    public void setAlpha(int alpha) {
        // Overall opacity belongs to the control View.  Individual component
        // opacity remains encoded in each ARGB color.
    }

    @Override
    public void setColorFilter(ColorFilter colorFilter) {
        surfacePaint.setColorFilter(colorFilter);
        pressedPaint.setColorFilter(colorFilter);
        borderPaint.setColorFilter(colorFilter);
        shadowPaint.setColorFilter(colorFilter);
        invalidateSelf();
    }

    @Override
    @SuppressWarnings("deprecation")
    public int getOpacity() {
        return PixelFormat.TRANSLUCENT;
    }

    private void updateSurfaceRect(Rect bounds) {
        float left = shadowInsetLeft();
        float right = shadowInsetRight();
        float top = shadowInsetTop();
        float bottom = shadowInsetBottom();

        float horizontalInsets = left + right;
        if (horizontalInsets >= bounds.width() && horizontalInsets > 0f) {
            float scale = Math.max(0f, bounds.width() - 1f) / horizontalInsets;
            left *= scale;
            right *= scale;
        }
        float verticalInsets = top + bottom;
        if (verticalInsets >= bounds.height() && verticalInsets > 0f) {
            float scale = Math.max(0f, bounds.height() - 1f) / verticalInsets;
            top *= scale;
            bottom *= scale;
        }
        surfaceRect.set(bounds.left + left, bounds.top + top,
            Math.max(bounds.left + left, bounds.right - right),
            Math.max(bounds.top + top, bounds.bottom - bottom));
    }

    private float shadowInsetLeft() {
        return buttonShadowActive ?
            dp(appearance.shadowRadiusDp) +
                Math.max(0f, -dp(appearance.shadowOffsetXDp)) : 0f;
    }

    private float shadowInsetTop() {
        return buttonShadowActive ?
            dp(appearance.shadowRadiusDp) +
                Math.max(0f, -dp(appearance.shadowOffsetYDp)) : 0f;
    }

    private float shadowInsetRight() {
        return buttonShadowActive ?
            dp(appearance.shadowRadiusDp) +
                Math.max(0f, dp(appearance.shadowOffsetXDp)) : 0f;
    }

    private float shadowInsetBottom() {
        return buttonShadowActive ?
            dp(appearance.shadowRadiusDp) +
                Math.max(0f, dp(appearance.shadowOffsetYDp)) : 0f;
    }

    private float dp(float value) {
        return value * density;
    }
}
