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
 * Full-screen schema-4 editor.  All edits stay in a detached draft with
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
                                float side = clamp(startWidth + rawDelta /
                                    Math.max(.001f, overlay.canvasUniformScale()), 32,
                                    Math.min(AndroidHudModel.CANVAS_WIDTH,
                                        AndroidHudModel.CANVAS_HEIGHT));
                                element.frame.width = side;
                                element.frame.height = side;
                            } else {
                                element.frame.width = clamp(startWidth + dx, 32,
                                    AndroidHudModel.CANVAS_WIDTH);
                                element.frame.height = clamp(startHeight + dy, 32,
                                    AndroidHudModel.CANVAS_HEIGHT);
                            }
                        } else {
                            element.frame.x = clamp(startX + dx, 0,
                                AndroidHudModel.CANVAS_WIDTH - element.frame.width);
                            element.frame.y = clamp(startY + dy, 0,
                                AndroidHudModel.CANVAS_HEIGHT - element.frame.height);
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
        List<AndroidHudModel.InfoSource> sources = overlay.infoSources();
        if (sources.isEmpty()) {
            Toast.makeText(activity, "信息源目录尚未就绪，请进入游戏后再试",
                Toast.LENGTH_SHORT).show();
            return;
        }
        ArrayList<AndroidHudSearchDialog.Item<AndroidHudModel.InfoSource>> items =
            new ArrayList<>();
        for (AndroidHudModel.InfoSource source : sources) {
            items.add(new AndroidHudSearchDialog.Item<>(source, source.id,
                source.category + " · " + source.title + "  [" + source.id + "]",
                source.title, source.category, source.renderer));
        }
        AndroidHudSearchDialog.showSingle(activity, "选择信息源",
            "搜索标题、分类或 ID", items, this::addInfo);
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
            info.providerSettings.put("radius", "10");
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
        LinearLayout content = verticalPanel();
        EditText label = textInput(working.label);
        content.addView(labeled("名称", label));

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
        CheckBox showLabel = check("显示名称", working.style.showLabel);
        CheckBox background = check("显示背景", working.style.background);
        CheckBox border = check("显示边框", working.style.border);
        content.addView(visible);
        content.addView(showLabel);
        content.addView(background);
        content.addView(border);

        String[] overflowModes = { "固定", "内容超出时可滑动" };
        Spinner overflow = spinner(overflowModes,
            AndroidHudModel.OVERFLOW_SCROLL.equals(working.overflowMode) ? 1 : 0);
        boolean overflowAvailable = !squareFrame &&
            !AndroidHudModel.TYPE_CONTROL.equals(working.type);
        if (!overflowAvailable) {
            overflow.setSelection(0);
            overflow.setEnabled(false);
        }
        content.addView(labeled("内容行为", overflow));

        String[] alignments = { "左对齐", "居中", "右对齐" };
        Spinner alignment = spinner(alignments,
            "center".equals(working.style.alignment) ? 1 :
                "right".equals(working.style.alignment) ? 2 : 0);
        content.addView(labeled("对齐", alignment));

        CheckBox bold = check("粗体", working.style.textBold);
        CheckBox italic = check("斜体", working.style.textItalic);
        CheckBox outline = check("文字描边", working.style.textOutline);
        content.addView(bold);
        content.addView(italic);
        content.addView(outline);

        ColorField textColor = colorField("文字颜色", working.style.textColor);
        ColorField outlineColor = colorField("描边颜色", working.style.textOutlineColor);
        ColorField backgroundColor =
            colorField("背景颜色", working.style.backgroundColor);
        ColorField borderColor = colorField("边框颜色", working.style.borderColor);
        content.addView(textColor.root, matchRow());
        content.addView(outlineColor.root, matchRow());
        content.addView(backgroundColor.root, matchRow());
        content.addView(borderColor.root, matchRow());

        float[] styleValues = {
            working.style.opacity,
            working.style.fontSizeSp,
            working.style.textOutlineWidthSp
        };
        addSlider(content, "不透明度", 10, 100,
            Math.round(styleValues[0] * 100), "%",
            value -> styleValues[0] = value / 100f);
        addSlider(content, "字体", 8, 40, Math.round(styleValues[1]), "sp",
            value -> styleValues[1] = value);
        addSlider(content, "描边粗细", 1, 6, Math.round(styleValues[2]), "sp",
            value -> styleValues[2] = value);

        CheckBox clip = null;
        Spinner selectorMode = null;
        LinkedHashMap<String, CheckBox> riskAuthorizationChecks = new LinkedHashMap<>();
        if (AndroidHudModel.TYPE_GROUP.equals(working.type)) {
            clip = check("裁剪超出组边界的子元素", working.clipChildren);
            content.addView(clip);
        }
        if (AndroidHudModel.TYPE_INFO.equals(working.type) &&
                "radar.threat_grid".equals(working.sourceId)) {
            EditText radius = textInput(working.providerSettings.get("radius"));
            radius.setInputType(InputType.TYPE_CLASS_NUMBER);
            content.addView(labeled("雷达半径（3–30 格）", radius));
            radius.setTag("radius");
        }
        if (AndroidHudModel.TYPE_CONTROL.equals(working.type)) {
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
            content.addView(propertySection(AndroidHudModel.TYPE_INFO.equals(working.type) ?
                "点击交互" : "控件动作"), matchRow());
            if (AndroidHudModel.TYPE_INFO.equals(working.type)) {
                content.addView(propertyHelp(
                    "未绑定时信息只负责显示；绑定一个动作时点击直接触发，绑定多个动作时点击弹出选择菜单。"),
                    matchRow());
            }
            content.addView(actions, matchRow());
            content.addView(propertySection("高风险动作授权"), matchRow());
            content.addView(propertyHelp(
                "勾选只代表允许该元素触发；运行时仍必须长按。多动作信息需长按打开菜单后选择，游戏原有确认不会被绕过。"),
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
            .setTitle("元素属性")
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
                    AndroidHudModel.CANVAS_WIDTH - working.frame.width);
                working.frame.y = parseFloat(y, working.frame.y, 0,
                    AndroidHudModel.CANVAS_HEIGHT - working.frame.height);
                working.visible = visible.isChecked();
                working.overflowMode = overflowAvailable &&
                    overflow.getSelectedItemPosition() == 1 ?
                    AndroidHudModel.OVERFLOW_SCROLL : AndroidHudModel.OVERFLOW_FIXED;
                working.style.showLabel = showLabel.isChecked();
                working.style.background = background.isChecked();
                working.style.border = border.isChecked();
                working.style.alignment = alignment.getSelectedItemPosition() == 1 ?
                    "center" : alignment.getSelectedItemPosition() == 2 ? "right" : "left";
                working.style.textColor = textColor.value;
                working.style.textOutlineColor = outlineColor.value;
                working.style.backgroundColor = backgroundColor.value;
                working.style.borderColor = borderColor.value;
                working.style.opacity = styleValues[0];
                working.style.fontSizeSp = styleValues[1];
                working.style.textOutlineWidthSp = styleValues[2];
                working.style.textBold = bold.isChecked();
                working.style.textItalic = italic.isChecked();
                working.style.textOutline = outline.isChecked();
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
                    working.providerSettings.put("radius", String.valueOf(radius));
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
        String title = AndroidHudModel.TYPE_INFO.equals(working.type) ?
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
        root.addView(label, new LinearLayout.LayoutParams(dp(96),
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

    private void addSlider(LinearLayout content, String label, int minimum, int maximum,
            int current, String suffix, SliderCallback callback) {
        LinearLayout row = new LinearLayout(activity);
        row.setOrientation(LinearLayout.HORIZONTAL);
        row.setGravity(Gravity.CENTER_VERTICAL);
        TextView title = new TextView(activity);
        title.setText(label);
        row.addView(title, new LinearLayout.LayoutParams(dp(88),
            ViewGroup.LayoutParams.WRAP_CONTENT));
        SeekBar seek = new SeekBar(activity);
        seek.setMax(maximum - minimum);
        seek.setProgress(Math.max(0, Math.min(maximum - minimum, current - minimum)));
        TextView value = new TextView(activity);
        value.setText(current + suffix);
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                int actual = progress + minimum;
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
}
