package com.crimsoncrossbunker.cataclysmcb;

import android.content.Context;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;

/**
 * Theme-independent HUD button surface.
 *
 * Android's platform Button owns a background, disabled alpha, elevation and
 * state animator.  Those implicit layers make a transparent HUD control keep
 * a gray surface or a floating shadow.  This view draws only the appearance
 * stored in the HUD model, while retaining TextView click/long-click and
 * accessibility behavior.
 */
final class AndroidHudControlButton extends TextView {
    private final AndroidHudControlSurfaceDrawable surfaceDrawable;
    private boolean centerText;

    AndroidHudControlButton(Context context) {
        super(context);
        surfaceDrawable = new AndroidHudControlSurfaceDrawable(
            context.getResources().getDisplayMetrics().density);
        setBackground(surfaceDrawable);
        setStateListAnimator(null);
        setElevation(0f);
        setTranslationZ(0f);
        setMinWidth(0);
        setMinHeight(0);
        setSingleLine(true);
        setEllipsize(TextUtils.TruncateAt.END);
        setIncludeFontPadding(false);
    }

    void applyAppearance(AndroidHudModel.Style textStyle,
            AndroidHudModel.ControlAppearance value, boolean centered) {
        surfaceDrawable.apply(value);
        // Re-attach the owned drawable in case a theme or a future caller
        // replaced the background between binds.
        if (getBackground() != surfaceDrawable) {
            setBackground(surfaceDrawable);
        }
        centerText = centered;
        AndroidHudRendererRegistry.applyTextStyle(this, textStyle, false);
        setGravity((centerText ? Gravity.CENTER_HORIZONTAL :
            horizontalGravity(textStyle.alignment)) | Gravity.CENTER_VERTICAL);

        boolean textEffectActive =
            AndroidHudModel.TEXT_EFFECT_OUTLINE.equals(textStyle.textEffect) &&
                textStyle.textOutlineWidthSp > 0f ||
            AndroidHudModel.TEXT_EFFECT_SHADOW.equals(textStyle.textEffect) &&
                textStyle.textShadowRadiusSp > 0f;
        setLayerType(surfaceDrawable.usesBlur() || textEffectActive ?
            View.LAYER_TYPE_SOFTWARE : View.LAYER_TYPE_NONE, null);

        float density = getResources().getDisplayMetrics().density;
        setPadding(
            Math.round(textStyle.contentPaddingLeftDp * density) +
                surfaceDrawable.shadowInsetLeftPixels(),
            Math.round(textStyle.contentPaddingTopDp * density) +
                surfaceDrawable.shadowInsetTopPixels(),
            Math.round(textStyle.contentPaddingRightDp * density) +
                surfaceDrawable.shadowInsetRightPixels(),
            Math.round(textStyle.contentPaddingBottomDp * density) +
                surfaceDrawable.shadowInsetBottomPixels());
        invalidate();
    }

    @Override
    public CharSequence getAccessibilityClassName() {
        return "android.widget.Button";
    }

    private static int horizontalGravity(String alignment) {
        if ("left".equals(alignment)) {
            return Gravity.LEFT;
        }
        if ("right".equals(alignment)) {
            return Gravity.RIGHT;
        }
        return Gravity.CENTER_HORIZONTAL;
    }
}
