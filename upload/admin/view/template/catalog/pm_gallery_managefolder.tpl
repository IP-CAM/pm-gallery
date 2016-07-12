<?php echo $header; ?><?php echo $column_left;?>
<div id="content">
  <div class="page-header">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
   </div>
  
    <div id="gallery" class="content">
    <?php echo $menu;?>

<div id="pm-gallery" class="col-md-9 col-lg-9 col-xs-12">
       <div id="newfolder"></div>
       
<?php if(!$images){ ?>
       
    <table id="folders" cellspacing="4" class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
    <tr><td colspan="2"><a class="mkdir" href="<?php echo $action;?>" style="margin-left:340px;"><?php echo $button_create_folder;?></a></td></tr>
    
    
    <?php   if($folder_info){ 
    $id = 0;
    foreach($folder_info as $info) {
       $key = array_keys($info);
        $folder = $key[0]; ?>
          <tr>  <td class="folder" colspan="2">
             <div class="folder-button" id="folder-<?php echo $folder;?>"><?php echo $folder ?></div>
             <div id="folder-<?php echo $module_id;?>-<?php echo $folder;?>" style="visbility:hidden;">

                   <a href="<?php echo $action;?>&empty=<?php echo $folder; ?>" data-toggle="tooltip" title="<?php echo $button_empty_folder; ?>" class="btn btn-primary"><i class="fa fa-star-half-empty"></i></a>
                   <a href="<?php echo $action;?>&rmdir=<?php echo $folder; ?>" data-toggle="tooltip" title="<?php echo $button_delete_folder; ?>" class="btn btn-primary"><i class="fa fa-remove"></i></a>
                   <a href="<?php echo $action;?>&images=<?php echo $folder; ?>" data-toggle="tooltip" title="<?php echo $button_images; ?>" class="btn btn-primary"><i class="fa fa-file-photo-o"></i></a>


           <table style="width:98%;">
                   <tr><td class="subject"><?php echo $text_image_files;?></td><td class="disk"> <?php echo $info[$folder]['files']; ?></td></tr>
                   <tr><td><?php echo $text_disk_usage;?></td><td class="disk"> <?php echo $info[$folder]['size']; ?> Mb</td></tr>
                <tr> <td><?php echo $text_disk_usage_of_fr;?></td>  <td class="disk"> <?php echo $info[$folder]['size_of_fr']; ?> Mb</td></tr>
                      <tr> <td><?php echo $text_total_disk_usage;?></td>  <td class="disk"> <?php echo $info[$folder]['size']+$info[$folder]['size_of_fr']; ?> Mb
                      
                   <a class="kg-button" href="<?php echo $action;?>&disk_usage=<?php echo $folder; ?>">Update Disk Usage</a><?php  echo $button_update_disk_usage; ?></td></tr>
                  </table>
     </div>
<script type="text/javascript">
$('#folder-<?php echo $folder;?>').ready(function(){
    $("#folder-<?php echo $module_id;?>-<?php echo $folder;?>").hide();
    $('#folder-<?php echo $folder;?>').attr('title','Display');
      $('#folder-<?php echo $folder;?>').click(function(){
      var beforeShow = $('#folder-<?php echo $module_id;?>-<?php echo $folder;?>:visible').length;
       var goHide = beforeShow;
         $("#folder-<?php echo $module_id;?>-<?php echo $folder;?>").slideToggle("slow");
      //  $('#folder-<?php echo $folder;?>').attr('title','Hidden');
  if (goHide) {
    $('#folder-<?php echo $folder;?>').prop('title', 'Display');
  } else {
    $('#folder-<?php echo $folder;?>').prop('title', 'Hidden');
  }
     });
});
</script>
     </td></tr>
                  <?php  $id++;  }
                  } ?>
    </table>
       
<?php } 
else { ?>
  <form action="<?php echo $action;?>" method="post" id="folder-form">
   <input type="hidden" name="folder_name" value="<?php echo  $folder;?>">
  
  <?php if($warning){ ?>
    <div class="warning" style="width:820px;margin-left:250px;"><?php echo $warning; ?></div>
    
          <?php if($error_list){ ?>
                       <div class="buttons"><a onclick="$('#folder-form').submit();" class="button"><?php echo $button_save_list; ?></a></div>
            <?php } ?>
          <?php if($error_modify){ ?>
                       <div class="buttons"><a onclick="$('#folder-form').submit();" class="button"><?php echo $button_update_last_modified; ?></a></div>
            <?php } ?>
  
          <?php if($error_sizes){ ?>
                      <input type="hidden" name="file_sizes" value="<?php echo $file_sizes;?>"/>
                       <div class="buttons"><a onclick="$('#folder-form').submit();" class="button"><?php echo $button_update_folder_size; ?></a></div>
            <?php } ?>
 <?php } ?>
    <table id="folders">
    <tr><td>&nbsp;</td><td><?php echo $text_photoalbum;?></td><td>Mixname</td><td>Filesize</tr>
    <?php  
                for($i=0;$i<count($dir_images);$i++){ ?>
                         <tr><td class="img-left"><?php
                         if(file_exists('../'.$ki_galleries.$folder.'/thumbs/'.$dir_images[$i]['mixthumb'].$dir_images[$i]['mixname'])){ ?>
                         <img  style="width:80px;" src="../<?php echo $ki_galleries.$folder;?>/thumbs/<?php echo $dir_images[$i]['mixthumb'].$dir_images[$i]['mixname'];?>">
                         <?php }
                         else{ ?>
                         <img src="../<?php echo $ki_galleries.$folder;?>/<?php echo $dir_images[$i]['mixname'];?>" style="width:80px;">
                         <?php } ?>
                         </td>
                         <td class="img-left"><?php if(isset($db_image[$i]['filename'])) {echo $db_image[$i]['filename'];} else{ echo $dir_images[$i]['filename'];}?></td>
                         <td class="img-dir"><?php if(isset($db_image[$i]['mixname'])) {echo $db_image[$i]['mixname'];} else{ echo $dir_images[$i]['mixname'];}?></td>
                           <td class="img-dir"><?php if(isset($db_image[$i]['mixname'])) {echo $db_image[$i]['mixname'];} else{ echo $dir_images[$i]['filesize'];}?> bytes</td>
                    </tr>   
                               
            <?php } ?>
    </table>
<?php } ?>
      </table>   
      </div> 
    </div>
  </div>
</div>
<script type="text/javascript">
$(".mkdir").click(function(e){
e.preventDefault();
var sbox = '<div id="create-folder">';
sbox += '<div class="cf-title"><?php echo $text_create_folder;?></div>'; 
sbox += '<form action="<?php echo $action;?>" method="post" id="mkdir">';
sbox += '       <input type="hidden" name="module_id" value="<?php echo $module_id;?>"/>';
sbox += '              <div class="form-group required">';
sbox += '                <label class="col-sm-3 control-label" for="input-createfolder"><?php echo $entry_directory; ?></label>';
sbox += '                <div class="col-sm-9">';
sbox += '                  <input type="text" name="createfolder" value="" placeholder="<?php echo $entry_directory; ?>" id="input-createfolder" class="form-control" />';
sbox += '                </div>';
sbox += '              </div>';
sbox += '              <div class="form-group">';
sbox += '                <label class="col-sm-3 control-label" for="input-sort_order"><?php echo $entry_sort_order; ?></label>';
sbox += '                <div class="col-sm-9">';
sbox += '                  <input type="text" name="sort_order" value="" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort_order" class="form-control" />';
sbox += '                </div>';
sbox += '              </div>';

sbox += '              <div class="form-group" style="margin-top:8px;">';
sbox += '                <label class="col-sm-3 control-label"><?php echo $entry_status; ?></label>';
sbox += '                <div class="col-sm-9>';
sbox += '                  <label class="radio-inline">';
sbox += '                    <input type="radio" name="status" value="1" />';
sbox += '                    <?php echo $text_enabled; ?>';
sbox += '                  </label>';
sbox += '                  <label class="radio-inline">';
sbox += '                    <input type="radio" name="status" value="0" />';
sbox += '                    <?php echo $text_disabled; ?>';
sbox += '                  </label>';
sbox += '                </div>';
sbox += '              </div>';
sbox += '<ul id="languages" class="nav nav-tabs" style="margin-top:16px;">';
<?php foreach ($languages as $language){ ?>
sbox += '<li><a href="#language<?php echo $language['language_id'];?>" data-toggle="tab">';
sbox += '<img src="view/image/flags/<?php echo $language["image"]; ?>" title="<?php echo $language["name"]; ?>" /><?php echo $language["name"]; ?></a></li>';
<?php } ?>
sbox += '</ul>';
<?php foreach ($languages as $language) { ?>
sbox += '<div id="language<?php echo $language['language_id']; ?>" class="tab-pane">';
sbox += '<div class="form-group required">';
sbox += '<label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $entry_album_name; ?></label>';
sbox += '             <div class="col-sm-10">';
sbox += '                      <input type="text" name="managefolder[<?php echo $language['language_id'];?>][title]" value="" placeholder="<?php echo $entry_album_name; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />';
sbox += '                    </div>';
sbox += '              </div>';
sbox += '         <div class="form-group">';
sbox += '            <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_album_description; ?></label>';
sbox += '              <div class="col-sm-10">';
sbox += '                   <textarea name="managefolder[<?php echo $language['language_id'];?>][description]" placeholder="<?php echo $entry_album_description; ?>" id="" class="form-control"></textarea>';
sbox += '              </div>';
sbox += '          </div>';        
sbox += '</div>';
<?php } ?>      
sbox += '      <div class="pull-right">';
sbox += '         <button type="submit" form="mkdir" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>';
sbox += '         <a href="<?php echo $action; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>';
sbox += '       </div>';
sbox += '<scr'+'ipt type="text/javascript">';
sbox += '$("#language a:first").tab(\'show\');';
sbox += '</scr'+'ipt>'; 
sbox += '</form>';
sbox += '</div>';
$('#newfolder') .html(sbox);  
});</script>
<div></div>