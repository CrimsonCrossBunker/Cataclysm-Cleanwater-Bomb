package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudInfoFormatTest {
    private static AndroidHudModel.InfoSource source() {
        AndroidHudModel.InfoSource result = new AndroidHudModel.InfoSource();
        result.id =
            "sidebar.legacy_labels_sidebar.group.ll_place_layout.0";
        result.renderer = "terminal_widget";
        result.terminalConfigurable = true;
        result.defaultColumns = 42;
        return result;
    }

    @Test
    public void originalColumnsIgnoreFrameAndRetainedCustomValues() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.frame.width = 120;
        element.infoPresentation.columns = 36;
        assertEquals(42, AndroidHudInfoFormat.columns(source(), element));

        element.frame.width = 1800;
        assertEquals(42, AndroidHudInfoFormat.columns(source(), element));
        assertEquals(AndroidHudModel.INFO_LAYOUT_ORIGINAL,
            AndroidHudInfoFormat.layoutMode(source(), element));
    }

    @Test
    public void customColumnsAndSparseRootLabelAreRequestedTogether()
            throws Exception {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.infoPresentation.layoutMode =
            AndroidHudModel.INFO_LAYOUT_CUSTOM;
        element.infoPresentation.columns = 36;
        AndroidHudModel.NodeOverride node = new AndroidHudModel.NodeOverride();
        node.path = "ll_place_layout@0";
        node.labelColumns = 8;
        element.infoPresentation.nodeOverrides.add(node);

        assertEquals(36, AndroidHudInfoFormat.columns(source(), element));
        assertEquals(8, AndroidHudInfoFormat.labelColumns(source(), element));
        AndroidHudInfoFormat.Request request =
            AndroidHudInfoFormat.request(source(), element);
        assertNotNull(request);
        assertEquals(64, request.key.length());
        assertEquals("custom", request.json.getString("layoutMode"));
        assertEquals(36, request.json.getInt("columns"));
        assertEquals("ll_place_layout@0",
            request.json.getJSONArray("nodeOverrides")
                .getJSONObject(0).getString("path"));
    }

    @Test
    public void requestHashIsCanonicalAndChangesWithConfiguration()
            throws Exception {
        AndroidHudModel.Element first = new AndroidHudModel.Element();
        first.infoPresentation.layoutMode =
            AndroidHudModel.INFO_LAYOUT_CUSTOM;
        AndroidHudModel.NodeOverride a = override("root@0/a@0", 9);
        AndroidHudModel.NodeOverride b = override("root@0/b@0", 12);
        first.infoPresentation.nodeOverrides.add(b);
        first.infoPresentation.nodeOverrides.add(a);

        AndroidHudModel.Element second = first.copy();
        second.infoPresentation.nodeOverrides.clear();
        second.infoPresentation.nodeOverrides.add(a.copy());
        second.infoPresentation.nodeOverrides.add(b.copy());
        String firstKey =
            AndroidHudInfoFormat.requestKey(source(), first);
        assertEquals(firstKey,
            AndroidHudInfoFormat.requestKey(source(), second));

        second.infoPresentation.nodeOverrides.get(0).widthColumns = 10;
        assertNotEquals(firstKey,
            AndroidHudInfoFormat.requestKey(source(), second));
    }

    @Test
    public void looseModeRetainsOverridesButDoesNotSendThem() throws Exception {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.infoPresentation.layoutMode =
            AndroidHudModel.INFO_LAYOUT_LOOSE;
        element.infoPresentation.nodeOverrides.add(
            override("ll_place_layout@0", 20));

        AndroidHudInfoFormat.Request request =
            AndroidHudInfoFormat.request(source(), element);
        assertEquals("loose", request.json.getString("layoutMode"));
        assertEquals(0,
            request.json.getJSONArray("nodeOverrides").length());
        assertEquals(1, element.infoPresentation.nodeOverrides.size());
    }

    @Test
    public void invalidSourceDefaultIsClampedBySharedResolver() {
        AndroidHudModel.InfoSource source = source();
        AndroidHudModel.Element element = new AndroidHudModel.Element();

        source.defaultColumns = 0;
        assertEquals(AndroidHudInfoFormat.MIN_COLUMNS,
            AndroidHudInfoFormat.defaultColumns(source));
        source.defaultColumns = 200;
        assertEquals(AndroidHudInfoFormat.MAX_COLUMNS,
            AndroidHudInfoFormat.columns(source, element));
    }

    @Test
    public void nativeAppearanceIsStrictAndExplicit() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        assertTrue(AndroidHudInfoFormat.nativeAppearance(element));

        element.infoPresentation.appearanceMode =
            AndroidHudModel.INFO_APPEARANCE_CUSTOM;
        assertFalse(AndroidHudInfoFormat.nativeAppearance(element));
    }

    @Test
    public void terminalCellUsesHalfOfAndroidWideGlyphAdvance() {
        assertEquals(10f,
            AndroidHudInfoFormat.terminalCellWidth(20f, 20f), 0.001f);
        assertEquals(9f,
            AndroidHudInfoFormat.terminalCellWidth(9f, 30f), 0.001f);
    }

    @Test
    public void terminalCellFallsBackSafelyForMissingFontMetrics() {
        assertEquals(9f,
            AndroidHudInfoFormat.terminalCellWidth(9f, 0f), 0.001f);
        assertEquals(1f,
            AndroidHudInfoFormat.terminalCellWidth(Float.NaN, Float.NaN),
            0.001f);
    }

    private static AndroidHudModel.NodeOverride override(
            String path, int width) {
        AndroidHudModel.NodeOverride result =
            new AndroidHudModel.NodeOverride();
        result.path = path;
        result.widthColumns = width;
        return result;
    }
}
