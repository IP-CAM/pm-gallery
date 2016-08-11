<?php
class ModelCatalogPMGallery extends Model{
      public function getSetting($module_id){
               $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `module_id`='" . $module_id . "'");
               $setting = unserialize($query->row['setting']);
             return $setting;
      }
      public function getFolders($module_id){                                       
                     $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder kgf LEFT JOIN
                     " . DB_PREFIX ."pm_gallery_folder_description kgd ON (kgf.folder_id = kgd.folder_id)  WHERE
                     kgf.module_id='" . $module_id . "' AND kgd.language_id = '" . $this->config->get('config_language_id') ."' ORDER BY kgf.sort_order ASC");
                     $folders = $query->rows;
                              return $folders;
      }
      public function getFolder($folder_id){                                       
                     $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder kgf LEFT JOIN
                     " . DB_PREFIX ."pm_gallery_folder_description kgd ON (kgf.folder_id = kgd.folder_id)  WHERE
                     kgf.folder_id = '" . $folder_id . "' AND kgd.language_id = '" . $this->config->get('config_language_id') ."' ORDER BY kgf.sort_order ASC");
                     $folders = $query->row;
                              return $folders;
      }
      public function getMinFolder(){  
        $sort_order = $this->getMin();
       
          $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder kgf LEFT JOIN
                     " . DB_PREFIX ."pm_gallery_folder_description kgd ON (kgf.folder_id = kgd.folder_id)  WHERE
                    kgf.sort_order='".$sort_order . "' AND kgd.language_id = '" . $this->config->get('config_language_id') ."' ORDER BY kgf.sort_order ASC");
           $folders = $query->row;
                  
                              return $folders;
      }
      public function getMin(){                                       
          $query = $this->db->query("SELECT MIN(sort_order)  FROM " . DB_PREFIX ."pm_gallery_folder");
                     $num = $query->row["MIN(sort_order)"];
                   
                              return $num;
      }
      public function addComment($data){                                       
            $query = $this->db->query("INSERT INTO " . DB_PREFIX ."pm_gallery_viewercomment SET
                                                                                              module_id = '" . $data['module_id'] . "',
                                                                                              folder_id = '" . $data['folder_id'] . "',
                                                                                              image_id = '" . $data['image_id'] . "',
                                                                                              image_name = '" . $this->db->escape($data['file']) . "',
                                                                                              name = '" . $this->db->escape($data['name']) . "',
                                                                                              date = NOW(),
                                                                                              comment = '" . $this->db->escape($data['comment']) . "'");
      }
      public function getComment($data){                                       
          $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_viewercomment WHERE module_id = '" . $data['module_id'] . "' AND folder_id = '" . $data['folder_id'] . "' AND image_id = '" . $data['image_id'] ."'");
          return $query->rows;
      }
      public function explorer($pm_galleries,$data){

       $query = $this->db->query("SELECT * FROM `". DB_PREFIX ."pm_gallery_folder` kgf LEFT JOIN `". DB_PREFIX ."pm_gallery_image` kgi ON (kgf.folder_id = kgi.folder_id) WHERE kgf.module_id = '" . $data['module_id'] . "' AND kgi.folder_id = '" . $data['folder_id'] . "'");
             
          $files = array();   
          if($query->num_rows){
            foreach ($query->rows as $file) {
                   if( is_file( $pm_galleries . $file['folder'] . '/' . $file['filename'] ) ){
                              $files[] = array(
                                                "thumb" =>   $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'],
                                                "image" =>  $pm_galleries . $file['folder'] . '/' . $file['filename'],
                                                "width" => $file['width'],
                                                "height" => $file['height'],
                                                "title" => $file['title'],
                                                "gallery" => $file['folder']
                                              );
                    }                        
           }
         }
         return $files;
      }
      public function navThumbs($pm_galleries,$data){
       $query = $this->db->query("SELECT * FROM `". DB_PREFIX ."pm_gallery_folder` kgf LEFT JOIN `". DB_PREFIX ."pm_gallery_image` kgi ON (kgf.folder_id = kgi.folder_id) WHERE kgf.module_id = '" . $data['module_id'] . "' AND kgi.folder_id = '" . $data['folder_id'] . "'");
             
          $next = array();  
          $prev = array(); 
          if($query->num_rows){
            foreach ($query->rows as $file) {
                   if( is_file( $pm_galleries . $file['folder'] . '/' . $file['filename'] ) ){
                            if($data['image_id'] - $file['id'] == 1){
                                $prev = array(  "image_id" => $file['id'],
                                                "thumb" =>   $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'],
                                                "image" =>  $pm_galleries . $file['folder'] . '/' . $file['filename'],
                                                "width" => $file['width'],
                                                "height" => $file['height'],
                                                "title" => $file['title'],
                                                "gallery" => HTTP_SERVER . $file['folder']
                                              );
                             }
                            if($file['id'] - $data['image_id'] == 1){
                                $next = array(  "image_id" => $file['id'],
                                                "thumb" =>   $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'],
                                                "image" =>  $pm_galleries . $file['folder'] . '/' . $file['filename'],
                                                "width" => $file['width'],
                                                "height" => $file['height'],
                                                "title" => $file['title'],
                                                "gallery" => HTTP_SERVER . $file['folder']
                                              );
                             }
                    }                        
           }
         }
         return array("prev"=>$prev, "next"=> $next);
      }
      public function getImages($data,$setting){
       $query = $this->db->query("SELECT * FROM `". DB_PREFIX ."pm_gallery_folder` kgf LEFT JOIN `". DB_PREFIX ."pm_gallery_image` kgi ON (kgf.folder_id = kgi.folder_id) WHERE kgf.module_id = '" . $data['module_id'] . "' AND kgi.folder_id = '" . $data['folder_id'] . "'");
       $image_info = array();

       foreach($query->rows as $rows){
          $image_info[] = array("filename" => $rows['filename'],
                                "image_id" => $rows['id'],
                                "width" => $rows['width'],
                                "height" => $rows['height'],
                                "title" => $rows['title'],
                                "folder" => $rows['folder'],
                                "gallery" => HTTP_SERVER . $setting['pm_galleries']);
       }
       return $image_info;
      }
}
