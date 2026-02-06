<?php

class google_consent_v2 {
    private $version = '3.0.2512301943';
    private $prefix = 'google_consent_v2_';
    
    private $fields = [
        'google_consent_v2_status',
        'google_consent_v2_hard_mode',
        'google_consent_v2_position',
        'google_consent_v2_update_enabled',
        'google_consent_v2_window_title',
        'google_consent_v2_window_text',
        'google_consent_v2_ad_storage',
        'google_consent_v2_ad_user_data',
        'google_consent_v2_ad_personalization',
        'google_consent_v2_analytics_storage',
        'google_consent_v2_functionality_storage',
        'google_consent_v2_personalization_storage',
        'google_consent_v2_security_storage',
        'google_consent_v2_button_accept',
        'google_consent_v2_button_customise',
        'google_consent_v2_button_back',
        'google_consent_v2_button_decline',
        'google_consent_v2_link_label',
        'google_consent_v2_button_change_settings',
        'google_consent_v2_window_update_title',
        'google_consent_v2_window_update_consent_id',
        'google_consent_v2_window_update_consent_date',
        'google_consent_v2_information_page',
        'google_consent_v2_background_color',
        'google_consent_v2_theme_primary_color',
        'google_consent_v2_theme_primary_text_color',
        'google_consent_v2_buttons_enabled_default',
    ];

    private $color_fields = [
        'background_color' => '#FFFFFF',
        'theme_primary_color' => '#1B1B32',
        'theme_primary_text_color' => '#FFFFFF',
    ];

    private $text_fields = [
        'window_title'            => 'This site uses cookies',
        'window_text'             => 'This site uses cookies to store information on your computer. Some of these cookies are essential to make our site work and others help us to improve by giving us some insight into how the site is being used. By using our site you accept the terms of our Privacy Policy.',
        'ad_storage'              => 'Ad storage',
        'ad_user_data'            => 'Ad user data',
        'ad_personalization'      => 'Ad personalization',
        'analytics_storage'       => 'Analytics storage',
        'functionality_storage'   => 'Functionality storage',
        'personalization_storage' => 'Personalization storage',
        'security_storage'        => 'Security storage',
        'button_accept'           => 'Accept cookies',
        'button_customise'        => 'Customise',
        'button_back'             => 'Back',
        'button_decline'          => 'Decline all cookies',
        'link_label'              => 'Privacy Policy',
        'button_change_settings'  => 'Cookies',
        'window_update_title'     => 'Update your cookie settings',
        'window_update_consent_id'  => 'Your consent ID',
        'window_update_consent_date'  => 'Consent updated on',
    ];

    public function getVersion() {
        return $this->version;
    }

    public function getFields() {
        return $this->fields;
    }

    public function getColorFields() {
        return $this->color_fields;
    }

    public function getTextFields() {
        return $this->text_fields;
    }

    public function getFieldsWithoutPrefix() {
        $fields_without_prefix = [];
        foreach ($this->fields as $field) {
            $fields_without_prefix[] = str_replace($this->prefix, '', $field);
        }
        return $fields_without_prefix;
    }
}