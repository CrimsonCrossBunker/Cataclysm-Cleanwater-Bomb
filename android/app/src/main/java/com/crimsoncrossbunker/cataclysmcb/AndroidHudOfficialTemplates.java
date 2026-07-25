package com.crimsoncrossbunker.cataclysmcb;

/**
 * Versioned, declarative layouts shipped by the game.
 *
 * Templates only compose public HUD information-source IDs.  They never
 * duplicate sidebar value calculation or rendering logic, and the repository
 * seeds each version at most once so deleting or replacing a template remains
 * under the player's control.
 */
final class AndroidHudOfficialTemplates {
    static final String GAMEPLAY_SCENE_ID = "gameplay.map";
    static final String TOP_SIDEBAR_LAYOUT_ID = "official.sidebar.top.v1";

    private static final int TOP_SIDEBAR_VERSION = 1;
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
        layout.name = "官方顶部侧边栏";

        float column1 = columnX(0);
        float column2 = columnX(1);
        float column3 = columnX(2);
        float column4 = columnX(3);

        addWidgetGroup(layout, "四肢", "ll_limbs_layout",
            column1, MARGIN, COLUMN_WIDTH, 112f);
        addWidgetGroup(layout, "移动", "ll_movement_layout",
            column1, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 112f);

        addWidgetGroup(layout, "状态", "ll_stats_layout",
            column2, MARGIN, COLUMN_WIDTH, 112f);
        addWidgetGroup(layout, "疲惫", "all_weariness_layout",
            column2, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 112f);

        addWidgetGroup(layout, "需求", "ll_needs_layout",
            column3, MARGIN, COLUMN_WIDTH, 150f);
        addWidgetGroup(layout, "地点", "ll_place_layout",
            column3, MARGIN + 150f + ROW_GAP, COLUMN_WIDTH, 260f);

        addWidgetGroup(layout, "风向/温度", "wind_temp_layout",
            column4, MARGIN, COLUMN_WIDTH, 112f);
        addWidgetGroup(layout, "氧气", "oxygen_layout",
            column4, MARGIN + 112f + ROW_GAP, COLUMN_WIDTH, 70f);

        addWidgetGroup(layout, "武器/流派", "weapon_style_layout",
            column1, SECOND_BAND_Y, COLUMN_WIDTH, 140f);
        addWidgetGroup(layout, "载具", "vehicle_acf_label_layout",
            column1, SECOND_BAND_Y + 140f + ROW_GAP, COLUMN_WIDTH, 100f);

        addWidgetGroup(layout, "罗盘", "compass_all_danger_layout",
            column2, SECOND_BAND_Y, COLUMN_WIDTH, 240f);
        addWidgetGroup(layout, "负重", "ll_weight_carried_value",
            column2, SECOND_BAND_Y + 240f + ROW_GAP, COLUMN_WIDTH, 70f);

        addWidgetGroup(layout, "辐射", "rad_badge_desc",
            column3, SECOND_BAND_Y, COLUMN_WIDTH, 70f);
        addInformation(layout, "日志", "log.messages",
            column3, SECOND_BAND_Y + 70f + ROW_GAP, COLUMN_WIDTH, 340f);

        float mapSide = 420f;
        addInformation(layout, "地图", "map.pixel",
            column4 + (COLUMN_WIDTH - mapSide) / 2f, SECOND_BAND_Y, mapSide, mapSide);
        return layout;
    }

    private static float columnX(int index) {
        return MARGIN + index * (COLUMN_WIDTH + COLUMN_GAP);
    }

    private static void addWidgetGroup(AndroidHudModel.Layout layout, String label,
            String widgetId, float x, float y, float width, float height) {
        AndroidHudModel.Element group = element(
            "official.sidebar.group." + widgetId, AndroidHudModel.TYPE_GROUP,
            label, x, y, width, height);
        group.clipChildren = true;
        group.style.showLabel = false;

        AndroidHudModel.Element information = element(
            "official.sidebar.info." + widgetId, AndroidHudModel.TYPE_INFO,
            label, 0f, 0f, width, height);
        information.sourceId = "widget." + widgetId;
        information.style.showLabel = false;
        group.children.add(information);
        layout.elements.add(group);
    }

    private static void addInformation(AndroidHudModel.Layout layout, String label,
            String sourceId, float x, float y, float width, float height) {
        AndroidHudModel.Element information = element(
            "official.sidebar.info." + sourceId, AndroidHudModel.TYPE_INFO,
            label, x, y, width, height);
        information.sourceId = sourceId;
        information.style.showLabel = false;
        AndroidHudModel.normalizeElementGeometry(information);
        layout.elements.add(information);
    }

    private static AndroidHudModel.Element element(String id, String type, String label,
            float x, float y, float width, float height) {
        AndroidHudModel.Element result = new AndroidHudModel.Element();
        result.id = id;
        result.type = type;
        result.label = label;
        result.frame.x = x;
        result.frame.y = y;
        result.frame.width = width;
        result.frame.height = height;
        return result;
    }
}
