<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right form-inline">
                <button type="submit" form="form-module" name="apply" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-check"></i></button>
                <button type="submit" form="form-module" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
            </div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($success) { ?>
            <div class="alert alert-success alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                <span class="pull-right"><?php echo $text_info; ?></span>
            </div>
            <div class="panel-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-main" data-toggle="tab"><?php echo $tab_main; ?></a></li>
                    <li><a href="#tab-customization" data-toggle="tab"><?php echo $tab_customization; ?></a></li>
                    <li><a href="#tab-log" data-toggle="tab"><?php echo $tab_log; ?></a></li>
                    <li><a href="#tab-help" data-toggle="tab"><?php echo $tab_help; ?></a></li>
                </ul>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
                    <div class="tab-content">
                        <div class="tab-pane active form-horizontal" id="tab-main">
                            <!-- Module status -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status"><span class="help" title="<?php echo $help_status; ?>" data-toggle="tooltip"><?php echo $entry_status; ?></span></label>
                                <div class="col-sm-10">
                                    <select name="<?php $prefix; ?>google_consent_v2_status" id="input-status" class="form-control">
                                        <option value="0" <?php echo ("0" == ${$prefix . 'google_consent_v2_status'}) ? "selected" : ""; ?>><?php echo $text_disabled; ?></option>
                                        <option value="1" <?php echo ("1" == ${$prefix . 'google_consent_v2_status'}) ? "selected" : ""; ?>><?php echo $text_enabled; ?></option>
                                    </select>
                                </div>
                            </div>
                            <!-- Hard Mode status -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-hard-mode"><span class="help" title="<?php echo $help_hard_mode; ?>" data-toggle="tooltip"><?php echo $entry_hard_mode; ?></span></label>
                                <div class="col-sm-10">
                                    <select name="<?php echo $prefix; ?>google_consent_v2_hard_mode" id="input-hard-mode" class="form-control">
                                        <option value="0" <?php echo ("0" == ${$prefix . 'google_consent_v2_hard_mode'}) ? "selected" : ""; ?>><?php echo $text_disabled; ?></option>
                                        <option value="1" <?php echo ("1" == ${$prefix . 'google_consent_v2_hard_mode'}) ? "selected" : ""; ?>><?php echo $text_enabled; ?></option>
                                    </select>
                                    <span class="help-block"><?php echo $help_hard_mode; ?></span>
                                </div>
                            </div>
                            <!-- Module position -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-position"><span class="help" title="<?php echo $help_position; ?>" data-toggle="tooltip"><?php echo $entry_position; ?></span></label>
                                <div class="col-sm-10">
                                    <select name="<?php echo $prefix; ?>google_consent_v2_position" id="input-position" class="form-control">
                                        <option value="bottom_right" <?php echo ("bottom_right" == ${$prefix . 'google_consent_v2_position'}) ? "selected" : ""; ?>><?php echo $text_position_bottom_right; ?></option>
                                        <option value="bottom_left" <?php echo ("bottom_left" == ${$prefix . 'google_consent_v2_position'}) ? "selected" : ""; ?>><?php echo $text_position_bottom_left; ?></option>
                                    </select>
                                    <span class="help-block"><?php echo $help_position; ?></span>
                                </div>
                            </div>
                            <!-- Module update enabled -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-update-enabled"><span class="help" title="<?php echo $help_update_enabled; ?>" data-toggle="tooltip"><?php echo $entry_update_enabled; ?></span></label>
                                <div class="col-sm-10">
                                    <select name="<?php echo $prefix; ?>google_consent_v2_update_enabled" id="input-update-enabled" class="form-control">
                                        <option value="0" <?php echo ("0" == ${$prefix . 'google_consent_v2_update_enabled'}) ? "selected" : ""; ?>><?php echo $text_disabled; ?></option>
                                        <option value="1" <?php echo ("1" == ${$prefix . 'google_consent_v2_update_enabled'}) ? "selected" : ""; ?>><?php echo $text_enabled; ?></option>
                                    </select>
                                    <span class="help-block"><?php echo $help_update_enabled; ?></span>
                                </div>
                            </div>
                            <!-- Module text fields -->
                            <?php foreach ($text_fields as $key => $value) { ?>
                                <div class="form-group">
                                    <?php $label = ${'entry_' . $key}; ?>
                                    <label class="col-sm-2 control-label"><?php echo $label; ?></label>
                                    <div class="col-sm-10">
                                        <?php foreach ($languages as $language) { ?>
                                        <?php $variable_value = isset(${$prefix . 'google_consent_v2_' . $key}[$language['language_id']]) ? ${$prefix . 'google_consent_v2_' . $key}[$language['language_id']] : ''; ?>
                                        <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                            <input type="text" name="<?php echo $prefix; ?>google_consent_v2_<?php echo $key; ?>[<?php echo $language['language_id']; ?>]" value="<?php echo $variable_value ? $variable_value : $value; ?>" placeholder="<?php echo $label; ?>" id="input-<?php echo $key; ?><?php echo $language['language_id']; ?>" class="form-control"/>
                                        </div>
                                        <?php } ?>
                                        <?php if (isset(${'help_' . $key})) { ?>
                                        <span class="help-block"><?php echo ${'help_' . $key}; ?></span>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <!-- Module information page -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-information-page"><?php echo $entry_information_page; ?></label>
                                <div class="col-sm-10">
                                    <select name="<?php echo $prefix; ?>google_consent_v2_information_page" id="input-information-page" class="form-control">
                                        <option value="0"><?php echo $text_none; ?></option>
                                        <?php foreach ($information_all as $item) { ?>
                                            <option value="<?php echo $item['information_id']; ?>" <?php echo ($item['information_id'] == ${$prefix . 'google_consent_v2_information_page'}) ? "selected" : ""; ?>><?php echo $item['name']; ?></option>
                                        <?php } ?>
                                    </select>
                                    <?php if (isset($help_information_page)) { ?>
                                    <span class="help-block"><?php echo $help_information_page; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane form-horizontal" id="tab-customization">
                            <?php foreach ($color_fields as $key => $value) { ?>
                                <div class="form-group">
                                    <?php $label = ${'entry_' . $key}; ?>
                                    <label class="col-sm-2 control-label"><?php echo $label; ?></label>
                                    <div class="col-sm-10">
                                        <?php $variable_value = ${$prefix . 'google_consent_v2_' . $key}; ?>
                                        <input type="color" name="<?php echo $prefix; ?>google_consent_v2_<?php echo $key; ?>" value="<?php echo $variable_value ? $variable_value : $value; ?>" placeholder="<?php echo $label; ?>" id="input-<?php echo $key; ?>" class="form-control"/>
                                        <?php if (isset(${'help_' . $key})) { ?>
                                        <span class="help-block"><?php echo ${'help_' . $key}; ?></span>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><?php echo $entry_buttons_enabled_default; ?></label>
                                <div class="col-sm-10">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="ad_storage" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("ad_storage", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_ad_storage; ?>
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="ad_user_data" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("ad_user_data", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_ad_user_data; ?>
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="ad_personalization" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("ad_personalization", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_ad_personalization; ?>
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="analytics_storage" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("analytics_storage", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_analytics_storage; ?>
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="functionality_storage" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("functionality_storage", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_functionality_storage; ?>
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="personalization_storage" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("personalization_storage", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_personalization_storage; ?>
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="<?php echo $prefix; ?>google_consent_v2_buttons_enabled_default[]" value="security_storage" <?php echo (is_array(${$prefix . 'google_consent_v2_buttons_enabled_default'}) && in_array("security_storage", ${$prefix . 'google_consent_v2_buttons_enabled_default'})) ? "checked" : ""; ?>/> <?php echo $entry_security_storage; ?>
                                        </label>
                                    </div>
                                    <?php if (isset($help_buttons_enabled_default)) { ?>
                                    <span class="help-block"><?php echo $help_buttons_enabled_default; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane form-horizontal" id="tab-log">
                            <div class="form-group">
                                <div class="col-sm-3">
                                    <div class="input-group date">
                                        <input type="text" name="filter_date_start" value="<?php echo $date_now; ?>" placeholder="<?php echo $entry_filter_date_start; ?>" data-date-format="YYYY-MM-DD" id="input-filter-date-start" class="form-control"/>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                    <span class="help-block"><?php echo $help_filter_date_start; ?></span>
                                </div>
                                <div class="col-sm-3">
                                    <div class="input-group date">
                                        <input type="text" name="filter_date_end" value="<?php echo $date_now; ?>" placeholder="<?php echo $entry_filter_date_end; ?>" data-date-format="YYYY-MM-DD" id="input-filter-date-end" class="form-control"/>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                    <span class="help-block"><?php echo $help_filter_date_end; ?></span>
                                </div>
                                <div class="col-sm-3">
                                    <input type="text" name="filter_uuid" value="" placeholder="<?php echo $entry_filter_uuid; ?>" id="input-filter-uuid" class="form-control"/>
                                    <span class="help-block"><?php echo $help_filter_uuid; ?></span>
                                </div>
                                <div class="col-sm-3 text-right">
                                    <button type="button" onclick="getLog();" id="button-filter-log" class="btn btn-primary"><i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>
                                    <button type="button" onclick="downloadLog();" id="button-download-log" class="btn btn-success"><i class="fa fa-download"></i> <?php echo $button_download; ?></button>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $column_uuid; ?></td>
                                            <td class="text-left"><?php echo $column_action; ?></td>
                                            <td class="text-left"><?php echo $column_session_id; ?></td>
                                            <td class="text-left"><?php echo $column_customer; ?></td>
                                            <td class="text-left"><?php echo $column_user_agent; ?></td>
                                            <td class="text-left"><?php echo $column_ip; ?></td>
                                            <td class="text-left"><?php echo $column_consent; ?></td>
                                            <td class="text-left"><?php echo $column_date_added; ?></td>
                                        </tr>
                                    </thead>
                                    <tbody id="log-entries"></tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane form-horizontal" id="tab-help">
                            <div id="help-container"></div>
                            <script>
                                document.addEventListener('DOMContentLoaded', function() {
                                    const url = 'https://raw.githubusercontent.com/and-ri/opencart-modules-readme/refs/heads/main/google-consent-mode-v2/faq.html?key=' + Math.random();

                                    fetch(url)
                                        .then(response => response.text())
                                        .then(text => {
                                            document.getElementById('help-container').innerHTML = text;
                                        });

                                });
                            </script>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
<script type="text/javascript"><!--
    $('.nav[id*=language]').find('a:first').tab('show');
    $('.date').datetimepicker({
        language: '<?php echo $datepicker; ?>',
        pickTime: false
    });


    function getLog() {
        const dateStart = $('#input-filter-date-start').val();
        const dateEnd = $('#input-filter-date-end').val();
        const uuid = $('#input-filter-uuid').val();

        // Set Button states
        $('#button-filter-log').button('loading');
        $('#log-entries').html('');

        // AJAX Request
        fetch('index.php?route=module/google_consent_v2/get_logs&token=<?php echo $token; ?>&date_start=' + dateStart + '&date_end=' + dateEnd + '&uuid=' + uuid)
            .then(response => response.json())
            .then(data => {
                data.logs.forEach(function(log) {
                    const row = `<tr>
                        <td class="text-left">${log.uuid}</td>
                        <td class="text-left">${log.action}</td>
                        <td class="text-left">${log.session_id}</td>
                        <td class="text-left">${log.customer.href ? `<a href="${log.customer.href}">${log.customer.name}</a>` : log.customer.name}</td>
                        <td class="text-left">${log.user_agent}</td>
                        <td class="text-left">${log.ip}</td>
                        <td class="text-left">${log.consent}</td>
                        <td class="text-left">${log.date_added}</td>
                    </tr>`;
                    $('#log-entries').append(row);
                });

                if (data.logs.length === 0) {
                    const row = `<tr>
                        <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                    </tr>`;
                    $('#log-entries').append(row);
                }
            })
            .finally(() => {
                $('#button-filter-log').button('reset');
            });
    }

    function downloadLog() {
        const dateStart = $('#input-filter-date-start').val();
        const dateEnd = $('#input-filter-date-end').val();
        const uuid = $('#input-filter-uuid').val();

        const downloadUrl = 'index.php?route=module/google_consent_v2/get_logs&token=<?php echo $token; ?>&date_start=' + dateStart + '&date_end=' + dateEnd + '&uuid=' + uuid + '&format=csv';

        // Open in new tab
        window.open(downloadUrl, '_blank');
    }

    $(document).ready(function() {
        getLog();
    });

//--></script>
</div>
<?php echo $footer; ?>