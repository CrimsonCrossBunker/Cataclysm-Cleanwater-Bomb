package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudInfoFormatTest {
    private static AndroidHudModel.InfoSource source() {
        AndroidHudModel.InfoSource result = new AndroidHudModel.InfoSource();
        result.id = "sidebar.legacy.place";
        result.renderer = "terminal_widget";
        result.terminalConfigurable = true;
        result.defaultColumns = 42;
        return result;
    }

    @Test
    public void originalColumnsDoNotDependOnElementFrame() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.frame.width = 120;
        assertEquals(42, AndroidHudInfoFormat.columns(source(), element));

        element.frame.width = 1800;
        assertEquals(42, AndroidHudInfoFormat.columns(source(), element));
        assertEquals(-1, AndroidHudInfoFormat.labelColumns(source(), element));
    }

    @Test
    public void typedColumnsAndLabelColumnsAreResolvedTogether() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.infoPresentation.columns = 36;
        element.infoPresentation.labelColumns = 8;

        assertEquals(36, AndroidHudInfoFormat.columns(source(), element));
        assertEquals(8, AndroidHudInfoFormat.labelColumns(source(), element));
        assertEquals("sidebar.legacy.place\t36\t8",
            AndroidHudInfoFormat.subscription(source(), element));
    }

    @Test
    public void invalidTypedValuesFallBackWithoutUsingFrameWidth() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.infoPresentation.columns = -20;
        element.infoPresentation.labelColumns = 42;
        element.frame.width = 1900;

        assertEquals(42, AndroidHudInfoFormat.columns(source(), element));
        assertEquals(-1, AndroidHudInfoFormat.labelColumns(source(), element));
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
    public void explicitZeroDisablesSharedLabelPadding() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.infoPresentation.labelColumns = 0;

        assertTrue(AndroidHudInfoFormat.hasCustomLabelColumns(element));
        assertFalse(AndroidHudInfoFormat.hasCustomColumns(element));
        assertEquals(0, AndroidHudInfoFormat.labelColumns(source(), element));
    }

    @Test
    public void nativeAppearanceIsExplicitAndIndependentFromGrid() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        assertTrue(AndroidHudInfoFormat.nativeAppearance(element));

        element.infoPresentation.appearanceMode =
            AndroidHudModel.INFO_APPEARANCE_CUSTOM;
        assertFalse(AndroidHudInfoFormat.nativeAppearance(element));
        assertEquals(42, AndroidHudInfoFormat.columns(source(), element));
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
}
