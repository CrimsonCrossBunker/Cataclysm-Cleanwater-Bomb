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

    private static AndroidHudModel.Element element(String id, String type) {
        AndroidHudModel.Element result = new AndroidHudModel.Element();
        result.id = id;
        result.type = type;
        return result;
    }
}
