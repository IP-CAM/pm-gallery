<?php echo $header; ?><?php echo $column_left;?>
<div id="content">
  <div class="page-header">
      <div class="pull-right">
        <button type="submit" form="form-sort" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>


 <div class="panel panel-default">                  
    <div class="content">
             <?php echo $menu;?>       
             </div>

<div id="pm-gallery" style="float:right;" class="col-md-9">

      <div id="viewercomment"></div>
   <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
  
    <ul class="nav nav-tabs">
                           <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                           <li><a href="#tab-resize" data-toggle="tab"><?php echo $tab_resize; ?></a></li>
                           <li><a href="#tab-comments" data-toggle="tab"><?php echo $tab_comments; ?></a></li>
                           <li><a href="#tab-watermark" data-toggle="tab"><?php echo $tab_watermark; ?></a>
                           <?php if($ki_pic_frame == 1){?>
                           <li><a href="#tab-imageframe" data-toggle="tab"><?php echo $tab_imageframe; ?></a></li>
                           <?php } ?>
                           <li><a href="#tab-exifdata" data-toggle="tab"><?php echo $tab_exifdata; ?></a></li>
          </ul>
      <div class="tab-content">
         <div class="tab-pane active" id="tab-general">
          <div class="row">
           <div class="image-left col-md-6 col-md-6">
                  <div class="text-image-top">
                      <h4><b><?php echo $text_picture;?> <?php echo $image;?></b></h4>
                      <table class="image-info">
                                      <tboby>
                                                <tr><td class="text-image"><?php echo $text_filesize;?> <?php echo $image_info['filesize'];?> Kb</td></tr>
                                                <tr><td class="text-image"><?php echo $text_pic_width;?> <?php echo $image_info['width'];?> px</td></tr>
                                                <tr><td class="text-image"><?php echo $text_pic_height;?> <?php echo $image_info['height'];?> px</td></tr>
                                                <?php if($image_info['filesize_of_fr'] > 0){ ?>
                                                <tr><td style="padding:8px;font-style:italic;"><?php echo $text_image_of_frame;?></td>
                                                <tr><td class="text-image"><?php echo $text_filesize;?> <?php echo $image_info['filesize_of_fr'];?> Kb</td></tr>
                                                <tr><td class="text-image"><?php echo $text_pic_width;?> <?php echo $image_info['width_of_fr'];?> px</td></tr>
                                                <tr><td class="text-image"><?php echo $text_pic_height;?> <?php echo $image_info['height_of_fr'];?> px</td></tr>
                                                <tr><td style="padding:8px;font-style:italic;"><?php echo $text_total_size;?> <?php echo $image_info['filesize']+$image_info['filesize_of_fr'];?> Kb</td></tr>
                                                <?php } ?>
                                              <tr><td><?php echo $entry_folder;?>
                                              <?php /*echo "<pre>";print_r($folders);
                                              print_r($image_info); echo "</pre>"; */ ?>
                                              <select name="change_folder" class="col-lg-12 col-md-12 col-sm-12"><?php
                                              foreach($folders as $folder){
                                                      if(trim($folder['folder_id']) == trim($image_info['folder_id'])){?>
                                                      <option value="<?php echo $folder['folder_id'];?>" selected="selected"><?php echo $folder['name'];?></option>
                                                         <?php       } else{ ?>
                                                      <option value="<?php echo $folder['folder_id'];?>" ><?php echo $folders['name'];?></option>
                                             <?php     } 
                                                  }?>
                                                  </select>
                                    </td></tr>
                                     <tr><td><br><?php echo $entry_thumb_title;?><br/>
                                       <span class="help"><?php echo $text_title_help;?></span>
                                         <textarea class="thumb-title col-lg-12 col-md-12 col-sm-12" name="edit_title"/><?php echo $image_info['title'];?></textarea>
                                                      
                                    </td></tr>
                                       </tbody>
                      </table>   
                  </div>                                
            </div>
            <div class="image-right col-lg-6 col-md-6">
                              <img src="../<?php echo $ki_galleries.$image_info['folder'].'/'.$image_info['mixname'];?>" width="300"/>
            </div>
            <div class="admin-comment col-md-12 col-sm-12 col-lg-12 col-xs-12">
              <ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
                <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                <?php } ?>
              </ul> 
                     
               <input type="hidden" name="image_id" value="<?php echo $image_info['id'];?>"/>
               <input type="hidden" name="foldername" value="<?php echo $image_info['folder'];?>"/>
               <input type="hidden" name="imagename" value="<?php echo $image_info['mixname'];?>"/>
               
               <div class="comment-title"><?php echo $text_admin_comment;?></div>
              
               <?php foreach ($languages as $language) { 
                            if($comment){?>                                          
                                      <div id="language<?php echo $language['language_id']; ?>">
                                             <input type="hidden" name="edit_kigallery[<?php echo $language['language_id']; ?>][id]" value="<?php if(isset($comment[$language['language_id']])) { echo $comment[$language['language_id']]['id'];}?>"/>

                                              <textarea rows="8" name="edit_kigallery[<?php echo $language['language_id'];?>][comment]" class="col-lg-12"><?php if(isset($comment[$language['language_id']])){ echo $comment[$language['language_id']]['comment']; }?></textarea>
                                              <input type="checkbox" name="delete_comment[<?php echo $language['language_id'];?>][comment]" value="1"> <?php echo $text_delete_comment;?>
                                              </div>
                                <?php 
                                } else{ ?>
                                
                                <div id="language<?php echo $language['language_id']; ?>">
                                                  <div><?php echo $text_no_comment;?></div>
                                                  <span><?php echo $entry_add_admin_comment;?></span><br/>
                                                  <textarea rows="3" name="add_kigallery_comment[<?php echo $language['language_id'];?>][comment]" class="col-lg-12"></textarea>
                       
                                </div>
                         <?php }
              }?>
            </div>     
     
            </div>     
   </div>   
   <div class="tab-pane" id="tab-resize">   
                <div class="comment-title">     <?php echo $text_change_filesize;?></div>
                     <div class="change-field">
                               
                                         <div class="cleft"><?php echo $text_width;?> <br/>
                                        <input type="text" size="5" name="width" value="">
                                        </div>
                              
                              <div class="cleft"><?php echo $text_height;?><br/>
                              <input type="text" size="5" name="height" value="">
                              </div>
                 </div>
     </div>
     <div class="tab-pane" id="tab-comments">  
           <div class="comment-title"><?php echo $text_viewercomments;?></div>
            <?php 
             if(count($vcomments) > 0){
              for($i=0;$i<count($vcomments);$i++){ ?>
               <div class="vcomment">
                     <div class="text"><?php echo $vcomments[$i]['comment'] ?></div> 
                                           <a class="vcomm-edit" id="name=<?php echo $vcomments[$i]['name']; ?>&post=<?php echo $vcomments[$i]['comment'] ?>&id=<?php echo $vcomments[$i]['id'];?>"><?php echo $text_edit;?></a>
                    </div>
                    <div class="vcomment-headdata">&raquo; 
                       <span><?php echo $vcomments[$i]['date'];?> </span>
                      <span style="font-weight:bold;"><?php echo $vcomments[$i]['name']; ?></span>
                      <a class="vcomm-delete"  id="name=<?php echo $vcomments[$i]['name']; ?>&post=<?php echo $vcomments[$i]['comment'] ?>&id=<?php echo $vcomments[$i]['id'];?>"><?php echo $text_del;?></a><h2>
                    </div>
                </div>

            <?php    
               }
              } else{?> 
                <span><?php echo $text_no_comments;?></span>
             <?php } ?>
    </div>  
    <div class="tab-pane" id="tab-watermark">   
                   <div class="comment-title"><?php echo $text_add_watermark;?></div>
                     <div class="change-field">
                          <input type="hidden" name="watermark_hori" value="<?php echo $watermark_hori;?>"/>
                          <input type="hidden" name="watermark_vert" value="<?php echo $watermark_vert;?>"/>
                          <input type="hidden" name="watermark_size" value="<?php echo $watermark_size;?>"/>
                               <?php if($image_info['watermark'] == 1){?>
                                        <div  class="warning"><?php echo $text_found_watermark;?></div><br/><br/>
                                <?php } ?>
                                         <span><?php echo $entry_add_watermark;?> 
                                        <input type="checkbox"  name="addwatermark" value="1">
                                        </span>
                     </div>
     </div>
<?php if($ki_pic_frame == 1){?>
<div class="tab-pane" id="tab-imageframe">   
       <div class="comment-title"><?php echo $text_add_imageframe;?></div>
       <?php
                       if($image_info['imageframe'] == 1){ ?>  
                       <div  class="success"><?php echo $text_found_imageframe;?></div> 
                       <?php } ?>

      <div class="form-group">
                     <input type="hidden" name="imageframe_id" value="<?php echo $image_info['id'];?>"/>
                <label class="col-sm-2 control-label" for="frame_version"><?php echo $entry_add_imageframe; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($image_info['frame_model'] == 'draw_frame') { ?>
                     <input type="radio" name="frame_version" value="draw_frame" checked="checked" />
                    <?php echo $text_draw_frame; ?>
                    <?php } else { ?>
                     <input type="radio" name="frame_version" value="draw_frame" />
                    <?php echo $text_draw_frame; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if ($image_info['frame_model'] == 'clip_frame') { ?>
                     <input type="radio" name="frame_version" value="clip_frame" checked="checked" />
                    <?php echo $text_clip_frame; ?>
                    <?php } else { ?>
                     <input type="radio" name="frame_version" value="clip_frame" />
                    <?php echo $text_clip_frame; ?>
                    <?php } ?>
                  </label>
                </div>
      </div>
      <div class="form-group" style="margin-top:8px;">
                <label class="col-sm-12 control-label">
                 <h4><b> <?php echo $column_frame_models; ?></b></h4>
                </label>
      </div>
      <div class="form-group">
                <label class="col-sm-2 control-label" for="select-tfolder"><?php echo $entry_draw_frame;?></label>
                <div class="col-sm-10">

                  <div class="well well-sm" style="height: 200px; overflow: auto;">
           <?php  foreach($frames['draw'] as $frame0){ ?>
                    <div class="checkbox">
                      <label>
                       <input name="draw_frame" type="checkbox" value="<?php echo $frame0['filename'];?>">
                      <img style="margin-left:30px;height:30px;" src="<?php echo $frame0['path'];?>" alt="<?php echo $frame0['filename'];?>"/>
                      <?php echo $frame0['filename']; ?>
                      </label>
                    </div>   
                <?php                                    
             }  ?>
               
                    </div>   
                </div>
      </div>
      <div class="form-group">
                <label class="col-sm-2 control-label" for="select-tfolder"><?php echo $entry_clip_frame;?></label>
                <div class="col-sm-10">

                  <div class="well well-sm" style="height: 160px; overflow: auto;">
           <?php  foreach($frames['clip'] as $frame1){ ?>
                    <div class="checkbox">
                      <label>
                       <input name="clip_frame" type="checkbox" value="<?php echo $frame1['filename'];?>">
                      <img style="margin-left:30px;height:30px;" src="<?php echo $frame1['path'];?>" alt="<?php echo $frame1['filename'];?>"/>
                      <?php echo $frame1['filename']; ?>
                      </label>
                    </div>   
                <?php                                    
             }  ?>
               
               </div>   
           </div>
      </div>
  </div>
                <?php                                    
             }  ?>
              
     <div class="tab-pane" id="tab-exifdata">     
       <div class="comment-title"><?php echo $text_exif_data;?></div>
          <table class="exif-data">
          <?php $exif_data = $image_info['exif_data']; ?>
                      <?php if(isset($exif_data['FileName'])){ ?>   
                    <tr><td><?php echo $text_exif_filename;?> </td><td> <?php echo  $exif_data['FileName'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['DateTimeOriginal'])){ ?>
                    <tr><td><?php echo $text_exif_datetimeoriginal;?> </td><td><?php echo  $exif_data['DateTimeOriginal'];?></td></tr>
                        <?php } ?>   
                       <?php if(isset($exif_data['FileDateTime'])){ ?>
                     <tr><td><?php echo $text_exif_filedatetime;?></td><td><?php echo  date('d-m-Y',$exif_data['FileDateTime']);?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['FileDateSize'])){ ?>
                    <tr><td><?php echo text_exif_filesize;?> </td><td><?php echo  $exif_data['FileSize'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['FileType'])){ ?>
                     <tr><td><?php echo $text_exif_filetype;?></td><td> <?php echo  $exif_data['FileType'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['MimeType'])){ ?>
                   <tr><td><?php echo $text_exif_mimetype;?> </td><td> <?php echo  $exif_data['MimeType'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['Make'])){ ?>
                     <tr><td><?php echo $text_exif_make;?> </td><td><?php echo  $exif_data['Make'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['Model'])){ ?>
                    <tr><td><?php echo $text_exif_model;?></td><td> <?php echo  $exif_data['Model'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['MakerNote'])){ ?>
                     <tr><td><?php echo $text_exif_makernote;?></td><td> <?php echo  $exif_data['MakerNote'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['Orientation'])){ ?>
                     <tr><td><?php echo $text_exif_orientation;?></td><td><?php echo  $exif_data['Orientation'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['Artist'])){ ?>
                     <tr><td><?php echo $text_exif_artist;?></td><td><?php echo  $exif_data['Artist'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['ISOSpeedRatings'])){ ?>
                     <tr><td><?php echo $text_exif_isospeedratings;?></td><td><?php echo  $exif_data['ISOSpeedRatings'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['XResolution'])){ ?>
                      <tr><td><?php echo $text_exif_xresolution;?></td><td> <?php echo  $exif_data['XResolution'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['YResolution'])){ ?>
                     <tr><td><?php echo $text_exif_yresolution;?> </td><td><?php echo  $exif_data['YResolution'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['ResolutionUnit'])){ ?>
                       <tr><td><?php echo $text_exif_resolutionunit;?></td><td> <?php echo  $exif_data['ResolutionUnit'];?> </td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['Software'])){ ?>
                       <tr><td><?php echo $text_exif_software;?> </td><td><?php echo  $exif_data['Software'];?> </td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['FlashPixVersion'])){ ?>
                       <tr><td><?php echo $text_exif_flashpixversion;?></td><td> <?php echo  $exif_data['FlashPixVersion'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['ExposureMode'])){ ?>
                      <tr><td><?php echo $text_exif_exposuremode;?> </td><td><?php echo  $exif_data['ExposureMode'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['WhiteBalance'])){ ?>
                       <tr><td><?php echo $text_exif_whitebalance;?></td><td> <?php echo  $exif_data['WhiteBalance'];?></td></tr>
                      <?php } ?>
                       <?php if(isset($exif_data['DigitalZoomRatio'])){ ?>
                      <tr><td><?php echo $text_exif_digitalzoomratio;?></td><td> <?php echo  $exif_data['DigitalZoomRatio'];?></td></tr>
                  
                      <?php } ?>   
                      </table>
                      </div>
           </div>   
       </div>
      </form>
    </div>
  </div>
</div>
</div>


<script type="text/javascript">
/*
$(".vcomm-edit").click(function(e){
          
                    var comment_id =getParam($(this).attr("id"),'id');
                    var comment =getParam($(this).attr("id"),'post');
                    var name =getParam($(this).attr("id"),'name');
                    
var sbox = '<form action="<?php echo $edit_vcomm;?>" method="post" id="editform">\r\n';
sbox += '<div id="edit-viewercomment">\r\n';
sbox += '<div class="cf-title"><?php echo $text_edit_comment;?></div>\r\n'; 
sbox += '<input type="hidden" name="edit_vcomment[id]" value="' + comment_id + '"/>\r\n';
sbox += '<div class="field-row"><?php echo $entry_writer;?> <input type="text" name="edit_vcomment[name]" value="' + name + '" size="15"/></div>\r\n'; 
sbox += '<span class="comment"><?php echo $entry_post;?></span><br/>';
sbox += '<textarea name="edit_vcomment[comment]">' + comment + '</textarea>';

sbox += '<div style="margin-top:16px;margin-left:300px;" ><a class="kg-button" onclick="$(\'#editform\').submit();" ><?php echo $button_save;?></a>\r\n'; 
sbox += '<a class="kg-button" href="<?php echo $edit_vcomm;?>"><?php echo $button_cancel;?></a></div>\r\n'; 
sbox += '</div>\r\n';
sbox += '</form>\r\n';
$('#viewercomment') .html(sbox);  
});


$(".vcomm-delete").click(function(e){
          
                    var comment_id =getParam($(this).attr("id"),'id');
                    var name =getParam($(this).attr("id"),'name');
                    var comment =getParam($(this).attr("id"),'post');
                    
var sbox = '<form action="<?php echo $edit_vcomm;?>" method="post" id="deleteform">\r\n';sbox = '<div id="edit-viewercomment">';
sbox += '<div class="cf-title"><?php echo $text_delete_comment;?></div>\r\n'; 
sbox += '<input type="hidden" name="delete_vcomment[id]" value="' + comment_id + '"/>';
sbox += '<h4><?php echo $text_about_delete_comment;?></h4>';
sbox += ' <div><?php echo $entry_writer;?> '+name+'</div>';
sbox += ' <div><?php echo $entry_post;?> '+comment+'</div>';
sbox += '<div style="margin-top:16px;margin-left:300px;" ><a class="kg-button" onclick="$(\'#deleteform\').submit();" ><?php echo $button_save;?></a>\r\n'; 
sbox += '<a class="kg-button" href="<?php echo $edit_vcomm;?>"><?php echo $button_cancel;?></a></div>\r\n'; 
sbox += '</div>\r\n';
sbox += '</form>\r\n';
$('#viewercomment') .html(sbox);  
});
*/
</script>
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script>
</body>
</html>
