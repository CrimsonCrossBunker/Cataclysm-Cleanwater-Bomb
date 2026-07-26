package com.crimsoncrossbunker.cataclysmcb;

/**
 * Optional, versioned layouts shipped by the game.
 *
 * A CCB composite Widget is one information element.  Android element groups
 * are reserved for actual player-authored containers with multiple children.
 */
final class AndroidHudOfficialTemplates {
    static final String GAMEPLAY_SCENE_ID = "gameplay.map";
    static final String TOP_SIDEBAR_LAYOUT_ID = "official.sidebar.top.v3";

    private static final int TOP_SIDEBAR_VERSION = 3;
    private static final float MARGIN = 20f;
    private static final float COLUMN_GAP = 20f;
    private static final float ROW_GAP = 12f;
    private static final float COLUMN_WIDTH = 450f;
    private static final float SECOND_BAND_Y = 500f;

    static final class Seed {
        final int version;
        final AndroidHudModel.Layout layout;

        Seed(int version, AndroidHudModel.Layout layout) {
            this.version = version;
            this.layout = layout;
        }
    }

    private AndroidHudOfficialTemplates() {
    }

    static Seed forScene(String sceneId) {
        if (!GAMEPLAY_SCENE_ID.equals(AndroidHudModel.safeId(sceneId))) {
            return null;
        }
        return new Seed(TOP_SIDEBAR_VERSION, createTopSidebar());
    }

    private static AndroidHudModel.Layout createTopSidebar() {
        AndroidHudModel.Layout layout = new AndroidHudModel.Layout();
        layout.id = TOP_SIDEBAR_LAYOUT_ID;
        layout.name = "官方 CCB 顶部信息";

        float column1 = columnX(0);
        float column2 = columnX(1);
        float column3 = columnX(2);
        float column4 = columnX(3);

        add(layout, "四肢", legacyLabelsGroup("ll_limbs_layout"),
            column1, MARGIN, COLUMN_WIDTH, 112f);
        add(layout, "移动", legacyLabelsGroup("ll_movement_layout"),
            column1, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 112f);

        add(layout, "状态", legacyLabelsGroup("ll_stats_layout"),
            column2, MARGIN, COLUMN_WIDTH, 112f);
        add(layout, "疲惫", legacyLabelsGroup("all_weariness_layout"),
            column2, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 112f);

        add(layout, "需求", legacyLabelsGroup("ll_needs_layout"),
            column3, MARGIN, COLUMN_WIDTH, 150f);
        add(layout, "地点", legacyLabelsGroup("ll_place_layout"),
            column3, MARGIN + 150f + ROW_GAP, COLUMN_WIDTH, 260f);

        add(layout, "风向/温度", legacyLabelsGroup("wind_temp_layout"),
            column4, MARGIN, COLUMN_WIDTH, 112f);
        add(layout, "氧气", legacyLabelsGroup("oxygen_layout"),
            column4, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 70f);

        add(layout, "武器/流派", legacyLabelsGroup("weapon_style_layout"),
            column1, SECOND_BAND_Y, COLUMN_WIDTH, 140f);
        add(layout, "载具", legacyLabelsGroup("vehicle_acf_label_layout"),
            column1, SECOND_BAND_Y + 140f + ROW_GAP, COLUMN_WIDTH, 100f);

        add(layout, "罗盘", legacyLabelsGroup("compass_all_danger_layout"),
            column2, SECOND_BAND_Y, COLUMN_WIDTH, 240f);
        add(layout, "负重", legacyLabelsGroup("ll_weight_carried_value"),
            column2, SECOND_BAND_Y + 240f + ROW_GAP, COLUMN_WIDTH, 70f);

        add(layout, "辐射", legacyLabelsGroup("rad_badge_desc"),
            column3, SECOND_BAND_Y, COLUMN_WIDTH, 70f);
        add(layout, "日志", "log.messages",
            column3, SECOND_BAND_Y + 70f + ROW_GAP, COLUMN_WIDTH, 340f);

        float mapSide = 420f;
        add(layout, "地图", "map.pixel",
            column4 + (COLUMN_WIDTH - mapSide) / 2f,
            SECOND_BAND_Y, mapSide, mapSide);
        return layout;
    }

    private static float columnX(int index) {
        return MARGIN + index * (COLUMN_WIDTH + COLUMN_GAP);
    }

    private static String legacyLabelsGroup(String widgetId) {
        return "sidebar.legacy_labels_sidebar.group." + widgetId + ".0";
    }

    private static void add(AndroidHudModel.Layout layout, String label,
            String sourceId, float x, float y, float width, float height) {
        AndroidHudModel.Element information = new AndroidHudModel.Element();
        information.id = "official.sidebar.info." + sourceId;
        information.type = AndroidHudModel.TYPE_INFO;
        information.label = label;
        information.sourceId = sourceId;
        information.frame.x = x;
        information.frame.y = y;
        information.frame.width = width;
        information.frame.height = height;
        information.style.showLabel = false;
        AndroidHudModel.normalizeElementGeometry(information);
        layout.elements.add(information);
    }
}
