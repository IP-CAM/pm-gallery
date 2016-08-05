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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
   </div>
  <div id="success"></div>
 
 <div class="panel panel-default">
                     
    <div class="content">
             <?php echo $menu;?>       

             </div>
                       
<div id="pm-gallery" style="float:right;" class="col-md-9">
        
        <form action="<?php echo $action;?>" method="post" id="form-sort">

      <div class="form-group required">
                <label class="col-sm-2 control-label" for="select-tfolder"><?php echo $entry_folder; ?></label>
                <div class="col-sm-9">
                <select name="folder" class="form-control">
                <option><?php echo $text_select;?></option>
                <?php
                foreach($folders as $folder){?>
                 <option value="<?php echo $folder['folder_id'];?>"><?php echo $folder['folder'];?></option>
                <?php } ?>
                </select>
           </div>
           <div class="text-left col-lg-1">
                <button type="button" id="button-continue" data-toggle="tooltip" title="<?php echo $button_continue; ?>" class="btn btn-primary"><i class="fa fa-arrow-circle-o-up" style="font-size:17px;padding:0px"></i></button>
                </div>
      </div>
        <table class="col-md-12">
       <thead style="font-weight:bold;background:black;color:#ffffff;"> <tr><td class="text-left" style="width:12%;padding-left:6px;">Folder name</td><td style="width:30%">Original filename</td><td style="width:30%">Mixed filename</td><td style="width:12%">Sort Order</td><td style="width:16%"></td></tr>
       </thead>
      <?php if($images){
      $i = 0;
           foreach($images as $image){     
                 ?>
                 <tr>      
                    <td class="text-left"style="color:#000000;"><?php echo $image['name'];?></td>
                 <td class="text-left style="color:#ffffff"><?php echo $image['filename'];?></td>        
            <td class="text-left"><?php echo $image['mixname'];?></td>
            <input type="hidden" name="image_change[<?php echo $i;?>][image_id]" value="<?php echo $image['id'];?>"/>
               <td class="text-left"><input name="image_change[<?php echo $i;?>][sort_order]" value="<?php echo $image['sort_order'];?>" size="3"/></td>

                  <td class="text-right">
<a onClick="viewImage('<?php echo $image['name'];?>/<?php echo $image['filename'];?>');" title="<?php echo $image['name'];?>/<?php echo $image['filename'];?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a>
                  <a href="<?php echo $image_path;?>&image=<?php echo $image['name'];?>/<?php echo $image['filename'];?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></tr>
   <?php $i++;
   }
} ?>
</table>
</form>
 
  <div class="pagination"><?php echo $pagination; ?></div>
        </div>
        
  </div>
</div>
<script type="text/javascript">
$("#button-continue").on('click', function(){
  var url = 'index.php?route=catalog/pm_gallery/edit&module_id=<?php echo $module_id;?>&token=<?php echo $token; ?>';
  var folder_id =  $('select[name=\'folder\']').val();

   if(folder_id){
          url += '&folder=' + encodeURIComponent(folder_id);
   }
  location = url;
});
function viewImage(img){
   var url = '../<?php echo $ki_galleries;?>' + img;
   html = '<div style="position:absolute;width:250px;top:300px;right:250px;background:#ffffff;padding:6px;z-index:100">';
   html += '<img src="' + url + '" alt="image" style="width:100%;"/>';
   html += '</div>';
   $("#success").html(html);
}
</script>
