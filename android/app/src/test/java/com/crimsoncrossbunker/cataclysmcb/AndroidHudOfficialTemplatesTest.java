package com.crimsoncrossbunker.cataclysmcb;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

import java.util.HashSet;
import java.util.Set;

public class AndroidHudOfficialTemplatesTest {
    @Test
    public void topSidebarUsesOriginalWidgetsWithoutExcludedVariants() {
        AndroidHudOfficialTemplates.Seed seed =
            AndroidHudOfficialTemplates.forScene("gameplay.map");
        assertNotNull(seed);
        assertEquals(AndroidHudOfficialTemplates.TOP_SIDEBAR_LAYOUT_ID, seed.layout.id);

        Set<String> sources = new HashSet<>();
        collectSources(seed.layout.elements, sources);
        assertEquals(15, sources.size());
        assertTrue(sources.contains(group("ll_limbs_layout")));
        assertTrue(sources.contains(group("ll_movement_layout")));
        assertTrue(sources.contains(group("ll_stats_layout")));
        assertTrue(sources.contains(group("all_weariness_layout")));
        assertTrue(sources.contains(group("ll_needs_layout")));
        assertTrue(sources.contains(group("ll_place_layout")));
        assertTrue(sources.contains(group("wind_temp_layout")));
        assertTrue(sources.contains(group("oxygen_layout")));
        assertTrue(sources.contains(group("weapon_style_layout")));
        assertTrue(sources.contains(group("vehicle_acf_label_layout")));
        assertTrue(sources.contains(group("compass_all_danger_layout")));
        assertTrue(sources.contains(group("ll_weight_carried_value")));
        assertTrue(sources.contains(group("rad_badge_desc")));
        assertTrue(sources.contains("log.messages"));
        assertTrue(sources.contains("map.pixel"));
        assertFalse(sources.contains("widget.ll_limbs_sa_layout"));
        assertFalse(sources.contains("widget.ll_needs_sa_layout"));
        assertFalse(sources.contains("widget.sundial_label_layout"));

        int groupCount = 0;
        for (AndroidHudModel.Element element : seed.layout.elements) {
            if (AndroidHudModel.TYPE_GROUP.equals(element.type)) {
                groupCount++;
            }
        }
        assertEquals(0, groupCount);
        assertEquals(15, seed.layout.elements.size());
    }

    @Test
    public void firstTwoColumnsMatchRequestedPanelPairs() {
        AndroidHudModel.Layout layout =
            AndroidHudOfficialTemplates.forScene("gameplay.map").layout;
        AndroidHudModel.Element limbs =
            layout.find("official.sidebar.info." + group("ll_limbs_layout"));
        AndroidHudModel.Element movement =
            layout.find("official.sidebar.info." + group("ll_movement_layout"));
        AndroidHudModel.Element stats =
            layout.find("official.sidebar.info." + group("ll_stats_layout"));
        AndroidHudModel.Element weariness =
            layout.find("official.sidebar.info." +
                group("all_weariness_layout"));

        assertEquals(limbs.frame.x, movement.frame.x, 0f);
        assertTrue(limbs.frame.y < movement.frame.y);
        assertEquals(stats.frame.x, weariness.frame.x, 0f);
        assertTrue(stats.frame.y < weariness.frame.y);
        assertTrue(stats.frame.x > limbs.frame.x);
    }

    @Test
    public void pixelMapIsAStandaloneSquareInformationElement() {
        AndroidHudModel.Layout layout =
            AndroidHudOfficialTemplates.forScene("gameplay.map").layout;
        AndroidHudModel.Element map =
            layout.find("official.sidebar.info.map.pixel");

        assertNotNull(map);
        assertEquals(AndroidHudModel.TYPE_INFO, map.type);
        assertEquals("map.pixel", map.sourceId);
        assertEquals(map.frame.width, map.frame.height, 0f);
        assertNull(layout.findParent(map.id));
    }

    @Test
    public void templatesAreOnlyOfferedForTheirScene() {
        assertNull(AndroidHudOfficialTemplates.forScene("inventory.main"));
    }

    private static void collectSources(Iterable<AndroidHudModel.Element> elements,
            Set<String> target) {
        for (AndroidHudModel.Element element : elements) {
            if (AndroidHudModel.TYPE_INFO.equals(element.type)) {
                target.add(element.sourceId);
            }
            collectSources(element.children, target);
        }
    }

    private static String group(String widgetId) {
        return "sidebar.legacy_labels_sidebar.group." + widgetId + ".0";
    }
}
