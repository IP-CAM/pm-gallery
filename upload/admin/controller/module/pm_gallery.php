<?php
class ControllerModulePMGallery extends Controller {
	private $error = array(); 
	
	public function index() {   
		$languages = $this->language->load('module/pm_gallery');

            foreach($languages as $key => $language){
                 $data[$key] = $language;
            }

		$this->document->setTitle($this->language->get('heading_title'));

    $this->load->model('extension/module');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pm_gallery', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

  		$data['breadcrumbs'] = array();
        $data['token'] = $this->session->data['token'];
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
          'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
          'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
          'href'      => $this->url->link('module/pm_gallery', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/pm_gallery', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/pm_gallery', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
    $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
    $keys = $this->getKeys();
    if (isset($this->request->get['module_id'])){
      $data['module_id'] = $this->request->get['module_id'];
        foreach($keys as $key=>$value){
           if (isset($this->request->post[$key])) {
             $data[$key] = $this->request->post[$key];
           } elseif (!empty($module_info) && isset($module_info[$key])) {
             $data[$key] = $module_info[$key];
           }
        }
    } else {
       $data['module_id'] = $this->moduleId();
       $data = array_merge($data,$keys);
    }

        $keys2 = array_keys($this->getKeys());
        foreach($keys2 as $key1){
           if (isset($this->request->post[$key1])) {
             $data[$key1] = $this->request->post[$key1];
           }
        }
    if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        foreach($keys2 as $key2){
          if (!empty($module_info) && isset($module_info[$key2])) {
             $data[$key2] = $module_info[$key2];
           }
        }
		} 

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pm_gallery.tpl', $data));
	}
	
  public function ajax(){
                $this->load->model('line/kiframe'); 
		        $this->language->load('module/pm_gallery');
                    
 		        $data['text_edit_folder'] = $this->language->get('text_edit_folder');
                    
                       $token = $this->session->data['token'];
                    
                    $json = $this->model_line_kiframe->getFrames();
               $this->response->setOutput(json_encode($json));
  }

  public function install(){

$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pm_gallery_admin_comment` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `folder_name` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `image_name` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `comment` text COLLATE utf8_swedish_ci NOT NULL,
  `language_id` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci AUTO_INCREMENT=1");

$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pm_gallery_folder` (
  `folder_id` int(3) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `folder` varchar(50) COLLATE utf8_swedish_ci NOT NULL,
  `mixthumb` int(30) NOT NULL,
  `size` int(15)  NOT NULL,
  `size_of_fr` int(30) NOT NULL,
  `files` int(5) NOT NULL,
  `last_modified` varchar(30) COLLATE utf8_swedish_ci NOT NULL,
  `sort_order` int(3) NOT NULL,
  `status` int(3) NOT NULL,
  PRIMARY KEY (`folder_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci AUTO_INCREMENT=3");

$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pm_gallery_folder_description` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `folder_id` int(5) NOT NULL,
  `module_id` int(11) NOT NULL,
  `title` varchar(50) COLLATE utf8_swedish_ci NOT NULL,
  `description` text COLLATE utf8_swedish_ci,
  `language_id` int(5) NOT NULL,
  `date_modified` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci AUTO_INCREMENT=3");


$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pm_gallery_image` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `folder_id` int(3) NOT NULL,
  `module_id` int(11) NOT NULL,
  `title` text COLLATE utf8_swedish_ci NOT NULL,
  `filename` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `mixname` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `width` int(6) NOT NULL,
  `height` int(6) NOT NULL,
  `filesize` int(20) NOT NULL,
  `exif_data` text COLLATE utf8_swedish_ci NOT NULL,
  `watermark` int(5) NOT NULL,
  `imageframe` int(5) NOT NULL,
  `width_of_fr` int(11) NOT NULL,
  `height_of_fr` int(11) NOT NULL,
  `filesize_of_fr` int(20) NOT NULL,
  `viewed` int(11) NOT NULL,
  `date_added` date NOT NULL,
  `sort_order` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci AUTO_INCREMENT=1");


$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pm_gallery_viewercomment` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `address` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `date` date NOT NULL,
  `folder_name` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `image_name` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `comment` text COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci AUTO_INCREMENT=3"); 

       $layout = $this->db->query("SELECT * FROM `".DB_PREFIX ."layout` WHERE name = 'Pm Gallery'");   
       $test = $layout->row;
      if(!isset($test['name'])){  
           $layout_id = $this->db->query("SELECT MAX(layout_id) FROM " . DB_PREFIX ."layout");
           $next = $layout_id->row["MAX(layout_id)"]+1;             
                       $this->db->query("INSERT INTO " . DB_PREFIX . "layout SET layout_id = '" . (int)$next . "', name = 'Pm Gallery'");
                       $this->db->query("INSERT INTO " . DB_PREFIX . "layout_route SET layout_id = '" . (int)$next . "', store_id = '0', route = 'store/gallery'");
      }
      $module_idx = $this->moduleId();     

              $this->db->query("INSERT INTO " . DB_PREFIX . "module SET `module_id` = '" . $module_idx . "',
                                                                        `name`= 'My Gallery',
                                                                        `code` = 'pm_gallery', 
                                                                        `setting`= '".$this->db->escape('a:93:{s:9:"module_id";s:2:"31";s:4:"name";s:10:"My Gallery";s:6:"status";s:1:"1";s:13:"pm_admin_mail";s:1:"0";s:18:"pm_admin_mail_from";s:15:"admin@localhost";s:16:"pm_admin_mail_to";s:15:"admin@localhost";s:11:"pm_template";s:26:"catalog/view/theme/default";s:10:"pm_folders";s:1:"1";s:14:"pm_breadcrumbs";s:1:"0";s:12:"pm_galleries";s:13:"pm_galleries/";s:10:"pm_keyword";s:1:"0";s:12:"pm_img_order";s:6:"manual";s:14:"pm_admin_limit";s:2:"24";s:16:"pm_show_warnings";s:1:"0";s:11:"pm_fr_color";s:7:"#666666";s:9:"pm_thumbs";s:2:"12";s:14:"pm_th_per_line";s:1:"2";s:11:"pm_th_lines";s:4:"auto";s:11:"pm_th_width";s:3:"150";s:12:"pm_th_height";s:3:"150";s:16:"pm_th_perc_width";s:2:"85";s:15:"pm_th_bord_size";s:1:"5";s:17:"pm_th_margin_left";s:2:"10";s:16:"pm_th_bord_color";s:7:"#666666";s:22:"pm_th_bord_hover_color";s:7:"#rrggbb";s:25:"pm_th_bord_hover_increase";s:3:"1.5";s:12:"pm_th_shadow";s:1:"1";s:11:"pm_th_title";s:1:"1";s:12:"pm_th_radius";s:1:"0";s:17:"pm_th_bord_radius";s:1:"0";s:15:"pm_th_to_square";s:1:"1";s:19:"pm_th_2sq_crop_hori";s:6:"center";s:19:"pm_th_2sq_crop_vert";s:6:"middle";s:17:"pm_thumbs_to_disk";s:1:"1";s:14:"pm_slider_type";s:8:"pmslider";s:9:"pm_radius";s:1:"1";s:12:"pm_br_radius";s:1:"8";s:13:"pm_picdiv_top";s:2:"40";s:14:"pm_resize_auto";s:1:"1";s:12:"pm_bord_size";s:1:"2";s:13:"pm_bord_color";s:7:"#666666";s:16:"pm_out_bord_size";s:2:"20";s:17:"pm_out_bord_color";s:7:"#808080";s:13:"pm_pic_radius";s:1:"0";s:14:"pm_bord_radius";s:1:"2";s:18:"pm_maxim_pic_width";s:4:"2048";s:19:"pm_maxim_pic_height";s:4:"1536";s:16:"pm_max_pic_width";s:4:"none";s:17:"pm_max_pic_height";s:4:"0.55";s:19:"pm_oversize_allowed";s:1:"0";s:20:"pm_disable_animation";s:1:"0";s:17:"pm_slideshow_time";s:4:"4000";s:11:"pm_comments";s:1:"1";s:17:"pm_comm_text_size";s:2:"12";s:18:"pm_comm_text_color";s:7:"#000000";s:17:"pm_comm_text_font";s:18:"Tahoma, sans-serif";s:18:"pm_comm_text_align";s:4:"left";s:12:"pm_comm_auto";s:1:"0";s:12:"pm_read_meta";s:1:"0";s:17:"pm_viewercomments";s:1:"1";s:17:"pm_moderate_posts";s:1:"0";s:21:"pm_vcomm_header_color";s:7:"#000000";s:18:"pm_vcomm_box_color";s:7:"#000000";s:19:"pm_vcomm_text_color";s:7:"#000000";s:23:"pm_vcomm_timedate_color";s:7:"#888888";s:19:"pm_vcomm_back_color";s:4:"none";s:19:"pm_vcomm_bord_color";s:7:"#888888";s:12:"pm_slideshow";s:1:"1";s:15:"pm_downloadpics";s:1:"1";s:11:"pm_checkgps";s:1:"0";s:11:"pm_cellinfo";s:1:"0";s:11:"pm_show_nav";s:1:"1";s:13:"pm_nav_always";s:1:"0";s:10:"pm_nav_pos";s:5:"right";s:12:"pm_nav_color";s:7:"#ffffff";s:19:"pm_nav_border_color";s:7:"#000000";s:12:"pm_nav_style";s:1:"1";s:17:"pm_show_image_nav";s:1:"1";s:19:"pm_image_nav_always";s:1:"0";s:13:"pm_show_share";s:1:"1";s:12:"pm_show_help";s:1:"1";s:11:"pm_help_pos";s:4:"left";s:15:"pm_show_preview";s:1:"0";s:16:"pm_preview_style";s:1:"1";s:15:"pm_preview_pics";s:1:"6";s:16:"pm_show_explorer";s:1:"1";s:19:"pm_explorer_padding";s:2:"50";s:17:"pm_watermark_hori";s:6:"center";s:17:"pm_watermark_vert";s:6:"middle";s:17:"pm_watermark_size";s:3:"0.4";s:13:"pm_fade_color";s:7:"#000000";s:13:"pm_fade_alpha";s:1:"8";s:22:"pm_shade_while_loading";s:1:"0";}')."'");
       $layout = $this->db->query("SELECT * FROM `".DB_PREFIX ."layout` WHERE `name` = 'Pm Gallery'");   
       $layout_id = $layout->row['layout_id'];

       $module = $this->db->query("SELECT * FROM `".DB_PREFIX ."module` WHERE `code` = 'pm_gallery'");   
       $module_id = $module->row['module_id'];

      $this->db->query("INSERT INTO " . DB_PREFIX . "layout_module SET `layout_id` = '" . $layout_id . "', `code` = 'pm_gallery." . $module_id ."', `position` = 'content_top', `sort_order` = '0'");
      $this->db->query("INSERT INTO `" . DB_PREFIX . "pm_gallery_folder` SET `folder_id` = '1',
                                                                                   `module_id` = '" . $module_id . "',
                                                                                   `folder` ='test',
                                                                                   `mixthumb` = '2147483647',
                                                                                   `sort_order` = '1',
                                                                                   `status` = '1'");

      foreach($languages as $language){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "pm_gallery_folder_description` SET `folder_id` = '1',
                                                                                               `module_id` = '" . $module_id . "',
                                                                                               `title` = 'Test',
                                                                                               `description` = 'This is test folder',
                                                                                               `language_id` = '" . $language['language_id'] . "',
                                                                                               `date_modified` = NOW()");
      }
  }
  protected function getKeys(){ 
        $str = 'a:93:{s:9:"module_id";s:2:"31";s:4:"name";s:10:"My Gallery";s:6:"status";s:1:"1";s:13:"pm_admin_mail";s:1:"0";s:18:"pm_admin_mail_from";s:15:"admin@localhost";s:16:"pm_admin_mail_to";s:15:"admin@localhost";s:11:"pm_template";s:26:"catalog/view/theme/default";s:10:"pm_folders";s:1:"1";s:14:"pm_breadcrumbs";s:1:"0";s:12:"pm_galleries";s:13:"pm_galleries/";s:10:"pm_keyword";s:1:"0";s:12:"pm_img_order";s:6:"manual";s:14:"pm_admin_limit";s:2:"24";s:16:"pm_show_warnings";s:1:"0";s:11:"pm_fr_color";s:7:"#666666";s:9:"pm_thumbs";s:2:"12";s:14:"pm_th_per_line";s:1:"2";s:11:"pm_th_lines";s:4:"auto";s:11:"pm_th_width";s:3:"150";s:12:"pm_th_height";s:3:"150";s:16:"pm_th_perc_width";s:2:"85";s:15:"pm_th_bord_size";s:1:"5";s:17:"pm_th_margin_left";s:2:"10";s:16:"pm_th_bord_color";s:7:"#666666";s:22:"pm_th_bord_hover_color";s:7:"#rrggbb";s:25:"pm_th_bord_hover_increase";s:3:"1.5";s:12:"pm_th_shadow";s:1:"1";s:11:"pm_th_title";s:1:"1";s:12:"pm_th_radius";s:1:"0";s:17:"pm_th_bord_radius";s:1:"0";s:15:"pm_th_to_square";s:1:"1";s:19:"pm_th_2sq_crop_hori";s:6:"center";s:19:"pm_th_2sq_crop_vert";s:6:"middle";s:17:"pm_thumbs_to_disk";s:1:"1";s:14:"pm_slider_type";s:8:"pmslider";s:9:"pm_radius";s:1:"1";s:12:"pm_br_radius";s:1:"8";s:13:"pm_picdiv_top";s:2:"40";s:14:"pm_resize_auto";s:1:"1";s:12:"pm_bord_size";s:1:"2";s:13:"pm_bord_color";s:7:"#666666";s:16:"pm_out_bord_size";s:2:"20";s:17:"pm_out_bord_color";s:7:"#808080";s:13:"pm_pic_radius";s:1:"0";s:14:"pm_bord_radius";s:1:"2";s:18:"pm_maxim_pic_width";s:4:"2048";s:19:"pm_maxim_pic_height";s:4:"1536";s:16:"pm_max_pic_width";s:4:"none";s:17:"pm_max_pic_height";s:4:"0.55";s:19:"pm_oversize_allowed";s:1:"0";s:20:"pm_disable_animation";s:1:"0";s:17:"pm_slideshow_time";s:4:"4000";s:11:"pm_comments";s:1:"1";s:17:"pm_comm_text_size";s:2:"12";s:18:"pm_comm_text_color";s:7:"#000000";s:17:"pm_comm_text_font";s:18:"Tahoma, sans-serif";s:18:"pm_comm_text_align";s:4:"left";s:12:"pm_comm_auto";s:1:"0";s:12:"pm_read_meta";s:1:"0";s:17:"pm_viewercomments";s:1:"1";s:17:"pm_moderate_posts";s:1:"0";s:21:"pm_vcomm_header_color";s:7:"#000000";s:18:"pm_vcomm_box_color";s:7:"#000000";s:19:"pm_vcomm_text_color";s:7:"#000000";s:23:"pm_vcomm_timedate_color";s:7:"#888888";s:19:"pm_vcomm_back_color";s:4:"none";s:19:"pm_vcomm_bord_color";s:7:"#888888";s:12:"pm_slideshow";s:1:"1";s:15:"pm_downloadpics";s:1:"1";s:11:"pm_checkgps";s:1:"0";s:11:"pm_cellinfo";s:1:"0";s:11:"pm_show_nav";s:1:"1";s:13:"pm_nav_always";s:1:"0";s:10:"pm_nav_pos";s:5:"right";s:12:"pm_nav_color";s:7:"#ffffff";s:19:"pm_nav_border_color";s:7:"#000000";s:12:"pm_nav_style";s:1:"1";s:17:"pm_show_image_nav";s:1:"1";s:19:"pm_image_nav_always";s:1:"0";s:13:"pm_show_share";s:1:"1";s:12:"pm_show_help";s:1:"1";s:11:"pm_help_pos";s:4:"left";s:15:"pm_show_preview";s:1:"0";s:16:"pm_preview_style";s:1:"1";s:15:"pm_preview_pics";s:1:"6";s:16:"pm_show_explorer";s:1:"1";s:19:"pm_explorer_padding";s:2:"50";s:17:"pm_watermark_hori";s:6:"center";s:17:"pm_watermark_vert";s:6:"middle";s:17:"pm_watermark_size";s:3:"0.4";s:13:"pm_fade_color";s:7:"#000000";s:13:"pm_fade_alpha";s:1:"8";s:22:"pm_shade_while_loading";s:1:"0";}';
   return unserialize($str);
  }
  protected function moduleId(){
       $module = $this->db->query("SELECT MAX(module_id) as total FROM `".DB_PREFIX ."module`");   
       $module_id = $module->row['total'] + 1;

       return $module_id;
  }
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pm_gallery')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
