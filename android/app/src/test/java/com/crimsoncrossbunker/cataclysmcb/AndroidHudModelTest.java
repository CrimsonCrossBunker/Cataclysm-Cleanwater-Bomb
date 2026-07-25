package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotSame;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class AndroidHudModelTest {
    @Test
    public void groupResizeDoesNotScaleChildren() {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        layout.id = "layout.test";
        AndroidHudModel.Element group = element("group.test", AndroidHudModel.TYPE_GROUP);
        group.frame.x = 100;
        group.frame.y = 120;
        group.frame.width = 600;
        group.frame.height = 400;
        AndroidHudModel.Element child = element("info.test", AndroidHudModel.TYPE_INFO);
        child.sourceId = "environment.time";
        child.frame.x = 80;
        child.frame.y = 90;
        child.frame.width = 220;
        child.frame.height = 70;
        group.children.add(child);
        layout.elements.add(group);

        AndroidHudModel.Layout draft = layout.copy();
        draft.find("group.test").frame.width = 300;

        AndroidHudModel.Element copiedChild = draft.find("info.test");
        assertEquals(80f, copiedChild.frame.x, 0f);
        assertEquals(220f, copiedChild.frame.width, 0f);
        assertNotSame(child, copiedChild);
    }

    @Test
    public void removingAGroupRemovesItsWholeSubtree() {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        AndroidHudModel.Element group = element("group.test", AndroidHudModel.TYPE_GROUP);
        AndroidHudModel.Element nested = element("group.nested", AndroidHudModel.TYPE_GROUP);
        AndroidHudModel.Element control = element("control.test", AndroidHudModel.TYPE_CONTROL);
        control.actionIds.add("pickup");
        nested.children.add(control);
        group.children.add(nested);
        layout.elements.add(group);

        assertEquals(3, layout.elementCount());
        assertTrue(layout.remove("group.test"));
        assertEquals(0, layout.elementCount());
        assertNull(layout.find("control.test"));
    }

    @Test
    public void controlDangerousAuthorizationIsDetachedInDraft() {
        AndroidHudModel.Element control = element("control.test", AndroidHudModel.TYPE_CONTROL);
        control.actionIds.add("DELETE_WORLD");
        control.defaultActionId = "DELETE_WORLD";
        control.selectedActionId = "DELETE_WORLD";
        control.selectorMode = AndroidHudModel.SELECTOR_MODE_CYCLE;
        control.authorizedDangerousActions.add("DELETE_WORLD");

        AndroidHudModel.Element copy = control.copy();
        copy.authorizedDangerousActions.clear();

        assertEquals(AndroidHudModel.SELECTOR_MODE_CYCLE, copy.selectorMode);
        assertTrue(control.authorizedDangerousActions.contains("DELETE_WORLD"));
        assertFalse(copy.authorizedDangerousActions.contains("DELETE_WORLD"));
    }

    @Test
    public void multiActionControlsDefaultToMenuSelection() {
        AndroidHudModel.Element control = element("control.test", AndroidHudModel.TYPE_CONTROL);

        assertEquals(AndroidHudModel.SELECTOR_MODE_MENU, control.selectorMode);
        assertEquals(AndroidHudModel.SELECTOR_MODE_MENU, control.copy().selectorMode);
    }

    @Test
    public void informationActionBindingsAreDetachedInDraft() {
        AndroidHudModel.Element info = element("info.test", AndroidHudModel.TYPE_INFO);
        info.sourceId = "character.summary";
        info.actionIds.add("INVENTORY");
        info.actionIds.add("PLAYER_INFO");
        info.actionIds.add("ITEMACTION");
        info.authorizedDangerousActions.add("ITEMACTION");

        AndroidHudModel.Element draft = info.copy();
        draft.actionIds.remove("PLAYER_INFO");
        draft.authorizedDangerousActions.clear();

        assertEquals(3, info.actionIds.size());
        assertEquals(2, draft.actionIds.size());
        assertTrue(info.authorizedDangerousActions.contains("ITEMACTION"));
        assertFalse(draft.authorizedDangerousActions.contains("ITEMACTION"));
        assertTrue(AndroidHudModel.supportsActionBinding(info));
        assertTrue(AndroidHudModel.shouldEncodeActionBinding(info));
    }

    @Test
    public void informationWithoutActionsKeepsJsonCompact() {
        AndroidHudModel.Element info = element("info.test", AndroidHudModel.TYPE_INFO);
        info.sourceId = "environment.summary";

        assertFalse(AndroidHudModel.shouldEncodeActionBinding(info));
        info.actionIds.add("INVENTORY");
        assertTrue(AndroidHudModel.shouldEncodeActionBinding(info));
    }

    @Test
    public void newElementsUseTransparentCompactTypographyByDefault() {
        AndroidHudModel.Element info = element("info.test", AndroidHudModel.TYPE_INFO);

        assertEquals(10f, info.style.fontSizeSp, 0f);
        assertFalse(info.style.background);
        assertFalse(info.style.border);
        assertFalse(info.style.textOutline);
        assertEquals(AndroidHudModel.OVERFLOW_FIXED, info.overflowMode);
    }

    @Test
    public void styleAndScrollableOverflowAreDetachedInDraft() {
        AndroidHudModel.Element info = element("info.test", AndroidHudModel.TYPE_INFO);
        info.sourceId = "log.messages";
        info.overflowMode = AndroidHudModel.OVERFLOW_SCROLL;
        info.style.textBold = true;
        info.style.textItalic = true;
        info.style.textOutline = true;
        info.style.textOutlineColor = 0xFF123456;
        info.style.textOutlineWidthSp = 3f;

        AndroidHudModel.Element restored = info.copy();
        restored.style.textOutlineColor = 0xFF654321;

        assertEquals(AndroidHudModel.OVERFLOW_SCROLL, restored.overflowMode);
        assertTrue(restored.style.textBold);
        assertTrue(restored.style.textItalic);
        assertTrue(restored.style.textOutline);
        assertEquals(0xFF123456, info.style.textOutlineColor);
        assertEquals(0xFF654321, restored.style.textOutlineColor);
        assertEquals(3f, restored.style.textOutlineWidthSp, 0f);
    }

    @Test
    public void gridInformationIsNormalizedToFixedSquareFrame() {
        AndroidHudModel.Element map = element("map.test", AndroidHudModel.TYPE_INFO);
        map.sourceId = "map.pixel";
        map.frame.width = 420f;
        map.frame.height = 180f;
        map.overflowMode = AndroidHudModel.OVERFLOW_SCROLL;

        AndroidHudModel.normalizeElementGeometry(map);

        assertEquals(420f, map.frame.width, 0f);
        assertEquals(420f, map.frame.height, 0f);
        assertEquals(AndroidHudModel.OVERFLOW_FIXED, map.overflowMode);
    }

    @Test
    public void searchMatchesChineseCatalogText() {
        assertTrue(AndroidHudModel.matchesSearch("天气",
            "环境信息", "位置 日期 天气", "environment.summary"));
        assertFalse(AndroidHudModel.matchesSearch("雷达",
            "环境信息", "位置 日期 天气", "environment.summary"));
    }

    @Test
    public void searchIgnoresLatinCase() {
        assertTrue(AndroidHudModel.matchesSearch("PICKUP",
            "拾取", "pickup", "context"));
    }

    @Test
    public void everySearchKeywordMustMatchAcrossFields() {
        assertTrue(AndroidHudModel.matchesSearch("wear inventory",
            "穿上", "WEAR", "inventory"));
        assertFalse(AndroidHudModel.matchesSearch("wear combat",
            "穿上", "WEAR", "inventory"));
        assertTrue(AndroidHudModel.matchesSearch("   ", "任意内容"));
    }

    private static AndroidHudModel.Element element(String id, String type) {
        AndroidHudModel.Element result = new AndroidHudModel.Element();
        result.id = id;
        result.type = type;
        return result;
    }
}
