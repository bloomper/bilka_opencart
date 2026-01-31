<?php
class Controllermodulegafenh extends Controller {
	private $modpath = 'module/gafenh'; 
	private $modvar = 'model_module_gafenh';
	public function __construct($registry) {		
		parent::__construct($registry);		
		ini_set("serialize_precision", -1);
		if(substr(VERSION,0,3)=='2.3' || substr(VERSION,0,3)=='3.0') {
			$this->modpath = 'extension/module/gafenh';
			$this->modvar = 'model_extension_module_gafenh';
		}
		if(substr(VERSION,0,3)=='4.0' || substr(VERSION,0,3)=='4.1') {
			$this->modpath = 'extension/gafenh/module/gafenh';
			$this->modvar = 'model_extension_gafenh_module_gafenh';
		}
 	}	
	public function index() {
		$this->load->model($this->modpath);
		$this->{$this->modvar}->index();
	}	
	public function save() {
		$this->load->model($this->modpath);
		$this->{$this->modvar}->save();
	}	
	public function install() {
		$this->load->model($this->modpath);
		$this->{$this->modvar}->install();
	}
	public function uninstall() {
		$this->load->model($this->modpath);
		$this->{$this->modvar}->uninstall();
	}
	public function loadjscss(&$route, &$data, &$output = '') {
		$this->load->model($this->modpath);
		$this->{$this->modvar}->loadjscss();
	}
}