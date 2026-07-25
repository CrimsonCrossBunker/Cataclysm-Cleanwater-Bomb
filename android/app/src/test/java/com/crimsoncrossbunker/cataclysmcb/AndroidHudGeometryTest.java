package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudGeometryTest {
    private static final float SCALE_X = 2800f / AndroidHudModel.CANVAS_WIDTH;
    private static final float SCALE_Y = 1272f / AndroidHudModel.CANVAS_HEIGHT;

    @Test
    public void squareMapCanAlignWithWideViewportRightEdge() {
        AndroidHudModel.Element map = squareMap(420f);

        map.frame.x = AndroidHudGeometry.maximumX(map,
            AndroidHudModel.CANVAS_WIDTH, SCALE_X, SCALE_Y, 0);

        int right = Math.round(map.frame.x * SCALE_X) +
            AndroidHudGeometry.renderedWidthPixels(map, SCALE_X, SCALE_Y, 0);
        assertEquals(2800, right);
        assertTrue(map.frame.x >
            AndroidHudModel.CANVAS_WIDTH - map.frame.width);
    }

    @Test
    public void ordinaryElementsStillUseIndependentCanvasScale() {
        AndroidHudModel.Element info = new AndroidHudModel.Element();
        info.type = AndroidHudModel.TYPE_INFO;
        info.sourceId = "environment.weather";
        info.frame.width = 420f;

        float maximumX = AndroidHudGeometry.maximumX(info,
            AndroidHudModel.CANVAS_WIDTH, SCALE_X, SCALE_Y, 0);

        assertEquals(1500f, maximumX, .5f);
        assertEquals(2800, Math.round(maximumX * SCALE_X) +
            AndroidHudGeometry.renderedWidthPixels(info, SCALE_X, SCALE_Y, 0));
    }

    @Test
    public void squareMapUsesTheSameBoundaryInsideAGroup() {
        AndroidHudModel.Element map = squareMap(420f);
        float groupWidth = 450f;

        map.frame.x = AndroidHudGeometry.maximumX(
            map, groupWidth, SCALE_X, SCALE_Y, 0);

        int groupRight = Math.round(groupWidth * SCALE_X);
        int mapRight = Math.round(map.frame.x * SCALE_X) +
            AndroidHudGeometry.renderedWidthPixels(map, SCALE_X, SCALE_Y, 0);
        assertEquals(groupRight, mapRight);
    }

    @Test
    public void resizingReclampsSquarePositionOnBothAxes() {
        AndroidHudModel.Element map = squareMap(700f);
        map.frame.x = 1500f;
        map.frame.y = 900f;

        AndroidHudGeometry.clampFrame(map,
            AndroidHudModel.CANVAS_WIDTH, AndroidHudModel.CANVAS_HEIGHT,
            SCALE_X, SCALE_Y, 0);

        assertEquals(2800, Math.round(map.frame.x * SCALE_X) +
            AndroidHudGeometry.renderedWidthPixels(map, SCALE_X, SCALE_Y, 0));
        assertEquals(1272, Math.round(map.frame.y * SCALE_Y) +
            AndroidHudGeometry.renderedHeightPixels(map, SCALE_X, SCALE_Y, 0));
    }

    @Test
    public void childFrameIsBoundedByItsGroup() {
        AndroidHudModel.Element info = new AndroidHudModel.Element();
        info.type = AndroidHudModel.TYPE_INFO;
        info.sourceId = "environment.weather";
        info.frame.x = 500f;
        info.frame.y = 300f;
        info.frame.width = 600f;
        info.frame.height = 200f;

        AndroidHudGeometry.clampFrame(info,
            450f, 180f, SCALE_X, SCALE_Y, 0);

        assertEquals(450f, info.frame.width, 0f);
        assertEquals(180f, info.frame.height, 0f);
        assertTrue(info.frame.x < .5f);
        assertTrue(info.frame.y < .5f);
    }

    @Test
    public void groupContentScopeExcludesExplicitPhysicalPadding() {
        AndroidHudModel.Element group = new AndroidHudModel.Element();
        group.type = AndroidHudModel.TYPE_GROUP;
        group.frame.width = 500f;
        group.frame.height = 300f;
        group.style.contentPaddingLeftDp = 10f;
        group.style.contentPaddingRightDp = 20f;
        group.style.contentPaddingTopDp = 5f;
        group.style.contentPaddingBottomDp = 15f;
        float density = 2f;

        assertEquals(500f - 60f / SCALE_X,
            AndroidHudGeometry.contentWidthCanvasUnits(group, SCALE_X, density), .01f);
        assertEquals(300f - 40f / SCALE_Y,
            AndroidHudGeometry.contentHeightCanvasUnits(group, SCALE_Y, density), .01f);
    }

    private static AndroidHudModel.Element squareMap(float side) {
        AndroidHudModel.Element result = new AndroidHudModel.Element();
        result.type = AndroidHudModel.TYPE_INFO;
        result.sourceId = "map.pixel";
        result.frame.width = side;
        result.frame.height = side;
        return result;
    }
}
