<?php 
class ControllerCatalogPMGallery extends Controller { 
	private $error = array();
	public function index() {
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
                                    
    $this->document->addStyle('view/stylesheet/pm_gallery.css');
    $this->load->model('extension/module');
    $this->load->model('catalog/pm_gallery');
		$this->document->setTitle($this->language->get('heading_title'));
    $data['action'] = $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL');
    $data['token'] = $this->session->data['token'];
    $data['route'] = 'catalog/pm_gallery';
		        
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
		      'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
           'href'      => $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
     $data['heading_title'] = $this->language->get('heading_title');
   
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

    $module_info = $this->model_catalog_pm_gallery->getModules();
    $data['module_id'] = 0;
    $data['module_info'] = array();
    if(count($module_info) > 1){
      $data['module_info'] = $module_info;
       $data['type'] = 2;
    } elseif (count($module_info) == 1){
       $data['module_id'] = $module_info[0]['module_id'];
       $data['menu'] = $this->load->controller('catalog/pm_gallery_menu');
       $data['type'] = 1;
    }
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');

    if(isset($this->request->get['module_id'])){
       $data['module_id'] = $this->request->get['module_id'];
       $data['style'] = 'float:right;';
       $data['col'] = 'col-md-9';
    } else {
      $data['style'] = 'text-align:center;padding:30px';
      $data['col'] = 'col-md-12';
    }
    $data['footer'] = $this->load->controller('common/footer');

    $this->response->setOutput($this->load->view('catalog/pm_gallery_select.tpl', $data));
   }
  public function insert() {
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/pm_gallery');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_pm_gallery->addKoschtitGallery($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
         $this->response->redirect($this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}

            $this->setting();
    }
     public function update() {
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/pm_gallery');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_pm_gallery->editKoschtitGallery($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->response->redirect($this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		$this->setting();
	}
  public function delete(){
    $this->document->addStyle('view/stylesheet/pm_gallery.css');
    $language_info = $this->language->load('catalog/pm_gallery');
          $this->load->model('extension/module'); 

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
	
	
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
	 	    'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
                                    
                                    
		$this->load->model('catalog/pm_gallery');
		$data['heading_title'] = $this->language->get('heading_title');
                                    
                                    if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
          if (isset($this->request->get['module_id'])) {
              $settings = $this->model_extension_module->getModule($this->request->get['module_id']);
              $data['folders'] = $this->model_catalog_pm_gallery->getFolders($this->request->get['module_id']);   
              $module_id = $this->request->get['module_id'];
              $data['module_id'] = $module_id;
          }  
            $data['image_path'] = $this->url->link('catalog/pm_gallery/image', 'module_id='.$module_id.'&token=' . $this->session->data['token'], 'SSL');            
         extract($settings); 
         $album = false;

         if(isset($this->request->get['folder'])){
         	$album = $this->request->get['folder'];
         }   
                                 
                              $data['folders'] = $this->model_catalog_pm_gallery->getFolders($pm_base,$pm_galleries);
                              $data['images'] = array();
                             if($album){
                               
                                   $this->model_catalog_pm_gallery->updateFiles($album,'../'.$pm_galleries,$module_id);   
                                   $data['images'] = $this->model_catalog_pm_gallery->getDatabaseFolder($album);

                              }
                                   
                                      $data['file_get_empty'] = "";
                                      $data['get_gallery_empty'] = "";
                                      $data['file_not_found'] = "";
                                      
                     if(isset($this->request->get['file']) && $this->validateForm()){

                                                    $done =  $this->model_catalog_pm_gallery->deleteImage($this->request->get,$pm_fr_gallery);
             
                                     if($done == 'Error'){
                                        $data['error_permission'] = sprintf($this->language->get('text_error_permission'),$done);
                                      } else{
                                        $data['error_permission']  = '';
                                      }
                     }
                   $to_database = $this->model_catalog_pm_gallery->getDatabaseImages($album);
                   $data['no_thumbs'] = "";
	
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		   $total = count($data['images']);
                       
          $pages = ceil($total/$pm_admin_limit);
          $max = $pages*$pm_admin_limit;
          
          if(isset($this->request->get['page'])){
                    $data['page'] = $this->request->get['page'];
                    $page = $this->request->get['page'];
                    
                    $data['start'] = ($page-1)*$admin_limit;
                    
                    if($page !=$pages or $pages == $page && $total == $max){
                      $data['plimit'] = $page*$admin_limit;
                    }
                    if($page == $pages && $total < $max){
                      $data['plimit'] = $total;
                    }
          } else{
                    $this->request->get['page'] = '';
                    $page = 1;
                    $data['page'] = 1;
                    $data['start'] = 0;
                    if($total >= $pm_admin_limit){
                    $data['plimit'] = $pm_admin_limit;
                    } else{
                     if($total > 0){
                        $data['plimit'] =  $total;
                        } else{
                                  $data['plimit'] = 0;
                        }
                                  
                    }
          } 
                                              $pagination = new Pagination();
                                              $pagination->total = $total;
                                              $pagination->page = $page;
                                              $pagination->limit = $pm_admin_limit;
                                              $pagination->text = $this->language->get('text_pagination');
                                              $pagination->url = $this->url->link('catalog/pm_gallery/delete', 'token=' . $this->session->data['token'].'&album='.$album.'&page={page}','SSL');
                       
                                              $data['pagination'] = $pagination->render();
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['footer'] = $this->load->controller('common/footer');
    $data['menu'] = $this->load->controller('catalog/pm_gallery_menu');

    $this->response->setOutput($this->load->view('catalog/pm_gallery_delete.tpl', $data));
                                    
  }
  public function edit(){
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
          $this->document->addStyle('view/stylesheet/pm_gallery.css');
	
	
                       $data['breadcrumbs'][] = array(
                       'text'      => $this->language->get('text_home'),
                       'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
                       'separator' => false
                       );

                       $data['breadcrumbs'][] = array(
                       'text'      => $this->language->get('heading_title'),
                       'href'      => $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
                       'separator' => ' :: '
                       );    
                                    
                       $this->load->model('catalog/pm_gallery');
                       
                       $data['heading_title'] = $this->language->get('heading_title');
                       
                                              
                       $data['button_cancel'] = $this->language->get('button_cancel');
                       $data['button_save'] = $this->language->get('button_save');
                       
                       $data['action'] = $this->url->link('catalog/pm_gallery/edit', 'token=' . $this->session->data['token'], 'SSL');
                                              $pm_galleries = "";
     
                       $data['token'] = $this->session->data['token'];
          $this->load->model('extension/module'); 
          $settings = array();      
          $module_id = '';
          $album = '';
          if (isset($this->request->get['module_id'])) {
              $settings = $this->model_extension_module->getModule($this->request->get['module_id']);
              $data['folders'] = $this->model_catalog_pm_gallery->getFolders($this->request->get['module_id']);   
              $module_id = $this->request->get['module_id'];
              $data['module_id'] = $module_id;
          }  
                       $data['image_path'] = $this->url->link('catalog/pm_gallery/image', 'module_id='.$module_id.'&token=' . $this->session->data['token'], 'SSL');            
         extract($settings);           

          if (isset($this->request->get['folder'])) {
              $data['images'] = $this->model_catalog_pm_gallery->getImages($module_id,$this->request->get['folder']);
              $album = $this->request->get['folder'];
          } else {
              $data['images'] = array();
          }
        /* Directories names from Setting */
                                     if(isset($pm_galleries)){
                                                      $pm_galleries = $pm_galleries;
                                       } else{
                                                      $pm_galleries = 'pm_galleries/';
                                      }
                                                      
                                     if(isset($pm_base)){
                                                      $basedir = $pm_base;
                                      } else{
                                                      $basedir = 'pm_base/';
                                      }

          $data['pm_galleries'] = $pm_galleries;
          $data['pm_base'] = $basedir;
                                       if(isset($pm_admin_limit)){
                                                      $admin_limit = $pm_admin_limit;
                                       } else{
                                                      $admin_limit = 32;
                                      }                                                   
                  $data['file_get_empty'] = "";
                  $data['get_gallery_empty'] = "";
                  $data['file_not_found'] = "";
          // Search imagelist from Database
                   if(isset($this->request->post['image_change']) && $this->validateForm()){
                        $this->model_catalog_pm_gallery->editImageOrder($this->request->post);
                                       
                        $this->response->redirect($this->url->link('catalog/pm_gallery/edit','module_id=' . $module_id . '&token=' . $this->session->data['token'].'&success=1', 'SSL'));
                                             
                   }
              if(isset($this->request->get['album'])){
                  $data['gallery'] = $this->model_catalog_pm_gallery->getDatabaseFolder($album);
                  } else{
                    $data['gallery'] = $this->model_catalog_pm_gallery->getDatabaseImage();
                 }
                                   
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}      
		if (isset($this->session->data['warning'])) {
			$data['error_warning'] = $this->session->data['warning'];
		
			unset($this->session->data['warning']);
		} else {
			$data['error_warning'] = '';
     }  
           
          $total = count($data['gallery']);
          $pages = ceil($total/$admin_limit);
          $max = $pages*$admin_limit;
               if(isset($this->request->get['page'])){
                    $data['page'] = $this->request->get['page'];
                    $page = $this->request->get['page'];
                    
                    $data['start'] = ($page-1)*$admin_limit;
                    
                    if($page !=$pages or $pages == $page && $total == $max){
                      $data['plimit'] = $page*$admin_limit;
                    }
                    if($page == $pages && $total < $max){
                      $data['plimit'] = $total;
                    }
          } else{
                    $this->request->get['page'] = '';
                    $page = 1;
                    $data['page'] = 1;
                    $data['start'] = 0;
                    if($total >= $admin_limit){
                    $data['plimit'] = $admin_limit;
                    } else{
                     if($total > 0){
                        $data['plimit'] =  $total;
                        } else{
                                  $data['plimit'] = 0;
                        }
                                  
                    }
          }     
                                              $pagination = new Pagination();
                                              $pagination->total = $total;
                                              $pagination->page = $page;
                                              $pagination->limit = $admin_limit;
                                              $pagination->text = $this->language->get('text_pagination');
                                              $pagination->url = $this->url->link('catalog/pm_gallery/edit', 'token=' . $this->session->data['token'].'&album='.$album.'&page={page}','SSL');
                       
                       $data['pagination'] = $pagination->render();
                          
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['menu'] = $this->load->controller('catalog/pm_gallery_menu');
    $data['footer'] = $this->load->controller('common/footer');

    $this->response->setOutput($this->load->view('catalog/pm_gallery_edit.tpl', $data));
                                    
     }
      public function upload() {

        $this->document->addStyle('view/stylesheet/pm_gallery.css');
        $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
                       $data['breadcrumbs'][] = array(
                       'text'      => $this->language->get('text_home'),
                       'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
                       'separator' => false
                       );

                       $data['breadcrumbs'][] = array(
                       'text'      => $this->language->get('heading_title'),
                       'href'      => $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
                       'separator' => ' :: '
                       );
                        $data['warning'] = "";            
                       $this->load->model('catalog/pm_gallery');
                       $this->load->model('catalog/pm_frame');
                       $data['pm_frame'] = '';
                       $data['fr_galleries'] = '';
                       $data['pm_pic_frame'] = '';
                       $fsetting = array();
                       if($this->config->get('pmframe_module')){
                        $fsettings = $this->config->get('pmframe_module');
                                              foreach($fsettings as $sett){
                                                                     $fsetting['frame_type'] = $sett['frame_type'];
                                                                     $fsetting['draw_frame'] = $sett['draw_frame'];
                                                                     $fsetting['clip_frame'] = $sett['clip_frame'];
                                                                     $fsetting['frame_width'] = $sett['frame_width'];
                                              }
                       }
                       $pm_galleries = "";
                       $basedir = '';
          $this->load->model('extension/module'); 
          $settings = array();      
          $module_id = '';
          $data['module_id'] = '';
           $data['gallery_title'] = '';
           $data['folders'] = array();
          if (isset($this->request->get['module_id'])) {
              $settings = $this->model_extension_module->getModule($this->request->get['module_id']);
              $module_id = $this->request->get['module_id'];
              $data['module_id'] = $module_id;

              $data['folders'] = $this->model_catalog_pm_gallery->getFolders($this->request->get['module_id']);
          }  else {
              $data['module_id'] = '';
          }
        
         extract($settings);   
                       if(isset($status)){
                                 $data['pm_galleries'] = $pm_galleries;
                                 $data['pm_basedir'] = $pm_base;

                       $data['breadcrumbs'][] = array( 
                       'text'      => sprintf($this->language->get('text_upload'), $name),
                       'href'      => $this->url->link('catalog/pm_gallery/upload', 'module_id=' . $module_id. '&token=' . $this->session->data['token'], 'SSL'),
                       'separator' => ' :: '
                       );

                       }
                       $data['pm_fr_galleries'] = $pm_fr_galleries;           
                       $data['pm_pic_frame'] = $pm_pic_frame;        
                            
                       $data['watermark_hori'] = $pm_watermark_hori;
                       $data['watermark_vert'] = $pm_watermark_vert;
                       $data['watermark_size'] = $pm_watermark_size;

                       $data['action'] = $this->url->link('catalog/pm_gallery/upload', 'module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');
                       $data['cancel'] = $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL');
                       $data['token'] = $this->session->data['token'];
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
                       $data['add'] = "";
                       
             if(isset($this->request->get['add'])){
                    $data['add'] = $this->request->get['add'];
             }
                       
             if(isset($this->request->post['title'])){
                    $data['title'] = $this->request->post['title'];
             } else {
                    $data['title'] = '';
             }
             
             
                                      $pfolder = '';
                       if(($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateAddImage($pm_galleries)){

                                              if(!isset($fsetting['status']) or $fsetting['status'] == 0){
                                                             $fsetting['frame_type'] = 'default';
                                                             $this->request->post['frame_width'] = '70';
                                              }
                        
                                              $done =  $this->model_catalog_pm_gallery->addImage($this->request->post,$pm_galleries,$pm_th_width,$pm_th_height,$pm_th_to_square,$pm_mixname,$pm_maxim_pic_width,$pm_maxim_pic_height,$module_id);

                                                if($pm_pic_frame == 1 && isset($this->request->post['addimageframe']) && $done == false){
                                                              if($fsetting['frame_type']){
                                                                         if($fsetting['frame_type'] == 'draw' or $fsetting['frame_type'] == 'default'){      
                                                                           $this->model_catalog_pm_frame->imgcreate($this->request->post,$pm_galleries, $pm_fr_galleries,$fsetting);
                                                                         }
                                                                         if($fsetting['frame_type'] == 'clip'){           
                                                                           $this->model_catalog_pm_frame->copyFrame($this->request->post,$pm_galleries, $pm_fr_galleries,$fsetting);
                                                                         }
                                                          }else{    
                                                                     $fsetting = array();  
                                                                     $this->model_catalog_pm_frame->imgcreate($this->request->post,$pm_galleries, $pm_fr_galleries,$fsetting);
                                                           }
                                                 }
                                      if(!strpos($done,'/')){
                                        }else{
                                              //  $this->response->redirect($this->url->link('catalog/pm_gallery/image','image='.$done.'&token=' . $this->session->data['token'].'&success=1&module_id=' . $module_id, 'SSL'));
                                           }         
                                      }
         
                                     
                   $galleries = array();
                   $data['to_album'] = "";
                   $data['sort_order'] = 0;
                   if(isset($this->request->get['to'])){
                                     $data['to_album'] = $this->request->get['to'];
                   }
                   else{
                                      $data['to_album'] = 0;
                       }
                                        
                                  if(!$pm_galleries){
                                                    $this->error['warning'] = $this->language->get('error_setting_galleries');
                                                    $pm_galleries = 'pm_galleries/';
                                                    $data['pm_galleries'] = $pm_galleries;
                                  }
                                  if(!$pm_base){
                                                    $this->error['warning'] = $this->language->get('error_setting_basedir');
                                                    $basedir = 'pm_base/';
                                                    $data['pm_basedir'] = $basedir;
                                  }
        
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}   
  
    if (isset($this->error['warning'])) {
      $data['error_warning'] = $this->error['warning'];
    } else {
      $data['error_warning'] = '';
    }
		
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['footer'] = $this->load->controller('common/footer');
    $data['menu'] = $this->load->controller('catalog/pm_gallery_menu');

    $this->response->setOutput($this->load->view('catalog/pm_gallery_upload.tpl', $data));
                  }
public function image() {
    $language_info = $this->language->load('catalog/pm_gallery');
    $this->load->model('extension/module'); 
    $this->load->model('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
                                    
    $this->document->addStyle('view/stylesheet/pm_gallery.css');

                       $data['breadcrumbs'][] = array(
                       'text'      => $this->language->get('text_home'),
                       'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
                       'separator' => false
                       );
                       
                       $data['breadcrumbs'][] = array(
                       'text'      => $this->language->get('heading_title'),
                       'href'      => $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
                       'separator' => ' :: '
                       );
                
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }   
          $this->load->model('extension/module'); 
          $module_id = '';
          $data['module_id'] = '';
          $settings = array();   
       

          if (isset($this->request->get['module_id'])) {
              $settings = $this->model_extension_module->getModule($this->request->get['module_id']);
              $module_id = $this->request->get['module_id'];
              $data['module_id'] = $module_id;
              $data['folders'] = $this->model_catalog_pm_gallery->getFolders($this->request->get['module_id']);
          }  else {
              $data['module_id'] = '';
          }
        
         extract($settings);     
         $data['pm_galleries'] = $pm_galleries;
 
                       $data['action'] = $this->url->link('catalog/pm_gallery/image', 'image='.$this->request->get['image'].'&token=' . $this->session->data['token'], 'SSL');				
                       $data['cancel'] = $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL');	
                   /*    $data['change'] = $this->url->link('catalog/pm_gallery/change', 'token=' . $this->session->data['token'], 'SSL');
                       $data['delete'] = $this->url->link('catalog/pm_gallery/delete', 'token=' . $this->session->data['token'], 'SSL');
                       $data['delete_image'] = $this->url->link('catalog/pm_gallery/deleteimage','module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');	
                       $data['edit_image'] = $this->url->link('catalog/pm_gallery/image', 'token=' . $this->session->data['token'], 'SSL');	
                       $data['gallery_images'] = $this->url->link('catalog/pm_gallery/upload', 'token=' . $this->session->data['token'], 'SSL');
                       $data['gallery_texts'] = $this->url->link('catalog/pm_gallery/settings', 'token=' . $this->session->data['token'], 'SSL');
                       $data['managefolder'] = $this->url->link('catalog/pm_gallery/managefolder', 'token=' . $this->session->data['token'], 'SSL');
                       $data['setting'] = $this->url->link('module/pm_gallery', 'token=' . $this->session->data['token'], 'SSL');	
                       $data['upload'] = $this->url->link('catalog/pm_gallery/upload', 'token=' . $this->session->data['token'], 'SSL'); */
                         $data['pm_frame'] = '';
         
                          if($this->config->get('pmframe_module')){
                        //   $fsettings = $this->config->get('kiframe_module');
                           $fsetting = array();
                                              foreach($fsettings as $sett){
                                                                     $fsetting['frame_type'] = $sett['frame_type'];
                                                                     $fsetting['draw_frame'] = $sett['draw_frame'];
                                                                     $fsetting['clip_frame'] = $sett['clip_frame'];
                                                                     $fsetting['frame_width'] = $sett['frame_width'];
                                              }
                          }
                          
                                    if(isset($this->request->get['success'])){
                                     $this->session->data['success'] = $this->language->get('text_upload_success');
                                    }
                              
                                              $data['watermark_hori'] = $pm_watermark_hori;
                                              $data['watermark_vert'] = $pm_watermark_vert;
                                              $data['watermark_size'] = $pm_watermark_size;         
                                              $data['pm_pic_frame'] = $pm_pic_frame;   
                               /*     $pm_galleries = "";
                                    $settings = $this->config->get('pm_gallery_module');
                                    foreach($settings as $setting){
                                                      if(isset($setting['pm_galleries'])){
                                                      $pm_galleries = $setting['pm_galleries'];
                                                      }
                                                      if(isset($setting['pm_base'])){
                                                      $pm_base = $setting['pm_base'];
                                                      }
                                                                                                    
                                                                $data['watermark_hori'] = $setting['pm_watermark_hori'];
                                                                $data['watermark_vert'] = $setting['pm_watermark_vert'];
                                                                $data['watermark_size'] = $setting['pm_watermark_size'];
                                                                       
                                              $pm_pic_frame = $setting['pm_pic_frame'];      
                                              $frame_galleries = $setting['pm_fr_galleries'];      
                                              $data['pm_pic_frame'] = $setting['pm_pic_frame'];      
                                           
                                          
                                    } */
                  
                                  if(!$pm_galleries){
                                                    $this->error['warning'] = $this->language->get('error_setting_galleries');
                                                    $pm_galleries = 'pm_galleries/';
                                  }
                                  if(!$pm_base){
                                                    $this->error['warning'] = $this->language->get('error_setting_basedir');
                                                    $pm_base = 'pm_base/';
                                  }
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
                       $data['folders'] = $this->model_catalog_pm_gallery->getFolders($module_id);
                    
                       $this->load->model('catalog/pm_gallery');
                       $this->load->model('catalog/pm_frame');
                       $data['frames'] = $this->model_catalog_pm_frame->getFrames();
		
                       $data['gallerydir'] = $pm_galleries;
                       $data['vcomments'] = array();
                       $data['comment'] = "";
                                    
                                   $data['image_info'] = ''; 
                                    if(isset($this->request->get['image']) && $pm_galleries !=""){
                                           
                                               $parts = explode('/',$this->request->get['image']);   
                                                 $data['image']=$this->request->get['image'];
                                      
                                                  $data['image_info'] = $this->model_catalog_pm_gallery->getImageInfo($parts);

                                               
                                                  $dir = $parts[0];
                                                  $data['folder'] = $dir.'/';
                                                  $fpart = explode('.',$parts[1]);
                                                  $vfile = str_replace($fpart[1],'txt',$parts[1]);
                                                  $i=0;
                                              
                                               foreach($data['languages'] as $language){
                                                  $file[$language['language_id']] = str_replace('.'.$fpart[1],'_'.$language['language_id'].'.txt',$parts[1]);
                                                  $i++;
                                               }
                                               $keys = array_keys($file);
                                               $commentfile = '../'.$pm_galleries.$dir.'/comments/'.$fpart[0].'_'.$keys[0].'.txt';
                                               $query = "";
                                          
     if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
                              if(isset($this->request->post['add_pm_gallery_comment'])){
                                        $this->model_catalog_pm_gallery->addComment($this->request->post);
                         }
    
                        if(isset($this->request->post['addwatermark'])){
                                        $this->model_catalog_pm_gallery->addWatermark($this->request->post,$pm_galleries,$pm_base);
                                        if($pm_pic_frame == 1){
                                         $this->model_catalog_pm_gallery->addWatermark($this->request->post,$pm_fr_galleries,$pm_base);
                                         $this->model_catalog_pm_frame->updateDiskUsage($pm_galleries,$pm_fr_galleries,$this->request->post['foldername'],'0');     
                                        } else{
                                         $this->model_catalog_pm_frame->updateDiskUsage($pm_galleries,$pm_fr_galleries,$this->request->post['foldername'],'1');     
                                        }
                              }
                             if(isset($this->request->post['add_imageframe'])){
                                                    $img_data = $this->request->post;
                                         if(!isset($img_data['frame_version'])){
                                                  if(isset($fsetting['frame_version'])){
                                                           $img_data['frame_version'] = $fsetting['frame_version'];
                                                    } else {
                                                                $img_data['frame_version'] = 'default';
                                                 }
                                         }
                                         if($img_data['frame_width'] == ''){
                                                  if(isset($fsetting['frame_width'])){
                                                           $img_data['frame_width'] = $fsetting['frame_width'];
                                                    } else {
                                                                $img_data['frame_width'] = 70;
                                                 }
                                         }
                                         if($img_data['frame_version'] == 'draw_frame' or $img_data['frame_version']  == 'default'){
                                          $this->model_catalog_pm_frame->addFrame($img_data, $pm_galleries, $frame_galleries);
                                        }
                                         if($img_data['frame_version'] == 'clip_frame'){
                                          $this->model_catalog_pm_frame->addCopyFrame($img_data, $pm_galleries, $frame_galleries);
                                        }
                                        $this->model_catalog_pm_gallery->editFrameModel($this->request->post['image_id'],$img_data);
                              }
                              if(isset($this->request->post['edit_pm_gallery'])){
                                        if(!isset($this->request->post['delete_comment'])){
                                        $this->model_catalog_pm_gallery->editComment($this->request->post);
                                        }
                                        if(isset($this->request->post['delete_comment'])){
                                                  $this->model_catalog_pm_gallery->deleteComment($this->request->post);
                                        }
                              }
                              if(isset($this->request->post['change_folder'])){
                                        $this->model_catalog_pm_gallery->changeImageFolder($this->request->post,$pm_galleries,$pm_base,$pm_pic_frame,$frame_galleries);
                                        $plod = explode("/",$this->request->get['image']);
                                        $change_folder = $this->request->post['change_folder'].'/'.$plod[1];
                                }
                    
                              if(isset($this->request->post['edit_title'])){
                                        $this->model_catalog_pm_gallery->editImageTitle($this->request->post);
                              }
                              if(isset($this->request->post['edit_vcomment'])){
                                        $this->model_catalog_pm_gallery->editViewerComment($this->request->post['edit_vcomment']);
                              }
                              if(isset($this->request->post['delete_vcomment'])){
                                        $this->model_catalog_pm_gallery->deleteViewerComment($this->request->post['delete_vcomment']);
                              }
                              if(isset($this->request->post['width']) && $this->request->post['width'] > 0 && isset($this->request->post['height']) && $this->request->post['height'] > 0){
                                        $this->model_catalog_pm_gallery->imageResize($this->request->post,$pm_galleries,$dir,$parts[1]);
                                        $this->model_catalog_pm_frame->updateDiskUsage($pm_galleries,$frame_galleries,$this->request->post['foldername'],1);     
                              }
                       $this->session->data['success'] = $this->language->get('text_success');
	
                   if(isset($change_folder)){   
                      $this->response->redirect($this->url->link('catalog/pm_gallery/image', 'image='.$change_folder.'&token=' . $this->session->data['token'], 'SSL')); 
                   }
                   else{   
                      $this->response->redirect($this->url->link('catalog/pm_gallery/image', 'image='.$this->request->get['image'].'&token=' . $this->session->data['token'], 'SSL')); 
                   } 

                                                      }
                                                   
                                                         $data['comment'] = $this->model_catalog_pm_gallery->getComment($data['image_info']['folder'],$data['image_info']['mixname']);   
                                                     
                                                     $data['vcomments'] = $this->model_catalog_pm_gallery->getComments($data['image_info']['folder'],$data['image_info']['mixname']);
                 }
	
         
	           $data['delete_vcomm'] = $this->url->link('catalog/pm_gallery/image', 'image='.$this->request->get['image'].'&token=' . $this->session->data['token'], 'SSL');
	           $data['edit_vcomm'] = $this->url->link('catalog/pm_gallery/image', 'image='.$this->request->get['image'].'&token=' . $this->session->data['token'], 'SSL');
 		if(isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if(isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['menu'] = $this->load->controller('catalog/pm_gallery_menu');
    $data['footer'] = $this->load->controller('common/footer');

    $this->response->setOutput($this->load->view('catalog/pm_gallery_image_form.tpl', $data));
    }
public function managefolder() {
                                    
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
    $this->document->addStyle('view/stylesheet/pm_gallery.css');
		$this->load->model('catalog/pm_gallery');
		$this->load->model('catalog/pm_frame');
                              
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
		      'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
          'href'      => $this->url->link('catalog/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
                  
                                    $pm_galleries = "";
          $this->load->model('extension/module'); 
          $settings = array();      
          $module_id = '';
          $settings = array();
              $data['module_id'] = '';
          if (isset($this->request->get['module_id'])) {
              $settings = $this->model_extension_module->getModule($this->request->get['module_id']);
              $module_id = $this->request->get['module_id'];
              $data['module_id'] = $module_id;
          }              
         extract($settings);   
              if($settings){         
                      $data['pm_galleries'] = $pm_galleries;
                      $data['basedir'] = $pm_base;
              }

                                  if(!isset($pm_galleries)){
                                                    $this->error['warning'] = $this->language->get('error_setting_galleries');
                                  }
                                  if(!isset($pm_base)){
                                                    $this->error['warning'] = $this->language->get('error_setting_basedir');
                                  }
         
                    
                       $data['token'] = $this->session->data['token'];
                       $data['album'] = "";     
                                                  
         if(isset($this->request->get['album'])){    
                                   $this->model_catalog_pm_gallery->updateFiles($this->request->get['album'],'../'.$pm_galleries);    
                                   }else{
                                   if(isset($data['folders'][0])){
                                   $this->model_catalog_pm_gallery->updateFiles($data['folders'][0],'../'.$pm_galleries);
                                   }
         }
                    if(isset($this->request->get['album'])){
                              $album = $this->request->get['album'];
                              $data['album'] = $this->request->get['album'];
                    }
                    else{
                              $album = 0;
                              if(isset($data['folders'][0])){
                              $data['album'] = $data['folders'][0];
                              }
                      }
                       $data['folder_info'] = $this->model_catalog_pm_gallery->getFolderInfo($module_id);          

                       $folder_info =  $data['folder_info']; 
                       $this->load->model('localisation/language');
                       $data['success']  = "";
                       $data['error']  = "";
                       $data['images'] = "";
                       $data['folder'] = "";
                       $data['warning'] = "";
                       $data['error_list']  = "";
                       $data['error_modify']  = "";
                       $data['error_sizes'] = "";
                       $data['folder_name'] = "";
                       
                       if(isset($this->request->get['images'])){
                                 $data['dir_images'] = $this->model_catalog_pm_gallery->getDatabaseImages($this->request->get['images']);
                                              
                                              $data['images'] = $this->request->get['images'];
                                              
                                              $data['folder'] = $this->request->get['images'];
                       
                       }
                           $pfolder = '';
                       if(isset($this->request->post['editfolder'])){
                        $info = $this->request->post['editfolder'];               
                                            $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE folder_id = '".$info['folder_id']."'");
                                            $result = $query->row;
                                              $pfolder = $result['name'];
                       }
                       if(isset($this->request->get['rmdir'])){
                                              $pfolder = $this->request->get['rmdir'];
                       }
                       if(isset($this->request->get['empty'])){
                                              $pfolder = $this->request->get['empty'];
                       }
                       if(isset($this->request->post['createfolder'])){
                                              $pfolder = $this->request->post['createfolder'];
                       }
         $data['action'] = $this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL');
$data['languages'] = $this->model_localisation_language->getLanguages();

      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
                              if(isset($this->request->post['createfolder']) && $this->validateMkdir()){
                 // Create new Folder
                                        $done = $this->model_catalog_pm_gallery->manageFolder($this->request->post,$settings);  
                                              if($done == false){    
                                                                     $this->session->data['success'] = $this->language->get('text_success');
                                                                     $this->response->redirect($this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL'));  
                                              } else {
                                                                  
                                                                $this->session->data['warning'] = $error_list[$done];
                                              }
                              } 
                              if(isset($this->request->post['editfolder'])){
                                        // Create new Folder
                                        $done = $this->model_catalog_pm_gallery->editFolder($this->request->post,$settings);  
                                                                    if($done == false){    
                                        $this->session->data['success'] = $this->language->get('text_success');
                                        $this->response->redirect($this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . ' &token=' . $this->session->data['token'], 'SSL'));
                                                      } else {
                                                                $this->session->data['warning'] = $error_list[$done];
                                         }
                                         } 
                          
                              if(isset($this->request->post['todatabase'])){
                                        // Update folder images to Database
                                       $this->model_catalog_pm_gallery->imageToDatabase($this->request->post);
                                       $this->response->redirect($this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
                              }
                              if(isset($this->request->post['files_sizes'])){
                                        $this->model_catalog_pm_gallery->folderSizetoDatabase($this->request->post);
                                        $this->response->redirect($this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
                              }
                    }
                  
                                   if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validateForm()) {
                                                  if(isset($this->request->get['disk_usage'])){
                                                     $this->model_catalog_pm_frame->updateDiskUsage($pm_galleries,$pm_fr_galleries,$this->request->get['disk_usage'],'0');
                                                    $this->response->redirect($this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
                                                                    }
                                                  if(isset($this->request->get['empty']) or isset($this->request->get['rmdir'])){
                                                            // Folder Emty or Delete
                                                     $done =   $this->model_catalog_pm_gallery->manageFolder($this->request->get,$settings[0]);  
                                                                      
                                                                    if($done == false){    
                                                                      $this->session->data['success'] = $this->language->get('text_success');
                                                                       $this->response->redirect($this->url->link('catalog/pm_gallery/managefolder','module_id=' . $module_id . ' &token=' . $this->session->data['token'], 'SSL'));
                                                                   } else{
                                                                             $this->session->data['warning'] = $error_list[$done];
                                                                    }
                                                  }
                              }
   
                    if(isset($this->error['createfolder'])){
                                           $data['error_create_folder'] = $this->error['createfolder'];
                    } else{
                                           $data['error_create_folder'] = '';
                    }
                        if(isset($this->session->data['warning'])){
                                               $data['error_warning'] =$this->session->data['warning'];
                                              $this->session->data['warning'] = '';
                        } else{
                                               $data['error_warning'] = '';
                        }
    
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['menu'] = $this->load->controller('catalog/pm_gallery_menu');
    $data['footer'] = $this->load->controller('common/footer');

    $this->response->setOutput($this->load->view('catalog/pm_gallery_managefolder.tpl', $data));
   }

	public function ajax(){
    $this->load->model('catalog/pm_gallery'); 
    $language_info = $this->language->load('catalog/pm_gallery');

            foreach($language_info as $key => $language){
                 $data[$key] = $language;
            }
        
      $token = $this->session->data['token'];
                    
	   	$json = $this->model_catalog_pm_gallery->getFolderDescription($this->request->get['folder_id']);
       $this->response->setOutput(json_encode($json));
   }
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/pm_gallery')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
					
		if (!$this->error) {
			return true;
		} else {
			return false;
		} 
	}
	protected function validateMkdir() {
    $this->language->load('catalog/pm_gallery');
		if (!$this->request->post['createfolder']) {
			$this->error['createfolder'] = $this->language->get('error_folder_name');
		}elseif(trim($this->request->post['createfolder'] == '')){
			$this->error['createfolder'] = $this->language->get('error_folder_name');
    }
    return !$this->error;
	}
  protected function validateAddImage($pm_galleries){
      $this->language->load('catalog/pm_gallery');
      $this->load->model('catalog/pm_gallery'); 

     if (!$this->user->hasPermission('modify', 'catalog/pm_gallery')) {
       $this->error['warning'] = $this->language->get('error_permission');
     }
     if( !isset($this->request->get['module_id']) ){
        $this->error['warning'] = $this->language->get('error_module_path');
     }    
     if( !$this->request->post['folder']  ){
        $this->error['warning'] = $this->language->get('error_folder_name');
     }  else {
       $folder_info = $this->model_catalog_pm_gallery->getFolder($this->request->get['module_id'], $this->request->post['folder']);
        if( !is_dir('../' . $pm_galleries . $folder_info['folder']) ){
          $this->error['warning'] =  sprintf($this->language->get('error_folder_directory_not_found'), $pm_galleries . $folder_info['folder'],'');
        } else {
            if(!is_writable('../' . $pm_galleries . $folder_info['folder'])){
               $this->error['warning'] = sprintf($this->language->get('error_not_permission_galleries'), $pm_galleries . $folder_info['folder'],'');
            }
        }
     }

    return !$this->error;
  }
  public function load(){
       $json['type'] = 'horizontal';
       if(isset($_FILES['iamge']['tmp_name'])){
        $width = imagesx($_FILES['image']['tmp_name']);
        $height = imagesy($_FILES['image']['tmp_name']);
        if($height > $width){
          $json['tyoe'] = 'vertical';
        }
       }
       $this->response->setOutput(json_encode($json));
  }
}
?>
