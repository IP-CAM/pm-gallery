<?php echo $header; ?><?php echo $column_left;?>
<div id="content">
  <div class="page-header">
      <div class="form-group required">
      <div class="pull-right">
     <?php if($module_info && $type == 2){?>
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_continue; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
    <?php } ?>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div

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
    <div class="panel panel-default">
      <div class="module-body">
      <?php  echo $menu;  ?>
       </div>
               
       <div id="pm-gallery" style="<?php echo $style;?>" class="<?php echo $col;?>">
        <form action="<?php echo $action;?>" method="get" id="form-sort">
        <input type="hidden" name="route" value="<?php echo $route;?>"/>
     <?php if($module_info && $type == 2){?>
      <div class="form-group required">
                <label class="col-sm-2 control-label" for="select-tfolder"><?php echo $entry_module; ?></label>
                <div class="col-sm-9">
                <select name="module_id" class="form-control">
                <option><?php echo $text_select;?></option>
                <?php foreach($module_info as $module){?>
                <option value="<?php echo $module['module_id'];?>"><?php echo $module['name'];?></option>
                <?php } ?>
                </select>
           </div>
    <?php } ?>
    <input type="hidden" name="token" value="<?php echo $token;?>"/>
    </form>
    </div>

    </div>
</div>
<?php echo $footer; ?>