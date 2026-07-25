package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class AndroidHudColumnTextTest {
    @Test
    public void cjkLabelsUseTheSameColumnsAsCcbWidgets() {
        assertEquals(6, AndroidHudColumnText.cellColumns("所有者"));
        assertEquals(4, AndroidHudColumnText.cellColumns("地点"));
        assertEquals(4, AndroidHudColumnText.cellColumns("积雪"));
        assertEquals(1, AndroidHudColumnText.cellColumns(':'));
    }

    @Test
    public void paddedLocationLabelsShareOneValueColumn() {
        assertEquals(12,
            AndroidHudColumnText.cellColumns("所有者:     "));
        assertEquals(12,
            AndroidHudColumnText.cellColumns("地点:       "));
        assertEquals(12,
            AndroidHudColumnText.cellColumns("光照:       "));
    }

    @Test
    public void movementRowsShareLabelAndValueSlots() {
        // CCB widgets may inherit different separator text.  The shared
        // separator slot adds one padding cell to the shorter form so both
        // values still begin in column six.
        assertEquals(6, AndroidHudColumnText.cellColumns("声音  "));
        assertEquals(6, AndroidHudColumnText.cellColumns("耐力: "));
        assertEquals(6, AndroidHudColumnText.cellColumns("心情: "));
        assertEquals(6, AndroidHudColumnText.cellColumns("速度: "));
        assertEquals(6, AndroidHudColumnText.cellColumns("专注: "));
        assertEquals(6, AndroidHudColumnText.cellColumns("移动: "));
    }

    @Test
    public void fullwidthAndCombiningCharactersMatchTerminalWidths() {
        assertEquals(2, AndroidHudColumnText.cellColumns('界'));
        assertEquals(2, AndroidHudColumnText.cellColumns('：'));
        assertEquals(1, AndroidHudColumnText.cellColumns('A'));
        assertEquals(0, AndroidHudColumnText.cellColumns(0x0301));
    }
}
