package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Color;
import android.graphics.Typeface;
import android.text.InputType;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Android touch editor for the fixed scene -> layout -> element hierarchy.
 * It only edits configuration.  Action execution remains in LuaUiOverlay's
 * revision-checked native action queue.
 */
final class LuaHudEditorDialog {
    private final CataclysmDDA activity;
    private final LuaUiOverlay overlay;
    private final LuaHudLayoutStore store;
    private AlertDialog currentDialog;

    LuaHudEditorDialog(CataclysmDDA activity, LuaUiOverlay overlay,
            LuaHudLayoutStore store) {
        this.activity = activity;
        this.overlay = overlay;
        this.store = store;
    }

    void showScenes() {
        LinearLayout content = verticalPanel();
        TextView hint = text("场景由游戏输入上下文决定，不能伪造。每个场景和屏幕方向可以使用不同布局。");
        hint.setTextColor(0xFFB6C6CE);
        content.addView(hint);

        String current = overlay.currentSceneId();
        for (String scene : store.scenes()) {
            Button button = touchButton((scene.equals(current) ? "● " : "") +
                store.sceneTitle(scene));
            button.setOnClickListener(view -> showLayouts(scene));
            content.addView(button, matchRow());
        }

        TextView packageTitle = text("布局包");
        packageTitle.setTypeface(Typeface.DEFAULT, Typeface.BOLD);
        packageTitle.setPadding(0, dp(12), 0, dp(4));
        content.addView(packageTitle);
        LinearLayout packageRow = new LinearLayout(activity);
        packageRow.setOrientation(LinearLayout.HORIZONTAL);
        Button importButton = touchButton("导入");
        importButton.setOnClickListener(view -> overlay.requestLayoutImport());
        packageRow.addView(importButton, weightedRow());
        Button exportButton = touchButton("导出");
        exportButton.setOnClickListener(view -> overlay.requestLayoutExport());
        packageRow.addView(exportButton, weightedRow());
        Button shareButton = touchButton("分享");
        shareButton.setOnClickListener(view -> overlay.requestLayoutShare());
        packageRow.addView(shareButton, weightedRow());
        content.addView(packageRow, matchRow());

        showReplacing(showScrollableDialog("Lua HUD · 场景", content)
            .setNegativeButton("关闭", null)
            .create());
    }

    private void showLayouts(final String scene) {
        LinearLayout content = verticalPanel();
        String orientation = overlay.currentOrientationId();
        String activeId = store.activeLayoutId(scene, orientation);
        TextView subtitle = text(store.sceneTitle(scene) + " · " +
            ("portrait".equals(orientation) ? "竖屏" : "横屏"));
        subtitle.setTextColor(0xFF9FB9C5);
        content.addView(subtitle);

        for (LuaHudLayoutStore.Layout layout : store.layouts(scene, orientation)) {
            LinearLayout row = new LinearLayout(activity);
            row.setOrientation(LinearLayout.HORIZONTAL);
            Button activate = touchButton((layout.id.equals(activeId) ? "✓ " : "") + layout.name);
            activate.setGravity(Gravity.CENTER_VERTICAL | Gravity.LEFT);
            activate.setOnClickListener(view -> {
                overlay.activateLayout(scene, layout.id);
                Toast.makeText(activity, "已切换到 " + layout.name, Toast.LENGTH_SHORT).show();
                showLayouts(scene);
            });
            row.addView(activate, new LinearLayout.LayoutParams(0, dp(52), 1f));
            Button edit = touchButton(layout.official ? "复制编辑" : "管理");
            edit.setTextSize(12f);
            edit.setOnClickListener(view -> {
                if (layout.official) {
                    overlay.editLayout(scene, layout.id);
                } else {
                    showLayoutActions(scene, layout);
                }
            });
            row.addView(edit, new LinearLayout.LayoutParams(dp(92), dp(52)));
            content.addView(row, matchRow());
        }

        Button add = touchButton("＋ 从当前布局创建副本");
        add.setOnClickListener(view -> showCreateLayout(scene));
        content.addView(add, matchRow());

        returnToScenesDialog("Lua HUD · 布局", content, scene);
    }

    private void showLayoutActions(final String scene, final LuaHudLayoutStore.Layout layout) {
        String[] actions = { "在画面上编辑", "重命名", "删除布局" };
        showReplacing(new AlertDialog.Builder(activity)
            .setTitle(layout.name)
            .setItems(actions, (dialog, which) -> {
                if (which == 0) {
                    overlay.editLayout(scene, layout.id);
                } else if (which == 1) {
                    showRenameLayout(scene, layout);
                } else {
                    confirmDeleteLayout(scene, layout);
                }
            })
            .setNegativeButton("取消", null)
            .create());
    }

    private void showCreateLayout(final String scene) {
        final EditText name = nameInput("自定义布局");
        showReplacing(new AlertDialog.Builder(activity)
            .setTitle("新建布局")
            .setMessage("新布局会复制当前布局，之后可以独立移动、缩放和增删按键。")
            .setView(name)
            .setPositiveButton("创建并编辑", (dialog, which) -> {
                LuaHudLayoutStore.Layout created =
                    overlay.createLayoutCopy(scene, name.getText().toString());
                if (created == null) {
                    Toast.makeText(activity, "无法创建更多布局", Toast.LENGTH_SHORT).show();
                } else {
                    overlay.editLayout(scene, created.id);
                }
            })
            .setNegativeButton("取消", null)
            .create());
    }

    private void showRenameLayout(final String scene, final LuaHudLayoutStore.Layout layout) {
        final EditText name = nameInput(layout.name);
        showReplacing(new AlertDialog.Builder(activity)
            .setTitle("重命名布局")
            .setView(name)
            .setPositiveButton("保存", (dialog, which) -> {
                store.renameLayout(scene, overlay.currentOrientationId(), layout.id,
                    name.getText().toString());
                showLayouts(scene);
            })
            .setNegativeButton("取消", null)
            .create());
    }

    private void confirmDeleteLayout(final String scene, final LuaHudLayoutStore.Layout layout) {
        showReplacing(new AlertDialog.Builder(activity)
            .setTitle("删除“" + layout.name + "”？")
            .setMessage("删除后不可恢复；导出的布局包不受影响。")
            .setPositiveButton("删除", (dialog, which) -> {
                if (store.deleteLayout(scene, overlay.currentOrientationId(), layout.id)) {
                    overlay.activateLayout(scene, LuaHudLayoutStore.OFFICIAL_LAYOUT_ID);
                    showLayouts(scene);
                }
            })
            .setNegativeButton("取消", null)
            .create());
    }

    void showAddButton() {
        if (overlay.availableHudActions().isEmpty()) {
            Toast.makeText(activity, "当前场景还没有可安全绑定的动作", Toast.LENGTH_SHORT).show();
            return;
        }
        showActionEditor(null);
    }

    void showButtonList() {
        final List<LuaUiOverlay.ButtonBinding> buttons = overlay.editableButtons();
        if (buttons.isEmpty()) {
            Toast.makeText(activity, "当前布局还没有可编辑按键", Toast.LENGTH_SHORT).show();
            return;
        }
        String[] labels = new String[buttons.size()];
        for (int i = 0; i < buttons.size(); ++i) {
            LuaUiOverlay.ButtonBinding binding = buttons.get(i);
            labels[i] = (binding.custom ? "自定义 · " : "Lua · ") + binding.title;
        }
        showReplacing(new AlertDialog.Builder(activity)
            .setTitle("编辑按键")
            .setItems(labels, (dialog, which) -> showActionEditor(buttons.get(which)))
            .setNegativeButton("取消", null)
            .create());
    }

    void showElementVisibility() {
        final List<LuaUiOverlay.ElementBinding> elements = overlay.editableElements();
        if (elements.isEmpty()) {
            Toast.makeText(activity, "当前布局没有可管理元素", Toast.LENGTH_SHORT).show();
            return;
        }
        String[] labels = new String[elements.size()];
        final boolean[] visible = new boolean[elements.size()];
        for (int i = 0; i < elements.size(); ++i) {
            labels[i] = elements.get(i).title;
            visible[i] = elements.get(i).visible;
        }
        showReplacing(new AlertDialog.Builder(activity)
            .setTitle("显示元素")
            .setMultiChoiceItems(labels, visible,
                (dialog, which, checked) -> visible[which] = checked)
            .setPositiveButton("保存",
                (dialog, which) -> overlay.setElementVisibility(elements, visible))
            .setNegativeButton("取消", null)
            .create());
    }

    private void showActionEditor(final LuaUiOverlay.ButtonBinding binding) {
        final List<LuaUiOverlay.HudAction> actions = overlay.availableHudActions();
        final Set<String> checked = new HashSet<>();
        if (binding != null) checked.addAll(binding.actions);

        LinearLayout content = verticalPanel();
        final EditText label = nameInput(binding == null ? "" : binding.label);
        label.setHint("自定义显示文字（留空则显示当前动作）");
        content.addView(label, new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(52)));
        TextView help = text("选择一个或多个动作。只有一个动作时不显示切换区；多个动作时会出现小切换按钮。");
        help.setTextColor(0xFFB6C6CE);
        content.addView(help);

        String lastGroup = "";
        for (LuaUiOverlay.HudAction action : actions) {
            if (!action.group.equals(lastGroup)) {
                TextView group = text(groupTitle(action.group));
                group.setTypeface(Typeface.DEFAULT, Typeface.BOLD);
                group.setTextColor(0xFF80CBC4);
                group.setPadding(0, dp(12), 0, dp(2));
                content.addView(group);
                lastGroup = action.group;
            }
            CheckBox choice = new CheckBox(activity);
            choice.setText(action.label + "  [" + action.id + "]");
            choice.setTextColor(Color.WHITE);
            choice.setChecked(checked.contains(action.id));
            choice.setMinHeight(dp(48));
            choice.setOnCheckedChangeListener((button, selected) -> {
                if (selected) checked.add(action.id);
                else checked.remove(action.id);
            });
            content.addView(choice, matchRow());
        }

        AlertDialog dialog = showScrollableDialog(
            binding == null ? "添加按键" : "配置按键", content)
            .setPositiveButton("保存", null)
            .setNegativeButton("取消", null)
            .setNeutralButton(binding == null ? null :
                (binding.custom ? "删除按键" : "恢复 Lua 默认"), null)
            .create();
        dialog.setOnShowListener(ignored -> {
            dialog.getButton(DialogInterface.BUTTON_POSITIVE).setOnClickListener(view -> {
                ArrayList<String> selected = new ArrayList<>();
                for (LuaUiOverlay.HudAction action : actions) {
                    if (checked.contains(action.id)) selected.add(action.id);
                }
                if (selected.isEmpty()) {
                    Toast.makeText(activity, "至少选择一个动作", Toast.LENGTH_SHORT).show();
                    return;
                }
                if (binding == null) overlay.addCustomButton(selected, label.getText().toString());
                else overlay.configureButton(binding, selected, label.getText().toString());
                dialog.dismiss();
            });
            if (binding != null) {
                dialog.getButton(DialogInterface.BUTTON_NEUTRAL).setOnClickListener(view -> {
                    overlay.removeButton(binding);
                    dialog.dismiss();
                });
            }
        });
        showReplacing(dialog);
    }

    private void returnToScenesDialog(String title, LinearLayout content, String scene) {
        showReplacing(showScrollableDialog(title, content)
            .setPositiveButton("编辑当前布局", (dialog, which) -> {
                String active = store.activeLayoutId(scene, overlay.currentOrientationId());
                overlay.editLayout(scene, active);
            })
            .setNeutralButton("返回场景", (dialog, which) -> showScenes())
            .setNegativeButton("关闭", null)
            .create());
    }

    private void showReplacing(AlertDialog dialog) {
        AlertDialog previous = currentDialog;
        currentDialog = null;
        if (previous != null && previous.isShowing()) previous.dismiss();
        currentDialog = dialog;
        dialog.setOnDismissListener(ignored -> {
            if (currentDialog == dialog) currentDialog = null;
        });
        dialog.show();
    }

    private AlertDialog.Builder showScrollableDialog(String title, LinearLayout content) {
        ScrollView scroll = new ScrollView(activity);
        scroll.setFillViewport(true);
        scroll.addView(content, new ScrollView.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return new AlertDialog.Builder(activity).setTitle(title).setView(scroll);
    }

    private LinearLayout verticalPanel() {
        LinearLayout content = new LinearLayout(activity);
        content.setOrientation(LinearLayout.VERTICAL);
        content.setPadding(dp(14), dp(8), dp(14), dp(12));
        return content;
    }

    private TextView text(String value) {
        TextView text = new TextView(activity);
        text.setText(value);
        text.setTextColor(Color.WHITE);
        text.setTextSize(14f);
        text.setPadding(dp(4), dp(5), dp(4), dp(5));
        return text;
    }

    private Button touchButton(String value) {
        Button button = new Button(activity);
        button.setText(value);
        button.setTextColor(Color.WHITE);
        button.setTextSize(14f);
        button.setAllCaps(false);
        button.setMinHeight(0);
        button.setMinimumHeight(0);
        button.setMinWidth(0);
        button.setMinimumWidth(0);
        return button;
    }

    private EditText nameInput(String value) {
        EditText input = new EditText(activity);
        input.setText(value);
        input.setSelectAllOnFocus(true);
        input.setSingleLine(true);
        input.setInputType(InputType.TYPE_CLASS_TEXT);
        input.setTextColor(Color.WHITE);
        input.setHintTextColor(0xFF90A4AE);
        int padding = dp(12);
        input.setPadding(padding, dp(6), padding, dp(6));
        return input;
    }

    private LinearLayout.LayoutParams matchRow() {
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, dp(52));
        params.setMargins(0, dp(2), 0, dp(2));
        return params;
    }

    private LinearLayout.LayoutParams weightedRow() {
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, dp(50), 1f);
        params.setMargins(dp(2), 0, dp(2), 0);
        return params;
    }

    private String groupTitle(String group) {
        if ("navigation".equals(group)) return "导航";
        if ("primary".equals(group)) return "主要操作";
        if ("combat".equals(group)) return "战斗";
        if ("items".equals(group)) return "物品";
        if ("world".equals(group)) return "世界";
        if ("character".equals(group)) return "角色";
        if ("system".equals(group)) return "系统";
        if ("text".equals(group)) return "文本";
        return "当前场景";
    }

    private int dp(int value) {
        return Math.round(value * activity.getResources().getDisplayMetrics().density);
    }
}
