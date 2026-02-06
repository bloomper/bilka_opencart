<?php if (!$exclude) { ?>
<style>#google-consent-mode, #google-consent-mode-update-container {--google-consent-mode-background-color: <?php echo $background_color; ?>;--google-consent-mode-theme-color: <?php echo $theme_primary_color; ?>;--google-consent-mode-theme-text-color: <?php echo $theme_primary_text_color; ?>;}</style>
<?php if ($show) { ?>
<div id="google-consent-mode" class="<?php echo $hard_mode ? 'hard-mode' : ''; ?> <?php echo $position ? $position : 'bottom_right'; ?>">
    <div id="google-consent-mode-window">
        <div id="google-consent-mode-window-header">
            <strong id="google-consent-mode-window-header-title"><?php echo $window_title; ?></strong>
        </div>
        <div id="google-consent-mode-window-body">
            <div id="google-consent-mode-window-main-content">
                <p><?php echo $window_text; ?></p>
                <a href="<?php echo $information; ?>" target="_blank"><?php echo $link_label; ?></a>
            </div>
            <div id="google-consent-mode-window-customise" style="display: none;">
                <?php foreach ($params as $param) { ?>
                    <div class="consent-window-switch">
                        <input type="checkbox" class="custom-control-input" id="consent-window-switch-<?php echo $param; ?>" <?php echo in_array($param, $buttons_enabled_default) ? 'checked' : ''; ?>>
                        <label class="custom-control-label" for="consent-window-switch-<?php echo $param; ?>">
                            <div class="consent-window-switch-switcher"></div>
                            <span><?php echo ${$param}; ?></span>
                        </label>
                    </div>
                <?php } ?>
            </div>
        </div>
        <div id="google-consent-mode-window-footer">
            <button type="button" role="button" id="consent-window-reject"><?php echo $button_decline; ?></button>
            <button type="button" role="button" id="consent-window-customise"><?php echo $button_customise; ?></button>
            <button type="button" role="button" id="consent-window-back" style="display:none;"><?php echo $button_back; ?></button>
            <button type="button" role="button" id="consent-window-accept"><?php echo $button_accept; ?></button>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', initGoogleConsentForm());
    document.getElementById('consent-window-customise').addEventListener('click', function() {
        document.getElementById('google-consent-mode-window-main-content').style.display = 'none';
        document.getElementById('google-consent-mode-window-customise').style.display = 'block';
        document.getElementById('consent-window-customise').style.display = 'none';
        document.getElementById('consent-window-back').style.display = 'block';
        document.getElementById('consent-window-reject').style.display = 'none';
    });
    document.getElementById('consent-window-back').addEventListener('click', function() {
        document.getElementById('google-consent-mode-window-main-content').style.display = 'block';
        document.getElementById('google-consent-mode-window-customise').style.display = 'none';
        document.getElementById('consent-window-customise').style.display = 'block';
        document.getElementById('consent-window-back').style.display = 'none';
        document.getElementById('consent-window-reject').style.display = 'block';
    });
</script>
<?php } elseif ($update_enabled) { ?>
<div id="google-consent-mode-update-container" class="<?php echo $position ? $position : 'bottom_right'; ?>">
    <button type="button" role="button" id="consent-window-update-button">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6h9.75M10.5 6a1.5 1.5 0 1 1-3 0m3 0a1.5 1.5 0 1 0-3 0M3.75 6H7.5m3 12h9.75m-9.75 0a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m-3.75 0H7.5m9-6h3.75m-3.75 0a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m-9.75 0h9.75" />
        </svg>
        <?php echo $button_change_settings; ?>
    </button>
</div>
<div id="google-consent-mode" class="<?php echo $position ? $position : 'bottom_right'; ?>" style="display: none;">
    <div id="google-consent-mode-window">
        <div id="google-consent-mode-window-header">
            <strong id="google-consent-mode-window-header-title"><?php echo $window_update_title; ?></strong>
            <button type="button" role="button" id="consent-window-update-close-button">&times;</button>
        </div>
        <div id="google-consent-mode-window-body">
            <div id="google-consent-mode-window-customise">
                <div id="google-consent-mode-window-update-details">
                    <p><b><?php echo $window_update_consent_id; ?>:</b> <span id="consent-id-value">-</span></p>
                    <p><b><?php echo $window_update_consent_date; ?>:</b> <span id="consent-date-value">-</span></p>
                </div>
                <?php foreach ($params as $param) { ?>
                    <div class="consent-window-switch">
                        <input type="checkbox" class="custom-control-input" id="consent-window-switch-<?php echo $param; ?>">
                        <label class="custom-control-label" for="consent-window-switch-<?php echo $param; ?>">
                            <div class="consent-window-switch-switcher"></div>
                            <span><?php echo ${$param}; ?></span>
                        </label>
                    </div>
                <?php } ?>
                <?php if ($information) { ?>
                <a href="<?php echo $information; ?>" target="_blank"><?php echo $link_label; ?></a>
                <?php } ?>
            </div>
        </div>
        <div id="google-consent-mode-window-footer">
            <button type="button" role="button" id="consent-window-reject"><?php echo $button_decline; ?></button>
            <button type="button" role="button" id="consent-window-accept"><?php echo $button_accept; ?></button>
        </div>
    </div>
</div>
<script>
    document.getElementById('consent-window-update-button').addEventListener('click', function() {
        <?php foreach ($params as $param) { ?>
            var checkbox = document.getElementById('consent-window-switch-<?php echo $param; ?>');

            if (document.cookie.indexOf('<?php echo $param; ?>=granted') !== -1) {
                checkbox.checked = true;
            } else {
                checkbox.checked = false;
            }
        <?php } ?>

        // Set consent ID and date values
        var consentId = document.cookie.replace(/(?:(?:^|.*;\s*)google_consent_v2_uuid\s*\=\s*([^;]*).*$)|^.*$/, "$1");
        var consentDate = document.cookie.replace(/(?:(?:^|.*;\s*)google_consent_v2_date_added\s*\=\s*([^;]*).*$)|^.*$/, "$1");
        document.getElementById('consent-id-value').textContent = consentId ? consentId : '-';
        document.getElementById('consent-date-value').textContent = consentDate ? consentDate : '-';

        document.getElementById('google-consent-mode').style.display = 'block';
    });

    document.getElementById('consent-window-update-close-button').addEventListener('click', function() {
        document.getElementById('google-consent-mode').style.display = 'none';
    });

    initGoogleConsentForm();
</script>
<?php } ?>
<?php } ?>