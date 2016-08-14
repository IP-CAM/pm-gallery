<?php
class ModelCatalogPMGallery extends Model {
public function getModules(){
    $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `code` = 'pm_gallery'");
    return $query->rows;
}
public function updateFiles($folder,$pm_gallery,$module_id){
           if(is_dir($pm_gallery.$folder)){       
$iterator = new DirectoryIterator($pm_gallery.$folder);
              $folderSearch = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder WHERE name='".$folder."'");
                  $folder_id = $folderSearch->row['folder_id'];
                          
    $exifdata = "";
            foreach ($iterator as $fileInfo) {
                  if(is_file($pm_gallery.$folder.'/'.$fileInfo)){
  
                        $fileSearch = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_image WHERE folder_id='".$folder_id."' AND mixname='".$fileInfo."'");
                                if(!isset($fileSearch->row['mixname'])){
                                                                                               
                                    $filesize = filesize($pm_gallery.$folder.'/'.$fileInfo);
                                    $size = getImagesize($pm_gallery.$folder.'/'.$fileInfo);
                                          if(function_exists("exif_read_data")){        
                                               $exif = @exif_read_data($pm_gallery.$folder.'/'.$fileInfo,'IFD0,EXIF', true);
                                              
                                               $exifdata = $this->td_get_exif($exif); 
                                          }
                                          $this->db->query("INSERT INTO " . DB_PREFIX . "pm_gallery_image SET
                                                                                        folder_id = '".$folder_id."',
                                                                                        module_id = '".$module_id."',
                                                                                        filename='".$fileInfo."',
                                                                                        mixname='".$fileInfo."',
                                                                                        width='".$size[0]."',
                                                                                        height='".$size[1]."',
                                                                                        filesize='".$filesize."',
                                                                                        exif_data = '" . $this->db->escape($exifdata) ."',
                                                                                        date_added = '".time()."'");      
                                                                                                                                                
                                          $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_folder SET
                                                                                                        files = files+1,
                                                                                                        size = size+" . $filesize ."WHERE folder_id='" . $folder_id ."'"); 
                               }
                                                                                               
                }
           }
     }
  }
 
  public function getComments($dir,$file){
                  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_viewercomment WHERE folder_name='" . $dir. "' AND image_name='" . $file. "'");
                  $results = $query->rows;
                    return $results;
  }
  public function getComment($album,$file){
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_admin_comment WHERE folder_name='" . $album."' AND image_name = '".$file."'");
                $results = $query->rows;
                $content = array();
                foreach($results as $result){
                          $content[$result['language_id']] = array("id"=>$result['id'],
                                                                                      "comment"=>$result['comment']);
                    }
                  return $content;
  }
  public function addComment($data){
                                
                     $rows = $data['add_pm_gallery_comment'];
                                     $languages = array_keys($data['add_pm_gallery_comment']);
                                   for($i=0;$i<count($languages);$i++){
                                      $this->db->query("INSERT " .DB_PREFIX ."pm_gallery_admin_comment SET
                                      folder_name='".$this->db->escape($data['foldername'])."',
                                      image_name='".$this->db->escape($data['imagename'])."',
                                      comment='". $this->db->escape($rows[$languages[$i]]['comment'])."',
                                      language_id='".$languages[$i]."'");
                                    }
  }                  
  public function editComment($data){
                 $k = array_keys($data['edit_pm_gallery']);
                 for($i=0;$i<count($k);$i++){
                   if(trim($data['edit_pm_gallery'][$k[$i]]['id']) !=''){
                    $this->db->query("UPDATE " . DB_PREFIX . "pm_gallery_admin_comment SET
                    comment='" . $this->db->escape($data['edit_pm_gallery'][$k[$i]]['comment']) . "' WHERE  id='".$data['edit_pm_gallery'][$k[$i]]['id']."'");
                   } else{
                              $this->db->query("INSERT INTO " . DB_PREFIX . "pm_gallery_admin_comment SET 
                              folder_name='" . $data['foldername'] . "',
                              image_name='" . $data['imagename']."',
                              comment='" . $this->db->escape($data['edit_pm_gallery'][$k[$i]]['comment']) . "',
                              language_id='" . $k[$i]."'");
                    }
              }
  }                    
  public function editViewerComment($data){
                    $this->db->query("UPDATE " . DB_PREFIX . "pm_gallery_viewercomment SET name='".$this->db->escape($data['name'])."', comment='" . $this->db->escape($data['comment']) . "'
                    WHERE id='".$data['id']."'");
  }
  private function calcSize($dir){
	   $size = 0;
	   $num = 0;
	   $iterator = new DirectoryIterator($dir);
	    foreach ($iterator as $fileInfo){
	    	if($fileInfo->isDot()){
			    continue;
		   } else if($fileInfo->isDir()){
	   		 $info = $this->calcSize($dir.$fileInfo->getBasename()."/");
		   	$size += $info[1];
		   } else if($fileInfo->isFile()){
			   $size += $fileInfo->getSize();
		   	$num += 1;
		  }
	  }
	  return array($num, $size);
  }
  public function getFolders($module_id){
               $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE `module_id` = '" . $module_id ." ' ORDER BY sort_order ASC");
                     
           return $query->rows;
  }  
  public function getFolder($module_id,$folder_id){
               $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE `module_id` = '" . $module_id ." ' AND `folder_id` = '" . $folder_id . "'");
                     
           return $query->row;
  }
  public function getDatabaseImage(){
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder kgf LEFT JOIN " . DB_PREFIX . "pm_gallery_image kgi 
              ON (kgf.folder_id = kgi.folder_id) ORDER BY kgi.sort_order ASC");
               $image_info = array();
                        $results = $query->rows;
                        $i=0;
                        $desc = array();
                        foreach($results as $result){
                                                $desc[$i] = $result['filename'];
                                               $description = $this->db->query("SELECT * FROM ". DB_PREFIX ."pm_gallery_admin_comment WHERE image_name = '".$result['mixname']."'");
                                              if(isset($description->row['comment'])){
                                                                     if($description->row['comment'] !=''){
                                                                      $desc[$i] = $description->row['comment'];
                                                                      }
                                               } 
                                                   $image_info[] = array('name'=>$result['folder'],
                                                                         'filename'=>$result['filename'],
                                                                         'description' => '',
                                                                         'id'=> $result['id'],
                                                                         'mixname'=>$result['mixname'],
                                                                         'filesize'=>$result['filesize'],
                                                                         'sort_order'=>$result['sort_order']);              
                                $i++;
                                               
                       }

                       for($i=0;$i<count($desc);$i++){
                                              $image_info[$i]['description'] = $desc[$i];
                       }
                     
              return $image_info;
  }
  public function getDatabaseImages($folder){
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder kgf LEFT JOIN " . DB_PREFIX . "pm_gallery_image kgi 
              ON (kgf.folder_id = kgi.folder_id) WHERE kgf.folder = '".$folder."' ORDER BY id ASC");

                        $results = $query->rows;
              return $results;;
  }
  public function folderSizetoDatabase($data){
                              $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_folder SET
                                                                                              size = '".$data['file_sizes']."'  WHERE name='" . $data['folder_name'] ."'"); 
  }
  public function editImageTitle($data){
                              $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_image SET
                                                                                             title = '".$this->db->escape($data['edit_title'])."'  WHERE id='" . $data['image_id'] ."'"); 
  }
  public function deleteViewerComment($data){
                             $this->db->query("DELETE FROM " . DB_PREFIX ."pm_gallery_viewercomment WHERE id = '".$data['id']."'");
  }
  public function deleteComment($data){
                             $this->db->query("DELETE FROM " . DB_PREFIX ."pm_gallery_admin_comment WHERE folder_name = '".$data['foldername']."' AND image_name='".$data['imagename']."'");
  }
  public function editFolder($data,$setting){
                    $info = $data['editfolder'];
                    $pm_galleries = $setting['pm_galleries'];
                    // image frame variables
                     $query = $this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE folder_id = '".$info['folder_id']."'");
                     $result = $query->row;
                         
                     $path = '../'.$pm_galleries;
                     
                     $path2 = '../'.$pm_galleries.$result['name'];
                    // image frame variables
                    @rename( '../'.$pm_galleries.$result['name'],'../'.$pm_galleries.$info['name']);
                    // image frame loop
                      $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_folder SET
                      	                                                              name = '". $info['name'] ."',
                                                                                      sort_order= '" . $info['sort_order']. "',
                                                                                      status = '".$info['status'] ."' WHERE folder_id='" . $info['folder_id'] ."'"); 
                    $update = $data['updatefolder'];
                    $lang = array_keys($update);
                    
                      $this->db->query("DELETE FROM  " . DB_PREFIX . "pm_gallery_folder_description WHERE folder_id='" . $info['folder_id'] ."'"); 
                   for($i=0;$i<count($lang);$i++){
                      $this->db->query("INSERT INTO  " . DB_PREFIX . "pm_gallery_folder_description SET folder_id='" . $info['folder_id'] ."',
                      title='".$this->db->escape($update[$lang[$i]]['title'])."', description='".$this->db->escape($update[$lang[$i]]['description'])."',language_id='".$lang[$i]."', date_modified=NOW()"); 
                 }
                      $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_admin_comment SET folder_name='".$this->db->escape($info['name'])."' WHERE folder_name='" . $result['name'] ."'"); 
                      $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_viewercomment SET folder_name='".$this->db->escape($info['name'])."' WHERE folder_name='" . $result['name'] ."'");  
  }
  public function changeImageFolder($data,$pm_gallery,$module_id){
                             
                    if($data['change_folder'] !=$data['foldername']){
                                                   
                        $query=$this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE name='".$data['foldername']."'");
                        $mixthumb = $query->row['mixthumb'];
   
                        $image_path = '../'.$pm_gallery.$data['foldername'] .'/'. $data['imagename'];    
                        $thumb_path = '../'.$pm_gallery.$data['foldername'] .'/thumbs/'. $mixthumb.$data['imagename'];   
                        $copy_folder_path = '../'.$pm_gallery.$data['change_folder'].'/'. $data['imagename'];
                        
                    // image frame loop
 
                        $query2=$this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE name='".$data['change_folder']."'");
                        $folder_id = $query2->row['folder_id'];
                        $mixthumb2 = $query2->row['mixthumb'];
                        
                        $copy_thumb_path = '../'.$pm_gallery.$data['change_folder'].'/thumbs/'. $mixthumb2.$data['imagename'];
                        
                        if(file_exists($image_path)){
                          @copy($image_path,$copy_folder_path);
                        $image_size = filesize($copy_folder_path);
                          } else{
                                           //     return "Error";
                          } 
                                 
                        if(file_exists($thumb_path)){
                        $thumb_dir = '../'.$pm_gallery.$data['change_folder'] .'/thumbs/';   
                                 if(!is_dir($thumb_dir)){
                                              $real_permission = $this->getLogsPerms();
                                              @mkdir( $thumb_dir, octdec( $real_permission ) );
                                 } 
                     
                          @copy($thumb_path,$copy_thumb_path);
                          }
   
                    // image frame loop
                        $query=$this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_image WHERE id='".$data['image_id']."'");
                        $result = $query->row;
                        $this->db->query("INSERT INTO  " . DB_PREFIX ."pm_gallery_image SET folder_id='".$folder_id."',
                                                                                                  module_id='".$module_id."',
                                                                                                  filename='".$result['filename']."',
                                                                                                  mixname='".$result['mixname']."',
                                                                                                  width='".$result['width']."',
                                                                                                  height='".$result['height']."',
                                                                                                  filesize='".$result['filesize']."',
                                                                                                  exif_data='".$this->db->escape($result['exif_data'])."',
                                                                                                  date_added='".$result['date_added']."'");                                                                                                  
                       
                         $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_folder SET
                      	                                                           files = files+1,
                                                                                   size = size+" . $image_size ."  WHERE folder_id='" . $folder_id ."'"); 

                              
                                $delete_data = array("pm_galleries"=>$pm_gallery,
                                                                "album"=>$data['foldername'],
                                                                "file"=>$data['imagename'],
                                                                "thumb"=>$mixthumb.$data['imagename']);
                        $this->deleteImage($delete_data,$pm_fr_gallery);
                    }
  }
  public function imgMysql($file,$mysql,$surplus){
               for($i=0;$i<count($surplus[1]);$i++){
                         if(isset($surplus[0][$i])){
                             $this->db->query("DELETE FROM " . DB_PREFIX ."pm_gallery_image WHERE id = '".$surplus[1][$i]."' AND mixname='".$surplus[0][$i]."'");
                             }
              }
  }
  public function getDatabaseFolder($folder){
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder kgf INNER JOIN " . DB_PREFIX . "pm_gallery_image kgi 
              ON (kgf.folder_id = kgi.folder_id) WHERE kgf.name = '".$folder."'");
    
              $results = $query->rows;
                $image_info = array();
                        $i=0;
                        $desc = array();
                        foreach($results as $result){
                                                $desc[$i] = $result['filename'];
                                               $description = $this->db->query("SELECT * FROM ". DB_PREFIX ."pm_gallery_admin_comment WHERE image_name = '".$result['mixname']."'");
                                              if(isset($description->row['comment'])){
                                                                     if($description->row['comment'] !=''){
                                                                      $desc[$i] = $description->row['comment'];
                                                                      }
                                               } 
                                                    $image_info[] = array('name'=>$result['name'],
                                                                          'filename'=>$result['filename'],
                                                                           'description' => '',
                                                                           'id'=> $result['id'],
                                                                           'mixname'=>$result['mixname'],
                                                                           'filesize'=>$result['filesize'],
                                                                           'sort_order'=>$result['sort_order']);              
                               $i++;
                                               
                       }

                       for($i=0;$i<count($desc);$i++){
                                              $image_info[$i]['description'] = $desc[$i];
                       }
                     
              return $image_info;
  }
  public function getImageOrder($folder){
                           $folder_id = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder WHERE name='".$folder."'");
    $query = $this->db->query("SELECT MAX(sort_order) FROM " . DB_PREFIX . "pm_gallery_image WHERE folder_id='".$folder_id->row['folder_id']."'");
    
              return $query->row["MAX(sort_order)"]+1;
  }
  public function getFolderInfo($module_id){
              $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder  WHERE `module_id` = '" . $module_id . "' ORDER BY sort_order ASC");
             
              $results = $query->rows;
       
              $info = array();
              $i=0;
              foreach($results as $result){
                        
                  if($result['size'] > 0) $size = round($result['size']/1024/1024,2); else $size = 0;  
                  /*   image frame   "size_of_fr"=>$size_of_fr,    */
                  if($result['size_of_fr'] > 0) $size_of_fr = round($result['size_of_fr']/1024/1024,2); else $size_of_fr = 0;    
                   $info[$i] = array($result['folder'] => array("folder_id"=>$result['folder_id'],
                                                                "module_id"=>$result['module_id'],
                                                                "files"=> $result['files'],
                                                                "size"=> $size,
                                                                "sort_order"=>$result['sort_order'],
                                                                "status"=>$result['status']));
                        $i++;
                   }
              return $info;
  }
  public function getFolderDescription($folder_id){
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language");
            $results = $query->rows;
            
            $query2 = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder WHERE folder_id='".$folder_id."'"); 
            $result2 = $query2->row;
          $i=0;
          foreach($results as $language){
                      $desc = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder_description WHERE folder_id='".$folder_id."'  AND language_id='".$language['language_id']."'");
                         $result = $desc->row; 
                         if(!isset($result['title'])){
                                   $result['title'] = ' ';
                         }
                         if(!isset($result['description'])){
                                   $result['description'] = ' ';
                         }
                               $description_info[$i] = 'language_id='.$language['language_id'].'&name='.$language['name'].'&image='.$language['image'].'&sort_order='.$result2['sort_order'].'&folder='.$result2['folder']. '&status='.$result2['status'].'&title='.$result['title'].'&description='.$result['description'];
                               $i++;
             }
               return $description_info;
  }
  public function editImageOrder($data){
           foreach ($data['image_change'] as $img){
                         
           $query2 = $this->db->query("UPDATE " . DB_PREFIX . "pm_gallery_image SET
            sort_order='".$img['sort_order']."' WHERE id='".$img['image_id']."'");
            }
  }
    // image frame method
  public function getImages($module_id,$folder){      
                  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder kgf LEFT JOIN " . DB_PREFIX . "pm_gallery_image kgi ON (kgf.folder_id = kgi.folder_id) WHERE kgi.folder_id='" . $folder ."' AND kgi.module_id='" . $module_id . "'");
                    
                                
                      return $query->rows;
  }
  public function addWatermark($data,$pm_gallery){
                       $pm_watermark_hori = $data['watermark_hori'];
                       $pm_watermark_vert = $data['watermark_vert'];
                       $pm_watermark_size = $data['watermark_size'];
                       $picture = '../'.$pm_gallery.$data['foldername'].'/'.$data['imagename'];
                       $watermark = '../'.$pm_gallery .'pm_watermark.pic';
                  if(file_exists($picture)){

  if(is_file($watermark)){
                         $image_info = getimagesize($picture);
                         
			$temp = explode('/', strtolower($image_info['mime']));
                                                                     
                                                                     if($temp[1] === "jpeg")$temp[1] = "jpg";
                                                                     
                                                                       switch($temp[1]){
                                                                                                                   case "jpg":
                                                                                                                   $image = imagecreatefromjpeg($picture);
                                                                      $extension = "jpg";
                                                                                              break;
                                                                                                                   case "png":
                                                                                                                   $image = imagecreatefrompng($picture);
                                                                      $extension = "png";
                                                                                                                   break;
                                                                                                                   case "gif":
                                                                                                                   $image = imagecreatefromgif($picture);
                                                                      $extension = "gif";
                                                                                                                   break;
                                                                     }
                                                                     imagealphablending($image, true);
                                                                     imagesavealpha($image, true);
                                                                                                                   
                                                                     $imageWidth = imagesx($image);
                                                                     $imageHeight = imagesy($image);
                                                                     $imageWidth_o = $imageWidth;
                                                                     $imageHeight_o = $imageHeight;
                                                                   
                                                             
                                                                     // Load the logo image
                                              $logoImage = imagecreatefrompng("../".$pm_gallery."pm_watermark.pic");
                                              
                                                                     if(!$logoImage){
                                                                                            $logoImage = imagecreatefromjpeg("../".$pm_gallery."pm_watermark.pic");
                                                                     }
                                                                     if(!$logoImage){
                                                                                            $logoImage = imagecreatefromgif("../".$pm_gallery."pm_watermark.pic");
                                                                     }
                                                                     if(!$logoImage){
                                                                                            exit();
                                                                     }							
                                                                     imagealphablending($logoImage, true);
                                                                     imagesavealpha($logoImage, true);

                                                                     $logoWidth = imagesx($logoImage);
                                                                     $logoHeight = imagesy($logoImage);
                                                                     
                                                                     $logoWidth_o = $logoWidth;
                                                                     $logoHeight_o = $logoHeight;
                                  
                       if($pm_watermark_size > 0){
                                                                                            
                                                                 $logoAspect = $logoWidth / $logoHeight;

                                                                     if($imageWidth > $imageHeight){
                                                                                            $wide = 1;	
                                                                     } else {
                                                                                            $wide = 0;	
                                                                     }
                                                                     
                                                                     if($logoWidth > $logoHeight){
                                                                                            $logoWide = 1;	
                                                                     } else {
                                                                                            $logoWide = 0;	
                                                                     }
                                                                                            
                                                                                            
                                              if($wide == 1){
                                                                                            if($logoWide == 1){
                                                                                                                   $logoWidth = round($pm_watermark_size * $imageWidth);
                                                                                                                   $logoHeight = round((1/$logoAspect) * $logoWidth);
                                                                                                                   if($logoHeight > $imageHeight){
                                                                                                                                          $logoHeight = round($pm_watermark_size * $imageHeight);
                                                                                                                                          $logoWidth = round($logoAspect * $logoHeight);	
                                                                                                                   }
                                                                                            } else {
                                                                                                                   $logoHeight = round($pm_watermark_size * $imageHeight);
                                                                                                                   $logoWidth = round($logoAspect * $logoHeight);
                                                                                            }
                                              } else {
                                                                                            if($logoWide == 0){
                                                                                                                   $logoHeight = round($pm_watermark_size * $imageHeight);
                                                                                                                   $logoWidth = round($logoAspect * $logoHeight);
                                                                                                                   if($logoWidth > $imageWidth){
                                                                                                                                          $logoWidth = round($pm_watermark_size * $imageWidth);
                                                                                                                                          $logoHeight = round((1/$logoAspect) * $logoWidth);
                                                                                                                   } else {
                                                                                                    $logoWidth = round($pm_watermark_size * $imageWidth);
                                                                                                    $logoHeight = round((1/$logoAspect) * $logoWidth);
                                                                                                                   }
                                                                                            }
                                              }
                    }	
                                                                     switch($pm_watermark_vert){
                                                                                            case "top":
                                                                                                                   $starty = 0;
                                                                                            break;
                                                                                            case "middle";
                                                                                                                   $starty = round(($imageHeight - $logoHeight)*0.5);
                                                                     break;
                                                                     case "bottom":
                                                                                            $starty = $imageHeight-$logoHeight;
                                                                     break;	 
                                                                     }
                                                                     switch($pm_watermark_hori){
                                                                                            case "left":
                                                                                                                   $startx = 0;
                                                                                            break;
                                                                                            case "center";
                                                                                                                   $startx = round(($imageWidth - $logoWidth)*0.5);
                                                                                            break;
                                                                                            case "right":
                                                                                                                   $startx = $imageWidth-$logoWidth;
                                                                                            break;	 
                                                                     }
                                                                     // Paste the logo
                                                                     imagecopyresampled($image, $logoImage, $startx, $starty, 0, 0, $logoWidth, $logoHeight, $logoWidth_o, $logoHeight_o);
                                                                      

                                                                     imageDestroy($logoImage);
                                              
                       // Save image
                       switch($temp[1]){
                                              case "jpg":
                                                                     imagejpeg($image, $picture, 80);
                                              break;
                                              case "png":
                                                                     imagepng($image, $picture);
                                              break;
                                              case "gif":
                                                                     imagegif($image, $picture);
                                              break;
                       }

                       imageDestroy($image);
                                              
                       $this->db->query("UPDATE ".DB_PREFIX ."pm_gallery_image SET watermark=1 WHERE id='".$data['image_id']."'");
                                      
                       }
         }
  }
  public function addImage($data,$pm_galleries,$pm_th_width,$pm_th_height,$pm_th_to_square,$pm_mixname,$maxx,$maxy,$module_id){
                  $pm_watermark_hori = $data['watermark_hori'];
                  $pm_watermark_vert = $data['watermark_vert'];
                  $pm_watermark_size = $data['watermark_size'];

        $root = dirname( dirname( dirname( dirname( __FILE__ ) ) ) ) . '/';
           $thefile = '';
           $image_name = '';
           $image_not_found = '';
	$supported = array("jpg","png","gif", "jpeg");
	$image_not_found = false;
                       $path = "../".$pm_galleries;
                       $path2 = "../".$pm_galleries.$data['folder'].'/';

        if(is_uploaded_file($_FILES['image']['tmp_name'])){
	
         if($pm_galleries !=''){
	
		$thefile = $_FILES['image'];
                                              
		if(isset($data['watermark'])){
			$target_name = "../".$pm_galleries."pm_watermark.pic";
                                                      
			$temp = explode('.', strtolower($thefile['name']));
			if(in_array($temp[1], $supported)){
				if(move_uploaded_file($thefile['tmp_name'], $target_name)){

				}
			} 
		} else {
        $folder_info = $this->getFolder($module_id,$data['folder']);
				$dir = $folder_info['folder'];

			if(!isset($data['addwatermark']))
				$addwatermak = 0;
			else	
				$addwatermak = $data['addwatermark'];
	
			if(!isset($data['rotate']))
				$rotate = 0;
			else	
				$rotate = intval($data['rotate']);
	
			// -------------- Sicherheitsabfragen!
                                                
			if(preg_match("/[\.]*\//", $dir))exit();
			// ---------- Ende Sicherheitsabfragen!
		
            $p='/';
			$target_path = "../".$pm_galleries.$dir.$p;
                    // image frame variables
                    // image frame loop
			$target_fr_path = "../".$data['pm_fr_galleries'].$dir.$p;                 
                                                        $targets = "../".$pm_galleries;
                                                        $real_permission = $this->getLogsPerms();
                                                            if( file_exists( $targets ) && $this->getFileperms( $targets ) != $real_permission ) {
                                                                                        @chmod( $targets, octdec( $real_permission ) );
                                                            }
                                                            if( file_exists( $target_path ) && $this->getFileperms( $target_path ) != $real_permission ) {
                                                                                        @chmod( $targets_fr_path, octdec( $real_permission ) );
                                                            }
                                                            if( file_exists( $target_fr_path ) && $this->getFileperms( $target_fr_path ) != $real_permission ) {
                                                                                        @chmod( $target_fr_path, octdec( $real_permission ) );
                                                            }
                                    
			$temp = explode('.', strtolower($thefile['name']));
      $temp = array_reverse($temp);
            if(in_array($temp[0], $supported)){

                  if($temp[0] === "jpeg")$temp[1] = "jpg";
                          $target_name = $target_path.$temp[1].".".$temp[0]; // Endgültige Pfad+Name
                                            
			$target_fr_name = $target_fr_path.$temp[1].".".$temp[0];
                       if(move_uploaded_file($thefile['tmp_name'], DIR_UPLOAD . $temp[1] . '.' . $temp[0]));

                       if(copy( DIR_UPLOAD . $temp[1] . '.' . $temp[0], $target_name)){
                                                   $path_arr = explode("/",$target_name);
                                                   $path_arr = array_reverse($path_arr);
                                                   $image_name = $path_arr[1].'/'.$path_arr[0];

					// Load the image where the logo will be embeded into
                                                    switch($temp[0]){
                                                       case "jpg":
                                                        $image = imagecreatefromjpeg($target_name);
                                                      //  $thumb =  imagecreatefromjpeg($target_thumb_name);
                                                        $extension = "jpg";
                                                        break;
                                                       case "png":
                                                        $image = imagecreatefrompng($target_name);
                                                        $extension = "png";
                                                        break;
                                                      case "gif":
                                                        $image = imagecreatefromgif($target_name);
                                                        $extension = "gif";
                                                        break;
          }
					imagealphablending($image, true);
					imagesavealpha($image, true);


					// Auto rotate
					$orientation = 1;
                                                  $exifdata = "";
                                                   if(function_exists("exif_read_data")){
                                                            if(file_exists($target_name) && is_writable($target_name)){
                                                                    $img = getimagesize($target_name);
                                                                        if($img['mime'] !='image/png'){
                                                                           $exif = @exif_read_data($target_name,'IFD0,EXIF', true);
                                                                           $exifdata = $this->td_get_exif($exif);  
                                                                        }
                                                            }

                                                                                                           
                                                            if($rotate == 1){
                                                                        if(isset($exif['Orientation'])){
                                                                                                
                                                                            if(!is_array($exif['Orientation']))$orientation = $exif['Orientation'];
                                                                        }
                                                                        switch($orientation) {
                                                                          case 3:
                                                                            $image = imagerotate($image, 180, 0);
                                                                           break;
                                                                           case 6:
                                                                            $image = imagerotate($image, -90, 0);
                                                                            break;
                                                                           case 8:
                                                                            $image = imagerotate($image, 90, 0);
                                                                            break;
                                                                             default:
                                                                             $orientation = 1;
                                                                              break;
                                                                       }
                                                             }
                                                     }

					// Get dimensions
					$imageWidth = imagesx($image);
					$imageHeight = imagesy($image);
					$imageWidth_o = $imageWidth;
					$imageHeight_o = $imageHeight;
					if($addwatermak == 1){
                                                     if(is_file("../".$pm_galleries."pm_watermark.pic")){
                                                         // Load the logo image
                                                         $logoImage = imagecreatefrompng("../".$pm_galleries."pm_watermark.pic");
                                                          if(!$logoImage){
                                                                $logoImage = imagecreatefromjpeg("../".$pm_galleries."pm_watermark.pic");
                                                          }
                                                         if(!$logoImage){
                                                              $logoImage = imagecreatefromgif("../".$pm_galleries."pm_watermark.pic");
                                                         }
                                                         if(!$logoImage){
                                                               exit();
                                                         }							
                                                        imagealphablending($logoImage, true);
                                                        imagesavealpha($logoImage, true);

                                                        $logoWidth = imagesx($logoImage);
                                                        $logoHeight = imagesy($logoImage);
                                                                                                                   
                                                        $logoWidth_o = $logoWidth;
                                                        $logoHeight_o = $logoHeight;
                                                                                
                                                         if($pm_watermark_size > 0){
                                                                                                                                          
                                                             $logoAspect = $logoWidth / $logoHeight;

                                                            if($imageWidth > $imageHeight){
                                                                $wide = 1;	
                                                           } else {
                                                                $wide = 0;	
                                                          }
                                                                                                                                          
                                                          if($logoWidth > $logoHeight){
                                                              $logoWide = 1;	
                                                          } else {
                                                             $logoWide = 0;	
                                                          }
                                                                                                                                          
                                                         if($wide == 1){
                                                             if($logoWide == 1){
                                                                 $logoWidth = round($pm_watermark_size * $imageWidth);
                                                                 $logoHeight = round((1/$logoAspect) * $logoWidth);
                                                                if($logoHeight > $imageHeight){
                                                                    $logoHeight = round($pm_watermark_size * $imageHeight);
                                                                   $logoWidth = round($logoAspect * $logoHeight);	
                                                                }
                                                             } else {
                                                                   $logoHeight = round($pm_watermark_size * $imageHeight);
                                                                   $logoWidth = round($logoAspect * $logoHeight);
                                                             }
                                                         } else {
                                                            if($logoWide == 0){
                                                                 $logoHeight = round($pm_watermark_size * $imageHeight);
                                                                $logoWidth = round($logoAspect * $logoHeight);
                                                               if($logoWidth > $imageWidth){
                                                                 $logoWidth = round($pm_watermark_size * $imageWidth);
                                                                 $logoHeight = round((1/$logoAspect) * $logoWidth);
                                                              } else {
                                                                 $logoWidth = round($pm_watermark_size * $imageWidth);
                                                                 $logoHeight = round((1/$logoAspect) * $logoWidth);
                                                              }
                                                           }
                                                        }
                                                    }	
                                                                            switch($pm_watermark_vert){
                                                                              case "top":
                                                                              $starty = 0;
                                                                               break;
                                                                              case "middle";
                                                                                $starty = round(($imageHeight - $logoHeight)*0.5);
                                                                                break;
                                                                             case "bottom":
                                                                                $starty = $imageHeight-$logoHeight;
                                                                                 break;	 
                                                                            }
                                                                             switch($pm_watermark_hori){
                                                                                case "left":
                                                                                  $startx = 0;
                                                                                  break;
                                                                                case "center";
                                                                                  $startx = round(($imageWidth - $logoWidth)*0.5);
                                                                                  break;
                                                                             case "right":
                                                                                  $startx = $imageWidth-$logoWidth;
                                                                                   break;	 
                                                                             }
                                                                            // Paste the logo
                                                  imagecopyresampled($image, $logoImage, $startx, $starty, 0, 0, $logoWidth, $logoHeight, $logoWidth_o, $logoHeight_o);

                                                  imageDestroy($logoImage);
                                                                                                                   
                                                                                                                   
                                                     }
                                                }
                                                                     
                                   if(isset($data['maxx'])){
                                         if(intval($data['maxx']) > 0)$maxx = intval($data['maxx']);
                                      }
                                       if(isset($data['maxy'])){
                                                    if(intval($data['maxy']) > 0)$maxy = intval($data['maxy']);
                                            }
					$aspect = $imageWidth / $imageHeight;
                                                                       
					if($aspect > 1){
						if($imageWidth > $maxx){
							$imageWidth = $maxx;
							$imageHeight = round((1/$aspect) * $imageWidth);
						}
						if($imageHeight > $maxy){
							$imageHeight = $maxy;
							$imageWidth = round($aspect * $imageHeight);
						}
					} else {
						if($imageHeight > $maxy){
							$imageHeight = $maxy;
							$imageWidth = round($aspect * $imageHeight);
						}
						if($imageWidth > $maxx){
							$imageWidth = $maxx;
							$imageHeight = round((1/$aspect) * $imageWidth);
						}
					}
    // -------- CREATE THUMB IMAGE -----------
    // Square thumb
          define('DIR_ROOT', $root . $pm_galleries . $dir . '/');
           if($imageWidth > $imageHeight){
            // vaaka
            $pros = round($pm_th_height/$imageHeight*100,3);
            $newwidth = round($pros*$imageWidth/100);
            $newheight = $pm_th_height;
            $w = 1;
            $h = 0;
           } elseif ($imageHeight > $imageWidth){
            // pysty
            $pros = round($pm_th_width/$imageWidth*100,3);
            $newheight = round($pros*$imageHeight/100,0);
            $newwidth = $pm_th_width;
            $w = 0;
            $h = 1;
           } 

      if(file_exists( DIR_UPLOAD . $temp[1] . '.' . $temp[0] )){
            $target_thumb_name = DIR_ROOT . 'thumbs/' .  $temp[1] . '.' . $temp[0];
           if($pm_th_to_square == 1){
               $create_thumb = imagecreatetruecolor($pm_th_width, $pm_th_width);
           } else {
               $create_thumb = imagecreatetruecolor($pm_th_width, $pm_th_height);
           }
            $thumb =  imagecreatefromjpeg( DIR_UPLOAD . $temp[1] . '.' . $temp[0] );
            imagealphablending($create_thumb, false);
            imagesavealpha($create_thumb, true);
            imagecopyresampled($create_thumb, $thumb, 0, 0, 0, 0,  $newwidth, $newheight, $imageWidth, $imageHeight); 
            switch($temp[0]){
              case "jpg":
                imagejpeg($create_thumb, $target_thumb_name , 80);
              break;
              case "png":
                imagepng($create_thumb, $target_thumb_name);
              break;
              case "gif":
                imagegif($create_thumb, $target_thumb_name);
              break;
              }                      
            imageDestroy($create_thumb);
     }

					if($imageWidth_o != $imageWidth || $imageHeight_o != $imageHeight){
            $bild = imagecreatetruecolor($imageWidth, $imageHeight);
						imagealphablending($bild, false);
						imagesavealpha($bild, true);
						imagecopyresampled($bild, $image, 0, 0, 0, 0, $imageWidth, $imageHeight, $imageWidth_o, $imageHeight_o); 
						switch($temp[0]){
							case "jpg":
								imagejpeg($bild, $target_name, 80);
							break;
							case "png":
								imagepng($bild, $target_name);
							break;
							case "gif":
								imagegif($bild, $target_name);
							break;
              }
                                                                                                                                                              
						imageDestroy($bild);
					} else {
						if($addwatermak == 1 || $orientation != 1){
							// Save image
							switch($temp[0]){
								case "jpg":
									imagejpeg($image, $target_name, 80);
								break;
								case "png":
									imagepng($image, $target_name);
								break;
								case "gif":
									imagegif($image, $target_name);
								break;
							}
						}
          }
       
                    // image frame loop
				// Release memory
             imageDestroy($image);
        // pm_mixname is true loop
                                              
                            $mix_path =  $target_name;
                            $fname = basename($target_name);
        // dimenssion and filesize of target_fr_name
                          
                            $folder_id = $data['folder'];
                      $size =  filesize($mix_path);
              
                $max_image = $this->maxImage();
              $query2 = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_image WHERE id = '" .$max_image ."'");
              $filename = basename($target_name);
              
              if(!isset($query2->row['filename']) or isset($query2->row['filename']) && $query2->row['filename'] != $filename ){
                // file exists target_fr_name loop
                /* sql insert
                                                                                                  mixname = '" . $this->db->escape($fname). "',
                                                                                                  width_of_fr = '".$width_of_fr."',
                                                                                                  height_of_fr = '".$height_of_fr."',
                                                                                                  filesize_of_fr = '".$filesize_of_fr."',
                */
                             if(isset($data['title'])){
                                                    $title = $this->db->escape($data['title']);
                             } else {
                                                    $title = '';
                             }

                        $this->db->query("INSERT INTO " . DB_PREFIX . "pm_gallery_image SET
                                                                                                  folder_id = '" . $folder_id . "',
                                                                                                  module_id = '" . $module_id . "',
                                                                                                  title = '" . $title ."', 
                                                                                                  filename = '" . $this->db->escape(basename($target_name)) ."',
                                                                                                  width = '" . $imageWidth . "',
                                                                                                  height = '" . $imageHeight . "',
                                                                                                  filesize = '" .$size. "',
                                                                                                  exif_data = '" . $this->db->escape($exifdata) ."',
                                                                                                  date_added = '".time()."',
                                                                                                  sort_order = '".$data['sort_order']."'");  
                      /*
                      ,
                                                                                              size_of_fr = size_of_fr + " . $filesize_of_fr . "  */                         
                        $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_folder SET
                                                                                              files = files+1,
                                                                                              size = size+" . $size ." WHERE folder_id='" . $folder_id ."'"); 
                                                                                   
                                                                         if(isset($data['add_pm_gallery_comment'])){
                                                                                                             
                                                                               $languages = array_keys($data['add_pm_gallery_comment']);
                                                                               $lang = $data['add_pm_gallery_comment'];
                                                                               $r = false;
                                                                                                                                 
                                                                                $data['imagename'] = basename($mix_path);
                                                                                $data['foldername'] = $dir;
                    
                                                                                    for($i=0;$i<count($languages);$i++){
                                                                                         if(isset($lang[$languages[$i]]['comment'])){
                                                                                             if($lang[$languages[$i]]['comment'] !=''){
                                                                                                  $r = true;
                                                                                             }
                                                                                          }
                                                                                    }
                                                                                     if($r == true){
                                                                                         $this->addComment($data);
                                                                                     }
                                                                            }   
                                                                            // end comment
                                                                   }
                                                       // end file check
                                                       }
                                              }
                                   
                                   }
                            }
	 }elseif($thefile == ''){
                                        $image_not_found = true;
                       }

                    // image frame variables


                    if($image_not_found == true){
                                      //        return "404fi";
                     } else{
                                     if($image_name !=''){
                                              return $image_name;
                                     } 
                                                                                            
                   }
  }
  public function deleteImage($data,$fr_galleries){
                  $response = "";
                  $pm_galleries = $data['pm_galleries'];
                  if(isset($data['album']))
                                    $gallery = rawurldecode($data['album']);
                                    
                  if(isset($data['file']))
                                    $file = rawurldecode($data['file']);
	
                  if(isset($data['thumb']))
                                    $thumb = rawurldecode($data['thumb']);
                                     
                  // -------------- Sicherheitsabfragen!
                  if(!is_file("../".$pm_galleries.$gallery."/".$file)) {  $response = "not_found";}
      
         
                                    $imgfile = "../".$pm_galleries.$gallery."/".$file;
                                    $thumbfile = "../".$pm_galleries.$gallery."/thumbs/".$thumb;
                                    
                                    $fr_imgfile = "../".$fr_galleries.$gallery."/".$file;
                                    $size='';
                          if(is_file($imgfile)){
                                                 $size = filesize($imgfile);
                                                 @unlink($imgfile);
                        $query=$this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE name='".$gallery."'");
                        $folder_id = $query->row['folder_id'];     
                        
                                 $this->db->query("UPDATE  " . DB_PREFIX . "pm_gallery_folder SET
                      	                                                           files = files-1,
                                                                                         size = size-" . $size ."  WHERE folder_id='" . $folder_id ."'"); 
                              
                              $this->db->query("DELETE FROM " . DB_PREFIX ."pm_gallery_image WHERE folder_id='".$folder_id."' AND mixname = '".$file."'");   
                              $this->db->query("DELETE FROM " . DB_PREFIX ."pm_gallery_admin_comment WHERE folder_name='".$gallery."' AND image_name = '".$file."'");  
                              $this->db->query("DELETE FROM " . DB_PREFIX ."pm_gallery_viewercomment WHERE folder_name='".$gallery."' AND image_name = '".$file."'");   
                                              }else{
                                                     //     $response =  "Error";
                                              }
                                    if(is_file($thumbfile))@unlink($thumbfile);
                                      if(file_exists($imgfile)) {
                                              //  $response =  "Error Permission";
                                                } 
                             if(is_file($fr_imgfile)){
                                                 @unlink($fr_imgfile);
                                }
                                    return $response;

  }
  public function imageResize($data,$pm_gallery,$dir,$file){
                        $query=$this->db->query("SELECT * FROM " . DB_PREFIX ."pm_gallery_folder WHERE name='".$dir."'");
                        $folder_id = $query->row['folder_id'];     
                        
                          $query2 =  $this->db->query("SELECT *  FROM " . DB_PREFIX ."pm_gallery_image WHERE folder_id='".$folder_id."' AND filename = '".$file."'");   
                           $old_size = $query2->row['filesize'];
                           
                   $filename = '../'.$pm_gallery.$dir.'/'.$query2->row['mixname'];
                   list($width_orig, $height_orig) = getimagesize($filename);
                   
                   // Set a maximum height and width
                       $width = $data['width'];
                       $height = $data['height']; 
               if($width > 25 && $height > 25){        
                  $ratio_orig = $width_orig/$height_orig;
                  
                  if ($width/$height > $ratio_orig) {  
                     $width = $height*$ratio_orig;
                  } else {        
                     $height = $width/$ratio_orig;
                       }

              // Resample
             $image_p = imagecreatetruecolor($width, $height);
          
             $temp = array_reverse(explode('.', strtolower($filename)));
                  switch($temp[0]){
                                    case "jpg":
                                                      $image = imagecreatefromjpeg($filename);
                                   break;
                                    case "png":
                                                      $image = imagecreatefrompng($filename);
                                    break;
                                    case "gif":
                                                      $image = imagecreatefromgif($filename);
                                    break;
                  }
         imagecopyresampled($image_p, $image, 0, 0, 0, 0, $width, $height, $width_orig, $height_orig);

            // Output
                  switch($temp[0]){
                                    case "jpg":
                                                      imagejpeg($image_p, $filename, 100);
                                    break;
                                    case "png":
                                                      imagepng($image_p, $filename);
                                    break;
                                    case "gif":
                                                      imagegif($image_p, $filename);
                                    break;
                       }

                    $filesize = 0;   
                    
                     if(file_exists($filename)){
                     $filesize = filesize($filename);   
                       }

     $querya = $this->db->query("SELECT (folder_id) FROM " . DB_PREFIX . "pm_gallery_folder WHERE name = '" .$dir ."'");
     $folder_id = $querya->row["folder_id"];
                 $this->db->query("UPDATE `".DB_PREFIX."pm_gallery_image` SET 
                                                               `imageframe` = '1',
                                                               `width` = '" .$width . "',
                                                               `height` = '"  . $height . "',
                                                               `filesize` = '" . $filesize . "' WHERE id='".$data['image_id']."'");

              }
                                                                                                     
  }
  private function deleteAll($folder,$info="",$last=""){
                    $iterator = new DirectoryIterator($folder);
                    foreach ($iterator as $fileInfo) {
                              if($fileInfo->isDot()){
                                        continue;
                              } else if($fileInfo->isFile()){
                                        @unlink($folder.$fileInfo->getBasename());
                              } else if($fileInfo->isDir()){
                                        $this->deleteAll($folder.$fileInfo->getBasename()."/");
                              }
                       }
   
                       if(file_exists($info)) @unlink($info);
                       if(file_exists($last)) @unlink($last);
             if(is_dir($folder)){
                       $cont = explode("/",$folder);
                       $cont = array_reverse($cont);
                       if($cont[1] !=''){
                         return @rmdir($folder);
                         }
                         else{
                         return true;
                       }
                }
  }          
  private function emptyAll($folder){
                    $iterator = new DirectoryIterator($folder);
                    foreach ($iterator as $fileInfo) {
                              if($fileInfo->isDot()){
                                        continue;
                              } else if($fileInfo->isFile()){
                                        if(!@unlink($folder.$fileInfo->getBasename()))return false;
                              } else if($fileInfo->isDir()){
                                        $this->deleteAll($folder.$fileInfo->getBasename()."/");
                              }
          }
                    return true;
  }
  public function managefolder($data,$setting){
         
             $pm_galleries = $setting['pm_galleries'];
             $pm_fr_galleries = $setting['pm_fr_galleries'];
             $pm_fr_width = $setting['pm_fr_width'];
             $pm_fr_height = $setting['pm_fr_height'];
             $pm_thumbs = $setting['pm_thumbs'];
             $pm_th_per_line = $setting['pm_th_per_line'];
             $pm_th_lines = $setting['pm_th_lines'];
             $pm_th_width = $setting['pm_th_width'];
             $pm_th_height = $setting['pm_th_height'];
             $pm_th_bord_size = $setting['pm_bord_size'];
             $pm_th_bord_hover_increase = $setting['pm_th_bord_hover_increase'];
             $pm_th_to_square = $setting['pm_th_to_square'];
             $pm_th_2sq_crop_vert = $setting['pm_th_2sq_crop_vert'];
             $pm_th_2sq_crop_hori = $setting['pm_th_2sq_crop_hori'];
             $pm_show_nav = $setting['pm_show_nav'];
             $pm_nav_always = $setting['pm_nav_always'];
                    // image frame variables
             
             $path = "../".$pm_galleries;
             $path2 = "../".$pm_fr_galleries; 
           /* Folder path */
           /* Frame folder path */
             if(isset($data['createfolder'])){
                              $folder = "../".$pm_galleries . $data['createfolder']."/";
              } elseif($data['rmdir']){
                              $folder = "../".$pm_galleries . $data['rmdir']."/";
              } elseif($data['empty']){
                              $folder = "../".$pm_galleries . $data['empty']."/";
              }
	  if(isset($data['createfolder'])){
                              
                              $new_folder_id = $this->maxFolder();
                            
                  if(!is_dir($folder)){
                                              $mask=umask(0);
                                              $real_permission = $this->getLogsPerms();
                                              @mkdir( $folder, octdec( $real_permission ) );
                                              umask($mask);          
                            if(!is_dir($folder. '/thumb')){
                                              $mask=umask(0);
                                              $real_permission = $this->getLogsPerms();
                                              @mkdir( $folder . '/thumb/', octdec( $real_permission ) );
                                              umask($mask);    
                            } 
                   }
                    
                  if(!is_dir($fr_folder)){
                                              $mask=umask(0);
                                              $real_permission = $this->getLogsPerms();
                                              @mkdir( $fr_folder, octdec( $real_permission ) );
                                              umask($mask);     
                                              
                  }
                    
                         $lastmodified = time(); 
                               if(isset($data['managefolder'])){
                                            $languages = array_keys($data['managefolder']);
                                        } else{                                         
                                          $languages = array(0=>1);
                              }
                          if(!isset($data['status'])){
                                                 $data['status'] = '0';
                          }
   
                       //   $mixthumb
                                $this->db->query("INSERT INTO " . DB_PREFIX ."pm_gallery_folder SET
                                         folder_id='" . $new_folder_id ."',
                                         module_id = '" . $data['module_id'] . "',
                                         name = '" . $this->db->escape($data['createfolder']) . "',
                                         size = '0',
                                         sort_order = '" . $data['sort_order'] . "',
                                         status = '" . $data['status'] ."'");
                                         
                               for($i=0;$i<count($languages);$i++){
                                         $this->db->query("INSERT INTO " . DB_PREFIX ."pm_gallery_folder_description SET
                                         folder_id='" . $new_folder_id ."',
                                         module_id = '" . $data['module_id'] . "',
                                         title = '" . $this->db->escape($data['managefolder'][$languages[$i]]['title']). "',
                                         description = '" . $this->db->escape($data['managefolder'][$languages[$i]]['description']). "',
                                         language_id = '" . $languages[$i] . "',
                                         date_modified=NOW()");
                              }
    }
	  if(isset($data['rmdir'])){      
                                              if(is_dir($folder)){
                                                               if(is_writable($folder)){   
                                                                     $this->deleteAll($folder);
                                                                     }
                                              }
                  
                    // image frame loop
                                        $query = $this->db->query("SELECT (folder_id) FROM ".DB_PREFIX."pm_gallery_folder WHERE name = '".$data['rmdir']."'");
                                        
                       $this->db->query("DELETE FROM ".DB_PREFIX."pm_gallery_folder WHERE name = '" . $data['rmdir']."'");
                                        
                                       if(isset($query->row["folder_id"])){ 
                                        $folder_id = $query->row["folder_id"];
                                        $this->db->query("DELETE FROM ".DB_PREFIX."pm_gallery_folder_description WHERE folder_id = '".$folder_id."'");
                                        $this->db->query("DELETE FROM ".DB_PREFIX."pm_gallery_image WHERE folder_id = '".$folder_id."'");
                                        }
                                        
    }
    if(isset($data['empty'])){
                                        $folder = "../".$pm_galleries.$data['empty']."/";
                                       // $file = "../".$pm_base . $data['empty']."_dir";
                                        $error = '';
                           if(is_dir($folder)){
                                        if(is_writable($folder)){   
                                       $this->emptyAll($folder);
                                       } 
                                       }
                    // image frame loop
                                       $q = $this->db->query("SELECT * FROM " . DB_PREFIX . "pm_gallery_folder WHERE name='".$data['empty']."'");
                                       $folder_id = $q->row['folder_id'];
                                       $this->db->query("DELETE FROM " . DB_PREFIX . "pm_gallery_image WHERE folder_id='".$folder_id."'");
                                       $this->db->query("UPDATE " . DB_PREFIX . "pm_gallery_folder SET size='',files='' WHERE folder_id='".$folder_id."'");
                          
    }
  }
  public function imageCrop($img){                          
                    $valid_exts = array('jpeg', 'jpg', 'png', 'gif');
                    $max_file_size = 200 * 1024; #200kb
                    $nw = $nh = 200; # image with & height
                    
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                      if ( isset($_FILES['image']) ) {
                        if (! $_FILES['image']['error'] && $_FILES['image']['size'] < $max_file_size) {
                          # get file extension
                          $ext = strtolower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
                          # file type validity
                          if (in_array($ext, $valid_exts)) {
                              $path = 'uploads/' . uniqid()  . '.' . $ext;
                              $size = getimagesize($_FILES['image']['tmp_name']);
                              # grab data form post request
                              $x = (int) $_POST['x'];
                              $y = (int) $_POST['y'];
                              $w = (int) $_POST['w'] ? $_POST['w'] : $size[0];
                              $h = (int) $_POST['h'] ? $_POST['h'] : $size[1];
                              # read image binary data
                              $data = file_get_contents($_FILES['image']['tmp_name']);
                              # create v image form binary data
                              $vImg = imagecreatefromstring($data);
                              $dstImg = imagecreatetruecolor($nw, $nh);
                              # copy image
                              imagecopyresampled($dstImg, $vImg, 0, 0, $x, $y, $nw, $nh, $w, $h);
                              # save image
                              imagejpeg($dstImg, $path);
                              # clean memory
                              imagedestroy($dstImg);
                              
                            } else {
                              echo 'unknown problem!';
                            } 
                        } else {
                          echo 'file is too small or large';
                        }
                      } else {
                        echo 'file not set';
                      }
                    } else {
                      echo 'bad request!';
                    }
  }
  // method getMixName
  // micThumb method
  protected function td_get_exif($image) {
                    $filename = $image['FILE']['FileName']; 
                    $exif = $image; 
                    if (is_array($exif) && isset($exif['EXIF'])) {
                    $data = array_merge($exif['IFD0'], $exif['EXIF']);
                    
                    $data2 = array_merge($exif['FILE'],$data);
                    foreach ($data as $key => $value) {
                              if (is_string($value)) {
                              // there are sometimes unicode characters that cause problems with serialize
                              $data2[$key] = preg_replace( '/[^[:print:]]/', '', $value);
                              }
                    }
                    return serialize($data2);
                    }
  }
  protected function maxFolder(){
                          $query = $this->db->query("SELECT MAX(folder_id) FROM ". DB_PREFIX ."pm_gallery_folder");
                          
                          return $query->row["MAX(folder_id)"]+1;
  }
  protected function maxImage(){
                          $query = $this->db->query("SELECT MAX(id) FROM ". DB_PREFIX ."pm_gallery_image");
                          
                          return $query->row["MAX(id)"];
  }
  protected function Replace($data){
                          $new = "";
                          for($i=10;$i<strlen($data);$i++){
                                            $new .=$data[$i];
                          }
                          return $new;
  }
  protected function getFileperms($dir){
	$dir_permission = substr( sprintf( '%o', fileperms( $dir ) ), -4 );
                       return $dir_permission;
  }
  private function getLogsPerms(){
	$path	 = DIR_SYSTEM . 'logs/';
	$dir_permission = substr( sprintf( '%o', fileperms( $path ) ), -4 );
                       return $dir_permission;
  }
  protected function changeArrayKeys($array){
                          $new = array();
                         $keys = array_keys($array);
                         for($i=0;$i<count($keys);$i++){
                                           $new[$i] = $array[$keys[$i]];
                      }
              
        return $new;
    }
}
