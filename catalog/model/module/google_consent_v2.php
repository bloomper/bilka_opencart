<?php

class ModelModuleGoogleConsentV2 extends Model {
    public function addAction($consent = array()) {
        if ($this->customer->isLogged()) {
            $customer_id = $this->customer->getId();
        } else {
            $customer_id = 0;
        }

        if (isset($this->request->server['REMOTE_ADDR'])) {
            $ip = $this->request->server['REMOTE_ADDR'];
        } else {
            $ip = '';
        }

        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $user_agent = $this->request->server['HTTP_USER_AGENT'];
        } else {
            $user_agent = '';
        }


        $session_id = $this->session->getId();

        if (isset($this->request->cookie['google_consent_v2_uuid']) && $this->getActionByUuid($this->request->cookie['google_consent_v2_uuid'])) {
            $uuid = $this->request->cookie['google_consent_v2_uuid'];
            $action = 'update';
        } else {
            $uuid = $this->createUniqueUuid();
            $action = 'add';
        }

        $is_reject_all = true;

        foreach ($consent as $value) {
            if ($value === 'granted') {
                $is_reject_all = false;
                break;
            }
        }

        if ($is_reject_all) {
            $action = 'reject_all';
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "google_consent_v2 SET uuid = '" . $this->db->escape($uuid) . "', session_id = '" . $session_id . "', action = '" . $this->db->escape($action) . "', customer_id = '" . (int)$customer_id . "', ip = '" . $this->db->escape($ip) . "', user_agent = '" . $this->db->escape($user_agent) . "', consent = '" . $this->db->escape(json_encode($consent)) . "', date_added = NOW()");

        if ($this->config->get('config_timezone')) {
            $iso_date = new DateTime('now', new DateTimeZone($this->config->get('config_timezone')));
        } else {
            // Use server default timezone if config timezone is not set
            $iso_date = new DateTime('now');
        }

        return array('uuid' => $uuid, 'date_added' => $iso_date->format('c'));
    }

    private function getActionByUuid($uuid) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "google_consent_v2 WHERE uuid = '" . $this->db->escape($uuid) . "'");

        return $query->row;
    }

    private function createUniqueUuid($bytes = 16) {
        if (function_exists('random_bytes')) {
            $data = random_bytes($bytes);
            assert(strlen($data) == $bytes);

            $data[6] = chr((ord($data[6]) & 0x0f) | 0x40); // set version to 0100
            $data[8] = chr((ord($data[8]) & 0x3f) | 0x80); // set bits 6-7 to 10

            return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
        } elseif (function_exists('openssl_random_pseudo_bytes')) {
            $data = openssl_random_pseudo_bytes($bytes);
            assert(strlen($data) == $bytes);

            $data[6] = chr((ord($data[6]) & 0x0f) | 0x40); // set version to 0100
            $data[8] = chr((ord($data[8]) & 0x3f) | 0x80); // set bits 6-7 to 10

            return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
        } else {
            // Fallback to uniqid if neither function is available (less secure)
            return uniqid('', true);
        }
    }
}