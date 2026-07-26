package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONException;

import java.util.List;

/** Scene/layout manager and import preview flow. */
final class AndroidHudManagerDialog {
    private final CataclysmDDA activity;
    private final AndroidHudOverlay overlay;
    private final AndroidHudRepository repository;
    private AlertDialog current;

    AndroidHudManagerDialog(CataclysmDDA activity, AndroidHudOverlay overlay,
            AndroidHudRepository repository) {
        this.activity = activity;
        this.overlay = overlay;
        this.repository = repository;
    }

    void showScenes() {
        dismiss();
        LinearLayout content = panel();
        TextView help = text("每个游戏界面是一个独立场景；每个场景可保存并激活多个布局。"
            + " 新场景只创建完全空白的布局。");
        help.setTextColor(0xFFB6C6CE);
        content.addView(help, row());

        List<AndroidHudModel.Scene> scenes = repository.scenes();
        if (scenes.isEmpty()) {
            TextView empty = text("尚未记录场景。进入任意游戏界面后会出现一个空白场景。");
            empty.setPadding(0, dp(16), 0, dp(16));
            content.addView(empty, row());
        }
        for (AndroidHudModel.Scene scene : scenes) {
            Button button = touchButton((scene.id.equals(overlay.currentSceneId()) ? "● " : "") +
                scene.title + "\n" + scene.layouts.size() + " 个布局 · " + scene.id);
            button.setGravity(Gravity.LEFT | Gravity.CENTER_VERTICAL);
            button.setOnClickListener(view -> showLayouts(scene.id));
            content.addView(button, row());
        }

        content.addView(section("导入、导出与备份"), row());
        LinearLayout packageActions = horizontal();
        Button importAll = touchButton("导入 JSON");
        importAll.setOnClickListener(view -> activity.importHudLayout());
        packageActions.addView(importAll, weighted());
        Button exportAll = touchButton("导出整包");
        exportAll.setOnClickListener(view -> activity.exportHudLayout(
            repository.exportPackage(), "cataclysm-android-hud-package.json"));
        packageActions.addView(exportAll, weighted());
        Button shareAll = touchButton("分享整包");
        shareAll.setOnClickListener(view -> activity.shareHudLayout(repository.exportPackage()));
        packageActions.addView(shareAll, weighted());
        content.addView(packageActions, row());

        show("Android HUD · 场景", content, null);
    }

    void previewImport(String raw) {
        final AndroidHudRepository.ImportPlan plan;
        try {
            plan = repository.inspectImport(raw);
        } catch (JSONException error) {
            Toast.makeText(activity,
                "无法导入：仅支持经过校验的 schema 4/5 HUD JSON",
                Toast.LENGTH_LONG).show();
            return;
        }
        String summary = (plan.single ? "单布局" : "完整布局包") + "\n" +
            "场景：" + plan.sceneCount + "\n" +
            "布局：" + plan.layoutCount + "\n" +
            "元素：" + plan.elementCount;
        if (plan.single) {
            new AlertDialog.Builder(activity)
                .setTitle("导入预览")
                .setMessage(summary + "\n\n该布局将合并到场景“" +
                    plan.sourceScene.title + "”。")
                .setPositiveButton("合并导入", (dialog, which) ->
                    applyImport(plan, AndroidHudRepository.ImportMode.MERGE))
                .setNegativeButton("取消", null)
                .show();
            return;
        }
        String[] actions = { "合并：保留本机布局", "整体替换：删除当前 schema 5 布局" };
        new AlertDialog.Builder(activity)
            .setTitle("整包导入预览")
            .setMessage(summary)
            .setItems(actions, (dialog, which) -> {
                if (which == 0) {
                    applyImport(plan, AndroidHudRepository.ImportMode.MERGE);
                } else {
                    confirmReplace(plan);
                }
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void showLayouts(String sceneId) {
        dismiss();
        AndroidHudModel.Scene scene = repository.scene(sceneId);
        if (scene == null) {
            showScenes();
            return;
        }
        LinearLayout content = panel();
        for (AndroidHudModel.Layout layout : scene.layouts.values()) {
            LinearLayout row = horizontal();
            Button select = touchButton((layout.id.equals(scene.activeLayoutId) ? "● " : "") +
                layout.name + "\n" + layout.elementCount() + " 个元素");
            select.setGravity(Gravity.LEFT | Gravity.CENTER_VERTICAL);
            select.setOnClickListener(view -> showLayoutActions(scene.id, layout.id));
            row.addView(select, new LinearLayout.LayoutParams(0, dp(64), 1f));
            if (!layout.id.equals(scene.activeLayoutId)) {
                Button activate = touchButton("启用");
                activate.setOnClickListener(view -> {
                    repository.activateLayout(scene.id, layout.id);
                    overlay.reloadFromRepository();
                    showLayouts(scene.id);
                });
                row.addView(activate, new LinearLayout.LayoutParams(dp(76), dp(64)));
            }
            content.addView(row, row());
        }

        content.addView(section("创建"), row());
        LinearLayout create = horizontal();
        Button blank = touchButton("＋ 空白布局");
        blank.setOnClickListener(view -> createLayout(scene.id, false));
        create.addView(blank, weighted());
        Button duplicate = touchButton("复制当前布局");
        duplicate.setOnClickListener(view -> createLayout(scene.id, true));
        create.addView(duplicate, weighted());
        content.addView(create, row());
        if (AndroidHudOfficialTemplates.forScene(scene.id) != null) {
            Button official = touchButton("＋ 从官方 CCB 信息模板创建");
            official.setOnClickListener(view -> {
                AndroidHudModel.Layout created =
                    repository.createOfficialLayout(scene.id);
                if (created == null) {
                    Toast.makeText(activity, "无法创建官方模板",
                        Toast.LENGTH_SHORT).show();
                    return;
                }
                overlay.editLayout(scene.id, created.id);
            });
            content.addView(official, row());
        }

        show("布局 · " + scene.title, content, (dialog, which) -> showScenes());
    }

    private void showLayoutActions(String sceneId, String layoutId) {
        AndroidHudModel.Scene scene = repository.scene(sceneId);
        AndroidHudModel.Layout layout = repository.layout(sceneId, layoutId);
        if (scene == null || layout == null) {
            showLayouts(sceneId);
            return;
        }
        String[] actions = {
            "编辑布局",
            "启用布局",
            "复制布局",
            "重命名",
            "导出单个布局",
            "分享单个布局",
            "删除布局"
        };
        dismiss();
        current = new AlertDialog.Builder(activity)
            .setTitle(layout.name)
            .setItems(actions, (dialog, which) -> {
                switch (which) {
                    case 0:
                        overlay.editLayout(sceneId, layoutId);
                        break;
                    case 1:
                        repository.activateLayout(sceneId, layoutId);
                        overlay.reloadFromRepository();
                        showLayouts(sceneId);
                        break;
                    case 2:
                        AndroidHudModel.Layout copy = repository.createLayout(sceneId,
                            layout.name + " 副本", layoutId);
                        if (copy != null) {
                            overlay.editLayout(sceneId, copy.id);
                        }
                        break;
                    case 3:
                        renameLayout(sceneId, layout);
                        break;
                    case 4:
                        activity.exportHudLayout(repository.exportLayout(sceneId, layoutId),
                            "cataclysm-android-hud-" + layoutId + ".json");
                        break;
                    case 5:
                        activity.shareHudLayout(repository.exportLayout(sceneId, layoutId));
                        break;
                    case 6:
                        confirmDelete(sceneId, layout);
                        break;
                    default:
                        break;
                }
            })
            .setNegativeButton("返回", (dialog, which) -> showLayouts(sceneId))
            .create();
        current.show();
    }

    private void createLayout(String sceneId, boolean duplicate) {
        AndroidHudModel.Scene scene = repository.scene(sceneId);
        if (scene == null) {
            return;
        }
        EditText name = input(duplicate ? "当前布局副本" : "空白布局");
        new AlertDialog.Builder(activity)
            .setTitle(duplicate ? "复制布局" : "新建空白布局")
            .setView(name)
            .setPositiveButton("创建并编辑", (dialog, which) -> {
                AndroidHudModel.Layout created = repository.createLayout(sceneId,
                    name.getText().toString(), duplicate ? scene.activeLayoutId : "");
                if (created == null) {
                    Toast.makeText(activity, "无法创建更多布局", Toast.LENGTH_SHORT).show();
                    return;
                }
                overlay.editLayout(sceneId, created.id);
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void renameLayout(String sceneId, AndroidHudModel.Layout layout) {
        EditText name = input(layout.name);
        new AlertDialog.Builder(activity)
            .setTitle("重命名布局")
            .setView(name)
            .setPositiveButton("保存", (dialog, which) -> {
                repository.renameLayout(sceneId, layout.id, name.getText().toString());
                showLayouts(sceneId);
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void confirmDelete(String sceneId, AndroidHudModel.Layout layout) {
        new AlertDialog.Builder(activity)
            .setTitle("删除“" + layout.name + "”？")
            .setMessage("若这是最后一个布局，系统只会新建一个空白布局。")
            .setPositiveButton("删除", (dialog, which) -> {
                repository.deleteLayout(sceneId, layout.id);
                overlay.reloadFromRepository();
                showLayouts(sceneId);
            })
            .setNegativeButton("取消", null)
            .show();
    }

    private void confirmReplace(AndroidHudRepository.ImportPlan plan) {
        new AlertDialog.Builder(activity)
            .setTitle("整体替换当前 HUD？")
            .setMessage("当前 schema 5 的全部场景与布局会被导入包替换。旧布局归档不会受影响。")
            .setPositiveButton("确认替换", (dialog, which) ->
                applyImport(plan, AndroidHudRepository.ImportMode.REPLACE))
            .setNegativeButton("取消", null)
            .show();
    }

    private void applyImport(AndroidHudRepository.ImportPlan plan,
            AndroidHudRepository.ImportMode mode) {
        if (repository.applyImport(plan, mode)) {
            overlay.reloadFromRepository();
            Toast.makeText(activity, "HUD 布局已导入", Toast.LENGTH_SHORT).show();
            showScenes();
        } else {
            Toast.makeText(activity, "导入失败：目标已满或内容无效", Toast.LENGTH_LONG).show();
        }
    }

    private void show(String title, LinearLayout content,
            DialogInterface.OnClickListener back) {
        AlertDialog.Builder builder = new AlertDialog.Builder(activity)
            .setTitle(title)
            .setView(scroll(content));
        if (back == null) {
            builder.setNegativeButton("关闭", null);
        } else {
            builder.setNegativeButton("返回", back);
        }
        current = builder.create();
        current.show();
    }

    private void dismiss() {
        if (current != null && current.isShowing()) {
            current.dismiss();
        }
        current = null;
    }

    private LinearLayout panel() {
        LinearLayout content = new LinearLayout(activity);
        content.setOrientation(LinearLayout.VERTICAL);
        content.setPadding(dp(16), dp(8), dp(16), dp(16));
        return content;
    }

    private LinearLayout horizontal() {
        LinearLayout row = new LinearLayout(activity);
        row.setOrientation(LinearLayout.HORIZONTAL);
        row.setGravity(Gravity.CENTER_VERTICAL);
        return row;
    }

    private ScrollView scroll(View content) {
        ScrollView scroll = new ScrollView(activity);
        scroll.setFillViewport(true);
        scroll.addView(content, new ScrollView.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return scroll;
    }

    private TextView text(String value) {
        TextView text = new TextView(activity);
        text.setText(value);
        text.setTextSize(14f);
        return text;
    }

    private TextView section(String value) {
        TextView text = text(value);
        text.setTextColor(0xFF80CBC4);
        text.setPadding(0, dp(14), 0, dp(4));
        return text;
    }

    private Button touchButton(String value) {
        Button button = new Button(activity);
        button.setText(value);
        button.setAllCaps(false);
        button.setMinHeight(dp(52));
        return button;
    }

    private EditText input(String value) {
        EditText input = new EditText(activity);
        input.setText(value);
        input.setSingleLine(true);
        input.setInputType(InputType.TYPE_CLASS_TEXT);
        input.setSelectAllOnFocus(true);
        return input;
    }

    private LinearLayout.LayoutParams row() {
        return new LinearLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
    }

    private LinearLayout.LayoutParams weighted() {
        return new LinearLayout.LayoutParams(0, dp(56), 1f);
    }

    private int dp(int value) {
        return Math.round(value * activity.getResources().getDisplayMetrics().density);
    }
}
