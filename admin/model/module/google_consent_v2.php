<?php

class ModelModuleGoogleConsentV2 extends Model {
    public function install() {
        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "google_consent_v2` (
                `google_consent_v2_id` INT NOT NULL AUTO_INCREMENT,
                `uuid` VARCHAR(36) NOT NULL,
                `action` VARCHAR(255) NOT NULL,
                `session_id` VARCHAR(255) NOT NULL,
                `customer_id` INT NOT NULL,
                `user_agent` TEXT NOT NULL,
                `ip` VARCHAR(45) NOT NULL,
                `consent` TEXT NOT NULL,
                `date_added` DATETIME NOT NULL,
                PRIMARY KEY (`google_consent_v2_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
        ");
    }

    public function uninstall() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "google_consent_v2`;");
    }

    public function getLogs($date_start = null, $date_end = null, $uuid = null) {
        $sql = "SELECT * FROM `" . DB_PREFIX . "google_consent_v2` WHERE 1";

        if ($date_start) {
            $sql .= " AND DATE(`date_added`) >= '" . $this->db->escape($date_start) . "'";
        }

        if ($date_end) {
            $sql .= " AND DATE(`date_added`) <= '" . $this->db->escape($date_end) . "'";
        }

        if ($uuid) {
            $sql .= " AND `uuid` = '" . $this->db->escape($uuid) . "'";
        }

        $sql .= " ORDER BY `date_added` DESC";

        $query = $this->db->query($sql);

        return $query->rows;
    }
}