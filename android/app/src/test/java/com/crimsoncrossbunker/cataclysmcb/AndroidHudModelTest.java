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
    public void widgetLayoutSettingsSurviveSchemaFourRoundTrip() throws Exception {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        layout.id = "layout.test";
        AndroidHudModel.Element info = element(
            "info.widget", AndroidHudModel.TYPE_INFO);
        info.sourceId = "widget.ll_place_layout";
        info.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_COLUMNS, "42");
        info.providerSettings.put(
            AndroidHudWidgetLayout.SETTING_LABEL_COLUMNS, "6");
        layout.elements.add(info);

        AndroidHudModel.Element restored =
            AndroidHudModel.Layout.fromJson(layout.toJson()).find("info.widget");

        assertEquals("42", restored.providerSettings.get(
            AndroidHudWidgetLayout.SETTING_COLUMNS));
        assertEquals("6", restored.providerSettings.get(
            AndroidHudWidgetLayout.SETTING_LABEL_COLUMNS));
    }

    @Test
    public void groupActionBindingsAreDetachedInDraft() {
        AndroidHudModel.Element group = element("group.test", AndroidHudModel.TYPE_GROUP);
        group.actionIds.add("INVENTORY");
        group.actionIds.add("PLAYER_INFO");
        group.authorizedDangerousActions.add("PLAYER_INFO");

        AndroidHudModel.Element draft = group.copy();
        draft.actionIds.remove("INVENTORY");
        draft.authorizedDangerousActions.clear();

        assertTrue(AndroidHudModel.supportsActionBinding(group));
        assertTrue(AndroidHudModel.shouldEncodeActionBinding(group));
        assertEquals(2, group.actionIds.size());
        assertTrue(group.authorizedDangerousActions.contains("PLAYER_INFO"));
        assertEquals(1, draft.actionIds.size());
        assertFalse(draft.authorizedDangerousActions.contains("PLAYER_INFO"));
    }

    @Test
    public void groupWithoutActionsKeepsJsonCompact() {
        AndroidHudModel.Element group = element("group.test", AndroidHudModel.TYPE_GROUP);

        assertFalse(AndroidHudModel.shouldEncodeActionBinding(group));
        group.actionIds.add("INVENTORY");
        assertTrue(AndroidHudModel.shouldEncodeActionBinding(group));
    }

    @Test
    public void newElementsUseTransparentCompactTypographyByDefault() {
        AndroidHudModel.Element info = element("info.test", AndroidHudModel.TYPE_INFO);

        assertEquals(10f, info.style.fontSizeSp, 0f);
        assertFalse(info.style.background);
        assertFalse(info.style.border);
        assertEquals(AndroidHudModel.TEXT_EFFECT_NONE, info.style.textEffect);
        assertTrue(info.style.sourceColors);
        assertEquals(0f, info.style.contentPaddingLeftDp, 0f);
        assertEquals(0f, info.style.contentPaddingTopDp, 0f);
        assertEquals(0f, info.style.contentPaddingRightDp, 0f);
        assertEquals(0f, info.style.contentPaddingBottomDp, 0f);
        assertEquals(AndroidHudModel.OVERFLOW_FIXED, info.overflowMode);
    }

    @Test
    public void styleAndScrollableOverflowAreDetachedInDraft() {
        AndroidHudModel.Element info = element("info.test", AndroidHudModel.TYPE_INFO);
        info.sourceId = "log.messages";
        info.overflowMode = AndroidHudModel.OVERFLOW_SCROLL;
        info.style.textBold = true;
        info.style.textItalic = true;
        info.style.textEffect = AndroidHudModel.TEXT_EFFECT_OUTLINE;
        info.style.sourceColors = false;
        info.style.textOutlineColor = 0xFF123456;
        info.style.textOutlineWidthSp = 3f;
        info.style.contentPaddingLeftDp = 2f;
        info.style.contentPaddingTopDp = 4f;
        info.style.contentPaddingRightDp = 6f;
        info.style.contentPaddingBottomDp = 8f;

        AndroidHudModel.Element restored = info.copy();
        restored.style.textOutlineColor = 0xFF654321;

        assertEquals(AndroidHudModel.OVERFLOW_SCROLL, restored.overflowMode);
        assertTrue(restored.style.textBold);
        assertTrue(restored.style.textItalic);
        assertEquals(AndroidHudModel.TEXT_EFFECT_OUTLINE, restored.style.textEffect);
        assertFalse(restored.style.sourceColors);
        assertEquals(0xFF123456, info.style.textOutlineColor);
        assertEquals(0xFF654321, restored.style.textOutlineColor);
        assertEquals(3f, restored.style.textOutlineWidthSp, 0f);
        assertEquals(2f, restored.style.contentPaddingLeftDp, 0f);
        assertEquals(4f, restored.style.contentPaddingTopDp, 0f);
        assertEquals(6f, restored.style.contentPaddingRightDp, 0f);
        assertEquals(8f, restored.style.contentPaddingBottomDp, 0f);
    }

    @Test
    public void contentPaddingUsesCompactJsonAndSurvivesRoundTrip() throws Exception {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        layout.id = "layout.test";
        AndroidHudModel.Element uniform = element(
            "info.uniform", AndroidHudModel.TYPE_INFO);
        uniform.sourceId = "environment.weather";
        uniform.style.contentPaddingLeftDp = 5f;
        uniform.style.contentPaddingTopDp = 5f;
        uniform.style.contentPaddingRightDp = 5f;
        uniform.style.contentPaddingBottomDp = 5f;
        AndroidHudModel.Element asymmetric = element(
            "info.asymmetric", AndroidHudModel.TYPE_INFO);
        asymmetric.sourceId = "environment.time";
        asymmetric.style.contentPaddingLeftDp = 1f;
        asymmetric.style.contentPaddingTopDp = 2f;
        asymmetric.style.contentPaddingRightDp = 3f;
        asymmetric.style.contentPaddingBottomDp = 4f;
        layout.elements.add(uniform);
        layout.elements.add(asymmetric);

        org.json.JSONObject encoded = layout.toJson();
        org.json.JSONArray elements = encoded.getJSONArray("elements");
        assertTrue(elements.getJSONObject(0).getJSONObject("style").has("paddingDp"));
        assertFalse(elements.getJSONObject(0).getJSONObject("style")
            .has("contentPadding"));
        assertTrue(elements.getJSONObject(1).getJSONObject("style")
            .has("contentPadding"));

        AndroidHudModel.Layout restored = AndroidHudModel.Layout.fromJson(encoded);
        assertEquals(5f,
            restored.find("info.uniform").style.contentPaddingBottomDp, 0f);
        assertEquals(1f,
            restored.find("info.asymmetric").style.contentPaddingLeftDp, 0f);
        assertEquals(4f,
            restored.find("info.asymmetric").style.contentPaddingBottomDp, 0f);
    }

    @Test
    public void legacyControlPaddingMigratesIntoSharedStyle() throws Exception {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        layout.id = "layout.test";
        AndroidHudModel.Element control = element(
            "control.test", AndroidHudModel.TYPE_CONTROL);
        layout.elements.add(control);
        org.json.JSONObject encoded = layout.toJson();
        org.json.JSONObject encodedControl =
            encoded.getJSONArray("elements").getJSONObject(0);
        encodedControl.getJSONObject("controlAppearance")
            .put("horizontalPaddingDp", 11f)
            .put("verticalPaddingDp", 3f);

        AndroidHudModel.Element restored =
            AndroidHudModel.Layout.fromJson(encoded).find("control.test");

        assertEquals(11f, restored.style.contentPaddingLeftDp, 0f);
        assertEquals(3f, restored.style.contentPaddingTopDp, 0f);
        assertEquals(11f, restored.style.contentPaddingRightDp, 0f);
        assertEquals(3f, restored.style.contentPaddingBottomDp, 0f);
        assertFalse(restored.controlAppearance.toJson()
            .has("horizontalPaddingDp"));
        assertFalse(restored.controlAppearance.toJson()
            .has("verticalPaddingDp"));
    }

    @Test
    public void controlAppearanceIsDetachedAndDefaultsToVisibleWithoutShadow() {
        AndroidHudModel.Element control = element(
            "control.test", AndroidHudModel.TYPE_CONTROL);

        AndroidHudModel.Element copy = control.copy();
        copy.controlAppearance.surfaceColor = 0xFF123456;
        copy.controlAppearance.shadow = true;

        assertTrue(control.controlAppearance.surface);
        assertFalse(control.controlAppearance.shadow);
        assertEquals(0xCC263746, control.controlAppearance.surfaceColor);
        assertEquals(0xFF123456, copy.controlAppearance.surfaceColor);
        assertTrue(copy.controlAppearance.shadow);
    }

    @Test
    public void controlAppearanceSupportsZeroStrengthAndIndependentShadows() {
        AndroidHudModel.Element control = element(
            "control.test", AndroidHudModel.TYPE_CONTROL);
        control.style.opacity = 0f;
        control.style.textEffect = AndroidHudModel.TEXT_EFFECT_SHADOW;
        control.style.textShadowRadiusSp = 0f;
        control.style.textShadowOffsetXSp = -4f;
        control.controlAppearance.surfaceColor = 0x80123456;
        control.controlAppearance.border = true;
        control.controlAppearance.borderWidthDp = 0f;
        control.controlAppearance.shadow = true;
        control.controlAppearance.shadowColor = 0x40112233;
        control.controlAppearance.shadowRadiusDp = 0f;
        control.controlAppearance.shadowOffsetXDp = -7f;

        AndroidHudModel.Element restored = control.copy();

        assertEquals(0f, restored.style.opacity, 0f);
        assertEquals(AndroidHudModel.TEXT_EFFECT_SHADOW,
            restored.style.textEffect);
        assertEquals(0f, restored.style.textShadowRadiusSp, 0f);
        assertEquals(-4f, restored.style.textShadowOffsetXSp, 0f);
        assertEquals(0x80123456, restored.controlAppearance.surfaceColor);
        assertTrue(restored.controlAppearance.border);
        assertEquals(0f, restored.controlAppearance.borderWidthDp, 0f);
        assertTrue(restored.controlAppearance.shadow);
        assertEquals(0x40112233, restored.controlAppearance.shadowColor);
        assertEquals(0f, restored.controlAppearance.shadowRadiusDp, 0f);
        assertEquals(-7f, restored.controlAppearance.shadowOffsetXDp, 0f);
    }

    @Test
    public void controlAppearanceSurvivesLayoutJsonRoundTrip() throws Exception {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        layout.id = "layout.test";
        layout.name = "Test";
        AndroidHudModel.Element control = element(
            "control.test", AndroidHudModel.TYPE_CONTROL);
        control.actionIds.add("ACTION_TEST");
        control.defaultActionId = "ACTION_TEST";
        control.selectedActionId = "ACTION_TEST";
        control.controlAppearance.surface = true;
        control.controlAppearance.surfaceColor = 0xCC263746;
        control.controlAppearance.pressedOverlayColor = 0x55778899;
        control.controlAppearance.border = true;
        control.controlAppearance.borderColor = 0xFF112233;
        control.controlAppearance.borderWidthDp = 3f;
        layout.elements.add(control);

        AndroidHudModel.Layout restored =
            AndroidHudModel.Layout.fromJson(layout.toJson());
        AndroidHudModel.Element restoredControl = restored.find("control.test");

        assertTrue(restoredControl.controlAppearance.surface);
        assertEquals(0xCC263746, restoredControl.controlAppearance.surfaceColor);
        assertEquals(0x55778899,
            restoredControl.controlAppearance.pressedOverlayColor);
        assertTrue(restoredControl.controlAppearance.border);
        assertEquals(0xFF112233, restoredControl.controlAppearance.borderColor);
        assertEquals(3f, restoredControl.controlAppearance.borderWidthDp, 0f);
    }

    @Test
    public void legacyControlPreservesPlatformButtonSurfaceWithoutGhostShadow() {
        AndroidHudModel.Element control = element(
            "control.test", AndroidHudModel.TYPE_CONTROL);
        control.style.background = false;
        control.style.backgroundColor = 0xAA102030;
        control.style.border = true;
        control.style.borderColor = 0xFF405060;

        AndroidHudModel.ControlAppearance restored =
            AndroidHudModel.ControlAppearance.fromLegacy(control.style);

        assertTrue(restored.surface);
        assertEquals(0xCC263746, restored.surfaceColor);
        assertTrue(restored.border);
        assertEquals(0xFF405060, restored.borderColor);
        assertFalse(restored.shadow);
    }

    @Test
    public void legacyControlUsesExplicitHostColorWhenItHadOne() {
        AndroidHudModel.Element control = element(
            "control.test", AndroidHudModel.TYPE_CONTROL);
        control.style.background = true;
        control.style.backgroundColor = 0xAA102030;

        AndroidHudModel.ControlAppearance restored =
            AndroidHudModel.ControlAppearance.fromLegacy(control.style);

        assertTrue(restored.surface);
        assertEquals(0xAA102030, restored.surfaceColor);
    }

    @Test
    public void textEffectsCanBeCompletelyDisabledWithZeroStrength() {
        AndroidHudModel.Element info = element(
            "info.test", AndroidHudModel.TYPE_INFO);
        info.style.textEffect = AndroidHudModel.TEXT_EFFECT_OUTLINE;
        info.style.textOutlineWidthSp = 0f;
        info.style.textShadowRadiusSp = 0f;

        AndroidHudModel.Element restored = info.copy();

        assertEquals(AndroidHudModel.TEXT_EFFECT_OUTLINE,
            restored.style.textEffect);
        assertEquals(0f, restored.style.textOutlineWidthSp, 0f);
        assertEquals(0f, restored.style.textShadowRadiusSp, 0f);
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
