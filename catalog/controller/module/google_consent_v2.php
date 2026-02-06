<?php

class ControllerModuleGoogleConsentV2 extends Controller {
    private $version;
    private $prefix;

    public function __construct($registry) {
        parent::__construct($registry);
        $this->prefix = (version_compare(VERSION, '3.0', '>=')) ? 'module_' : '';
        require_once(DIR_SYSTEM . 'library/google_consent_v2.php');
        $this->google_consent_v2 = new google_consent_v2($registry);
        $this->version = $this->google_consent_v2->getVersion();
    }

    public function index() {
        if ($this->config->get($this->prefix . 'google_consent_v2_status')) {
            $this->document->addStyle('catalog/view/javascript/google-consent-v2/style.css?v=' . $this->version);
            $this->document->addScript('catalog/view/javascript/google-consent-v2/script.js?v=' . $this->version);

            $fields = $this->google_consent_v2->getColorFields();

            foreach ($fields as $field) {
                $data[$field] = $this->config->get($this->prefix . 'google_consent_v2_' . $field);
            }

            $fields = $this->google_consent_v2->getFieldsWithoutPrefix();

            foreach ($fields as $field) {
                $data[$field] = $this->config->get($this->prefix . 'google_consent_v2_' . $field);
            }

            $fields = $this->google_consent_v2->getTextFields();

            foreach ($fields as $field => $default) {
                if (isset($this->config->get($this->prefix . 'google_consent_v2_' . $field)[$this->config->get('config_language_id')])) {
                    $data[$field] = $this->config->get($this->prefix . 'google_consent_v2_' . $field)[$this->config->get('config_language_id')];
                } else {
                    $data[$field] = '';
                }
            }

            $data['information'] = $this->url->link('information/information', 'information_id=' . $data['information_page']);

            if (isset($this->request->cookie['google_consent_mode_v2']) && isset($this->request->cookie['google_consent_v2_uuid']) && isset($this->request->cookie['google_consent_v2_date_added'])) {
                $data['show'] = false;
            } else {
                $data['show'] = true;
            }

            if (!empty($data['information_page']) && isset($this->request->get['information_id']) && $this->request->get['information_id'] == $data['information_page']) {
                $data['exclude'] = true;
            } else {
                $data['exclude'] = false;
            }

            $data['params'] = ['ad_storage', 'ad_user_data', 'ad_personalization', 'analytics_storage', 'personalization_storage', 'security_storage', 'functionality_storage'];

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/google_consent_v2.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/module/google_consent_v2.tpl', $data);
            } else {
                return $this->load->view('default/template/module/google_consent_v2.tpl', $data);
            }
        }
    }

    public function add_action() {
        $consent = array(
            'ad_storage'             => 'denied',
            'ad_user_data'           => 'denied',
            'ad_personalization'     => 'denied',
            'analytics_storage'      => 'denied',
            'functionality_storage'  => 'denied',
            'personalization_storage'=> 'denied',
            'security_storage'       => 'denied'
        );

        foreach ($consent as $key => $value) {
            if (isset($this->request->cookie[$key]) && in_array($this->request->cookie[$key], ['granted', 'denied'])) {
                $consent[$key] = $this->request->cookie[$key];
            }
        }

        $this->load->model('module/google_consent_v2');

        $action = $this->model_module_google_consent_v2->addAction($consent);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode(['uuid' => !empty($action['uuid']) ? $action['uuid'] : '', 'date_added' => !empty($action['date_added']) ? $action['date_added'] : '']));
    }
}
