package com.crimsoncrossbunker.cataclysmcb;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.TreeSet;

import android.Manifest;
import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.app.AlertDialog;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.DialogInterface;
import android.content.DialogInterface.OnShowListener;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.net.Uri;
import android.os.*;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.crimsoncrossbunker.cataclysmcb.CataclysmDDA_Helpers;

public class SplashScreen extends Activity {
    private static final String TAG = "Splash";
    private static final int INSTALL_DIALOG_ID = 0;
    private static final int STORAGE_PERMISSION_REQUEST = 1;
    private ProgressDialog installDialog;
    private boolean waitingForManageStorage = false;

    private AlertDialog accessibilityServicesAlert;

    public boolean[] mSettingsValues = { false, true, true, false };
    private int mSystemUiModeIndex = 0;

    private String getInstallationStamp() {
        try {
            Context context = getApplicationContext();
            PackageInfo pInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return pInfo.versionName + ":" + pInfo.lastUpdateTime;
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    private boolean useLegacyStorage() {
        return StoragePaths.useLegacyStorage(getApplicationContext());
    }

    private String getGameUserDirectory() {
        return StoragePaths.getUserDirectory(getApplicationContext()).getPath();
    }

    private void showCrashAlert() {
        String userDirectory = getGameUserDirectory();
        File crashAlertPrompt = new File(userDirectory + "/config/crash.log.prompt");
        try {
            crashAlertPrompt.delete();
            if(crashAlertPrompt.exists()) { // Sometimes .delete() doesn't really delete the file and I don't know why
                crashAlertPrompt.getCanonicalFile().delete();
            }
        } catch(IOException e) {
            return;
        }
        File crashLog = new File(userDirectory + "/config/crash.log");
        StringBuilder text = new StringBuilder();
        text.append(getString(R.string.crashMessage));
        text.append("\n\n");
        try {
            BufferedReader br = new BufferedReader(new FileReader(crashLog));
            String line;
            while((line = br.readLine()) != null) {
                text.append(line);
                text.append("\n");
            }
            br.close();
        } catch (IOException e) {
            return;
        }
        final String message = text.toString();
        this.runOnUiThread(new Runnable() {
           public void run() {
                AlertDialog errorAlert = new AlertDialog.Builder(SplashScreen.this)
                .setTitle(getString(R.string.crashAlert))
                .setCancelable(false)
                .setMessage(message)
                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        SplashScreen.this.startGameActivity(false);
                    }
                }).create();
                errorAlert.show();
           }
        });
    }

    @Override
    protected void onStart() {
        Log.e(TAG, "onStart()");
        super.onStart();
    }

    @Override
    protected void onPause() {
        Log.e(TAG, "onPause()");
        super.onPause();
        accessibilityServicesAlert.dismiss();
    }

    @Override
    protected void onResume() {
        Log.e(TAG, "onResume()");
        super.onResume();

        if (waitingForManageStorage) {
            waitingForManageStorage = false;
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&
                !Environment.isExternalStorageManager()) {
                Toast.makeText(this, getString(R.string.storagePermissionRequired),
                    Toast.LENGTH_LONG).show();
                finish();
                return;
            }
        }

        Context context = getApplicationContext();
        String service_names = CataclysmDDA_Helpers.getEnabledAccessibilityServiceNames(context);
        accessibilityServicesAlert.setMessage( String.format( getString(R.string.accessibilityServicesMessage), service_names ) );
        if (!service_names.isEmpty()) {
            accessibilityServicesAlert.show();
        } else {
            SplashScreen.this.installOrRun();
        }
    }
    
    protected void installOrRun() {
        Log.e(TAG, "onCreate()");
        accessibilityServicesAlert.dismiss();
        // Start the game if already installed, otherwise start installing...
        if (getInstallationStamp().equals(PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getString("installed", ""))) {
            // Show an alert box if the game crashed last time
            String userDirectory = getGameUserDirectory();
            File crashAlertPrompt = new File(userDirectory + "/config/crash.log.prompt");
            if(crashAlertPrompt.exists()) {
                showCrashAlert();
            } else {
                startGameActivity(false);
            }
        }
        else {
            new InstallProgramTask().execute();
        }
        return;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e(TAG, "onCreate()");
        super.onCreate(savedInstanceState);

        accessibilityServicesAlert = new AlertDialog.Builder(SplashScreen.this)
            .setTitle(getString(R.string.accessibilityServicesTitle))
            .setCancelable(false)
            .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int id) {
                    SplashScreen.this.installOrRun();
                    return;
                }
            })
            .setNeutralButton(getString(R.string.showAccessibilitySettings), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        startActivityForResult(new Intent(android.provider.Settings.ACTION_ACCESSIBILITY_SETTINGS), 0);
                        dialog.dismiss();
                        return;
                    }
            })
            .setNegativeButton(getString(R.string.ignoreFalsePostives), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        CataclysmDDA_Helpers.saveAccessibilityServiceInfoFalsePositives(getApplicationContext());
                        SplashScreen.this.installOrRun();
                        return;
                    }
            }).create();
    }

    @Override
    public Dialog onCreateDialog(int id) {
        switch (id) {
            case INSTALL_DIALOG_ID:
                installDialog = new ProgressDialog(this);
                installDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
                boolean clean_install = PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getString("installed", "").isEmpty();
                installDialog.setTitle(getString(clean_install ? R.string.installTitle : R.string.upgradeTitle));
                installDialog.setIndeterminate(true);
                installDialog.setCancelable(false);
                return installDialog;
            default:
                return null;
        }
    }

    private void startGameActivity(boolean delay) {
        if (!delay) {
            runOnUiThread(new StartGameRunnable());
        }
        else {
            // Wait 1.5 seconds, then start game
            Timer timer = new Timer();
            TimerTask gameStartTask = new TimerTask() {
                @Override
                public void run() {
                    runOnUiThread(new StartGameRunnable());
                }
            };
            timer.schedule(gameStartTask, 1500);
        }
    }

    private final class StartGameRunnable implements Runnable {
        @Override
        public void run() {
            if (!useLegacyStorage() && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
                Build.VERSION.SDK_INT < Build.VERSION_CODES.R &&
                checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) !=
                PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[] {
                    Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE
                }, STORAGE_PERMISSION_REQUEST);
                return;
            }
            if (!useLegacyStorage() && Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&
                !Environment.isExternalStorageManager()) {
                Intent permissionIntent = new Intent(
                    Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION,
                    Uri.parse("package:" + getPackageName())
                );
                waitingForManageStorage = true;
                startActivity(permissionIntent);
                return;
            }

            Intent intent = new Intent(SplashScreen.this, CataclysmDDA.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
            startActivity(intent);
            finish();
            overridePendingTransition(0, 0);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions,
            int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode != STORAGE_PERMISSION_REQUEST) {
            return;
        }
        boolean granted = grantResults.length > 0;
        for (int result : grantResults) {
            granted &= result == PackageManager.PERMISSION_GRANTED;
        }
        if (granted) {
            startGameActivity(false);
        } else {
            Toast.makeText(this, getString(R.string.storagePermissionRequired),
                Toast.LENGTH_LONG).show();
            finish();
        }
    }

    private class InstallProgramTask extends AsyncTask<Void, Integer, Boolean> {
        private static final String ASSET_MANIFEST = ".installed-assets.txt";
        private final List<String> PRESERVE_SUBFOLDERS = Arrays.asList("sound", "mods", "gfx"); // don't delete custom subfolders under these folders
        private final List<String> PRESERVE_FOLDERS = Arrays.asList("font"); // don't delete this folder
        private final List<String> PRESERVE_FILES = Arrays.asList("user-default-mods.json"); // don't delete this file
        private final Set<String> installedAssetPaths = new TreeSet<>();

        private int totalFiles = 0;
        private int installedFiles = 0;

        private AlertDialog installationAlert;
        private AlertDialog settingsAlert;
        private AlertDialog helpAlert;

        @Override
        protected void onPreExecute() {
            installationAlert = new AlertDialog.Builder(SplashScreen.this)
                .setTitle("Installation Failed")
                .setCancelable(false)
                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        SplashScreen.this.finish();
                        return;
                    }
                }).create();
            AssetManager assetManager = getAssets();
            try {
                totalFiles = countTotalAssets(assetManager, "data") +
                    countTotalAssets(assetManager, "gfx") +
                    countTotalAssets(assetManager, "lang");
                showDialog(INSTALL_DIALOG_ID);
            } catch(Exception e) {
                installationAlert.setMessage(e.getMessage());
                installationAlert.show();
            }

            helpAlert = new AlertDialog.Builder(SplashScreen.this)
                .setTitle(getString(R.string.helpTitle))
                .setCancelable(false)
                .setMessage(getString(R.string.helpMessage))
                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        settingsAlert.show();
                        return;
                    }
                }).create();

            loadSettingsDefaults();

            settingsAlert = new AlertDialog.Builder(SplashScreen.this)
                .setTitle(getString(R.string.settings))
                .setView(createSettingsView())
                .setCancelable(false)
                .setPositiveButton(getString(R.string.startGame), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).edit().putBoolean("Software rendering", SplashScreen.this.mSettingsValues[0]).commit();
                        PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).edit().putString(CataclysmDDA.PREF_SYSTEM_UI_MODE, getSelectedSystemUiMode()).commit();
                        PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).edit().putBoolean("Trap Back button", SplashScreen.this.mSettingsValues[1]).commit();
                        PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).edit().putBoolean("Native Android UI", SplashScreen.this.mSettingsValues[2]).commit();
                        PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).edit().putBoolean(StoragePaths.PREF_USE_LEGACY_STORAGE, SplashScreen.this.mSettingsValues[3]).commit();
                        SplashScreen.this.startGameActivity(false);
                        return;
                    }
                })
                .setNeutralButton(getString(R.string.showHelp), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        helpAlert.show();
                        return;
                    }
                }).create();
        }

        private void loadSettingsDefaults() {
            SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
            SplashScreen.this.mSettingsValues[0] = preferences.getBoolean("Software rendering", false);
            SplashScreen.this.mSettingsValues[1] = preferences.getBoolean("Trap Back button", true);
            SplashScreen.this.mSettingsValues[2] = preferences.getBoolean("Native Android UI", true);
            SplashScreen.this.mSettingsValues[3] = preferences.getBoolean(StoragePaths.PREF_USE_LEGACY_STORAGE, false);

            String mode;
            if (preferences.contains(CataclysmDDA.PREF_SYSTEM_UI_MODE)) {
                mode = preferences.getString(
                    CataclysmDDA.PREF_SYSTEM_UI_MODE,
                    CataclysmDDA.SYSTEM_UI_MODE_SYSTEM_BARS);
            } else {
                mode = preferences.getBoolean(CataclysmDDA.PREF_FORCE_FULLSCREEN, false)
                    ? CataclysmDDA.SYSTEM_UI_MODE_EDGE_TO_EDGE
                    : CataclysmDDA.SYSTEM_UI_MODE_SYSTEM_BARS;
            }
            SplashScreen.this.mSystemUiModeIndex = systemUiModeIndex(mode);
        }

        private ScrollView createSettingsView() {
            ScrollView scrollView = new ScrollView(SplashScreen.this);
            scrollView.setFillViewport(true);
            LinearLayout layout = new LinearLayout(SplashScreen.this);
            layout.setOrientation(LinearLayout.VERTICAL);
            int padding = (int)(24 * getResources().getDisplayMetrics().density);
            layout.setPadding(padding, padding, padding, padding);

            TextView displayModeLabel = new TextView(SplashScreen.this);
            displayModeLabel.setText(getString(R.string.androidSystemUiMode));
            layout.addView(displayModeLabel);

            RadioGroup displayModeGroup = new RadioGroup(SplashScreen.this);
            displayModeGroup.setOrientation(RadioGroup.VERTICAL);
            addSystemUiModeButton(displayModeGroup, 0, getString(R.string.androidSystemUiModeSystemBars));
            addSystemUiModeButton(displayModeGroup, 1, getString(R.string.androidSystemUiModeFullscreen));
            addSystemUiModeButton(displayModeGroup, 2, getString(R.string.androidSystemUiModeEdgeToEdge));
            displayModeGroup.check(systemUiModeButtonId(mSystemUiModeIndex));
            displayModeGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
                @Override
                public void onCheckedChanged(RadioGroup group, int checkedId) {
                    SplashScreen.this.mSystemUiModeIndex = systemUiModeIndexFromButtonId(checkedId);
                }
            });
            layout.addView(displayModeGroup);

            addBooleanSetting(layout, 0, getString(R.string.softwareRendering));
            addBooleanSetting(layout, 1, getString(R.string.trapBackButton));
            addBooleanSetting(layout, 2, getString(R.string.nativeAndroidUI));
            addBooleanSetting(layout, 3, getString(R.string.useLegacyStorage));
            scrollView.addView(layout, new ScrollView.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT));
            return scrollView;
        }

        private void addSystemUiModeButton(RadioGroup group, int id, String label) {
            RadioButton button = new RadioButton(SplashScreen.this);
            button.setId(systemUiModeButtonId(id));
            button.setText(label);
            group.addView(button, new RadioGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT));
        }

        private int systemUiModeButtonId(int index) {
            return 1000 + index;
        }

        private int systemUiModeIndexFromButtonId(int buttonId) {
            return buttonId - 1000;
        }

        private void addBooleanSetting(LinearLayout layout, final int index, String label) {
            CheckBox checkBox = new CheckBox(SplashScreen.this);
            checkBox.setText(label);
            checkBox.setChecked(SplashScreen.this.mSettingsValues[index]);
            checkBox.setOnClickListener(v -> SplashScreen.this.mSettingsValues[index] = checkBox.isChecked());
            layout.addView(checkBox, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT));
        }

        private String getSelectedSystemUiMode() {
            switch (mSystemUiModeIndex) {
                case 1:
                    return CataclysmDDA.SYSTEM_UI_MODE_FULLSCREEN;
                case 2:
                    return CataclysmDDA.SYSTEM_UI_MODE_EDGE_TO_EDGE;
                default:
                    return CataclysmDDA.SYSTEM_UI_MODE_SYSTEM_BARS;
            }
        }

        private int systemUiModeIndex(String mode) {
            if (CataclysmDDA.SYSTEM_UI_MODE_FULLSCREEN.equals(mode)) {
                return 1;
            } else if (CataclysmDDA.SYSTEM_UI_MODE_EDGE_TO_EDGE.equals(mode)) {
                return 2;
            }
            return 0;
        }

        @Override
        protected Boolean doInBackground(Void... params) {
            if (installDialog != null) {
                installDialog.setIndeterminate(false);
                installDialog.setMax(totalFiles);
            }
            publishProgress(installedFiles);

            AssetManager assetManager = getAssets();
            String externalFilesDir = getExternalFilesDir(null).getPath();

            try {
                // Remove files recorded from the previous APK while leaving untracked custom files alone.
                // Existing installations without a manifest use the legacy preservation rules once.
                if (!deletePreviouslyInstalledAssets(externalFilesDir)) {
                    deleteRecursive(assetManager, externalFilesDir, new File(externalFilesDir + "/data"));
                    deleteRecursive(assetManager, externalFilesDir, new File(externalFilesDir + "/gfx"));
                    deleteRecursive(assetManager, externalFilesDir, new File(externalFilesDir + "/lang"));
                }
                deleteGeneratedCaches(externalFilesDir);

                // Install the new data over the top
                copyAssetFolder(assetManager, "data", externalFilesDir + "/data");
                copyAssetFolder(assetManager, "gfx", externalFilesDir + "/gfx");
                copyAssetFolder(assetManager, "lang", externalFilesDir + "/lang");
                writeAssetManifest(externalFilesDir);
            } catch(Exception e) {
                installationAlert.setMessage(e.getMessage());
                return false;
            }

            // Remember which version the installed data is
            PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).edit().putString("installed", getInstallationStamp()).commit();

            publishProgress(++installedFiles);
            Log.d(TAG, "Total number of files copied: " + installedFiles);
            return true;
        }

        private boolean isManagedAssetPath(String path) {
            return path.startsWith("data/") || path.startsWith("gfx/") ||
                path.startsWith("lang/");
        }

        private boolean deletePreviouslyInstalledAssets(String externalFilesDir) throws IOException {
            File manifest = new File(externalFilesDir, ASSET_MANIFEST);
            if (!manifest.isFile()) {
                return false;
            }

            String rootPath = new File(externalFilesDir).getCanonicalPath() + File.separator;
            try (BufferedReader reader = new BufferedReader(new FileReader(manifest))) {
                String assetPath;
                while ((assetPath = reader.readLine()) != null) {
                    if (assetPath.isEmpty()) {
                        continue;
                    }
                    if (!isManagedAssetPath(assetPath)) {
                        throw new IOException("Invalid installed asset path: " + assetPath);
                    }
                    File installedAsset = new File(externalFilesDir, assetPath);
                    if (!installedAsset.getCanonicalPath().startsWith(rootPath)) {
                        throw new IOException("Installed asset escaped storage root: " + assetPath);
                    }
                    if (installedAsset.isFile() && !installedAsset.delete()) {
                        throw new IOException("Unable to remove old installed asset: " + assetPath);
                    }
                }
            }

            deleteEmptyDirectories(new File(externalFilesDir, "data"), false);
            deleteEmptyDirectories(new File(externalFilesDir, "gfx"), false);
            deleteEmptyDirectories(new File(externalFilesDir, "lang"), false);
            return true;
        }

        private void deleteEmptyDirectories(File directory, boolean deleteRoot) {
            File[] children = directory.listFiles();
            if (children == null) {
                return;
            }
            for (File child : children) {
                if (child.isDirectory()) {
                    deleteEmptyDirectories(child, true);
                }
            }
            children = directory.listFiles();
            if (deleteRoot && children != null && children.length == 0) {
                directory.delete();
            }
        }

        private void deleteGeneratedDirectory(File directory) {
            File[] children = directory.listFiles();
            if (children != null) {
                for (File child : children) {
                    if (child.isDirectory()) {
                        deleteGeneratedDirectory(child);
                    } else {
                        child.delete();
                    }
                }
            }
            directory.delete();
        }

        private void deleteGeneratedCaches(String externalFilesDir) {
            deleteGeneratedDirectory(new File(externalFilesDir, "data/cache"));
            deleteGeneratedDirectory(new File(externalFilesDir, "cache"));

            File userDirectory = new File(getGameUserDirectory());
            deleteGeneratedDirectory(new File(userDirectory, "cache"));
            deleteGeneratedDirectory(new File(userDirectory, "config/cache"));
            deleteGeneratedDirectory(new File(userDirectory, "memorial/cache"));
        }

        private void writeAssetManifest(String externalFilesDir) throws IOException {
            File manifest = new File(externalFilesDir, ASSET_MANIFEST);
            File temporaryManifest = new File(externalFilesDir, ASSET_MANIFEST + ".new");
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(temporaryManifest))) {
                for (String assetPath : installedAssetPaths) {
                    writer.write(assetPath);
                    writer.newLine();
                }
            }
            if (manifest.exists() && !manifest.delete()) {
                throw new IOException("Unable to replace installed asset manifest");
            }
            if (!temporaryManifest.renameTo(manifest)) {
                throw new IOException("Unable to save installed asset manifest");
            }
        }

        void deleteRecursive(AssetManager assetManager, String externalFilesDir, File fileOrDirectory) {
            String parentFolder = fileOrDirectory.getParentFile().getName().toLowerCase();
            String fileOrDirectoryName = fileOrDirectory.getName().toLowerCase();
            if (fileOrDirectory.isDirectory()) {
                // Don't delete the folder if it is in the preserve folders list
                if (PRESERVE_FOLDERS.contains(fileOrDirectoryName))
                    return;

                // Don't delete the folder if its parent is in the preserve subfolders list, and it doesn't exist in the APK assets (so must be custom data)
                if (PRESERVE_SUBFOLDERS.contains(parentFolder) && !assetExists(assetManager, fileOrDirectory.getPath().substring(externalFilesDir.length()+1)))
                    return;

                File[] children = fileOrDirectory.listFiles();
                if (children != null) {
                    for (File child : children)
                        deleteRecursive(assetManager, externalFilesDir, child);
                }
            }
            else {
                // Don't delete the file if it's in the preserve files list
                if (PRESERVE_FILES.contains(fileOrDirectoryName))
                    return;
            }

            fileOrDirectory.delete();
        }

        // Returns true if an asset exists in the APK (either a directory or a file)
        // eg. assetExists("data/sound") or assetExists("data/font", "unifont.ttf") would both return true
        private boolean assetExists(AssetManager assetManager, String assetPath) {
            return assetExists(assetManager, assetPath, "");
        }

        private boolean assetExists(AssetManager assetManager, String assetPath, String assetName) {
            try {
                String[] files = assetManager.list(assetPath);
                if (assetName.isEmpty())
                    return files.length > 0; // folder exists
                for (String file : files) {
                    if (file.equalsIgnoreCase(assetName))
                        return true; // file exists
                }
                return false;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

        private int countTotalAssets(AssetManager assetManager, String assetPath) throws Exception {
            try {
                String[] files = assetManager.list(assetPath);
                int count = 0;
                for (String file : files)
                {
                    String filePath = assetPath + "/" + file;
                    String subdir_files[] = assetManager.list(filePath);
                    if (subdir_files.length == 0) // file
                        count++;
                    else // folder
                        count += countTotalAssets(assetManager, filePath);
                }
                return count;
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        }

        // Pinched from http://stackoverflow.com/questions/16983989/copy-directory-from-assets-to-data-folder
        private boolean copyAssetFolder(AssetManager assetManager, String fromAssetPath, String toPath) throws Exception {
            try {
                String[] files = assetManager.list(fromAssetPath);
                new File(toPath).mkdirs();
                boolean res = true;
                for (String file : files)
                {
                    String subdir_files[] = assetManager.list(fromAssetPath + "/" + file);
                    if (subdir_files.length == 0) // file
                        res &= copyAsset(assetManager, fromAssetPath + "/" + file, toPath + "/" + file);
                    else // folder
                        res &= copyAssetFolder(assetManager, fromAssetPath + "/" + file, toPath + "/" + file);
                }
                return res;
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        }

        private boolean copyAsset(AssetManager assetManager, String fromAssetPath, String toPath) throws Exception {
            publishProgress(++installedFiles, totalFiles);
            InputStream in = null;
            OutputStream out = null;
            try {
              in = assetManager.open(fromAssetPath);
              new File(toPath).createNewFile();
              out = new FileOutputStream(toPath);
              copyFile(in, out);
              in.close();
              in = null;
              out.flush();
              out.close();
              out = null;
              installedAssetPaths.add(fromAssetPath);
              return true;
            } catch(Exception e) {
                e.printStackTrace();
                throw e;
            }
        }

        private void copyFile(InputStream in, OutputStream out) throws IOException {
            byte[] buffer = new byte[1024];
            int read;
            while((read = in.read(buffer)) != -1) {
              out.write(buffer, 0, read);
            }
        }

        @Override
        protected void onProgressUpdate(Integer... values) {
            if (installDialog == null) {
                return;
            }
            installDialog.setProgress(values[0]);
        }

        @Override
        protected void onPostExecute(Boolean result) {
            removeDialog(INSTALL_DIALOG_ID);
            if(result) {
                settingsAlert.show();
            } else {
                installationAlert.show();
            }
        }
    }
}
