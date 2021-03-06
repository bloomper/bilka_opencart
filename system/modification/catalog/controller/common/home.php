<?php
class ControllerCommonHome extends Controller {
	public function index() {

			$seo_pp_store_settings = $this->config->get('seo_pp_store_settings');
			if(!isset($seo_pp_store_settings[$this->config->get('config_language_id')])){
			
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

			} else {
				$clangId = $this->config->get('config_language_id');
				$this->document->setTitle($seo_pp_store_settings[$clangId]['mt']);
				$this->document->setDescription($seo_pp_store_settings[$clangId]['md']);
				$this->document->setKeywords($seo_pp_store_settings[$clangId]['mk']);
			}
			

		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/home.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
		}
	}
}