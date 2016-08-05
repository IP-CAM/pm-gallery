<?php
class ControllerCatalogPMGalleryMenu extends Controller {
	public function index() {
		if (isset($this->request->get['token']) && isset($this->session->data['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
		    $this->load->language('catalog/pm_gallery');
        $this->load->model('catalog/pm_gallery');
    $module_info = $this->model_catalog_pm_gallery->getModules();
    $module_id = 0;
    if( !isset($this->request->get['module_id']) && count($module_info) > 0 ){
      $module_id = $module_info[0]['module_id'];
    } 
    if(isset($this->request->get['module_id'])){
      $module_id = $this->request->get['module_id'];  
    }
                       $data['text_load_images'] = $this->language->get('text_load_images');
                       $data['text_change_order'] = $this->language->get('text_change_order');
                       $data['text_delete_images'] = $this->language->get('text_delete_images');
                       $data['text_manage_folder'] = $this->language->get('text_manage_folder');
                       $data['text_change'] = $this->language->get('text_change');
                       $data['text_settings'] = $this->language->get('text_settings');
                                                                                                                                          
     $data['delete'] = $this->url->link('catalog/pm_gallery/delete', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');  
     $data['upload'] = $this->url->link('catalog/pm_gallery/upload', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');
     $data['gallery_texts'] = $this->url->link('catalog/pm_gallery/settings', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');
     $data['managefolder'] = $this->url->link('catalog/pm_gallery/managefolder', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');
     $data['change'] = $this->url->link('catalog/pm_gallery/edit', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');
     $data['setting'] = $this->url->link('module/pm_gallery', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');

			return $this->load->view('catalog/pm_gallery_menu.tpl', $data);
		}
	}
}
