package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudWidgetLayoutTest {
    private static AndroidHudModel.InfoSource source() {
        AndroidHudModel.InfoSource result = new AndroidHudModel.InfoSource();
        result.id = "widget.ll_place_layout";
        result.configurableWidgetLayout = true;
        result.defaultWidgetColumns = 42;
        return result;
    }

    @Test
    public void originalColumnsDoNotDependOnElementFrame() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.frame.width = 120;
        assertEquals(42, AndroidHudWidgetLayout.columns(source(), element));

        element.frame.width = 1800;
        assertEquals(42, AndroidHudWidgetLayout.columns(source(), element));
        assertEquals(-1, AndroidHudWidgetLayout.labelColumns(source(), element));
    }

    @Test
    public void explicitColumnsAndLabelColumnsAreResolvedTogether() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_COLUMNS, "36");
        element.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_LABEL_COLUMNS, "8");

        assertEquals(36, AndroidHudWidgetLayout.columns(source(), element));
        assertEquals(8, AndroidHudWidgetLayout.labelColumns(source(), element));
        assertEquals("widget.ll_place_layout\t36\t8",
            AndroidHudWidgetLayout.subscription(source(), element));
    }

    @Test
    public void invalidSettingsFallBackWithoutPoisoningOtherValues() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_COLUMNS, "not-a-number");
        element.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_LABEL_COLUMNS, "42");

        assertEquals(42, AndroidHudWidgetLayout.columns(source(), element));
        assertEquals(-1, AndroidHudWidgetLayout.labelColumns(source(), element));
    }

    @Test
    public void invalidSourceDefaultIsClampedByTheSharedResolver() {
        AndroidHudModel.InfoSource source = source();
        AndroidHudModel.Element element = new AndroidHudModel.Element();

        source.defaultWidgetColumns = 0;
        assertEquals(AndroidHudWidgetLayout.MIN_COLUMNS,
            AndroidHudWidgetLayout.defaultColumns(source));
        assertEquals(AndroidHudWidgetLayout.MIN_COLUMNS,
            AndroidHudWidgetLayout.columns(source, element));

        source.defaultWidgetColumns = 200;
        assertEquals(AndroidHudWidgetLayout.MAX_COLUMNS,
            AndroidHudWidgetLayout.defaultColumns(source));
        assertEquals(AndroidHudWidgetLayout.MAX_COLUMNS,
            AndroidHudWidgetLayout.columns(source, element));
    }

    @Test
    public void explicitZeroDisablesSharedLabelPadding() {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_LABEL_COLUMNS, "0");

        assertTrue(AndroidHudWidgetLayout.hasCustomLabelColumns(element));
        assertFalse(AndroidHudWidgetLayout.hasCustomColumns(element));
        assertEquals(0, AndroidHudWidgetLayout.labelColumns(source(), element));
    }
}
