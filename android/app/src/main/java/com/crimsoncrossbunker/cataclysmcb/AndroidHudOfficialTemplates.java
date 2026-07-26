package com.crimsoncrossbunker.cataclysmcb;

/**
 * Optional, versioned layouts shipped by the game.
 *
 * A CCB composite Widget is one information element.  Android element groups
 * are reserved for actual player-authored containers with multiple children.
 */
final class AndroidHudOfficialTemplates {
    static final String GAMEPLAY_SCENE_ID = "gameplay.map";
    static final String TOP_SIDEBAR_LAYOUT_ID = "official.sidebar.top.v2";

    private static final int TOP_SIDEBAR_VERSION = 2;
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

        add(layout, "四肢", "sidebar.legacy.limbs",
            column1, MARGIN, COLUMN_WIDTH, 112f);
        add(layout, "移动", "sidebar.legacy.movement",
            column1, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 112f);

        add(layout, "状态", "sidebar.legacy.stats",
            column2, MARGIN, COLUMN_WIDTH, 112f);
        add(layout, "疲惫", "sidebar.legacy.weariness",
            column2, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 112f);

        add(layout, "需求", "sidebar.legacy.needs",
            column3, MARGIN, COLUMN_WIDTH, 150f);
        add(layout, "地点", "sidebar.legacy.place",
            column3, MARGIN + 150f + ROW_GAP, COLUMN_WIDTH, 260f);

        add(layout, "风向/温度", "sidebar.legacy.wind_temperature",
            column4, MARGIN, COLUMN_WIDTH, 112f);
        add(layout, "氧气", "sidebar.legacy.oxygen",
            column4, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 70f);

        add(layout, "武器/流派", "sidebar.legacy.weapon_style",
            column1, SECOND_BAND_Y, COLUMN_WIDTH, 140f);
        add(layout, "载具", "sidebar.legacy.vehicle",
            column1, SECOND_BAND_Y + 140f + ROW_GAP, COLUMN_WIDTH, 100f);

        add(layout, "罗盘", "sidebar.legacy.compass",
            column2, SECOND_BAND_Y, COLUMN_WIDTH, 240f);
        add(layout, "负重", "sidebar.legacy.carry_weight",
            column2, SECOND_BAND_Y + 240f + ROW_GAP, COLUMN_WIDTH, 70f);

        add(layout, "辐射", "sidebar.legacy.radiation",
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
