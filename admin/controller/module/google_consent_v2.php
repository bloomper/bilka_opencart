<?php

class ControllerModuleGoogleConsentV2 extends Controller {

    private $version;
    private $error = array();
    private $token_var;
    private $extension_var;
    private $prefix;

    public function __construct($registry) {
        parent::__construct($registry);
        $this->token_var = 'token';
        $this->extension_var = 'extension';
        $this->prefix = '';
        
        require_once(DIR_SYSTEM . 'library/google_consent_v2.php');

        $this->google_consent_v2 = new google_consent_v2($registry);

        $this->version = $this->google_consent_v2->getVersion();
    }

    public function install() {
        $this->load->model('module/google_consent_v2');

        $this->model_module_google_consent_v2->install();
    }

    public function uninstall() {
        $this->load->model('module/google_consent_v2');

        $this->model_module_google_consent_v2->uninstall();
    }

    public function index() {
        if (!$this->checkLicense()) {
            $this->response->redirect($this->url->link('module/google_consent_v2/license', $this->token_var . '=' . $this->session->data[$this->token_var], true));
        }

        $data = $this->load->language('module/google_consent_v2');

        $heading_title = preg_replace('/^.*?\|\s?/ius', '', $this->language->get('heading_title'));
        $data['heading_title'] = $heading_title;
        $this->document->setTitle($heading_title);

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting($this->prefix . 'google_consent_v2', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            if (isset($this->request->post['apply'])) {
                $this->response->redirect($this->url->link('module/google_consent_v2', $this->token_var . '=' . $this->session->data[$this->token_var], true));
            } else {
                $this->response->redirect($this->url->link($this->extension_var . '/module', $this->token_var . '=' . $this->session->data[$this->token_var] . '&type=module', true));
            }
        }

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', $this->token_var . '=' . $this->session->data[$this->token_var], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link($this->extension_var . '/module', $this->token_var . '=' . $this->session->data[$this->token_var] . '&type=module', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $heading_title,
            'href' => $this->url->link('module/google_consent_v2', $this->token_var . '=' . $this->session->data[$this->token_var], true)
        );

        $data['prefix'] = $this->prefix;
        $data['token_var'] = $this->token_var;
        $data[$this->token_var] = $this->session->data[$this->token_var];
        $data['action'] = $this->url->link('module/google_consent_v2', $this->token_var . '=' . $this->session->data[$this->token_var], true);
        $data['cancel'] = $this->url->link($this->extension_var . '/module', $this->token_var . '=' . $this->session->data[$this->token_var] . '&type=module', true);
        $data['text_info'] = sprintf($this->language->get('text_info'), $this->version);

        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();
        $data['languages'] = $languages;

        $fields = $this->google_consent_v2->getFields();

        foreach ($fields as $field) {
            if (isset($this->request->post[$this->prefix . $field])) {
                $data[$this->prefix . $field] = $this->request->post[$this->prefix . $field];
            } else {
                $data[$this->prefix . $field] = $this->config->get($this->prefix . $field);
            }
        }

        // google_consent_v2_buttons_enabled_default fix
        if (!isset($data[$this->prefix . 'google_consent_v2_buttons_enabled_default'])) {
            $data[$this->prefix . 'google_consent_v2_buttons_enabled_default'] = array();
        }

        // google_consent_v2_hard_mode fix
        if (!isset($data[$this->prefix . 'google_consent_v2_hard_mode'])) {
            $data[$this->prefix . 'google_consent_v2_hard_mode'] = 0;
        }

        $this->load->model('catalog/information');

        $information_all = $this->model_catalog_information->getInformations(array());
        $data['information_all'] = array();


        if ($information_all) { 
            foreach ($information_all as $item) { 
                $data['information_all'][] = array(
                    'information_id' => $item['information_id'],
                    'name' => $item['title']
                );
            }
        }

        $data['color_fields'] = $this->google_consent_v2->getColorFields();

        $data['text_fields'] = $this->google_consent_v2->getTextFields();

        $data['date_now'] = date('Y-m-d');

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/google_consent_v2.tpl', $data));
    }

    public function license() {
        $data = $this->load->language('module/google_consent_v2');

        $heading_title = preg_replace('/^.*?\|\s?/ius', '', $this->language->get('heading_title'));
        $data['heading_title'] = $heading_title;
        $this->document->setTitle($heading_title);
    
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', $this->token_var . '=' . $this->session->data[$this->token_var], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link($this->extension_var . '/module', $this->token_var . '=' . $this->session->data[$this->token_var] . '&type=module', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $heading_title,
            'href' => $this->url->link('module/google_consent_v2', $this->token_var . '=' . $this->session->data[$this->token_var], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_license'),
            'href' => $this->url->link('module/google_consent_v2/license', $this->token_var . '=' . $this->session->data[$this->token_var], true)
        );

        $data['prefix'] = $this->prefix;
        $data['token_var'] = $this->token_var;
        $data[$this->token_var] = $this->session->data[$this->token_var];
        $data['action'] = $this->url->link('module/google_consent_v2/license', $this->token_var . '=' . $this->session->data[$this->token_var], true);
        $data['cancel'] = $this->url->link($this->extension_var . '/module', $this->token_var . '=' . $this->session->data[$this->token_var] . '&type=module', true);
        $data['text_info'] = sprintf($this->language->get('text_info'), $this->version);

        if (isset($this->request->post['order_id'])) {
            $data['order_id'] = $this->request->post['order_id'];

            $result = $this->activateLicense($this->request->post['order_id']);

            if ($result['success']) {
                $this->session->data['success'] = $this->language->get('text_success');
                $this->response->redirect($this->url->link('module/google_consent_v2', $this->token_var . '=' . $this->session->data[$this->token_var], true));
            } else {
                $data['error_order_id'] = $result['error'];
            }

        } else {
            $data['order_id'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/google_consent_v2_license.tpl', $data));
    }

    public function checkLicense() {
        if ($this->config->get('config_secure')) {
            $domain = HTTPS_CATALOG;
        } else {
            $domain = HTTP_CATALOG;
        }

        $url = 'https://license.and.co.ua/domain.php?domain=' . $domain;

        $json = $this->fetchData($url);

        $result = json_decode($json, true);

        if (isset($result['success']) && $result['success'] == true) {
            return true;
        } else {
            return false;
        }
    }

    public function activateLicense($order_id) {
        if ($this->config->get('config_secure')) {
            $domain = HTTPS_CATALOG;
        } else {
            $domain = HTTP_CATALOG;
        }
    
        $url = 'https://license.and.co.ua/activate.php?domain=' . urlencode($domain) . '&order_id=' . urlencode($order_id);
        
        $json = $this->fetchData($url);
        
        $result = json_decode($json, true);
        
        if (isset($result['success']) && $result['success'] == true) {
            return array('success' => true, 'error' => '');
        } else {
            $error_message = isset($result['error']) ? $result['error'] : 'Unknown error';
            return array('success' => false, 'error' => $error_message);
        }
    }

    private function fetchData($url) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        
        $response = curl_exec($ch);
        
        if (curl_errno($ch)) {
            $response = json_encode(array('success' => false, 'error' => curl_error($ch)));
        }
        
        curl_close($ch);
        return $response;
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'module/google_consent_v2')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }


        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }

        return !$this->error;
    }

    public function get_logs() {
        $this->load->language('module/google_consent_v2');

        $json = array();

        // Check user permission
        if (!$this->user->hasPermission('modify', 'module/google_consent_v2')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            $this->load->model('module/google_consent_v2');

            $date_from = isset($this->request->get['date_start']) ? $this->request->get['date_start'] : '';
            $date_to = isset($this->request->get['date_end']) ? $this->request->get['date_end'] : '';
            $uuid = isset($this->request->get['uuid']) ? $this->request->get['uuid'] : '';

            $logs = $this->model_module_google_consent_v2->getLogs($date_from, $date_to, $uuid);

            $this->load->model('sale/customer');

            $json['logs'] = array();

            foreach ($logs as $log) {
                if ($log['customer_id']) {
                    $customer_info = $this->model_sale_customer->getCustomer($log['customer_id']);
                } else {
                    $customer_info = array();
                }

                if ($customer_info) {
                    $name = $customer_info['firstname'] . ' ' . $customer_info['lastname'];
                    $href = $this->url->link('sale/customer/edit', $this->token_var . '=' . $this->session->data[$this->token_var] . '&customer_id=' . $log['customer_id'], true);
                } else {
                    $name = $this->language->get('text_guest');
                    $href = '';
                }

                $log_data = array();

                $log_data['uuid'] = $log['uuid'];
                $log_data['action'] = $log['action'];
                $log_data['session_id'] = $log['session_id'];

                $log_data['customer'] = array(
                    'name' => $name,
                    'href' => $href
                );

                $log_data['user_agent'] = $log['user_agent'];
                $log_data['ip'] = $this->getMaskedIp($log['ip']);
                
                $consent = json_decode($log['consent'], true);

                $log_data['consent'] = '';
                $log_data['consent_csv'] = '';

                foreach ($consent as $key => $value) {
                    $log_data['consent'] .= '<strong>' . htmlspecialchars($key) . ':</strong> ' . htmlspecialchars($value) . '<br>';
                    $log_data['consent_csv'] .= $key . ': ' . $value . '/';
                }

                $log_data['date_added'] = date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($log['date_added']));

                $json['logs'][] = $log_data;
            }
        }

        $is_csv = isset($this->request->get['format']) && $this->request->get['format'] === 'csv';

        if (!$is_csv) {
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
            return;
        }

        // CSV Export
        $filename = 'google_consent_v2_logs_' . date('Ymd_His') . '.csv';

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=' . $filename);

        $output = fopen('php://output', 'w');
        fputcsv($output, array(
            $this->language->get('column_uuid'),
            $this->language->get('column_action'),
            $this->language->get('column_session_id'),
            $this->language->get('column_customer'),
            $this->language->get('column_user_agent'),
            $this->language->get('column_ip'),
            $this->language->get('column_consent'),
            $this->language->get('column_date_added')
        ));
        foreach ($json['logs'] as $log) {
            fputcsv($output, array(
                $log['uuid'],
                $log['action'],
                $log['session_id'],
                $log['customer']['name'],
                $log['user_agent'],
                $log['ip'],
                rtrim($log['consent_csv'], '/'),
                $log['date_added']
            ));
        }
        fclose($output);

        exit();
    }

    private function getMaskedIp($ip) {
        if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
            // IPv4
            $parts = explode('.', $ip);
            $parts[3] = '0';
            return implode('.', $parts);
        } elseif (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV6)) {
            // IPv6
            $parts = explode(':', $ip);
            $parts[7] = '0000';
            return implode(':', $parts);
        } else {
            // Invalid IP
            return '';
        }
    }
}
