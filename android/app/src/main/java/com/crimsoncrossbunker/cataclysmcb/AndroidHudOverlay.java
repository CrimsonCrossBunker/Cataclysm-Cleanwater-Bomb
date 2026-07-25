package com.crimsoncrossbunker.cataclysmcb;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.GradientDrawable;
import android.os.Handler;
import android.os.SystemClock;
import android.util.Log;
import android.view.GestureDetector;
import android.view.Gravity;
import android.view.HapticFeedbackConstants;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Schema-4 Android HUD runtime and canvas.
 *
 * The model, repository, renderer registry, editor and manager are separate
 * modules.  This class only coordinates immutable native snapshots with a
 * recursively-rendered element tree.
 */
final class AndroidHudOverlay extends FrameLayout {
    private static final String TAG = "AndroidHudOverlay";
    private static final long POLL_INTERVAL_MS = 100L;
    private static final long THREE_FINGER_HOLD_MS = 650L;

    private final CataclysmDDA activity;
    private final AndroidHudRepository repository;
    private final AndroidHudRendererRegistry rendererRegistry =
        new AndroidHudRendererRegistry();
    private final AndroidHudEditor editor;
    private final AndroidHudManagerDialog manager;
    private final Handler handler = new Handler();
    private final Paint gridPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final LinkedHashMap<String, AndroidHudModel.InfoSource> sourceCatalog =
        new LinkedHashMap<>();
    private final Map<String, RenderedElement> rendered = new HashMap<>();
    private final Runnable poller = new Runnable() {
        @Override
        public void run() {
            refreshSnapshot();
            if (started) {
                handler.postDelayed(this, POLL_INTERVAL_MS);
            }
        }
    };
    private final Runnable threeFingerHold = new Runnable() {
        @Override
        public void run() {
            if (!threeFingerTracking || editor.isEditing()) {
                return;
            }
            threeFingerTracking = false;
            activity.cancelActiveGameTouch();
            if (currentSceneId.isEmpty()) {
                showManager();
            } else {
                editActiveScene();
            }
        }
    };

    private AndroidHudSnapshot snapshot = AndroidHudSnapshot.empty();
    private AndroidHudModel.Layout displayedLayout;
    private String displayedSceneId = "";
    private String currentSceneId = "";
    private String currentSceneTitle = "";
    private String lastSubscriptions = "";
    private int lastSnapshotRevision = -1;
    private boolean started;
    private boolean threeFingerTracking;
    private float gestureStartX;
    private float gestureStartY;
    private View activeMinimapView;

    AndroidHudOverlay(CataclysmDDA activity) {
        super(activity);
        this.activity = activity;
        repository = new AndroidHudRepository(activity);
        editor = new AndroidHudEditor(activity, this, repository);
        manager = new AndroidHudManagerDialog(activity, this, repository);
        setClipChildren(true);
        setClipToPadding(true);
        setWillNotDraw(false);
        setClickable(false);
        gridPaint.setStrokeWidth(dp(1));
        gridPaint.setColor(0x335A7184);
    }

    void start() {
        if (started) {
            return;
        }
        started = true;
        handler.post(poller);
    }

    void stop() {
        started = false;
        handler.removeCallbacks(poller);
        cancelThreeFingerGesture();
        for (RenderedElement entry : rendered.values()) {
            if (entry.content instanceof ControlView) {
                ((ControlView)entry.content).cancelRepeat();
            }
            entry.host.clearRuntimeInteraction();
        }
        activity.setHudMinimapRect(0, 0, 0, 0, false);
    }

    void showManager() {
        manager.showScenes();
    }

    AndroidHudSnapshot runtimeSnapshot() {
        return snapshot;
    }

    List<AndroidHudModel.InfoSource> infoSources() {
        return new ArrayList<>(sourceCatalog.values());
    }

    String currentSceneId() {
        return currentSceneId;
    }

    String currentSceneTitle() {
        return currentSceneTitle;
    }

    boolean isCurrentScene(String sceneId) {
        return snapshot.ready && currentSceneId.equals(sceneId);
    }

    float canvasScaleX() {
        return getWidth() / (float)AndroidHudModel.CANVAS_WIDTH;
    }

    float canvasScaleY() {
        return getHeight() / (float)AndroidHudModel.CANVAS_HEIGHT;
    }

    float canvasUniformScale() {
        return Math.min(canvasScaleX(), canvasScaleY());
    }

    void editLayout(String sceneId, String layoutId) {
        AndroidHudModel.Layout layout = repository.layout(sceneId, layoutId);
        AndroidHudModel.Scene scene = repository.scene(sceneId);
        if (layout == null || scene == null) {
            Toast.makeText(activity, "布局已发生变化，请重新选择", Toast.LENGTH_SHORT).show();
            return;
        }
        editor.begin(scene, layout, !isCurrentScene(sceneId));
    }

    void editActiveScene() {
        AndroidHudModel.Scene scene = repository.scene(currentSceneId);
        AndroidHudModel.Layout layout = repository.activeLayout(currentSceneId);
        if (scene == null || layout == null) {
            showManager();
            return;
        }
        editor.begin(scene, layout, false);
    }

    void displayEditorDraft(String sceneId, AndroidHudModel.Layout draft) {
        displayedSceneId = sceneId;
        displayedLayout = draft;
        rebuildTree();
    }

    void finishEditing(boolean committed) {
        displayedSceneId = currentSceneId;
        displayedLayout = repository.activeLayout(currentSceneId);
        rebuildTree();
        invalidate();
        if (committed) {
            Toast.makeText(activity, "HUD 布局已保存", Toast.LENGTH_SHORT).show();
        }
    }

    void refreshEditorDraft() {
        displayedLayout = editor.draft();
        rebuildTree();
    }

    void relayoutEditorDraft() {
        layoutRenderedTree();
        invalidate();
    }

    RenderedElement renderedElement(String elementId) {
        return rendered.get(elementId);
    }

    void importPackage(String raw) {
        manager.previewImport(raw);
    }

    String exportPackage() {
        return repository.exportPackage();
    }

    String exportLayout(String sceneId, String layoutId) {
        return repository.exportLayout(sceneId, layoutId);
    }

    void reloadFromRepository() {
        if (editor.isEditing()) {
            return;
        }
        displayedSceneId = currentSceneId;
        displayedLayout = repository.activeLayout(currentSceneId);
        rebuildTree();
    }

    /**
     * Observe Activity-level touch without stealing ordinary SDL input.  Three
     * stationary pointers open the editor for the currently active scene.
     */
    void observeGlobalTouchEvent(MotionEvent event) {
        if (editor.isEditing()) {
            return;
        }
        int action = event.getActionMasked();
        if (event.getPointerCount() >= 3 &&
                (action == MotionEvent.ACTION_POINTER_DOWN || action == MotionEvent.ACTION_DOWN)) {
            float[] center = pointerCenter(event);
            gestureStartX = center[0];
            gestureStartY = center[1];
            threeFingerTracking = true;
            handler.removeCallbacks(threeFingerHold);
            handler.postDelayed(threeFingerHold, THREE_FINGER_HOLD_MS);
            return;
        }
        if (action == MotionEvent.ACTION_MOVE && threeFingerTracking) {
            float[] center = pointerCenter(event);
            int slop = ViewConfiguration.get(activity).getScaledTouchSlop() * 2;
            if (Math.abs(center[0] - gestureStartX) > slop ||
                    Math.abs(center[1] - gestureStartY) > slop ||
                    event.getPointerCount() < 3) {
                cancelThreeFingerGesture();
            }
        } else if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL ||
                action == MotionEvent.ACTION_POINTER_UP && event.getPointerCount() <= 3) {
            cancelThreeFingerGesture();
        }
    }

    @Override
    protected void onSizeChanged(int width, int height, int oldWidth, int oldHeight) {
        super.onSizeChanged(width, height, oldWidth, oldHeight);
        layoutRenderedTree();
        publishSubscriptions();
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (!editor.isEditing()) {
            return;
        }
        float stepX = Math.max(dp(16), 80f * canvasScaleX());
        float stepY = Math.max(dp(16), 80f * canvasScaleY());
        for (float x = 0; x < getWidth(); x += stepX) {
            canvas.drawLine(x, 0, x, getHeight(), gridPaint);
        }
        for (float y = 0; y < getHeight(); y += stepY) {
            canvas.drawLine(0, y, getWidth(), y, gridPaint);
        }
    }

    private void refreshSnapshot() {
        String raw = activity.getHudSnapshot();
        if (raw == null || raw.isEmpty()) {
            return;
        }
        try {
            AndroidHudSnapshot next = AndroidHudSnapshot.parse(raw);
            if (next.revision == lastSnapshotRevision) {
                return;
            }
            lastSnapshotRevision = next.revision;
            snapshot = next;
            if (!next.sources.isEmpty()) {
                sourceCatalog.clear();
                sourceCatalog.putAll(next.sources);
            }
            if (!next.ready || next.sceneId.isEmpty()) {
                if (!editor.isEditing()) {
                    setRuntimeVisibility(false);
                }
                bindRuntimeState();
                return;
            }
            currentSceneId = next.sceneId;
            currentSceneTitle = next.sceneTitle.isEmpty() ? next.sceneId : next.sceneTitle;
            repository.ensureScene(currentSceneId, currentSceneTitle);
            repository.updateActionCatalog(currentSceneId, next.actionList());
            if (!editor.isEditing()) {
                AndroidHudModel.Layout active = repository.activeLayout(currentSceneId);
                String nextLayout = active == null ? "" : active.id;
                String shownLayout = displayedLayout == null ? "" : displayedLayout.id;
                if (!displayedSceneId.equals(currentSceneId) || !shownLayout.equals(nextLayout)) {
                    displayedSceneId = currentSceneId;
                    displayedLayout = active;
                    rebuildTree();
                }
                setRuntimeVisibility(true);
            }
            bindRuntimeState();
        } catch (JSONException e) {
            Log.w(TAG, "Rejected native Android HUD snapshot", e);
        }
    }

    private void rebuildTree() {
        clearRenderedTree();
        if (displayedLayout == null || getWidth() <= 0 || getHeight() <= 0) {
            publishSubscriptions();
            editor.bringToolbarToFront();
            return;
        }
        for (AndroidHudModel.Element element : displayedLayout.elements) {
            renderElement(this, element, "");
        }
        layoutRenderedTree();
        bindRuntimeState();
        publishSubscriptions();
        editor.bringToolbarToFront();
        invalidate();
    }

    private void clearRenderedTree() {
        if (activeMinimapView != null) {
            activity.setHudMinimapRect(0, 0, 0, 0, false);
            activeMinimapView = null;
        }
        for (RenderedElement entry : rendered.values()) {
            if (entry.content instanceof ControlView) {
                ((ControlView)entry.content).dispose();
            }
            entry.host.clearRuntimeInteraction();
            if (entry.host.getParent() instanceof ViewGroup) {
                ((ViewGroup)entry.host.getParent()).removeView(entry.host);
            }
        }
        rendered.clear();
    }

    private void renderElement(FrameLayout parent, AndroidHudModel.Element element,
            String parentGroupId) {
        ElementHost host = new ElementHost(activity, element.id);
        host.setClipChildren(AndroidHudModel.TYPE_GROUP.equals(element.type) &&
            element.clipChildren);
        host.setClipToPadding(AndroidHudModel.TYPE_GROUP.equals(element.type) &&
            element.clipChildren);
        host.setVisibility(element.visible ? VISIBLE : GONE);
        parent.addView(host);

        View content = null;
        FrameLayout groupContent = null;
        ScrollView scrollContainer = null;
        if (AndroidHudModel.TYPE_GROUP.equals(element.type)) {
            groupContent = new FrameLayout(activity);
            groupContent.setClipChildren(element.clipChildren);
            groupContent.setClipToPadding(element.clipChildren);
            if (AndroidHudModel.OVERFLOW_SCROLL.equals(element.overflowMode)) {
                scrollContainer = verticalScroller();
                scrollContainer.addView(groupContent, new ScrollView.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT));
                host.addView(scrollContainer, new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT));
            } else {
                host.addView(groupContent, new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT));
            }
            if (element.style.showLabel) {
                TextView title = new TextView(activity);
                title.setText(element.label.isEmpty() ? "元素组" : element.label);
                AndroidHudRendererRegistry.applyTextStyle(title, element.style, false);
                title.setPadding(dp(5), 0, dp(5), 0);
                host.addView(title, new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT,
                    Gravity.TOP));
                content = title;
            }
            for (AndroidHudModel.Element child : element.children) {
                renderElement(groupContent, child, element.id);
            }
        } else if (AndroidHudModel.TYPE_INFO.equals(element.type)) {
            AndroidHudModel.InfoSource source = sourceCatalog.get(element.sourceId);
            if (source == null) {
                source = missingSource(element.sourceId);
            }
            content = rendererRegistry.create(activity, source);
            if (AndroidHudModel.OVERFLOW_SCROLL.equals(element.overflowMode) &&
                    !AndroidHudModel.requiresSquareFrame(element)) {
                scrollContainer = verticalScroller();
                scrollContainer.addView(content, new ScrollView.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT));
                host.addView(scrollContainer, new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT));
            } else {
                host.addView(content, new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT));
            }
        } else {
            ControlView control = new ControlView(activity);
            content = control;
            host.addView(control, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        }
        RenderedElement renderedElement = new RenderedElement(element, parentGroupId, host,
            content, groupContent, scrollContainer);
        rendered.put(element.id, renderedElement);
        applyStyle(renderedElement);
        editor.configureElementInteraction(renderedElement);
    }

    private void layoutRenderedTree() {
        if (displayedLayout == null || getWidth() <= 0 || getHeight() <= 0) {
            return;
        }
        for (AndroidHudModel.Element element : displayedLayout.elements) {
            layoutElement(element);
        }
        if (activeMinimapView != null) {
            activeMinimapView.post(() -> publishMinimap(activeMinimapView, true));
        }
    }

    private void layoutElement(AndroidHudModel.Element element) {
        RenderedElement renderedElement = rendered.get(element.id);
        if (renderedElement == null) {
            return;
        }
        int width;
        int height;
        if (AndroidHudModel.requiresSquareFrame(element)) {
            int side = Math.max(dp(24),
                Math.round(element.frame.width * canvasUniformScale()));
            width = side;
            height = side;
        } else {
            width = Math.max(dp(24), Math.round(element.frame.width * canvasScaleX()));
            height = Math.max(dp(24), Math.round(element.frame.height * canvasScaleY()));
        }
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(width, height,
            Gravity.TOP | Gravity.LEFT);
        params.leftMargin = Math.round(element.frame.x * canvasScaleX());
        params.topMargin = Math.round(element.frame.y * canvasScaleY());
        renderedElement.host.setLayoutParams(params);
        if (renderedElement.groupContent != null) {
            int contentHeight = height;
            if (renderedElement.scrollContainer != null) {
                for (AndroidHudModel.Element child : element.children) {
                    float childBottom = child.frame.y + child.frame.height;
                    contentHeight = Math.max(contentHeight,
                        Math.round(childBottom * canvasScaleY()));
                }
            }
            if (renderedElement.scrollContainer == null) {
                renderedElement.groupContent.setLayoutParams(new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT));
            } else {
                renderedElement.groupContent.setLayoutParams(new ScrollView.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT, contentHeight));
            }
        }
        for (AndroidHudModel.Element child : element.children) {
            layoutElement(child);
        }
    }

    private void bindRuntimeState() {
        boolean preview = editor.isEditing() && editor.isPreview();
        boolean editing = editor.isEditing();
        LinkedHashMap<String, AndroidHudModel.ActionDescriptor> actionCatalog =
            actionsForDisplayedScene();
        activeMinimapView = null;
        for (RenderedElement entry : rendered.values()) {
            AndroidHudModel.Element element = entry.element;
            if (AndroidHudModel.TYPE_INFO.equals(element.type)) {
                AndroidHudModel.InfoSource source = sourceCatalog.get(element.sourceId);
                if (source == null) {
                    source = missingSource(element.sourceId);
                }
                rendererRegistry.bind(entry.content, source, element, snapshot, preview,
                    this::publishMinimap);
                bindInformationInteraction(entry, actionCatalog, editing);
            } else if (AndroidHudModel.TYPE_CONTROL.equals(element.type)) {
                ((ControlView)entry.content).bind(element, actionCatalog,
                    editing, new ControlCallback() {
                        @Override
                        public void trigger(String actionId, boolean authorized) {
                            triggerAction(element, actionId, authorized);
                        }

                        @Override
                        public void select(String actionId) {
                            element.selectedActionId = actionId;
                            if (!editor.isEditing()) {
                                repository.updateSelectedAction(displayedSceneId,
                                    displayedLayout.id, element.id, actionId);
                            }
                        }
                    });
            } else {
                entry.host.clearRuntimeInteraction();
            }
        }
    }

    private void bindInformationInteraction(RenderedElement entry,
            LinkedHashMap<String, AndroidHudModel.ActionDescriptor> actionCatalog,
            boolean editing) {
        ArrayList<String> choices =
            AndroidHudActionMenu.availableActions(entry.element, actionCatalog);
        if (editing || choices.isEmpty()) {
            entry.host.clearRuntimeInteraction();
            return;
        }
        entry.host.setRuntimeInteraction(
            () -> activateInformationAction(entry.element, entry.host, false),
            () -> activateInformationAction(entry.element, entry.host, true));
    }

    private void activateInformationAction(AndroidHudModel.Element element,
            View anchor, boolean authorizedGesture) {
        LinkedHashMap<String, AndroidHudModel.ActionDescriptor> actionCatalog =
            actionsForDisplayedScene();
        ArrayList<String> choices =
            AndroidHudActionMenu.availableActions(element, actionCatalog);
        if (choices.isEmpty()) {
            Toast.makeText(activity, "该信息没有当前界面可用的动作",
                Toast.LENGTH_SHORT).show();
            return;
        }
        if (choices.size() == 1) {
            triggerAction(element, choices.get(0), authorizedGesture);
            return;
        }
        AndroidHudActionMenu.show(anchor, choices, actionCatalog, "",
            actionId -> triggerAction(element, actionId, authorizedGesture));
    }

    private LinkedHashMap<String, AndroidHudModel.ActionDescriptor> actionsForDisplayedScene() {
        if (displayedSceneId.equals(currentSceneId) && snapshot.ready) {
            return snapshot.actions;
        }
        AndroidHudModel.Scene scene = repository.scene(displayedSceneId);
        return scene == null ? new LinkedHashMap<>() : scene.actionCatalog;
    }

    private void triggerAction(AndroidHudModel.Element element, String actionId,
            boolean authorized) {
        AndroidHudModel.ActionDescriptor action = snapshot.actions.get(actionId);
        if (action == null || !snapshot.ready || !displayedSceneId.equals(currentSceneId)) {
            Toast.makeText(activity, "该动作不属于当前界面", Toast.LENGTH_SHORT).show();
            return;
        }
        boolean risky = !AndroidHudModel.RISK_SAFE.equals(action.risk);
        if (risky && (!element.authorizedDangerousActions.contains(actionId) || !authorized)) {
            Toast.makeText(activity, "高风险动作需在属性中授权，并长按触发",
                Toast.LENGTH_SHORT).show();
            return;
        }
        if (!activity.enqueueHudAction(actionId, snapshot.contextRevision, risky)) {
            Toast.makeText(activity, "界面已变化，请重试", Toast.LENGTH_SHORT).show();
        }
    }

    private void applyStyle(RenderedElement entry) {
        AndroidHudModel.Element element = entry.element;
        entry.host.setAlpha(element.style.opacity);
        if (!element.style.background && !element.style.border && !editor.isEditing()) {
            entry.host.setBackgroundColor(Color.TRANSPARENT);
            return;
        }
        GradientDrawable background = new GradientDrawable();
        background.setColor(element.style.background ?
            element.style.backgroundColor : Color.TRANSPARENT);
        background.setCornerRadius(dp(6));
        if (element.style.border || editor.isEditing()) {
            int color = editor.isEditing() && editor.isSelected(element.id) ?
                0xFF80D8FF : element.style.borderColor;
            background.setStroke(dp(editor.isEditing() ? 2 : 1), color);
        }
        entry.host.setBackground(background);
    }

    void refreshElementStyles() {
        for (RenderedElement entry : rendered.values()) {
            applyStyle(entry);
        }
    }

    private void publishSubscriptions() {
        Set<String> subscriptions = new HashSet<>();
        collectSubscriptions(displayedLayout == null ? null : displayedLayout.elements,
            subscriptions);
        StringBuilder encoded = new StringBuilder();
        for (String source : subscriptions) {
            if (encoded.length() > 0) {
                encoded.append('\n');
            }
            encoded.append(source);
        }
        String next = encoded.toString();
        if (!next.equals(lastSubscriptions)) {
            lastSubscriptions = next;
            activity.setHudSubscriptions(next);
        }
    }

    private static void collectSubscriptions(List<AndroidHudModel.Element> elements,
            Set<String> target) {
        if (elements == null) {
            return;
        }
        for (AndroidHudModel.Element element : elements) {
            if (!element.visible) {
                continue;
            }
            if (AndroidHudModel.TYPE_INFO.equals(element.type)) {
                target.add(element.sourceId);
            }
            collectSubscriptions(element.children, target);
        }
    }

    private void publishMinimap(View view, boolean visible) {
        if (!visible || editor.isEditing()) {
            if (view == activeMinimapView) {
                activity.setHudMinimapRect(0, 0, 0, 0, false);
                activeMinimapView = null;
            }
            return;
        }
        if (activeMinimapView != null && activeMinimapView != view) {
            return; // The native renderer intentionally has one minimap target.
        }
        activeMinimapView = view;
        view.post(() -> {
            if (activeMinimapView != view || !snapshot.ready) {
                return;
            }
            int[] location = new int[2];
            view.getLocationOnScreen(location);
            activity.setHudMinimapRect(location[0], location[1],
                view.getWidth(), view.getHeight(), view.getVisibility() == VISIBLE);
        });
    }

    private void setRuntimeVisibility(boolean visible) {
        for (RenderedElement entry : rendered.values()) {
            entry.host.setVisibility(visible && entry.element.visible ? VISIBLE : GONE);
        }
        if (!visible) {
            activity.setHudMinimapRect(0, 0, 0, 0, false);
            activeMinimapView = null;
        }
    }

    private void cancelThreeFingerGesture() {
        threeFingerTracking = false;
        handler.removeCallbacks(threeFingerHold);
    }

    private static float[] pointerCenter(MotionEvent event) {
        float x = 0;
        float y = 0;
        int count = Math.max(1, event.getPointerCount());
        for (int i = 0; i < count; ++i) {
            x += event.getX(i);
            y += event.getY(i);
        }
        return new float[] { x / count, y / count };
    }

    private static AndroidHudModel.InfoSource missingSource(String id) {
        AndroidHudModel.InfoSource source = new AndroidHudModel.InfoSource();
        source.id = id;
        source.title = "缺失信息源";
        source.category = "高级";
        source.renderer = "text";
        return source;
    }

    private ScrollView verticalScroller() {
        ScrollView scroll = new ScrollView(activity);
        scroll.setFillViewport(true);
        scroll.setClipToPadding(true);
        scroll.setVerticalScrollBarEnabled(true);
        scroll.setOverScrollMode(View.OVER_SCROLL_IF_CONTENT_SCROLLS);
        scroll.setOnScrollChangeListener((view, scrollX, scrollY, oldScrollX, oldScrollY) -> {
            if (activeMinimapView != null) {
                publishMinimap(activeMinimapView, true);
            }
        });
        return scroll;
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    static final class RenderedElement {
        final AndroidHudModel.Element element;
        final String parentGroupId;
        final ElementHost host;
        final View content;
        final FrameLayout groupContent;
        final ScrollView scrollContainer;

        RenderedElement(AndroidHudModel.Element element, String parentGroupId,
                ElementHost host, View content, FrameLayout groupContent,
                ScrollView scrollContainer) {
            this.element = element;
            this.parentGroupId = parentGroupId;
            this.host = host;
            this.content = content;
            this.groupContent = groupContent;
            this.scrollContainer = scrollContainer;
        }
    }

    static final class ElementHost extends FrameLayout {
        final String elementId;
        private final GestureDetector runtimeGestures;
        private boolean editorTouchCapture;
        private Runnable runtimeClick;
        private Runnable runtimeLongPress;

        ElementHost(Context context, String elementId) {
            super(context);
            this.elementId = elementId;
            runtimeGestures = new GestureDetector(context,
                new GestureDetector.SimpleOnGestureListener() {
                    @Override
                    public boolean onDown(MotionEvent event) {
                        return hasRuntimeInteraction();
                    }

                    @Override
                    public boolean onSingleTapUp(MotionEvent event) {
                        if (!hasRuntimeInteraction() || runtimeClick == null) {
                            return false;
                        }
                        runtimeClick.run();
                        return true;
                    }

                    @Override
                    public void onLongPress(MotionEvent event) {
                        if (!hasRuntimeInteraction() || runtimeLongPress == null) {
                            return;
                        }
                        performHapticFeedback(HapticFeedbackConstants.LONG_PRESS);
                        runtimeLongPress.run();
                    }
                });
        }

        void setEditorTouchCapture(boolean capture) {
            editorTouchCapture = capture;
            if (capture) {
                cancelRuntimeGesture();
            }
        }

        void setRuntimeInteraction(Runnable click, Runnable longPress) {
            boolean wasEnabled = hasRuntimeInteraction();
            if (!wasEnabled) {
                cancelRuntimeGesture();
            }
            runtimeClick = click;
            runtimeLongPress = longPress;
            if (!editorTouchCapture) {
                setClickable(false);
            }
        }

        void clearRuntimeInteraction() {
            cancelRuntimeGesture();
            runtimeClick = null;
            runtimeLongPress = null;
            if (!editorTouchCapture) {
                setClickable(false);
            }
        }

        @Override
        public boolean dispatchTouchEvent(MotionEvent event) {
            boolean handled = super.dispatchTouchEvent(event);
            boolean runtimeHandled = hasRuntimeInteraction() &&
                runtimeGestures.onTouchEvent(event);
            return handled || runtimeHandled;
        }

        private void cancelRuntimeGesture() {
            long now = SystemClock.uptimeMillis();
            MotionEvent cancel = MotionEvent.obtain(
                now, now, MotionEvent.ACTION_CANCEL, 0, 0, 0);
            runtimeGestures.onTouchEvent(cancel);
            cancel.recycle();
        }

        private boolean hasRuntimeInteraction() {
            return !editorTouchCapture &&
                (runtimeClick != null || runtimeLongPress != null);
        }

        @Override
        public boolean onInterceptTouchEvent(MotionEvent event) {
            // In edit mode the frame itself owns selection, drag, resize and
            // double-tap.  Runtime children such as Button must not consume
            // the gesture before the editor's host listener sees it.
            return editorTouchCapture || super.onInterceptTouchEvent(event);
        }
    }

    private interface ControlCallback {
        void trigger(String actionId, boolean authorized);
        void select(String actionId);
    }

    private static final class ControlView extends LinearLayout {
        private static final long REPEAT_DELAY_MS = 350L;
        private static final long REPEAT_INTERVAL_MS = 90L;

        private final Button trigger;
        private final Button selector;
        private final Handler repeatHandler = new Handler();
        private final Runnable repeater = new Runnable() {
            @Override
            public void run() {
                if (!pressed || boundCallback == null || boundActionId.isEmpty() ||
                        boundRisky || !boundRepeatable) {
                    return;
                }
                repeated = true;
                boundCallback.trigger(boundActionId, false);
                if (pressed) {
                    repeatHandler.postDelayed(this, REPEAT_INTERVAL_MS);
                }
            }
        };
        private ControlCallback boundCallback;
        private String boundActionId = "";
        private boolean boundRisky;
        private boolean boundRepeatable;
        private boolean pressed;
        private boolean repeated;

        ControlView(Context context) {
            super(context);
            setOrientation(HORIZONTAL);
            trigger = new Button(context);
            trigger.setAllCaps(false);
            trigger.setMinWidth(0);
            trigger.setMinHeight(0);
            selector = new Button(context);
            selector.setText("▾");
            selector.setTextSize(11f);
            selector.setMinWidth(0);
            selector.setMinHeight(0);
            addView(trigger, new LinearLayout.LayoutParams(0,
                ViewGroup.LayoutParams.MATCH_PARENT, 1f));
            addView(selector, new LinearLayout.LayoutParams(
                Math.round(38 * context.getResources().getDisplayMetrics().density),
                ViewGroup.LayoutParams.MATCH_PARENT));

            trigger.setOnClickListener(view -> {
                if (boundRisky) {
                    Toast.makeText(getContext(), "长按触发已授权的高风险动作",
                        Toast.LENGTH_SHORT).show();
                } else if (!boundRepeatable && boundCallback != null &&
                        !boundActionId.isEmpty()) {
                    boundCallback.trigger(boundActionId, false);
                }
            });
            trigger.setOnLongClickListener(view -> {
                if (boundCallback == null || boundActionId.isEmpty()) {
                    return false;
                }
                boundCallback.trigger(boundActionId, boundRisky);
                return true;
            });
            trigger.setOnTouchListener((view, event) -> {
                if (!boundRepeatable || boundRisky || !trigger.isEnabled()) {
                    return false;
                }
                switch (event.getActionMasked()) {
                    case MotionEvent.ACTION_DOWN:
                        pressed = true;
                        repeated = false;
                        repeatHandler.removeCallbacks(repeater);
                        repeatHandler.postDelayed(repeater, REPEAT_DELAY_MS);
                        return true;
                    case MotionEvent.ACTION_UP:
                        repeatHandler.removeCallbacks(repeater);
                        if (pressed && !repeated && boundCallback != null &&
                                !boundActionId.isEmpty()) {
                            boundCallback.trigger(boundActionId, false);
                        }
                        pressed = false;
                        return true;
                    case MotionEvent.ACTION_CANCEL:
                        cancelRepeat();
                        return true;
                    default:
                        return true;
                }
            });
        }

        void bind(AndroidHudModel.Element element,
                LinkedHashMap<String, AndroidHudModel.ActionDescriptor> catalog,
                boolean editing, ControlCallback callback) {
            ArrayList<String> choices =
                AndroidHudActionMenu.availableActions(element, catalog);
            String selected = element.selectedActionId;
            if (!choices.contains(selected)) {
                selected = choices.contains(element.defaultActionId) ?
                    element.defaultActionId : choices.isEmpty() ? "" : choices.get(0);
            }
            final String active = selected;
            AndroidHudModel.ActionDescriptor descriptor = catalog.get(active);
            boolean risky = descriptor != null &&
                !AndroidHudModel.RISK_SAFE.equals(descriptor.risk);
            boolean repeatable = descriptor != null && descriptor.repeatable && !risky;
            if (!active.equals(boundActionId) || risky != boundRisky ||
                    repeatable != boundRepeatable || editing || descriptor == null) {
                cancelRepeat();
            }
            boundActionId = active;
            boundRisky = risky;
            boundRepeatable = repeatable;
            boundCallback = callback;

            String label = element.label.isEmpty() ?
                descriptor == null ? active : descriptor.label : element.label;
            trigger.setText(label.isEmpty() ? "未绑定" : label);
            AndroidHudRendererRegistry.applyTextStyle(trigger, element.style, false);
            trigger.setEnabled(!editing && descriptor != null);
            boolean menuMode = AndroidHudModel.SELECTOR_MODE_MENU.equals(element.selectorMode);
            selector.setText(menuMode ? "☰" : "↻");
            selector.setVisibility(choices.size() > 1 ? VISIBLE : GONE);
            selector.setEnabled(!editing && choices.size() > 1);
            selector.setOnClickListener(view -> {
                if (menuMode) {
                    AndroidHudActionMenu.show(selector, choices, catalog, active,
                        chosenActionId -> {
                            callback.select(chosenActionId);
                            bind(element, catalog, editing, callback);
                        });
                    return;
                }
                int index = choices.indexOf(active);
                String next = choices.get((index + 1 + choices.size()) % choices.size());
                callback.select(next);
                bind(element, catalog, editing, callback);
            });
        }

        private void cancelRepeat() {
            pressed = false;
            repeated = false;
            repeatHandler.removeCallbacks(repeater);
        }

        private void dispose() {
            cancelRepeat();
            boundCallback = null;
            boundActionId = "";
        }
    }
}
