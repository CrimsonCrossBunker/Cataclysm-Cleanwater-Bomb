package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudSnapshotTest {
    @Test
    public void widgetLayoutVariantsKeepIndependentValues() throws Exception {
        String raw = "{\"schema\":3,\"ready\":true,\"revision\":1," +
            "\"infoSources\":[{\"id\":\"widget.test\",\"title\":\"Test\"," +
            "\"renderer\":\"text\",\"configurableWidgetLayout\":true," +
            "\"defaultWidgetColumns\":42}]," +
            "\"values\":[" +
            "{\"sourceId\":\"widget.test\",\"layoutColumns\":42," +
            "\"labelColumns\":6,\"text\":\"six\",\"runs\":[]}," +
            "{\"sourceId\":\"widget.test\",\"layoutColumns\":42," +
            "\"labelColumns\":10,\"text\":\"ten\",\"runs\":[]}]}";

        AndroidHudSnapshot snapshot = AndroidHudSnapshot.parse(raw);

        assertTrue(snapshot.sources.get("widget.test").configurableWidgetLayout);
        assertEquals(42, snapshot.sources.get("widget.test").defaultWidgetColumns);
        assertEquals("six", snapshot.value("widget.test", 42, 6, false).text);
        assertEquals("ten", snapshot.value("widget.test", 42, 10, false).text);
    }

    @Test
    public void missingWidthTemporarilyFallsBackToAnotherVariant() throws Exception {
        String raw = "{\"schema\":3,\"ready\":true,\"revision\":1," +
            "\"values\":[{\"sourceId\":\"widget.test\",\"layoutColumns\":12," +
            "\"text\":\"cached\",\"runs\":[]}]}";

        AndroidHudSnapshot snapshot = AndroidHudSnapshot.parse(raw);

        assertEquals("cached", snapshot.value(
            "widget.test", 13, -1, false).text);
    }
}
