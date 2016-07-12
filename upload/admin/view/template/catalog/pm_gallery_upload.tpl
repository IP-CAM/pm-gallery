<?php echo $header; ?><?php echo $column_left;?>
<div id="content">
  <div class="page-header">
      <div class="pull-right">
        <button type="submit" form="form-upload" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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

     <div id="pm-gallery" class="col-md-9 col-xs-12">   
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-upload">
           
       <input type="hidden" name="module_id" value="<?php echo $module_id;?>"/>
       <input type="hidden" name="galleries" value="<?php echo $pm_galleries;?>"/>
       <input type="hidden" name="basedir" value="<?php echo $pm_basedir;?>"/>
       <input type="hidden" name="watermark_hori" value="<?php echo $watermark_hori;?>"/>
       <input type="hidden" name="watermark_vert" value="<?php echo $watermark_vert;?>"/>
       <input type="hidden" name="watermark_size" value="<?php echo $watermark_size;?>"/>
       <input type="hidden" name="pm_pic_frame" value="<?php echo $pm_pic_frame;?>"/>
       <input type="hidden" name="pm_fr_galleries" value="<?php echo $fr_galleries;?>"/>
   
          <h3><?php echo $entry_upload;?></h3><br/>

<div id="imagePreview"></div>
 <div id="add-image">
<input id="uploadFile" type="file" name="image" class="img" />
      <div class="panel-body">
      <ul class="nav nav-tabs" id="language">
        <?php foreach ($languages as $language) { ?>
                <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
         <?php } ?>
      </ul>
              <div class="tab-content">
     <?php foreach ($languages as $language) { ?>
        <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-comment<?php echo $language['language_id']; ?>"><?php echo $entry_add_comment; ?></label>
                  <div class="col-sm-10">
                     <textarea cols="57" rows="2" name="add_pm_gallery_comment[<?php echo $language['language_id'];?>][comment]" placeholder="<?php echo $entry_add_comment; ?>" id="input-comment<?php echo $language['language_id']; ?>" class="form-control"><?php if(isset($comment[$language['language_id']])){ echo $comment[$language['language_id']]['comment']; }?></textarea>
                  </div>
              </div>
        </div> <!-- End tab -->
     <?php } ?>
              <div class="form-group">
                <label title="<?php echo $text_title_help;?>" class="col-sm-2 control-label" for="input-thumb-title<?php echo $language['language_id']; ?>"><?php echo $entry_thumb_title; ?></label>
                  <div class="col-sm-10">
                     <textarea cols="57" rows="2" name="title" placeholder="<?php echo $entry_thumb_title; ?>" id="input-thumb-title" class="form-control"><?php echo $title;?></textarea>
                  </div>
              </div>

              </div>
       
      <div class="form-group required">
                <label class="col-sm-2 control-label" for="select-tfolder"><?php echo $entry_folder; ?></label>
                <div class="col-sm-10">
                <select name="folder" for="select-folder" class="form-control">
                <option value=""><?php echo $text_select;?></option>
                <?php
                foreach($folders as $folder){?>
                 <option value="<?php echo $folder['folder_id'];?>"><?php echo $folder['folder'];?></option>
                <?php } ?>
                </select>
           </div>
      </div>
      <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                </div>
      </div>
 <?php if($pm_pic_frame == 1){?>
      <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_imageframe; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 80px;">
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="addimageframe" value="0" />
                        <?php echo $entry_add_imageframe; ?>
                      </label>
                    </div>
                  </div>
               </div>
       </div>
  <?php } ?>
        <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_maximum_image_size; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 60px;">
                    <div class="checkbox">
                      <label>
                        <input type="text" name="maxy" id="maxx" value="" placeholder="width" /> <input type="text" name="maxy" id="maxy" value="" placeholder="height"/>
                      </label>
                    </div>
                  </div>
               </div>
      </div>
      <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_watermark; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 60px;">
                    <div class="checkbox">
                      <label>
                        <input type="file" name="watermark" />
                      </label>
                      <label>
                        <input type="checkbox" name="addwatermark" value="1" /> <?php echo $entry_add_watermark; ?>
                      </label>
                    </div>
                  </div>
                </div>
        </div>
        <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_rotate; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 50px;">
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="rotate" value="1" />
                      </label>
                    </div>
                  </div>
                </div>
        </div>
        </div>
  </div>
     </form>
<img id="image-upload" src="" alt=""/>
    </div>
    </div>
    </div>
<script type="text/javascript">
$(function() {
    $("#uploadFile").on("change", function()
    {
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
        if (/^image/.test( files[0].type)){ // only image file
            var reader = new FileReader(); // instance of the FileReader
            reader.readAsDataURL(files[0]); // read the local file
            reader.onloadend = function(){ // set image data as background of div           
                $("#imagePreview").css({'background-image': 'url(' + this.result + ')','width': '300px','height': '200px','display': 'inline-block','background-position': 'center center','background-size': 'cover','-webkit-box-shadow':' 0 0 1px 1px rgba(0, 0, 0, .3)'});
              }
            }
    });
});
</script>   
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script> 
<?php echo $footer;?>