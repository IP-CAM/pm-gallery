<?php
class ControllerModulePMGallery extends Controller {
	private $error = array(); 
  private $pm_gallery = array();

  public function index($setting) {
    $this->pm_gallery = $setting;
    $data = array();
		$this->language->load('module/pm_gallery');

             $this->load->model('catalog/pm_gallery');
             $this->load->model('tool/image');
                                   
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);
		$this->document->setTitle($this->language->get('heading_title'));
     $data = array_merge($data,$setting);
     $data = array_merge($data,$this->language->load('module/pm_gallery'));
   
       extract($setting);
    if($pm_slider_type == 'pmslider'){
        $this->document->addStyle('catalog/view/javascript/jquery/pm-gallery/css/pm-gallery.css');
       $this->document->addScript('catalog/view/javascript/jquery/pm-gallery/pmslider.js');
    }
    if($pm_slider_type == 'slice'){
       $this->document->addStyle('catalog/view/javascript/jquery/pm-gallery/css/slicebox.css');
       $this->document->addStyle('catalog/view/javascript/jquery/pm-gallery/css/custom.css');
       $this->document->addStyle('catalog/view/javascript/jquery/pm-gallery/css/demo.css');
       $this->document->addScript('catalog/view/javascript/jquery/pm-gallery/modernizr.custom.46884.js');
   }
                    $data['pm_gallery_module'] = true;

                    $data['galleries'] = array();
                    $data['pm_help_text'] = str_replace("\r\n","",$data['txt_help_text']); 
                    $data['pm_help_text'] = str_replace("\n","",$data['txt_help_text']); 
                   
                    $data['folder'] = '';
                    $data['description'] = '';
     
                    $data['folders'] = array();
        $folders =  $this->model_catalog_pm_gallery->getFolders($module_id); 
   
       foreach($folders as $key => $value){
        $data = array_merge($data,$value);
        extract($value);
       }
          if(!isset($this->request->get['album'])){
                    if($folders){
                          $data['folders'] = $folders;
                            if($pm_folders != 1){
                                           $data['minFolder'] =  $this->model_catalog_pm_gallery->getMinFolder();
                            }
                                  foreach($folders as $folder){             
                                     $data['folder'] = $folder['folder'];
                                     $data['folder_description'] = $folder['title'];
                                  }
                   }
          } 
      
        
          $data['image_path'] = $pm_galleries . $name . '/';
          $data['db'] = $this->db;

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
      }

                  $data['count'] = count($folders);
                  $data['album'] = "";
                  if(isset($this->request->get['album'])){
                                      $data['album'] = $this->request->get['album'];
                  }  
       $data['module_id'] = $module_id;     
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pm_gallery.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/pm_gallery.tpl', $data);
		} else {
			return $this->load->view('default/template/module/pm_gallery.tpl', $data);
		}
  }
  public function explorer(){
        $json = array();
        $this->load->model('catalog/pm_gallery');
        if(isset($this->request->get['pm_galleries']) && isset($this->request->get['module_id']) && isset($this->request->get['folder_id'])){

       $settings = $this->settings($this->request->post['module_id']);

       extract($settings);
       
            $json = $this->model_catalog_pm_gallery->explorer($pm_galleries,$this->request->get);
        }
              $this->response->addHeader('Content-Type: application/json');
              $this->response->setOutput(json_encode($json));
  }
  public function navpics(){
        $json = array();
        $json['success'] = '';
        $json['error'] = '';
        $json['prev']['image'] = '';
        $json['next']['image'] = '';
        $this->load->model('catalog/pm_gallery');
     if(isset($this->request->post['module_id'])){
       $settings = $this->settings($this->request->post['module_id']);

       extract($settings);
         $query = $this->model_catalog_pm_gallery->navThumbs($pm_galleries,$this->request->post); 
         $json = $query;
    }
              $this->response->addHeader('Content-Type: application/json');
              $this->response->setOutput(json_encode($json));
  }
  public function vcomm(){
    $this->language->load('module/pm_gallery');
    $this->load->model("catalog/pm_gallery");

    $json = array();
    $json['success'] = '';
    $json['error'] = '';
     if(isset($this->request->post['module_id'])){
       $settings = $this->settings($this->request->post['module_id']);

       extract($settings);
         $sx = $this->model_catalog_pm_gallery->addComment($this->request->post); 

       if(empty($this->request->post['name'])){
           $json['error'] = $this->language->load('error_name');
       }
       if(empty($this->request->post['comment'])){
          $json['error'] = $this->language->load('error_comment');
       }

      if($pm_moderate_posts == 1){
        $address = HTTP_SERVER . $this->request->post['file'];

             $content = sprintf($this->language->load('txt_new_comment'),$address,$address);

      $mail = new Mail();
      $mail->protocol = $this->config->get('config_mail_protocol');
      $mail->parameter = $this->config->get('config_mail_parameter');
      $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
      $mail->smtp_username = $this->config->get('config_mail_smtp_username');
      $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
      $mail->smtp_port = $this->config->get('config_mail_smtp_port');
      $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

      $mail->setTo($pm_admin_mail);
      $mail->setFrom($this->config->get('config_email'));
      $mail->setSender(html_entity_decode($this->request->post['name'], ENT_QUOTES, 'UTF-8'));
      $mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name']), ENT_QUOTES, 'UTF-8'));
      $mail->setText($content);
      $mail->send();
      } 

      if(!$json['error']){
         $sx = $this->model_catalog_pm_gallery->addComment($this->request->post); 
         $json['success'] = 'OK';  

      }
    }
         $this->response->addHeader('Content-Type: application/json');
         $this->response->setOutput(json_encode($json));
  }
  public function comment(){
    $this->language->load('module/pm_gallery');
    $this->load->model("catalog/pm_gallery");

        $json = array();
    $json['success'] = '';
    $json['error'] = '';
     if(isset($this->request->post['module_id'])){
       $query = $this->model_catalog_pm_gallery->getComment($this->request->post);
       $json['comments'] = $query;
       $json['success'] = 'OK';
    }
         $this->response->addHeader('Content-Type: application/json');
         $this->response->setOutput(json_encode($json));
  }
  public function settings($module_id){
         $this->load->model("catalog/pm_gallery");
         $json = $this->model_catalog_pm_gallery->getSetting($module_id);
         return $json;
  }
  public function slider(){
        $this->language->load('module/pm_gallery');
        $this->load->model("catalog/pm_gallery");
      if(isset($this->request->post['module_id'])){
         $json = $this->model_catalog_pm_gallery->getImages($this->request->post,$this->settings($this->request->post['module_id']));
         $this->response->addHeader('Content-Type: application/json');
         $this->response->setOutput(json_encode($json));
      }
  }
}
