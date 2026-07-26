package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.text.InputType;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.UUID;

/**
 * Full-screen schema-6 editor.  All edits stay in a detached draft with
 * bounded undo/redo history until Done performs one atomic repository commit.
 */
final class AndroidHudEditor {
    private static final int MAX_HISTORY = 50;

    private final CataclysmDDA activity;
    private final AndroidHudOverlay overlay;
    private final AndroidHudRepository repository;
    private final LinearLayout toolbar;
    private final TextView breadcrumb;
    private final Button enterOrUp;
    private final Button undo;
    private final Button redo;
    private final ArrayList<AndroidHudModel.Layout> history = new ArrayList<>();

    private AndroidHudModel.Scene scene;
    private AndroidHudModel.Layout draft;
    private String currentGroupId = "";
    private String selectedId = "";
    private boolean editing;
    private boolean preview;
    private int historyIndex = -1;

    AndroidHudEditor(CataclysmDDA activity, AndroidHudOverlay overlay,
            AndroidHudRepository repository) {
        this.activity = activity;
        this.overlay = overlay;
        this.repository = repository;
        toolbar = new LinearLayout(activity);
        toolbar.setOrientation(LinearLayout.HORIZONTAL);
        toolbar.setGravity(Gravity.CENTER_VERTICAL);
        toolbar.setPadding(dp(5), dp(4), dp(5), dp(4));
        toolbar.setBackgroundColor(0xF21B2732);
        toolbar.setVisibility(View.GONE);

        breadcrumb = new TextView(activity);
        breadcrumb.setTextColor(Color.WHITE);
        breadcrumb.setTextSize(12f);
        breadcrumb.setSingleLine(true);
        toolbar.addView(breadcrumb, new LinearLayout.LayoutParams(0, dp(48), 1f));

        enterOrUp = toolButton("进入组");
        enterOrUp.setOnClickListener(view -> enterOrExitGroup());
        toolbar.addView(enterOrUp);
        Button add = toolButton("添加");
        add.setOnClickListener(view -> showAddMenu());
        toolbar.addView(add);
        Button properties = toolButton("属性");
        properties.setOnClickListener(view -> showSelectedProperties());
        toolbar.addView(properties);
        Button delete = toolButton("删除");
        delete.setOnClickListener(view -> deleteSelected());
        toolbar.addView(delete);
        undo = toolButton("撤销");
        undo.setOnClickListener(view -> undo());
        toolbar.addView(undo);
        redo = toolButton("重做");
        redo.setOnClickListener(view -> redo());
        toolbar.addView(redo);
        Button cancel = toolButton("取消");
        cancel.setOnClickListener(view -> cancel());
        toolbar.addView(cancel);
        Button done = toolButton("完成");
        done.setOnClickListener(view -> done());
        toolbar.addView(done);

        overlay.addView(toolbar, new ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(56)));
    }

    boolean isEditing() {
        return editing;
    }

    boolean isPreview() {
        return preview;
    }

    AndroidHudModel.Layout draft() {
        return draft;
    }

    boolean isSelected(String elementId) {
        return editing && elementId.equals(selectedId);
    }

    void begin(AndroidHudModel.Scene scene, AndroidHudModel.Layout source, boolean preview) {
        if (editing) {
            return;
        }
        this.scene = scene.copy();
        this.draft = source.copy();
        this.preview = preview;
        editing = true;
        currentGroupId = "";
        selectedId = "";
        history.clear();
        history.add(draft.copy());
        historyIndex = 0;
        toolbar.setVisibility(View.VISIBLE);
        overlay.setClickable(true);
        overlay.displayEditorDraft(scene.id, draft);
        updateToolbar();
        Toast.makeText(activity,
            "拖动移动；从右下角拖动缩放；双击元素组进入组内",
            Toast.LENGTH_LONG).show();
    }

    void bringToolbarToFront() {
        if (editing) {
            toolbar.bringToFront();
        }
    }

    void configureElementInteraction(AndroidHudOverlay.RenderedElement rendered) {
        boolean editableAtCurrentLevel = editing &&
            rendered.parentGroupId.equals(currentGroupId);
        rendered.host.setEditorTouchCapture(editableAtCurrentLevel);
        if (!editableAtCurrentLevel) {
            rendered.host.setOnTouchListener(null);
            rendered.host.setClickable(false);
            return;
        }
        rendered.host.setClickable(true);
        rendered.host.setOnTouchListener(new View.OnTouchListener() {
            final int slop = ViewConfiguration.get(activity).getScaledTouchSlop();
            float downRawX;
            float downRawY;
            float startX;
            float startY;
            float startWidth;
            float startHeight;
            boolean resize;
            boolean moved;
            long previousTap;

            @Override
            public boolean onTouch(View view, MotionEvent event) {
                AndroidHudModel.Element element = draft == null ? null :
                    draft.find(rendered.element.id);
                if (element == null) {
                    return false;
                }
                switch (event.getActionMasked()) {
                    case MotionEvent.ACTION_DOWN:
                        select(element.id);
                        downRawX = event.getRawX();
                        downRawY = event.getRawY();
                        startX = element.frame.x;
                        startY = element.frame.y;
                        startWidth = element.frame.width;
                        startHeight = element.frame.height;
                        resize = event.getX() >= view.getWidth() - dp(30) &&
                            event.getY() >= view.getHeight() - dp(30);
                        moved = false;
                        return true;
                    case MotionEvent.ACTION_MOVE:
                        float rawDx = event.getRawX() - downRawX;
                        float rawDy = event.getRawY() - downRawY;
                        if (Math.abs(rawDx) > slop || Math.abs(rawDy) > slop) {
                            moved = true;
                        }
                        float dx = rawDx / Math.max(.001f, overlay.canvasScaleX());
                        float dy = rawDy / Math.max(.001f, overlay.canvasScaleY());
                        if (resize) {
                            if (AndroidHudModel.requiresSquareFrame(element)) {
                                float rawDelta = Math.abs(rawDx) >= Math.abs(rawDy) ?
                                    rawDx : rawDy;
                                float side = Math.max(32, startWidth + rawDelta /
                                    Math.max(.001f, overlay.canvasUniformScale()));
                                element.frame.width = side;
                                element.frame.height = side;
                            } else {
                                element.frame.width = Math.max(32, startWidth + dx);
                                element.frame.height = Math.max(32, startHeight + dy);
                            }
                            clampToCurrentScope(element);
                        } else {
                            element.frame.x = startX + dx;
                            element.frame.y = startY + dy;
                            clampPositionToCurrentScope(element);
                        }
                        overlay.relayoutEditorDraft();
                        return true;
                    case MotionEvent.ACTION_UP:
                        if (moved) {
                            recordHistory();
                        } else {
                            long now = event.getEventTime();
                            if (AndroidHudModel.TYPE_GROUP.equals(element.type) &&
                                    now - previousTap < 350) {
                                enterGroup(element.id);
                            }
                            previousTap = now;
                        }
                        return true;
                    case MotionEvent.ACTION_CANCEL:
                        return true;
                    default:
                        return false;
                }
            }
        });
    }

    private void showAddMenu() {
        String[] choices = { "元素组", "信息", "控件" };
        new AlertDialog.Builder(activity)
            .setTitle("添加到 " + currentScopeName())
            .setItems(choices, (dialog, which) -> {
                if (which == 0) {
                    addGroup();
                } else if (which == 1) {
                    showInfoCatalog();
                } else {
                    showAddControl();
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void addGroup() {
        if (!canAddElement()) {
            return;
        }
        EditText name = new EditText(activity);
        name.setHint("元素组名称");
        new AlertDialog.Builder(activity)
            .setTitle("新建元素组")
            .setView(name)
            .setPositiveButton("添加", (dialog, which) -> {
                AndroidHudModel.Element group = newElement(AndroidHudModel.TYPE_GROUP);
                group.label = AndroidHudModel.boundedText(name.getText().toString(), 100);
                if (group.label.isEmpty()) {
                    group.label = "元素组";
                }
                group.frame.width = 520;
                group.frame.height = 340;
                addToCurrentScope(group);
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void showInfoCatalog() {
        showInfoCatalog(false);
    }

    private void showInfoCatalog(boolean advancedTab) {
        List<AndroidHudModel.InfoSource> sources = overlay.infoSources();
        if (sources.isEmpty()) {
            Toast.makeText(activity, "信息源目录尚未就绪，请进入游戏后再试",
                Toast.LENGTH_SHORT).show();
            return;
        }
        ArrayList<AndroidHudSearchDialog.Item<AndroidHudModel.InfoSource>> items =
            new ArrayList<>();
        for (AndroidHudModel.InfoSource source : sources) {
            boolean advanced = "advanced".equals(source.catalogTier);
            if (!advancedTab &&
                    !AndroidHudModel.isCommonInfoSource(source)) {
                continue;
            }
            String breadcrumb;
            if (!source.sidebarTitle.isEmpty()) {
                breadcrumb = source.sidebarTitle + " › " + source.title;
            } else if (advanced) {
                breadcrumb = "开发者/高级 › " + source.category +
                    " › " + source.title;
            } else {
                breadcrumb = "通用信息 › " + source.title;
            }
            String state = source.defaultEnabled ? "" : " 〔默认关闭〕";
            String kind = source.composite ? "原版组合" :
                advanced ? "开发者信息" : source.category;
            items.add(new AndroidHudSearchDialog.Item<>(source, source.id,
                breadcrumb + state + "\n" + kind + "  [" + source.id + "]",
                source.title, source.category, source.renderer,
                source.catalogTier, source.sidebarTitle, breadcrumb));
        }
        String alternateLabel = advancedTab ? "返回常用信息" : "开发者/高级";
        AndroidHudSearchDialog.showSingle(activity,
            advancedTab ? "开发者/高级（包含全部常用信息）" :
                "常用信息（侧边栏分组）",
            "搜索全部后代、侧边栏、标题或 ID", items, this::addInfo,
            alternateLabel, () -> showInfoCatalog(!advancedTab));
    }

    private void addInfo(AndroidHudModel.InfoSource source) {
        if (!canAddElement()) {
            return;
        }
        AndroidHudModel.Element info = newElement(AndroidHudModel.TYPE_INFO);
        info.sourceId = source.id;
        info.label = source.title;
        info.frame.width = source.defaultWidth;
        info.frame.height = source.defaultHeight;
        info.style.background = false;
        info.style.border = false;
        if ("pixel_minimap".equals(source.renderer) ||
                "overmap_grid".equals(source.renderer) ||
                "threat_grid".equals(source.renderer)) {
            info.style.showLabel = false;
        }
        if (source.square || AndroidHudModel.requiresSquareFrame(info)) {
            float side = Math.min(info.frame.width, info.frame.height);
            info.frame.width = side;
            info.frame.height = side;
            info.overflowMode = AndroidHudModel.OVERFLOW_FIXED;
        }
        if ("threat_grid".equals(source.renderer)) {
            info.infoPresentation.radarRadius = 10;
        }
        addToCurrentScope(info);
    }

    private void showAddControl() {
        if (!canAddElement()) {
            return;
        }
        final List<AndroidHudModel.ActionDescriptor> actions =
            new ArrayList<>(scene.actionCatalog.values());
        if (actions.isEmpty()) {
            Toast.makeText(activity, "该场景还没有记录到可绑定动作", Toast.LENGTH_SHORT).show();
            return;
        }
        AndroidHudSearchDialog.showMultiple(activity, "选择控件动作",
            "搜索动作名称、ID 或分组", actionSearchItems(actions), null, "添加",
            selectedIds -> {
                AndroidHudModel.Element control = newElement(AndroidHudModel.TYPE_CONTROL);
                for (AndroidHudModel.ActionDescriptor action : actions) {
                    if (selectedIds.contains(action.id)) {
                        control.actionIds.add(action.id);
                    }
                }
                if (control.actionIds.isEmpty()) {
                    Toast.makeText(activity, "至少选择一个动作", Toast.LENGTH_SHORT).show();
                    return false;
                }
                control.defaultActionId = control.actionIds.get(0);
                control.selectedActionId = control.defaultActionId;
                control.frame.width = control.actionIds.size() > 1 ? 300 : 240;
                control.frame.height = 100;
                control.style.showLabel = false;
                control.style.opacity = 1f;
                control.style.alignment = "center";
                addToCurrentScope(control);
                return true;
            });
    }

    private void showSelectedProperties() {
        AndroidHudModel.Element original = selectedElement();
        if (original == null) {
            Toast.makeText(activity, "请先选择当前层级中的元素", Toast.LENGTH_SHORT).show();
            return;
        }
        AndroidHudModel.Element working = original.copy();
        boolean squareFrame = AndroidHudModel.requiresSquareFrame(working);
        boolean controlElement = AndroidHudModel.TYPE_CONTROL.equals(working.type);
        LinearLayout content = verticalPanel();
        content.addView(propertySection("基本与位置"), matchRow());
        EditText label = textInput(working.label);
        content.addView(labeled(controlElement ?
            "按钮文字（留空使用当前动作名称）" : "名称", label));

        EditText x = numberInput(working.frame.x);
        EditText y = numberInput(working.frame.y);
        EditText width = numberInput(working.frame.width);
        EditText height = numberInput(working.frame.height);
        content.addView(labeled("X（虚拟画布单位）", x));
        content.addView(labeled("Y（虚拟画布单位）", y));
        content.addView(labeled(squareFrame ? "正方形边长" : "宽度", width));
        if (!squareFrame) {
            content.addView(labeled("高度", height));
        } else {
            TextView squareHelp = propertyHelp(
                "该网格信息强制使用正方形，编辑边框与实际渲染区域完全一致。");
            content.addView(squareHelp, matchRow());
        }

        CheckBox visible = check("显示", working.visible);
        content.addView(visible);
        SliderField overallOpacity = addSlider(content,
            controlElement ? "控件整体不透明度" : "整体不透明度",
            0, 100, Math.round(working.style.opacity * 100), "%",
            value -> { });
        content.addView(propertyHelp(
            "整体不透明度会统一乘到文字、表面、边框和阴影上；只调整某一项时，请使用对应颜色调色盘内的不透明度。"),
            matchRow());

        ContentPaddingFields paddingFields =
            new ContentPaddingFields(content, working.style);
        ContainerPropertyFields containerFields = controlElement ? null :
            new ContainerPropertyFields(content, working, squareFrame);
        ControlAppearanceFields controlFields = controlElement ?
            new ControlAppearanceFields(content, working.controlAppearance) : null;
        AndroidHudModel.InfoSource selectedSource =
            AndroidHudModel.TYPE_INFO.equals(working.type) ?
                overlay.infoSource(working.sourceId) : null;
        InfoFormatPropertyFields infoFormatFields =
            AndroidHudInfoFormat.isTerminal(selectedSource) ?
                new InfoFormatPropertyFields(
                    content, selectedSource, working) : null;
        TextStyleFields textFields = new TextStyleFields(content, working.style,
            AndroidHudModel.TYPE_INFO.equals(working.type));

        CheckBox clip = null;
        Spinner selectorMode = null;
        LinkedHashMap<String, CheckBox> riskAuthorizationChecks = new LinkedHashMap<>();
        if (AndroidHudModel.TYPE_GROUP.equals(working.type)) {
            content.addView(propertySection("元素组"), matchRow());
            clip = check("裁剪超出组边界的子元素", working.clipChildren);
            content.addView(clip);
        }
        if (AndroidHudModel.TYPE_INFO.equals(working.type) &&
                "radar.threat_grid".equals(working.sourceId)) {
            content.addView(propertySection("信息源"), matchRow());
            EditText radius = textInput(
                String.valueOf(working.infoPresentation.radarRadius));
            radius.setInputType(InputType.TYPE_CLASS_NUMBER);
            content.addView(labeled("雷达半径（3–30 格）", radius));
            radius.setTag("radius");
        }
        if (AndroidHudModel.TYPE_CONTROL.equals(working.type)) {
            content.addView(propertySection("交互行为"), matchRow());
            String[] selectorModes = { "展开控件菜单", "逐个切换" };
            selectorMode = spinner(selectorModes,
                AndroidHudModel.SELECTOR_MODE_CYCLE.equals(working.selectorMode) ? 1 : 0);
            content.addView(labeled("多个动作时的切换方式", selectorMode));
        }
        if (AndroidHudModel.supportsActionBinding(working)) {
            Button actions = new Button(activity);
            actions.setText(actionBindingButtonText(working));
            LinearLayout riskPanel = verticalPanel();
            riskPanel.setPadding(0, dp(4), 0, dp(4));
            populateRiskAuthorizationPanel(riskPanel, working, riskAuthorizationChecks);
            actions.setOnClickListener(view -> {
                applyRiskAuthorizationChecks(working, riskAuthorizationChecks);
                showActionBindingDialog(working, () -> {
                    actions.setText(actionBindingButtonText(working));
                    populateRiskAuthorizationPanel(
                        riskPanel, working, riskAuthorizationChecks);
                });
            });
            content.addView(propertySection(actionBindingSectionTitle(working)), matchRow());
            if (!AndroidHudModel.TYPE_CONTROL.equals(working.type)) {
                content.addView(propertyHelp(
                    AndroidHudModel.TYPE_GROUP.equals(working.type) ?
                        "未绑定时元素组只负责组织内容；绑定一个动作时点击组内未被子元素处理的区域直接触发，绑定多个动作时弹出选择菜单。" :
                        "未绑定时信息只负责显示；绑定一个动作时点击直接触发，绑定多个动作时点击弹出选择菜单。"),
                    matchRow());
            }
            content.addView(actions, matchRow());
            content.addView(propertySection("高风险动作授权"), matchRow());
            content.addView(propertyHelp(
                "勾选只代表允许该元素触发；运行时仍必须长按。多个动作需长按打开菜单后选择，游戏原有确认不会被绕过。"),
                matchRow());
            content.addView(riskPanel, matchRow());
        }

        final CheckBox finalClip = clip;
        final Spinner finalSelectorMode = selectorMode;
        ScrollView propertyScroll = scroll(content);
        int screenHeight = activity.getResources().getDisplayMetrics().heightPixels;
        propertyScroll.setLayoutParams(new ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, Math.round(screenHeight * .72f)));
        AlertDialog dialog = new AlertDialog.Builder(activity)
            .setTitle(controlElement ? "控件属性" : "元素属性")
            .setView(propertyScroll)
            .setPositiveButton("保存", null)
            .setNegativeButton("取消", null)
            .create();
        dialog.setOnShowListener(ignored -> {
            if (dialog.getWindow() != null) {
                int screenWidth = activity.getResources().getDisplayMetrics().widthPixels;
                dialog.getWindow().setLayout(
                    Math.min(screenWidth, dp(760)), Math.round(screenHeight * .94f));
            }
            dialog.getButton(DialogInterface.BUTTON_POSITIVE).setOnClickListener(view -> {
                working.label = AndroidHudModel.boundedText(label.getText().toString(), 100);
                working.frame.width = parseFloat(width, working.frame.width, 32,
                    AndroidHudModel.CANVAS_WIDTH);
                working.frame.height = squareFrame ? working.frame.width :
                    parseFloat(height, working.frame.height, 32,
                        AndroidHudModel.CANVAS_HEIGHT);
                working.frame.x = parseFloat(x, working.frame.x, 0,
                    currentScopeWidth());
                working.frame.y = parseFloat(y, working.frame.y, 0,
                    currentScopeHeight());
                clampToCurrentScope(working);
                working.visible = visible.isChecked();
                working.style.opacity = overallOpacity.value / 100f;
                paddingFields.applyTo(working.style);
                if (containerFields != null) {
                    containerFields.applyTo(working);
                }
                if (controlFields != null) {
                    controlFields.applyTo(working.controlAppearance);
                }
                if (infoFormatFields != null &&
                        !infoFormatFields.applyTo(working)) {
                    return;
                }
                textFields.applyTo(working.style);
                if (finalClip != null) {
                    working.clipChildren = finalClip.isChecked();
                }
                if (finalSelectorMode != null) {
                    working.selectorMode = finalSelectorMode.getSelectedItemPosition() == 1 ?
                        AndroidHudModel.SELECTOR_MODE_CYCLE :
                        AndroidHudModel.SELECTOR_MODE_MENU;
                }
                applyRiskAuthorizationChecks(working, riskAuthorizationChecks);
                View radiusView = content.findViewWithTag("radius");
                if (radiusView instanceof EditText) {
                    int radius = Math.round(parseFloat((EditText)radiusView, 10, 3, 30));
                    working.infoPresentation.radarRadius = radius;
                }
                replaceElement(working);
                recordHistory();
                dialog.dismiss();
            });
        });
        dialog.show();
    }

    private void showActionBindingDialog(AndroidHudModel.Element working,
            Runnable onChanged) {
        List<AndroidHudModel.ActionDescriptor> actions =
            new ArrayList<>(scene.actionCatalog.values());
        String title = AndroidHudModel.TYPE_GROUP.equals(working.type) ?
            "元素组点击动作" : AndroidHudModel.TYPE_INFO.equals(working.type) ?
                "信息点击动作" : "控件候选动作";
        AndroidHudSearchDialog.showMultiple(activity, title,
            "搜索动作名称、ID 或分组", actionSearchItems(actions),
            working.actionIds, "下一步", selectedIds -> {
                working.actionIds.clear();
                for (AndroidHudModel.ActionDescriptor action : actions) {
                    if (selectedIds.contains(action.id)) {
                        working.actionIds.add(action.id);
                    }
                }
                if (working.actionIds.isEmpty()) {
                    working.defaultActionId = "";
                    working.selectedActionId = "";
                    working.authorizedDangerousActions.clear();
                    onChanged.run();
                    return true;
                }
                if (AndroidHudModel.TYPE_CONTROL.equals(working.type)) {
                    if (!working.actionIds.contains(working.defaultActionId)) {
                        working.defaultActionId = working.actionIds.get(0);
                    }
                    if (!working.actionIds.contains(working.selectedActionId)) {
                        working.selectedActionId = working.defaultActionId;
                    }
                }
                working.authorizedDangerousActions.retainAll(working.actionIds);
                onChanged.run();
                return true;
            });
    }

    private static String actionBindingSectionTitle(AndroidHudModel.Element element) {
        if (AndroidHudModel.TYPE_GROUP.equals(element.type)) {
            return "元素组点击";
        }
        return AndroidHudModel.TYPE_INFO.equals(element.type) ?
            "点击交互" : "控件动作";
    }

    private List<AndroidHudSearchDialog.Item<AndroidHudModel.ActionDescriptor>>
            actionSearchItems(List<AndroidHudModel.ActionDescriptor> actions) {
        ArrayList<AndroidHudSearchDialog.Item<AndroidHudModel.ActionDescriptor>> items =
            new ArrayList<>();
        for (AndroidHudModel.ActionDescriptor action : actions) {
            items.add(new AndroidHudSearchDialog.Item<>(action, action.id,
                riskPrefix(action) + action.label + " · " + action.group +
                    "  [" + action.id + "]",
                action.label, action.group, action.risk));
        }
        return items;
    }

    private void deleteSelected() {
        AndroidHudModel.Element selected = selectedElement();
        if (selected == null) {
            Toast.makeText(activity, "请先选择元素", Toast.LENGTH_SHORT).show();
            return;
        }
        String message = AndroidHudModel.TYPE_GROUP.equals(selected.type) ?
            "删除元素组会同时删除其中全部控件和信息。" : "删除后可在提交前使用撤销恢复。";
        new AlertDialog.Builder(activity)
            .setTitle("删除“" + elementName(selected) + "”？")
            .setMessage(message)
            .setPositiveButton("删除", (dialog, which) -> {
                draft.remove(selected.id);
                selectedId = "";
                recordHistory();
                overlay.refreshEditorDraft();
                updateToolbar();
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void enterOrExitGroup() {
        if (!currentGroupId.isEmpty()) {
            AndroidHudModel.Element parent = draft.findParent(currentGroupId);
            currentGroupId = parent == null ? "" : parent.id;
            selectedId = "";
            overlay.refreshEditorDraft();
            updateToolbar();
            return;
        }
        AndroidHudModel.Element selected = selectedElement();
        if (selected != null && AndroidHudModel.TYPE_GROUP.equals(selected.type)) {
            enterGroup(selected.id);
        }
    }

    private void enterGroup(String groupId) {
        AndroidHudModel.Element group = draft.find(groupId);
        if (group == null || !AndroidHudModel.TYPE_GROUP.equals(group.type)) {
            return;
        }
        currentGroupId = groupId;
        selectedId = "";
        overlay.refreshEditorDraft();
        updateToolbar();
    }

    private void undo() {
        if (historyIndex <= 0) {
            return;
        }
        draft = history.get(--historyIndex).copy();
        repairScopeAfterHistory();
    }

    private void redo() {
        if (historyIndex + 1 >= history.size()) {
            return;
        }
        draft = history.get(++historyIndex).copy();
        repairScopeAfterHistory();
    }

    private void cancel() {
        if (historyIndex <= 0) {
            close(false);
            return;
        }
        new AlertDialog.Builder(activity)
            .setTitle("放弃 HUD 草稿？")
            .setMessage("尚未点击完成的修改不会写入布局文件。")
            .setPositiveButton("放弃", (dialog, which) -> close(false))
            .setNegativeButton("继续编辑", null)
            .show();
    }

    private void done() {
        if (repository.commitLayout(scene.id, draft)) {
            close(true);
        } else {
            Toast.makeText(activity, "布局校验失败，未保存", Toast.LENGTH_SHORT).show();
        }
    }

    private void close(boolean committed) {
        editing = false;
        toolbar.setVisibility(View.GONE);
        overlay.setClickable(false);
        history.clear();
        historyIndex = -1;
        currentGroupId = "";
        selectedId = "";
        draft = null;
        scene = null;
        overlay.finishEditing(committed);
    }

    private void addToCurrentScope(AndroidHudModel.Element element) {
        List<AndroidHudModel.Element> target = draft.childrenOf(currentGroupId);
        if (target == null) {
            return;
        }
        int offset = (draft.elementCount() % 12) * 24;
        element.frame.x = 80 + offset;
        // Root elements must start below the fixed native editor toolbar.
        // Child coordinates are group-relative and do not need that offset.
        element.frame.y = (currentGroupId.isEmpty() ? 220 : 50) + offset;
        clampToCurrentScope(element);
        target.add(element);
        selectedId = element.id;
        recordHistory();
        overlay.refreshEditorDraft();
        updateToolbar();
    }

    private boolean canAddElement() {
        if (draft.elementCount() >= AndroidHudModel.MAX_ELEMENTS_PER_LAYOUT) {
            Toast.makeText(activity, "该布局已达到元素数量上限", Toast.LENGTH_SHORT).show();
            return false;
        }
        int depth = 0;
        AndroidHudModel.Element cursor = draft.find(currentGroupId);
        while (cursor != null) {
            depth++;
            cursor = draft.findParent(cursor.id);
        }
        if (depth >= AndroidHudModel.MAX_ELEMENT_DEPTH) {
            Toast.makeText(activity, "元素组嵌套已达到上限", Toast.LENGTH_SHORT).show();
            return false;
        }
        return true;
    }

    private AndroidHudModel.Element newElement(String type) {
        AndroidHudModel.Element element = new AndroidHudModel.Element();
        element.id = "element." + UUID.randomUUID().toString();
        element.type = type;
        return element;
    }

    private void replaceElement(AndroidHudModel.Element replacement) {
        List<AndroidHudModel.Element> siblings = draft.childrenOf(currentGroupId);
        if (siblings == null) {
            return;
        }
        for (int i = 0; i < siblings.size(); ++i) {
            if (siblings.get(i).id.equals(replacement.id)) {
                siblings.set(i, replacement);
                selectedId = replacement.id;
                overlay.refreshEditorDraft();
                return;
            }
        }
    }

    private void recordHistory() {
        while (history.size() > historyIndex + 1) {
            history.remove(history.size() - 1);
        }
        history.add(draft.copy());
        if (history.size() > MAX_HISTORY) {
            history.remove(0);
        }
        historyIndex = history.size() - 1;
        updateToolbar();
    }

    private void repairScopeAfterHistory() {
        if (!currentGroupId.isEmpty()) {
            AndroidHudModel.Element group = draft.find(currentGroupId);
            if (group == null || !AndroidHudModel.TYPE_GROUP.equals(group.type)) {
                currentGroupId = "";
            }
        }
        if (!selectedId.isEmpty() && draft.find(selectedId) == null) {
            selectedId = "";
        }
        overlay.displayEditorDraft(scene.id, draft);
        updateToolbar();
    }

    private void select(String elementId) {
        if (!elementId.equals(selectedId)) {
            selectedId = elementId;
            overlay.refreshElementStyles();
            updateToolbar();
        }
    }

    private AndroidHudModel.Element selectedElement() {
        if (draft == null || selectedId.isEmpty()) {
            return null;
        }
        AndroidHudModel.Element element = draft.find(selectedId);
        AndroidHudModel.Element parent = element == null ? null : draft.findParent(element.id);
        String parentId = parent == null ? "" : parent.id;
        return parentId.equals(currentGroupId) ? element : null;
    }

    private void updateToolbar() {
        StringBuilder path = new StringBuilder(scene == null ? "HUD" : scene.title);
        ArrayList<String> names = new ArrayList<>();
        AndroidHudModel.Element current = draft == null ? null : draft.find(currentGroupId);
        while (current != null) {
            names.add(0, elementName(current));
            current = draft.findParent(current.id);
        }
        for (String name : names) {
            path.append(" / ").append(name);
        }
        if (preview) {
            path.append(" · 离线预览");
        }
        breadcrumb.setText(path.toString());
        AndroidHudModel.Element selected = selectedElement();
        enterOrUp.setText(!currentGroupId.isEmpty() ? "上一级" :
            selected != null && AndroidHudModel.TYPE_GROUP.equals(selected.type) ?
                "进入组" : "根层级");
        enterOrUp.setEnabled(!currentGroupId.isEmpty() ||
            selected != null && AndroidHudModel.TYPE_GROUP.equals(selected.type));
        undo.setEnabled(historyIndex > 0);
        redo.setEnabled(historyIndex + 1 < history.size());
        bringToolbarToFront();
    }

    private String currentScopeName() {
        AndroidHudModel.Element group = draft.find(currentGroupId);
        return group == null ? "布局根层级" : elementName(group);
    }

    private float currentScopeWidth() {
        AndroidHudModel.Element group = draft == null ? null : draft.find(currentGroupId);
        return group == null ? AndroidHudModel.CANVAS_WIDTH :
            overlay.contentScopeWidth(group);
    }

    private float currentScopeHeight() {
        AndroidHudModel.Element group = draft == null ? null : draft.find(currentGroupId);
        return group == null ? AndroidHudModel.CANVAS_HEIGHT :
            overlay.contentScopeHeight(group);
    }

    private List<AndroidHudModel.Element> currentScopeElements() {
        List<AndroidHudModel.Element> elements =
            draft == null ? null : draft.childrenOf(currentGroupId);
        return elements == null ? new ArrayList<>() : elements;
    }

    private void clampToCurrentScope(AndroidHudModel.Element element) {
        AndroidHudGeometry.clampFrame(element, currentScopeWidth(), currentScopeHeight(),
            overlay.canvasScaleX(), overlay.canvasScaleY(),
            overlay.minimumElementSizePixels());
    }

    private void clampPositionToCurrentScope(AndroidHudModel.Element element) {
        AndroidHudGeometry.clampPosition(element,
            currentScopeWidth(), currentScopeHeight(),
            overlay.canvasScaleX(), overlay.canvasScaleY(),
            overlay.minimumElementSizePixels());
    }

    private static String elementName(AndroidHudModel.Element element) {
        if (!element.label.isEmpty()) {
            return element.label;
        }
        if (AndroidHudModel.TYPE_GROUP.equals(element.type)) {
            return "元素组";
        }
        if (AndroidHudModel.TYPE_CONTROL.equals(element.type)) {
            return "控件";
        }
        return "信息";
    }

    private static String riskPrefix(AndroidHudModel.ActionDescriptor action) {
        return AndroidHudModel.RISK_SAFE.equals(action.risk) ? "" : "⚠ ";
    }

    private static String actionBindingButtonText(AndroidHudModel.Element element) {
        String kind = AndroidHudModel.TYPE_INFO.equals(element.type) ?
            "点击动作" : "控件动作";
        return "配置" + kind + "（" + element.actionIds.size() + "）";
    }

    private static void applyRiskAuthorizationChecks(AndroidHudModel.Element element,
            LinkedHashMap<String, CheckBox> checks) {
        element.authorizedDangerousActions.retainAll(element.actionIds);
        for (String actionId : checks.keySet()) {
            if (checks.get(actionId).isChecked()) {
                element.authorizedDangerousActions.add(actionId);
            } else {
                element.authorizedDangerousActions.remove(actionId);
            }
        }
    }

    private void populateRiskAuthorizationPanel(LinearLayout panel,
            AndroidHudModel.Element element,
            LinkedHashMap<String, CheckBox> checks) {
        panel.removeAllViews();
        checks.clear();
        for (String actionId : element.actionIds) {
            AndroidHudModel.ActionDescriptor action = scene.actionCatalog.get(actionId);
            if (action == null || AndroidHudModel.RISK_SAFE.equals(action.risk)) {
                continue;
            }
            CheckBox authorized = check("允许“" + action.label + "”  [" + action.id + "]",
                element.authorizedDangerousActions.contains(action.id));
            checks.put(action.id, authorized);
            panel.addView(authorized, matchRow());
        }
        if (checks.isEmpty()) {
            panel.addView(propertyHelp("当前元素没有需要额外授权的动作。"), matchRow());
        }
    }

    private LinearLayout verticalPanel() {
        LinearLayout layout = new LinearLayout(activity);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(dp(18), dp(12), dp(18), dp(18));
        return layout;
    }

    private View labeled(String label, View value) {
        LinearLayout row = new LinearLayout(activity);
        row.setOrientation(LinearLayout.VERTICAL);
        TextView title = new TextView(activity);
        title.setText(label);
        title.setTextColor(0xFFB6C6CE);
        row.addView(title);
        row.addView(value, matchRow());
        row.setPadding(0, dp(4), 0, dp(4));
        return row;
    }

    private ScrollView scroll(View content) {
        ScrollView scroll = new ScrollView(activity);
        scroll.setFillViewport(true);
        scroll.setClipToPadding(false);
        scroll.setPadding(0, 0, 0, dp(28));
        scroll.setVerticalScrollBarEnabled(true);
        scroll.setNestedScrollingEnabled(true);
        scroll.addView(content, new ScrollView.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return scroll;
    }

    private TextView propertySection(String value) {
        TextView text = new TextView(activity);
        text.setText(value);
        text.setTextColor(0xFF80CBC4);
        text.setTextSize(14f);
        text.setPadding(0, dp(14), 0, dp(4));
        return text;
    }

    private TextView propertyHelp(String value) {
        TextView text = new TextView(activity);
        text.setText(value);
        text.setTextColor(0xFFB6C6CE);
        text.setTextSize(12f);
        text.setPadding(0, dp(4), 0, dp(8));
        return text;
    }

    private EditText textInput(String value) {
        EditText input = new EditText(activity);
        input.setText(value == null ? "" : value);
        input.setSingleLine(true);
        return input;
    }

    private EditText numberInput(float value) {
        EditText input = textInput(String.valueOf(Math.round(value)));
        input.setInputType(InputType.TYPE_CLASS_NUMBER |
            InputType.TYPE_NUMBER_FLAG_DECIMAL | InputType.TYPE_NUMBER_FLAG_SIGNED);
        return input;
    }

    private CheckBox check(String title, boolean checked) {
        CheckBox check = new CheckBox(activity);
        check.setText(title);
        check.setChecked(checked);
        return check;
    }

    private Spinner spinner(String[] values, int selected) {
        Spinner spinner = new Spinner(activity);
        spinner.setAdapter(new ArrayAdapter<>(activity,
            android.R.layout.simple_spinner_dropdown_item, values));
        spinner.setSelection(Math.max(0, Math.min(selected, values.length - 1)));
        return spinner;
    }

    private ColorField colorField(String title, int current) {
        LinearLayout root = new LinearLayout(activity);
        root.setOrientation(LinearLayout.HORIZONTAL);
        root.setGravity(Gravity.CENTER_VERTICAL);
        TextView label = new TextView(activity);
        label.setText(title);
        root.addView(label, new LinearLayout.LayoutParams(dp(128),
            ViewGroup.LayoutParams.WRAP_CONTENT));
        Button button = new Button(activity);
        button.setAllCaps(false);
        ColorField field = new ColorField(root, button, current);
        updateColorButton(field);
        button.setOnClickListener(view -> AndroidHudColorPickerDialog.show(
            activity, title, field.value, color -> {
                field.value = color;
                updateColorButton(field);
            }));
        root.addView(button, new LinearLayout.LayoutParams(
            0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        return field;
    }

    private void updateColorButton(ColorField field) {
        field.button.setText(String.format("#%08X", field.value));
        field.button.setBackgroundTintList(ColorStateList.valueOf(field.value));
        double luminance = .299 * Color.red(field.value) +
            .587 * Color.green(field.value) + .114 * Color.blue(field.value);
        field.button.setTextColor(luminance >= 150 ? Color.BLACK : Color.WHITE);
    }

    private interface SliderCallback {
        void changed(int value);
    }

    private SliderField addSlider(LinearLayout content, String label,
            int minimum, int maximum,
            int current, String suffix, SliderCallback callback) {
        LinearLayout row = new LinearLayout(activity);
        row.setOrientation(LinearLayout.HORIZONTAL);
        row.setGravity(Gravity.CENTER_VERTICAL);
        TextView title = new TextView(activity);
        title.setText(label);
        row.addView(title, new LinearLayout.LayoutParams(dp(132),
            ViewGroup.LayoutParams.WRAP_CONTENT));
        SeekBar seek = new SeekBar(activity);
        seek.setMax(maximum - minimum);
        seek.setProgress(Math.max(0, Math.min(maximum - minimum, current - minimum)));
        TextView value = new TextView(activity);
        value.setText(current + suffix);
        SliderField field = new SliderField(row, seek, value,
            Math.max(minimum, Math.min(maximum, current)));
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                int actual = progress + minimum;
                field.value = actual;
                value.setText(actual + suffix);
                callback.changed(actual);
            }

            @Override public void onStartTrackingTouch(SeekBar seekBar) {}
            @Override public void onStopTrackingTouch(SeekBar seekBar) {}
        });
        row.addView(seek, new LinearLayout.LayoutParams(0,
            ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        row.addView(value, new LinearLayout.LayoutParams(dp(64),
            ViewGroup.LayoutParams.WRAP_CONTENT));
        content.addView(row, matchRow());
        return field;
    }

    private Button toolButton(String title) {
        Button button = new Button(activity);
        button.setText(title);
        button.setTextSize(11f);
        button.setAllCaps(false);
        button.setMinWidth(0);
        button.setMinHeight(0);
        button.setPadding(dp(6), 0, dp(6), 0);
        button.setLayoutParams(new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT, dp(48)));
        return button;
    }

    private LinearLayout.LayoutParams matchRow() {
        return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
    }

    private float parseFloat(EditText input, float fallback, float minimum, float maximum) {
        try {
            return clamp(Float.parseFloat(input.getText().toString()), minimum, maximum);
        } catch (NumberFormatException error) {
            return fallback;
        }
    }

    private int dp(int value) {
        return Math.round(value * activity.getResources().getDisplayMetrics().density);
    }

    private static float clamp(float value, float minimum, float maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }

    private final class InfoFormatPropertyFields {
        private final AndroidHudModel.InfoSource source;
        private final AndroidHudModel.Element working;
        private final AndroidHudLayoutSchema layoutSchema;
        private final Spinner layoutMode;
        private final Spinner appearance;
        private final CheckBox customColumns;
        private final EditText columns;
        private final Button nodeOverrides;
        private final CheckBox sourceBackgrounds;
        private final CheckBox sourceAttributes;
        private final ColorField cellBackgroundColor;

        InfoFormatPropertyFields(LinearLayout content,
                AndroidHudModel.InfoSource source,
                AndroidHudModel.Element element) {
            this.source = source;
            working = element;
            layoutSchema = loadLayoutSchema(source.id);
            content.addView(propertySection("原版 Widget 排版"), matchRow());
            content.addView(propertyHelp(
                "排版使用 CCB Widget 树和字符网格；元素边框仍只负责位置、点击区域与裁剪/滑动。每个信息实例拥有独立配置，不会修改游戏全局 Widget。"),
                matchRow());

            String[] layoutModes = { "原版", "自定义", "完全松散" };
            int selectedMode = AndroidHudModel.INFO_LAYOUT_CUSTOM.equals(
                element.infoPresentation.layoutMode) ? 1 :
                AndroidHudModel.INFO_LAYOUT_LOOSE.equals(
                    element.infoPresentation.layoutMode) ? 2 : 0;
            layoutMode = spinner(layoutModes, selectedMode);
            content.addView(labeled("信息排版模式", layoutMode));
            content.addView(propertyHelp(
                "原版：严格使用所属侧边栏的列宽、分隔符和间距；自定义：从原版开始应用稀疏逐节点覆盖；完全松散：保留树、顺序和颜色，取消固定宽度与尾部补齐，兄弟列只留 1 格。切换模式不会删除覆盖。"),
                matchRow());

            if (source.contextAmbiguous && !source.contextWarning.isEmpty()) {
                content.addView(propertyHelp(
                    "上下文提示：" + source.contextWarning),
                    matchRow());
            }
            String[] appearances = { "原版样式", "自定义样式" };
            appearance = spinner(appearances,
                AndroidHudInfoFormat.nativeAppearance(element) ? 0 : 1);
            content.addView(labeled("外观模式", appearance));
            content.addView(propertyHelp(
                "原版样式严格保留 CCB 的前景、背景、亮色/粗体和高亮属性，下面的颜色与文字效果不会覆盖它。切到自定义样式后，才可分别决定是否沿用来源前景、背景和属性。"),
                matchRow());

            customColumns = check("自定义总列宽",
                AndroidHudInfoFormat.hasCustomColumns(element));
            content.addView(customColumns);
            columns = textInput(customColumns.isChecked() ?
                String.valueOf(element.infoPresentation.columns) :
                String.valueOf(AndroidHudInfoFormat.defaultColumns(source)));
            columns.setInputType(InputType.TYPE_CLASS_NUMBER);
            content.addView(labeled("总列宽（8–80）", columns));
            content.addView(propertyHelp(
                "仅自定义模式使用该值；关闭时继承所属侧边栏的内容列宽（侧边栏宽度减左右各 1 格）。"),
                matchRow());

            nodeOverrides = new Button(activity);
            updateNodeOverrideButton();
            nodeOverrides.setOnClickListener(view -> showNodeCatalog());
            content.addView(nodeOverrides, matchRow());
            content.addView(propertyHelp(
                "进入 Widget 树后可按节点覆盖分配宽度、本地标签槽、直属列间距和分隔符。节点路径稳定且配置是稀疏的；条件分支会显示标记。"),
                matchRow());
            addMissingOverridesSection(content);

            content.addView(propertySection("终端来源属性"), matchRow());
            sourceBackgrounds = check("自定义样式沿用来源背景",
                element.infoPresentation.sourceBackgrounds);
            sourceAttributes = check("自定义样式沿用来源高亮/粗体",
                element.infoPresentation.sourceAttributes);
            content.addView(sourceBackgrounds);
            content.addView(sourceAttributes);
            cellBackgroundColor = colorField("自定义终端基础背景",
                element.infoPresentation.cellBackgroundColor);
            content.addView(cellBackgroundColor.root, matchRow());

            customColumns.setOnCheckedChangeListener((button, checked) ->
                columns.setEnabled(checked));
            columns.setEnabled(customColumns.isChecked());
        }

        boolean applyTo(AndroidHudModel.Element element) {
            element.infoPresentation.layoutMode =
                layoutMode.getSelectedItemPosition() == 1 ?
                AndroidHudModel.INFO_LAYOUT_CUSTOM :
                layoutMode.getSelectedItemPosition() == 2 ?
                AndroidHudModel.INFO_LAYOUT_LOOSE :
                AndroidHudModel.INFO_LAYOUT_ORIGINAL;
            element.infoPresentation.appearanceMode =
                appearance.getSelectedItemPosition() == 1 ?
                AndroidHudModel.INFO_APPEARANCE_CUSTOM :
                AndroidHudModel.INFO_APPEARANCE_NATIVE;

            int resolvedColumns =
                AndroidHudInfoFormat.defaultColumns(source);
            if (customColumns.isChecked()) {
                Integer value = parseInteger(columns);
                if (value == null ||
                        value < AndroidHudInfoFormat.MIN_COLUMNS ||
                        value > AndroidHudInfoFormat.MAX_COLUMNS) {
                    Toast.makeText(activity, "总列宽必须是 8–80 的整数",
                        Toast.LENGTH_SHORT).show();
                    return false;
                }
                resolvedColumns = value;
                element.infoPresentation.columns = value;
            } else {
                element.infoPresentation.columns = 0;
            }
            element.infoPresentation.sourceBackgrounds =
                sourceBackgrounds.isChecked();
            element.infoPresentation.sourceAttributes =
                sourceAttributes.isChecked();
            element.infoPresentation.cellBackgroundColor =
                cellBackgroundColor.value;
            return true;
        }

        private AndroidHudLayoutSchema loadLayoutSchema(String sourceId) {
            try {
                String encoded = activity.getHudLayoutSchema(sourceId);
                return encoded.isEmpty() ? null :
                    AndroidHudLayoutSchema.parse(encoded);
            } catch (Exception error) {
                return null;
            }
        }

        private void updateNodeOverrideButton() {
            nodeOverrides.setText("编辑逐节点排版（" +
                working.infoPresentation.nodeOverrides.size() + " 项）");
            nodeOverrides.setEnabled(layoutSchema != null &&
                layoutSchema.available);
        }

        private void addMissingOverridesSection(LinearLayout content) {
            if (layoutSchema == null || !layoutSchema.available) {
                content.addView(propertyHelp(
                    "当前无法读取该信息源的 Widget 树；已有覆盖仍会保留，进入游戏并加载目录后可继续编辑。"),
                    matchRow());
                return;
            }
            java.util.Set<String> paths = layoutSchema.paths();
            ArrayList<String> missing = new ArrayList<>();
            for (AndroidHudModel.NodeOverride node :
                    working.infoPresentation.nodeOverrides) {
                if (!paths.contains(node.path)) {
                    missing.add(node.path);
                }
            }
            if (!missing.isEmpty()) {
                content.addView(propertySection(
                    "缺失节点覆盖（保留但运行时忽略）"), matchRow());
                content.addView(propertyHelp(
                    android.text.TextUtils.join("\n", missing)), matchRow());
                Button clear = new Button(activity);
                clear.setText("清理全部缺失覆盖");
                clear.setOnClickListener(view -> {
                    working.infoPresentation.nodeOverrides.removeIf(
                        node -> !paths.contains(node.path));
                    updateNodeOverrideButton();
                    clear.setEnabled(false);
                });
                content.addView(clear, matchRow());
            }
        }

        private void showNodeCatalog() {
            if (layoutSchema == null || !layoutSchema.available) {
                return;
            }
            ArrayList<AndroidHudSearchDialog.Item<AndroidHudLayoutSchema.Node>>
                items = new ArrayList<>();
            for (AndroidHudLayoutSchema.Node node :
                    layoutSchema.flattened()) {
                AndroidHudModel.NodeOverride configured =
                    working.infoPresentation.overrideForPath(node.path);
                String marker = configured == null ? "" : " ●";
                String branch = node.conditional ||
                    node.conditionalBranches ? " 〔条件分支〕" : "";
                String breadcrumb = layoutSchema.breadcrumb(node);
                items.add(new AndroidHudSearchDialog.Item<>(
                    node, node.path, breadcrumb + marker + branch +
                    "\n[" + node.path + "]",
                    node.label, node.id, node.path, node.style,
                    node.arrangement, breadcrumb));
            }
            AndroidHudSearchDialog.showSingle(activity,
                "逐节点排版覆盖", "搜索标签、ID、路径或上级节点",
                items, this::showNodeProperties);
        }

        private void showNodeProperties(AndroidHudLayoutSchema.Node node) {
            AndroidHudModel.NodeOverride existing =
                working.infoPresentation.overrideForPath(node.path);
            AndroidHudModel.NodeOverride edit = existing == null ?
                new AndroidHudModel.NodeOverride() : existing.copy();
            edit.path = node.path;

            LinearLayout panel = verticalPanel();
            panel.addView(propertyHelp(
                layoutSchema.breadcrumb(node) + "\n" + node.path +
                "\n原版：宽 " + node.originalWidthColumns +
                "，标签槽 " + node.originalLabelColumns +
                "，间距 " + node.originalGapColumns +
                "，分隔符“" + node.separator + "”"), matchRow());
            CheckBox useWidth = check("覆盖分配宽度",
                edit.widthColumns != null);
            EditText width = textInput(edit.widthColumns == null ? "" :
                String.valueOf(edit.widthColumns));
            width.setInputType(InputType.TYPE_CLASS_NUMBER);
            panel.addView(useWidth);
            panel.addView(labeled("宽度（1–80 格）", width));

            CheckBox useLabels = check("覆盖本地标签槽",
                edit.labelColumns != null);
            EditText labels = textInput(edit.labelColumns == null ? "" :
                String.valueOf(edit.labelColumns));
            labels.setInputType(InputType.TYPE_CLASS_NUMBER);
            panel.addView(useLabels);
            panel.addView(labeled("标签槽（0–40 格）", labels));

            CheckBox useGap = check("覆盖直属列间距",
                edit.gapColumns != null);
            EditText gap = textInput(edit.gapColumns == null ? "" :
                String.valueOf(edit.gapColumns));
            gap.setInputType(InputType.TYPE_CLASS_NUMBER);
            panel.addView(useGap);
            panel.addView(labeled("间距（0–8 格）", gap));

            CheckBox useSeparator = check("覆盖分隔符",
                edit.separator != null);
            EditText separator = textInput(
                edit.separator == null ? "" : edit.separator);
            panel.addView(useSeparator);
            panel.addView(labeled("分隔符（最多 32 字节）", separator));
            useWidth.setOnCheckedChangeListener((button, checked) ->
                width.setEnabled(checked));
            useLabels.setOnCheckedChangeListener((button, checked) ->
                labels.setEnabled(checked));
            useGap.setOnCheckedChangeListener((button, checked) ->
                gap.setEnabled(checked));
            useSeparator.setOnCheckedChangeListener((button, checked) ->
                separator.setEnabled(checked));
            width.setEnabled(useWidth.isChecked());
            labels.setEnabled(useLabels.isChecked());
            gap.setEnabled(useGap.isChecked());
            separator.setEnabled(useSeparator.isChecked());

            AlertDialog dialog = new AlertDialog.Builder(activity)
                .setTitle(node.displayName())
                .setView(scroll(panel))
                .setPositiveButton("保存", null)
                .setNeutralButton("恢复原版", null)
                .setNegativeButton("取消", null)
                .create();
            dialog.setOnShowListener(ignored -> {
                dialog.getButton(DialogInterface.BUTTON_POSITIVE)
                    .setOnClickListener(view -> {
                        Integer widthValue = useWidth.isChecked() ?
                            parseInteger(width) : null;
                        Integer labelValue = useLabels.isChecked() ?
                            parseInteger(labels) : null;
                        Integer gapValue = useGap.isChecked() ?
                            parseInteger(gap) : null;
                        if (widthValue != null &&
                                (widthValue < 1 || widthValue > 80) ||
                                useWidth.isChecked() && widthValue == null) {
                            Toast.makeText(activity,
                                "宽度必须是 1–80 的整数",
                                Toast.LENGTH_SHORT).show();
                            return;
                        }
                        int assignedWidth = widthValue == null ?
                            (node.originalWidthColumns > 0 ?
                                node.originalWidthColumns :
                                AndroidHudInfoFormat.columns(source, working)) :
                            widthValue;
                        if (labelValue != null &&
                                (labelValue < 0 || labelValue > 40 ||
                                    labelValue >= assignedWidth) ||
                                useLabels.isChecked() && labelValue == null) {
                            Toast.makeText(activity,
                                "标签槽必须是 0–40 的整数，并小于节点宽度",
                                Toast.LENGTH_SHORT).show();
                            return;
                        }
                        if (gapValue != null &&
                                (gapValue < 0 || gapValue > 8) ||
                                useGap.isChecked() && gapValue == null) {
                            Toast.makeText(activity,
                                "间距必须是 0–8 的整数",
                                Toast.LENGTH_SHORT).show();
                            return;
                        }
                        String separatorValue = useSeparator.isChecked() ?
                            separator.getText().toString() : null;
                        if (separatorValue != null &&
                                separatorValue.getBytes(
                                    java.nio.charset.StandardCharsets.UTF_8).length > 32) {
                            Toast.makeText(activity,
                                "分隔符最多 32 字节",
                                Toast.LENGTH_SHORT).show();
                            return;
                        }
                        edit.widthColumns = widthValue;
                        edit.labelColumns = labelValue;
                        edit.gapColumns = gapValue;
                        edit.separator = separatorValue;
                        saveNodeOverride(existing, edit);
                        updateNodeOverrideButton();
                        dialog.dismiss();
                    });
                dialog.getButton(DialogInterface.BUTTON_NEUTRAL)
                    .setOnClickListener(view -> {
                        if (existing != null) {
                            working.infoPresentation.nodeOverrides
                                .remove(existing);
                        }
                        updateNodeOverrideButton();
                        dialog.dismiss();
                    });
            });
            dialog.show();
        }

        private void saveNodeOverride(AndroidHudModel.NodeOverride existing,
                AndroidHudModel.NodeOverride edit) {
            if (existing != null) {
                working.infoPresentation.nodeOverrides.remove(existing);
            }
            if (edit.widthColumns != null || edit.labelColumns != null ||
                    edit.gapColumns != null || edit.separator != null) {
                working.infoPresentation.nodeOverrides.add(edit);
            }
        }

        private Integer parseInteger(EditText input) {
            try {
                return Integer.valueOf(input.getText().toString().trim());
            } catch (NumberFormatException ignored) {
                return null;
            }
        }
    }

    private final class ContainerPropertyFields {
        private final CheckBox showLabel;
        private final CheckBox background;
        private final CheckBox border;
        private final ColorField backgroundColor;
        private final ColorField borderColor;
        private final Spinner overflow;
        private final boolean overflowAvailable;

        ContainerPropertyFields(LinearLayout content, AndroidHudModel.Element element,
                boolean squareFrame) {
            content.addView(propertySection("容器与内容"), matchRow());
            showLabel = check("显示名称", element.style.showLabel);
            background = check("显示背景", element.style.background);
            border = check("显示边框", element.style.border);
            content.addView(showLabel);
            content.addView(background);
            content.addView(border);

            backgroundColor = colorField("背景颜色", element.style.backgroundColor);
            borderColor = colorField("边框颜色", element.style.borderColor);
            content.addView(backgroundColor.root, matchRow());
            content.addView(borderColor.root, matchRow());

            String[] overflowModes = { "固定", "内容超出时可滑动" };
            overflow = spinner(overflowModes,
                AndroidHudModel.OVERFLOW_SCROLL.equals(element.overflowMode) ? 1 : 0);
            overflowAvailable = !squareFrame;
            if (!overflowAvailable) {
                overflow.setSelection(0);
                overflow.setEnabled(false);
            }
            content.addView(labeled("内容行为", overflow));

            background.setOnCheckedChangeListener((button, checked) ->
                backgroundColor.root.setVisibility(checked ? View.VISIBLE : View.GONE));
            border.setOnCheckedChangeListener((button, checked) ->
                borderColor.root.setVisibility(checked ? View.VISIBLE : View.GONE));
            backgroundColor.root.setVisibility(
                background.isChecked() ? View.VISIBLE : View.GONE);
            borderColor.root.setVisibility(border.isChecked() ? View.VISIBLE : View.GONE);
        }

        void applyTo(AndroidHudModel.Element element) {
            element.style.showLabel = showLabel.isChecked();
            element.style.background = background.isChecked();
            element.style.border = border.isChecked();
            element.style.backgroundColor = backgroundColor.value;
            element.style.borderColor = borderColor.value;
            element.overflowMode = overflowAvailable &&
                overflow.getSelectedItemPosition() == 1 ?
                AndroidHudModel.OVERFLOW_SCROLL : AndroidHudModel.OVERFLOW_FIXED;
        }
    }

    private final class ContentPaddingFields {
        private final SliderField left;
        private final SliderField top;
        private final SliderField right;
        private final SliderField bottom;

        ContentPaddingFields(LinearLayout content, AndroidHudModel.Style style) {
            content.addView(propertySection("内容内边距"), matchRow());
            content.addView(propertyHelp(
                "控制内容与元素边框之间的距离，适用于信息、元素组和控件。设为 0 时不再保留 Android 字体的隐式留白。"),
                matchRow());
            left = addSlider(content, "左内边距", 0, 64,
                Math.round(style.contentPaddingLeftDp), "dp", value -> { });
            top = addSlider(content, "上内边距", 0, 64,
                Math.round(style.contentPaddingTopDp), "dp", value -> { });
            right = addSlider(content, "右内边距", 0, 64,
                Math.round(style.contentPaddingRightDp), "dp", value -> { });
            bottom = addSlider(content, "下内边距", 0, 64,
                Math.round(style.contentPaddingBottomDp), "dp", value -> { });
        }

        void applyTo(AndroidHudModel.Style style) {
            style.contentPaddingLeftDp = left.value;
            style.contentPaddingTopDp = top.value;
            style.contentPaddingRightDp = right.value;
            style.contentPaddingBottomDp = bottom.value;
        }
    }

    private final class TextStyleFields {
        private final Spinner alignment;
        private final CheckBox sourceColors;
        private final CheckBox bold;
        private final CheckBox italic;
        private final ColorField textColor;
        private final SliderField fontSize;
        private final Spinner effect;
        private final LinearLayout outlinePanel;
        private final ColorField outlineColor;
        private final SliderField outlineWidth;
        private final LinearLayout shadowPanel;
        private final ColorField shadowColor;
        private final SliderField shadowRadius;
        private final SliderField shadowOffsetX;
        private final SliderField shadowOffsetY;

        TextStyleFields(LinearLayout content, AndroidHudModel.Style style,
                boolean supportsSourceColors) {
            content.addView(propertySection("文字"), matchRow());
            sourceColors = check("使用原版动态颜色", style.sourceColors);
            if (supportsSourceColors) {
                content.addView(sourceColors);
                content.addView(propertyHelp(
                    "开启后保留血量、天气、状态、日志和地图等信息源的原版状态颜色；关闭后统一使用文字颜色。"),
                    matchRow());
            }

            String[] alignments = { "左对齐", "居中", "右对齐" };
            alignment = spinner(alignments,
                "center".equals(style.alignment) ? 1 :
                    "right".equals(style.alignment) ? 2 : 0);
            content.addView(labeled("文字对齐", alignment));

            bold = check("粗体", style.textBold);
            italic = check("斜体", style.textItalic);
            content.addView(bold);
            content.addView(italic);

            textColor = colorField("文字颜色", style.textColor);
            content.addView(textColor.root, matchRow());
            fontSize = addSlider(content, "字体大小", 8, 40,
                Math.round(style.fontSizeSp), "sp", value -> { });

            String[] effects = { "无", "描边", "投影" };
            effect = spinner(effects,
                AndroidHudModel.TEXT_EFFECT_OUTLINE.equals(style.textEffect) ? 1 :
                    AndroidHudModel.TEXT_EFFECT_SHADOW.equals(style.textEffect) ? 2 : 0);
            content.addView(labeled("文字效果", effect));
            content.addView(propertyHelp(
                "文字描边/投影只作用于文字；按钮阴影在“按钮阴影”分区单独控制。选择“无”或把强度设为 0 都会完全关闭效果。"),
                matchRow());

            outlinePanel = optionPanel();
            outlineColor = colorField("描边颜色", style.textOutlineColor);
            outlinePanel.addView(outlineColor.root, matchRow());
            outlineWidth = addSlider(outlinePanel, "描边粗细", 0, 6,
                Math.round(style.textOutlineWidthSp), "sp", value -> { });
            content.addView(outlinePanel, matchRow());

            shadowPanel = optionPanel();
            shadowColor = colorField("文字投影颜色", style.textShadowColor);
            shadowPanel.addView(shadowColor.root, matchRow());
            shadowRadius = addSlider(shadowPanel, "文字投影模糊", 0, 12,
                Math.round(style.textShadowRadiusSp), "sp", value -> { });
            shadowOffsetX = addSlider(shadowPanel, "文字投影 X", -12, 12,
                Math.round(style.textShadowOffsetXSp), "sp", value -> { });
            shadowOffsetY = addSlider(shadowPanel, "文字投影 Y", -12, 12,
                Math.round(style.textShadowOffsetYSp), "sp", value -> { });
            content.addView(shadowPanel, matchRow());

            effect.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view,
                        int position, long id) {
                    updateEffectPanels();
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {
                }
            });
            updateEffectPanels();
        }

        void applyTo(AndroidHudModel.Style style) {
            style.alignment = alignment.getSelectedItemPosition() == 1 ?
                "center" : alignment.getSelectedItemPosition() == 2 ? "right" : "left";
            style.sourceColors = sourceColors.isChecked();
            style.textBold = bold.isChecked();
            style.textItalic = italic.isChecked();
            style.textColor = textColor.value;
            style.fontSizeSp = fontSize.value;
            style.textEffect = effect.getSelectedItemPosition() == 1 ?
                AndroidHudModel.TEXT_EFFECT_OUTLINE :
                effect.getSelectedItemPosition() == 2 ?
                    AndroidHudModel.TEXT_EFFECT_SHADOW :
                    AndroidHudModel.TEXT_EFFECT_NONE;
            style.textOutlineColor = outlineColor.value;
            style.textOutlineWidthSp = outlineWidth.value;
            style.textShadowColor = shadowColor.value;
            style.textShadowRadiusSp = shadowRadius.value;
            style.textShadowOffsetXSp = shadowOffsetX.value;
            style.textShadowOffsetYSp = shadowOffsetY.value;
        }

        private void updateEffectPanels() {
            outlinePanel.setVisibility(effect.getSelectedItemPosition() == 1 ?
                View.VISIBLE : View.GONE);
            shadowPanel.setVisibility(effect.getSelectedItemPosition() == 2 ?
                View.VISIBLE : View.GONE);
        }
    }

    private final class ControlAppearanceFields {
        private final CheckBox surface;
        private final ColorField surfaceColor;
        private final ColorField pressedOverlayColor;
        private final CheckBox border;
        private final ColorField borderColor;
        private final SliderField borderWidth;
        private final SliderField cornerRadius;
        private final SliderField selectorWidth;
        private final SliderField buttonGap;
        private final CheckBox shadow;
        private final ColorField shadowColor;
        private final SliderField shadowRadius;
        private final SliderField shadowOffsetX;
        private final SliderField shadowOffsetY;

        ControlAppearanceFields(LinearLayout content,
                AndroidHudModel.ControlAppearance appearance) {
            content.addView(propertySection("按钮表面"), matchRow());
            surface = check("显示按钮表面（关闭后为纯文字控件）",
                appearance.surface);
            content.addView(surface);
            content.addView(propertyHelp(
                "按钮表面由 HUD 自己绘制，不再使用 Android 系统灰色按钮。关闭后不会残留系统阴影。所有颜色均为 #AARRGGBB；点颜色可用 0–255 独立调整该项不透明度。"),
                matchRow());
            surfaceColor = colorField("按钮表面颜色", appearance.surfaceColor);
            pressedOverlayColor = colorField(
                "按下反馈颜色", appearance.pressedOverlayColor);
            content.addView(surfaceColor.root, matchRow());
            content.addView(pressedOverlayColor.root, matchRow());

            border = check("显示按钮边框", appearance.border);
            content.addView(border);
            borderColor = colorField("按钮边框颜色", appearance.borderColor);
            content.addView(borderColor.root, matchRow());
            borderWidth = addSlider(content, "按钮边框宽度", 0, 12,
                Math.round(appearance.borderWidthDp), "dp", value -> { });
            cornerRadius = addSlider(content, "按钮圆角", 0, 64,
                Math.round(appearance.cornerRadiusDp), "dp", value -> { });

            content.addView(propertySection("多动作区"), matchRow());
            selectorWidth = addSlider(content, "动作选择区宽度", 24, 120,
                Math.round(appearance.selectorWidthDp), "dp", value -> { });
            buttonGap = addSlider(content, "主按钮与选择区间距", 0, 32,
                Math.round(appearance.buttonGapDp), "dp", value -> { });

            content.addView(propertySection("按钮阴影"), matchRow());
            shadow = check("显示按钮阴影", appearance.shadow);
            content.addView(shadow);
            content.addView(propertyHelp(
                "按钮阴影与文字效果完全独立。只有开启按钮表面时才绘制；关闭表面后绝不会出现透明按钮残留阴影。模糊为 0 时也会完全关闭。"),
                matchRow());
            shadowColor = colorField("按钮阴影颜色", appearance.shadowColor);
            content.addView(shadowColor.root, matchRow());
            shadowRadius = addSlider(content, "按钮阴影模糊", 0, 32,
                Math.round(appearance.shadowRadiusDp), "dp", value -> { });
            shadowOffsetX = addSlider(content, "按钮阴影 X", -32, 32,
                Math.round(appearance.shadowOffsetXDp), "dp", value -> { });
            shadowOffsetY = addSlider(content, "按钮阴影 Y", -32, 32,
                Math.round(appearance.shadowOffsetYDp), "dp", value -> { });

            surface.setOnCheckedChangeListener((button, checked) ->
                updateVisibility());
            border.setOnCheckedChangeListener((button, checked) ->
                updateVisibility());
            shadow.setOnCheckedChangeListener((button, checked) ->
                updateVisibility());
            updateVisibility();
        }

        void applyTo(AndroidHudModel.ControlAppearance appearance) {
            appearance.surface = surface.isChecked();
            appearance.surfaceColor = surfaceColor.value;
            appearance.pressedOverlayColor = pressedOverlayColor.value;
            appearance.border = border.isChecked();
            appearance.borderColor = borderColor.value;
            appearance.borderWidthDp = borderWidth.value;
            appearance.cornerRadiusDp = cornerRadius.value;
            appearance.selectorWidthDp = selectorWidth.value;
            appearance.buttonGapDp = buttonGap.value;
            appearance.shadow = shadow.isChecked();
            appearance.shadowColor = shadowColor.value;
            appearance.shadowRadiusDp = shadowRadius.value;
            appearance.shadowOffsetXDp = shadowOffsetX.value;
            appearance.shadowOffsetYDp = shadowOffsetY.value;
        }

        private void updateVisibility() {
            boolean hasSurface = surface.isChecked();
            surfaceColor.root.setVisibility(hasSurface ? View.VISIBLE : View.GONE);
            pressedOverlayColor.root.setVisibility(hasSurface ? View.VISIBLE : View.GONE);
            borderColor.root.setVisibility(border.isChecked() ? View.VISIBLE : View.GONE);
            borderWidth.root.setVisibility(border.isChecked() ? View.VISIBLE : View.GONE);
            shadow.setEnabled(hasSurface);
            boolean hasShadow = hasSurface && shadow.isChecked();
            shadowColor.root.setVisibility(hasShadow ? View.VISIBLE : View.GONE);
            shadowRadius.root.setVisibility(hasShadow ? View.VISIBLE : View.GONE);
            shadowOffsetX.root.setVisibility(hasShadow ? View.VISIBLE : View.GONE);
            shadowOffsetY.root.setVisibility(hasShadow ? View.VISIBLE : View.GONE);
        }
    }

    private LinearLayout optionPanel() {
        LinearLayout panel = new LinearLayout(activity);
        panel.setOrientation(LinearLayout.VERTICAL);
        return panel;
    }

    private static final class ColorField {
        final LinearLayout root;
        final Button button;
        int value;

        ColorField(LinearLayout root, Button button, int value) {
            this.root = root;
            this.button = button;
            this.value = value;
        }
    }

    private static final class SliderField {
        final LinearLayout root;
        final SeekBar seek;
        final TextView valueView;
        int value;

        SliderField(LinearLayout root, SeekBar seek, TextView valueView, int value) {
            this.root = root;
            this.seek = seek;
            this.valueView = valueView;
            this.value = value;
        }
    }
}
