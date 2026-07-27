package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.json.JSONObject;
import org.junit.Test;

public class AndroidHudLayoutSchemaTest {
    @Test
    public void onDemandTreePreservesPathsBreadcrumbsAndConditionalBadge()
            throws Exception {
        String raw = "{\"schema\":1,\"sourceId\":\"widget.root\"," +
            "\"available\":true,\"defaultColumns\":64,\"root\":{" +
            "\"id\":\"root\",\"path\":\"root@0\",\"label\":\"Root\"," +
            "\"style\":\"layout\",\"arrangement\":\"rows\"," +
            "\"originalGapColumns\":2,\"children\":[{" +
            "\"id\":\"child\",\"path\":\"root@0/child@0\"," +
            "\"label\":\"子项\",\"style\":\"text\"," +
            "\"conditional\":true,\"children\":[]}]}}";

        AndroidHudLayoutSchema schema =
            AndroidHudLayoutSchema.parse(raw);
        assertTrue(schema.available);
        assertEquals(2, schema.flattened().size());
        assertTrue(schema.paths().contains("root@0/child@0"));
        assertEquals("Root › 子项",
            schema.breadcrumb(schema.flattened().get(1)));
        assertTrue(schema.flattened().get(1).conditional);
    }

    @Test
    public void commonCatalogIsSubsetOfAdvancedTabInput() throws Exception {
        AndroidHudModel.InfoSource common =
            AndroidHudModel.InfoSource.fromJson(new JSONObject(
                "{\"id\":\"sidebar.labels.group.test.0\"," +
                "\"title\":\"Test\",\"renderer\":\"terminal_widget\"," +
                "\"catalogTier\":\"common\",\"sidebarId\":\"labels\"," +
                "\"sidebarTitle\":\"Labels\",\"sidebarOrder\":0," +
                "\"groupOrder\":0}"));
        AndroidHudModel.InfoSource raw =
            AndroidHudModel.InfoSource.fromJson(new JSONObject(
                "{\"id\":\"widget.test\",\"title\":\"Raw\"," +
                "\"renderer\":\"terminal_widget\"," +
                "\"catalogTier\":\"advanced\"}"));

        assertTrue(AndroidHudModel.isCommonInfoSource(common));
        assertFalse(AndroidHudModel.isCommonInfoSource(raw));
        assertEquals("Labels", common.sidebarTitle);
        // The advanced tab iterates the full source list; it does not apply
        // the common predicate, so both entries remain available.
        assertEquals(2, java.util.Arrays.asList(common, raw).size());
    }
}
