package com.crimsoncrossbunker.cataclysmcb;

/**
 * Pure geometry shared by HUD layout, drag/resize editing and property input.
 *
 * Ordinary elements follow the independently scaled virtual canvas.  Square
 * information renderers use the smaller viewport scale on both axes, so their
 * displayed footprint in canvas units is not necessarily frame.width x
 * frame.height.  All boundary calculations must use that displayed footprint.
 */
final class AndroidHudGeometry {
    private static final float MIN_FRAME_SIZE = 32f;
    private static final float MIN_SCALE = .001f;

    private AndroidHudGeometry() {
    }

    static int renderedWidthPixels(AndroidHudModel.Element element,
            float scaleX, float scaleY, int minimumPixels) {
        float width = AndroidHudModel.requiresSquareFrame(element) ?
            element.frame.width * uniformScale(scaleX, scaleY) :
            element.frame.width * safeScale(scaleX);
        return Math.max(Math.max(0, minimumPixels), Math.round(width));
    }

    static int renderedHeightPixels(AndroidHudModel.Element element,
            float scaleX, float scaleY, int minimumPixels) {
        float height = AndroidHudModel.requiresSquareFrame(element) ?
            element.frame.width * uniformScale(scaleX, scaleY) :
            element.frame.height * safeScale(scaleY);
        return Math.max(Math.max(0, minimumPixels), Math.round(height));
    }

    static float maximumX(AndroidHudModel.Element element, float scopeWidth,
            float scaleX, float scaleY, int minimumPixels) {
        float occupied = occupiedWidthCanvasUnits(
            element, scaleX, scaleY, minimumPixels);
        return Math.max(0f, finiteScope(scopeWidth) - occupied);
    }

    static float maximumY(AndroidHudModel.Element element, float scopeHeight,
            float scaleX, float scaleY, int minimumPixels) {
        float occupied = occupiedHeightCanvasUnits(
            element, scaleX, scaleY, minimumPixels);
        return Math.max(0f, finiteScope(scopeHeight) - occupied);
    }

    static float occupiedWidthCanvasUnits(AndroidHudModel.Element element,
            float scaleX, float scaleY, int minimumPixels) {
        return renderedWidthPixels(
            element, scaleX, scaleY, minimumPixels) / safeScale(scaleX);
    }

    static float occupiedHeightCanvasUnits(AndroidHudModel.Element element,
            float scaleX, float scaleY, int minimumPixels) {
        return renderedHeightPixels(
            element, scaleX, scaleY, minimumPixels) / safeScale(scaleY);
    }

    static float contentWidthCanvasUnits(AndroidHudModel.Element element,
            float scaleX, float density) {
        float horizontalPaddingPixels = Math.max(0f, density) *
            (element.style.contentPaddingLeftDp +
                element.style.contentPaddingRightDp);
        return Math.max(0f, element.frame.width -
            horizontalPaddingPixels / safeScale(scaleX));
    }

    static float contentHeightCanvasUnits(AndroidHudModel.Element element,
            float scaleY, float density) {
        float verticalPaddingPixels = Math.max(0f, density) *
            (element.style.contentPaddingTopDp +
                element.style.contentPaddingBottomDp);
        return Math.max(0f, element.frame.height -
            verticalPaddingPixels / safeScale(scaleY));
    }

    static void clampPosition(AndroidHudModel.Element element,
            float scopeWidth, float scopeHeight, float scaleX, float scaleY,
            int minimumPixels) {
        element.frame.x = AndroidHudModel.clampFinite(element.frame.x, 0,
            maximumX(element, scopeWidth, scaleX, scaleY, minimumPixels));
        element.frame.y = AndroidHudModel.clampFinite(element.frame.y, 0,
            maximumY(element, scopeHeight, scaleX, scaleY, minimumPixels));
    }

    static void clampFrame(AndroidHudModel.Element element,
            float scopeWidth, float scopeHeight, float scaleX, float scaleY,
            int minimumPixels) {
        float boundedWidth = Math.max(MIN_FRAME_SIZE, finiteScope(scopeWidth));
        float boundedHeight = Math.max(MIN_FRAME_SIZE, finiteScope(scopeHeight));
        if (AndroidHudModel.requiresSquareFrame(element)) {
            float uniform = uniformScale(scaleX, scaleY);
            float maximumSide = Math.min(
                boundedWidth * safeScale(scaleX) / uniform,
                boundedHeight * safeScale(scaleY) / uniform);
            maximumSide = Math.min(maximumSide,
                Math.min(AndroidHudModel.CANVAS_WIDTH, AndroidHudModel.CANVAS_HEIGHT));
            float side = AndroidHudModel.clampFinite(element.frame.width,
                MIN_FRAME_SIZE, Math.max(MIN_FRAME_SIZE, maximumSide));
            element.frame.width = side;
            element.frame.height = side;
            element.overflowMode = AndroidHudModel.OVERFLOW_FIXED;
        } else {
            element.frame.width = AndroidHudModel.clampFinite(element.frame.width,
                MIN_FRAME_SIZE, boundedWidth);
            element.frame.height = AndroidHudModel.clampFinite(element.frame.height,
                MIN_FRAME_SIZE, boundedHeight);
        }
        clampPosition(element, boundedWidth, boundedHeight,
            scaleX, scaleY, minimumPixels);
    }

    private static float uniformScale(float scaleX, float scaleY) {
        return Math.min(safeScale(scaleX), safeScale(scaleY));
    }

    private static float safeScale(float scale) {
        return Float.isNaN(scale) || Float.isInfinite(scale) || scale <= 0f ?
            MIN_SCALE : scale;
    }

    private static float finiteScope(float value) {
        return Float.isNaN(value) || Float.isInfinite(value) ?
            0f : Math.max(0f, value);
    }
}
