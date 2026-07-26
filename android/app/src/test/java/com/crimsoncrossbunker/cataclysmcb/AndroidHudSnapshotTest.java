package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudSnapshotTest {
    @Test
    public void terminalLayoutVariantsKeepIndependentCellPositions() throws Exception {
        String raw = "{\"schema\":4,\"ready\":true,\"revision\":1," +
            "\"infoSources\":[{\"id\":\"sidebar.test\",\"title\":\"Test\"," +
            "\"renderer\":\"terminal_widget\",\"terminalConfigurable\":true," +
            "\"defaultColumns\":42,\"catalogTier\":\"recommended\"," +
            "\"composite\":true}]," +
            "\"values\":[" +
            value("sidebar.test", 42, 4, "声音", 0, "0", 6) + "," +
            value("sidebar.test", 42, 8, "声音", 0, "0", 10) + "]}";

        AndroidHudSnapshot snapshot = AndroidHudSnapshot.parse(raw);
        AndroidHudSnapshot.TerminalText four =
            snapshot.terminalValue("sidebar.test", 42, 4, false);
        AndroidHudSnapshot.TerminalText eight =
            snapshot.terminalValue("sidebar.test", 42, 8, false);

        assertTrue(snapshot.sources.get("sidebar.test").terminalConfigurable);
        assertTrue(snapshot.sources.get("sidebar.test").composite);
        assertEquals(42, snapshot.sources.get("sidebar.test").defaultColumns);
        assertEquals(6, four.rows.get(0).cells.get(1).column);
        assertEquals(10, eight.rows.get(0).cells.get(1).column);
    }

    @Test
    public void missingColumnsTemporarilyFallBackToAnotherVariant() throws Exception {
        String raw = "{\"schema\":4,\"ready\":true,\"revision\":1," +
            "\"values\":[" + value(
                "sidebar.test", 12, -1, "缓存", 0, "值", 6) + "]}";

        AndroidHudSnapshot snapshot = AndroidHudSnapshot.parse(raw);
        AndroidHudSnapshot.TerminalText terminal =
            snapshot.terminalValue("sidebar.test", 13, -1, false);

        assertEquals("缓存", terminal.rows.get(0).cells.get(0).text);
        assertEquals("值", terminal.rows.get(0).cells.get(1).text);
        assertEquals(6, terminal.rows.get(0).cells.get(1).column);
    }

    @Test
    public void emptyRowsPreserveFollowingRowsAndColumns() throws Exception {
        String raw = "{\"schema\":4,\"ready\":true,\"revision\":1," +
            "\"values\":[{\"sourceId\":\"sidebar.test\",\"layoutColumns\":42," +
            "\"terminal\":{\"columns\":42,\"rows\":[" +
            "{\"cells\":[{\"column\":0,\"span\":4,\"text\":\"地点\"}," +
            "{\"column\":10,\"span\":2,\"text\":\"旷野\"}]}," +
            "{\"cells\":[]}," +
            "{\"cells\":[{\"column\":0,\"span\":4,\"text\":\"日期\"}," +
            "{\"column\":10,\"span\":3,\"text\":\"5月20\"}]}]}}]}";

        AndroidHudSnapshot.TerminalText terminal =
            AndroidHudSnapshot.parse(raw).terminalValue(
                "sidebar.test", 42, -1, false);

        assertEquals(3, terminal.rows.size());
        assertTrue(terminal.rows.get(1).cells.isEmpty());
        assertEquals(10, terminal.rows.get(2).cells.get(1).column);
    }

    @Test
    public void previewFallbackDoesNotInferTerminalWidthFromUtf16() throws Exception {
        AndroidHudSnapshot.TerminalText terminal =
            AndroidHudSnapshot.parse(
                "{\"schema\":4,\"ready\":true,\"revision\":1}")
                .terminalValue("sidebar.test", 42, -1, true);

        assertEquals("示例数据", terminal.rows.get(0).cells.get(0).text);
        assertEquals(42, terminal.rows.get(0).cells.get(0).span);
    }

    private static String value(String id, int columns, int labels,
            String left, int leftColumn, String right, int rightColumn) {
        String labelMember = labels < 0 ? "" : ",\"labelColumns\":" + labels;
        return "{\"sourceId\":\"" + id + "\",\"layoutColumns\":" + columns +
            labelMember + ",\"terminal\":{\"columns\":" + columns +
            ",\"rows\":[{\"cells\":[" +
            "{\"column\":" + leftColumn + ",\"span\":2,\"text\":\"" + left + "\"}," +
            "{\"column\":" + rightColumn + ",\"span\":1,\"text\":\"" + right + "\"}" +
            "]}]}}";
    }
}
