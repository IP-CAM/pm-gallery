<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-kigallery" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>

  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-kigallery" class="form-horizontal">
        <input type="hidden" name="module_id" value="<?php echo $module_id;?>"/>
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-thumb" data-toggle="tab">Thumb images</a></li>
            <li><a href="#tab-full" data-toggle="tab">Full images</a></li>
            <li><a href="#tab-texts" data-toggle="tab">Texts</a></li>
          </ul>

  <div class="tab-content">
  <div class="tab-pane active" id="tab-general">
      <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-5">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
     </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-5">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-5"></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin-mail"><?php echo $entry_admin_mail; ?></label>
            <div class="col-sm-5">
              <select name="pm_admin_mail" id="input-admin-mail" class="form-control">
         <?php   if($pm_admin_mail == 1){ ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-5"></div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin-mail-from"><?php echo $entry_admin_mail_from; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_admin_mail_from" value="<?php echo $pm_admin_mail_from; ?>" placeholder="<?php echo $entry_admin_mail_from; ?>" id="input-admin-mail-from" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin-mail-to"><?php echo $entry_admin_mail_to; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_admin_mail_to" value="<?php echo $pm_admin_mail_to; ?>" placeholder="<?php echo $entry_admin_mail_to; ?>" id="input-admin-mail-to" class="form-control" />
            </div>
             <div class="col-sm-5"></div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-template"><?php echo $entry_template; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_template" value="<?php echo $pm_template; ?>" placeholder="<?php echo $entry_template; ?>" id="input-template" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-folders"><?php echo $entry_pm_folders; ?></label>
            <div class="col-sm-5">
              <select name="pm_folders" id="input-folders" class="form-control">
                <?php if ($pm_folders == 1) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-5"><?php echo $entry_pm_folders_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-breadcrumbs"><?php echo $entry_pm_breadcrumbs; ?></label>
            <div class="col-sm-5">
              <select name="pm_breadcrumbs" id="input-breadcrumbs" class="form-control">
                <?php if ($pm_breadcrumbs == 1) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-5"><?php echo $entry_pm_breadcrumbs_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-galleries"><?php echo $entry_galleriesdir; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_galleries" value="<?php echo $pm_galleries; ?>" placeholder="<?php echo $entry_galleriesdir; ?>" id="input-galleries" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
          </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-keyword"><?php echo $entry_pm_keyword; ?></label>
            <div class="col-sm-5">
              <select name="pm_keyword" id="input-keyword" class="form-control">
                <?php if ($pm_keyword == 1) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-5"><?php echo $entry_pm_keyword_help; ?></div>
    </div>

    <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_image_order; ?></label>
                <div class="col-sm-5">
                  <label class="radio-inline">
               <?php  if($pm_img_order == 'manual'){ ?>
              <input name="pm_img_order" type="radio" value="manual"  checked="checked"/>
              <?php echo $text_manual;
                     } else { ?>
              <input name="pm_img_order" type="radio" value="manual"/>
              <?php echo $text_manual;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_img_order == 'size'){ ?>
              <input name="pm_img_order" type="radio" value="size"  checked="checked"/>
              <?php echo $text_size; 
                     } else { ?>
              <input name="pm_img_order" type="radio" value="size"/>
              <?php echo $text_size;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
               <?php  if($pm_img_order == 'new'){ ?>
              <input name="pm_img_order" type="radio" value="new"  checked="checked"/>
              <?php echo $text_new;
                     } else { ?>
              <input name="pm_img_order" type="radio" value="new"/>
              <?php echo $text_news;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_img_order == 'old'){ ?>
              <input name="pm_img_order" type="radio" value="old"  checked="checked"/>
              <?php echo $text_olds;?> 
                    <?php } else { ?>
              <input name="pm_img_order" type="radio" value="old"/>
              <?php echo $text_olds;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_img_order == 'name'){ ?>
              <input name="pm_img_order" type="radio" value="name"  checked="checked"/>
              <?php echo $text_name;?> 
                    <?php } else { ?>
              <input name="pm_img_order" type="radio" value="name"/>
              <?php echo $text_name;?> 
                    <?php } ?>
                  </label>
            </div>
            <div class="col-sm-5"> <?php echo $entry_order_help; ?> </div>
   </div>
        
   <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin-limit"><?php echo $entry_admin_limit; ?></label>
            <div class="col-sm-5">
              <input size="5" name="pm_admin_limit" type="text" value="<?php echo $pm_admin_limit;?>" id="input-admin-limit" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
    </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_warnings; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
       <?php   if($pm_show_warnings == 1){ ?>
              <input name="pm_show_warnings" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_show_warnings" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
       <?php   if($pm_show_warnings == 0){ ?>
               <input name="pm_show_warnings" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_warnings" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
                </div>   
                <div class="col-sm-5"><?php echo $entry_show_warnings_help; ?></div>
     </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-fr_color"><?php echo $entry_fr_color; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_fr_color" value="<?php echo $pm_fr_color; ?>" placeholder="<?php echo $entry_fr_color; ?>" id="input-fr_color" class="form-control" />
            </div>
            <div class="col-sm-5">
            <?php echo $entry_fr_color_help; ?>
            </div>
   </div>
</div>
<div class="tab-pane" id="tab-thumb">
    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-thumbs"><?php echo $entry_thumbs; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_thumbs" value="<?php echo $pm_thumbs; ?>" placeholder="<?php echo $entry_thumbs; ?>" id="input-thumbs" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_thumbs_help; ?></div>
     </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_per_line"><?php echo $entry_th_per_line; ?></label>
            <div class="col-sm-5">
              <select name="pm_th_per_line" id="input-th_per_line" class="form-control">
                <?php if ($pm_th_per_line == 12) { ?>
                <option value="12" selected="selected">1</option>
                <option value="6">2</option>
                <option value="4">3</option>
                <option value="3">4</option>
                <option value="2">6</option>
                <?php }?>
                <?php if ($pm_th_per_line == 6) { ?>
                <option value="12">1</option>
                <option value="6" selected="selected">2</option>
                <option value="4">3</option>
                <option value="3">4</option>
                <option value="2">6</option>
                <?php }?>
                <?php if ($pm_th_per_line == 4) { ?>
                <option value="12">1</option>
                <option value="6">2</option>
                <option value="4" selected="selected">3</option>
                <option value="3">4</option>
                <option value="2">6</option>
                <?php }?>
                <?php if ($pm_th_per_line == 3) { ?>
                <option value="12">1</option>
                <option value="6"2</option>
                <option value="4">3</option>
                <option value="3" selected="selected">4</option>
                <option value="2">6</option>
                <?php }?>
                <?php if ($pm_th_per_line == 2) { ?>
                <option value="12">1</option>
                <option value="6">2</option>
                <option value="4">3</option>
                <option value="3">4</option>
                <option value="2" selected="selected">6</option>
                <?php }?>
              </select>
            </div>
            <div class="col-sm-5"><?php echo $entry_th_per_line_help; ?></div>
    </div>
    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_lines"><?php echo $entry_th_lines; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_lines" value="<?php echo $pm_th_lines; ?>" placeholder="<?php echo $entry_th_lines; ?>" id="input-th_lines" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_th_lines_help; ?></div>
   </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_width"><?php echo $entry_th_width; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_width" value="<?php echo $pm_th_width; ?>" placeholder="<?php echo $entry_th_width; ?>" id="input-th_width" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_th_width_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th-height"><?php echo $entry_th_height; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_height" value="<?php echo $pm_th_height; ?>" placeholder="<?php echo $entry_th_height; ?>" id="input-th-height" class="form-control" />
            </div>
            <div class="col-sm-5"> <?php /* echo $entry_th_height_help; */ ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th__perc_width"><?php echo $entry_th_perc_width; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_perc_width" value="<?php echo $pm_th_perc_width; ?>" placeholder="<?php echo $entry_th_perc_width; ?>" id="input-th_width" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_th_perc_width_help; ?></div>
    </div>

     <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th-bord-size"><?php echo $entry_th_bord_size; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_bord_size" value="<?php echo $pm_th_bord_size; ?>" placeholder="<?php echo $entry_th_bord_size; ?>" id="input-th-bord-size" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_th_bord_size_help; ?> </div>
   </div>

   <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_margin_left"><?php echo $entry_th_margin_left; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_margin_left" value="<?php echo $pm_th_margin_left; ?>" placeholder="<?php echo $entry_th_margin_left; ?>" id="input-th_margin_left" class="form-control" />
            </div>
            <div class="col-sm-5"><?php /* echo $entry_th_margin_left_help; */ ?> </div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_bord_color"><?php echo $entry_th_bord_color; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_bord_color" value="<?php echo $pm_th_bord_color;?>" placeholder="<?php echo $entry_th_bord_color; ?>" id="input-th_bord_color" class="form-control" />
            </div>
            <div class="col-sm-5"><?php /* echo $entry_th_bord_color_help; */ ?> </div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_bord_hover_color"><?php echo $entry_th_bord_hover_color; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_bord_hover_color" value="<?php echo $pm_th_bord_hover_color; ?>" placeholder="<?php echo $entry_th_bord_hover_color; ?>" id="input-th_bord_hover_color" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_th_bord_hover_color_help; ?> </div>
   </div>

   <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_bord_hover_increase"><?php echo $entry_th_bord_hover_increase; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_bord_hover_increase" value="<?php echo $pm_th_bord_hover_increase; ?>" placeholder="<?php echo $entry_th_bord_hover_increase; ?>" id="input-th_bord_hover_increase" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_th_bord_hover_increase_help; ?></div>
    </div>

    <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_th_shadow; ?></label>
                <div class="col-sm-5">
                  <label class="radio-inline">
          <?php   if($pm_th_shadow == 1){ ?>
              <input  name="pm_th_shadow" type="radio" value="1"  checked="checked"/>
              <?php echo $text_enabled;
                     } else { ?>
              <input name="pm_th_shadow" type="radio" value="1"/>
              <?php echo $text_enabled;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
          <?php   if($pm_th_shadow == 0){ ?>
              <input  name="pm_th_shadow" type="radio" value="0"  checked="checked"/>
              <?php echo $text_disabled; 
                     } else { ?>
              <input  name="pm_th_shadow" type="radio" value="0"/>
              <?php echo $text_disabled;?> 
                    <?php } ?>
                  </label>
                </div>
            <div class="col-sm-5"><?php echo $entry_th_shadow_help; ?></div>
    </div>

     <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_th_title; ?></label>
                <div class="col-sm-5">
                  <label class="radio-inline">
          <?php   if($pm_th_title == 1){ ?>
              <input  name="pm_th_title" type="radio" value="1"  checked="checked"/>
              <?php echo $text_enabled;
                     } else { ?>
              <input name="pm_th_title" type="radio" value="1"/>
              <?php echo $text_enabled;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
          <?php   if($pm_th_title == 0){ ?>
              <input  name="pm_th_title" type="radio" value="0"  checked="checked"/>
              <?php echo $text_disabled; 
                     } else { ?>
              <input  name="pm_th_title" type="radio" value="0"/>
              <?php echo $text_disabled;?> 
                    <?php } ?>
                  </label>
                </div>
            <div class="col-sm-5"><?php echo $entry_th_title_help; ?></div>
    </div>

    <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_th_radius; ?></label>
                <div class="col-sm-5">
                  <label class="radio-inline">
          <?php   if($pm_th_radius == 1){ ?>
              <input  name="pm_th_radius" type="radio" value="1"  checked="checked"/>
              <?php echo $text_enabled;
                     } else { ?>
              <input name="pm_th_radius" type="radio" value="1"/>
              <?php echo $text_enabled;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
          <?php   if($pm_th_radius == 0){ ?>
              <input  name="pm_th_radius" type="radio" value="0"  checked="checked"/>
              <?php echo $text_disabled; 
                     } else { ?>
              <input  name="pm_th_radius" type="radio" value="0"/>
              <?php echo $text_disabled;?> 
                    <?php } ?>
                  </label>
                </div>
            <div class="col-sm-5"><?php /* echo $entry_th_radius_help; */ ?></div>
   </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_bord_radius"><?php echo $entry_th_bord_radius; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_th_bord_radius" value="<?php  echo $pm_th_bord_radius; ?>" placeholder="8" id="input-th_bord_radius" class="form-control" />
            </div>
            <div class="col-sm-5"><?php /* echo $entry_th_bord_radius_help; */ ?></div>
          </div>

           <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_th_to_square; ?></label>
                <div class="col-sm-5">
                  <label class="radio-inline">
          <?php   if($pm_th_to_square == 1){ ?>
              <input  name="pm_th_to_square" type="radio" value="1"  checked="checked"/>
              <?php echo $text_enabled;
                     } else { ?>
              <input name="pm_th_to_square" type="radio" value="1"/>
              <?php echo $text_enabled;?> 
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
          <?php   if($pm_th_to_square == 0){ ?>
              <input  name="pm_th_to_square" type="radio" value="0"  checked="checked"/>
              <?php echo $text_disabled; 
                     } else { ?>
              <input  name="pm_th_to_square" type="radio" value="0"/>
              <?php echo $text_disabled;?> 
                    <?php } ?>
                  </label>
                </div>
            <div class="col-sm-5">
            <?php echo $entry_th_to_square_help; ?>
            </div>
            </div>
        
            <div class="form-group">
            <label class="col-sm-2 control-label" for="input-th_2sq_crop_hori"><?php echo $entry_th_2sq_crop_hori; ?></label>
            <div class="col-sm-5">
            
              <input name="pm_th_2sq_crop_hori" type="text" value="<?php echo $pm_th_2sq_crop_hori;?>" id="input-th_2sq_crop_hori" class="form-control"/>
            </div>
                <div class="col-sm-5"><?php echo $entry_th_2sq_crop_hori_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_th_2sq_crop_vert; ?></label>
            <div class="col-sm-5">
              <input name="pm_th_2sq_crop_vert" type="text" value="<?php echo $pm_th_2sq_crop_vert;?>" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_th_2sq_crop_vert_help; ?></div>
                </div>

    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_thumbs_to_disk; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_thumbs_to_disk == 1){ ?>
              <input name="pm_thumbs_to_disk" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_thumbs_to_disk" type="radio" value="1"/> <?php echo $text_enabled;?>
                <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_thumbs_to_disk == 0){ ?>
               <input name="pm_thumbs_to_disk" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_thumbs_to_disk" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?> 
                  </label>  </div>
            <div class="col-sm-5"><?php echo $entry_thumbs_to_disk_help; ?></div>
    </div>
</div>
<div class="tab-pane" id="tab-full">  
   <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_slider_type; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_slider_type == 'slice'){ ?>
              <input name="pm_slider_type" type="radio" value="slice"  checked="checked"/> Slicebox
               <?php } else{ ?>
              <input name="pm_slider_type" type="radio" value="slice"/> Slicebox
                <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_slider_type == 'pmslider'){ ?>
               <input name="pm_slider_type" type="radio" value="pmslider"  checked="checked"/> Pmslider
               <?php } else{ ?>
               <input name="pm_slider_type" type="radio" value="pmslider"/> Pmslider
               <?php } ?>
                  </label>
                </div>   
                <div class="col-sm-5"><?php echo $entry_resize_auto_help; ?></div>
    </div>      
     <div class="form-group">
            <label class="col-sm-2 control-label" for="input-ki-radius"><?php echo $entry_pm_radius; ?></label>
            <div class="col-sm-5">
              <select name="pm_radius" id="input-ki-radius" class="form-control">
                <?php if ($pm_radius == 1) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-5"> <?php echo $entry_pm_radius_help; ?></div>
   </div>

   <div class="form-group">
            <label class="col-sm-2 control-label" for="input-pm_br_radius"><?php echo $entry_pm_br_radius; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_br_radius" value="<?php echo $pm_br_radius; ?>" placeholder="<?php echo $entry_pm_br_radius; ?>" id="input-pm_br_radius" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_pm_br_radius_help; ?> </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-picdiv_top"><?php echo $entry_picdiv_top; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pm_picdiv_top" value="<?php echo $pm_picdiv_top; ?>" placeholder="<?php echo $entry_picdiv_top; ?>" id="input-picdiv_top" class="form-control" />
            </div>
            <div class="col-sm-5"> <?php echo $entry_picdiv_top_help; ?></div>
     </div>  

   <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_resize_auto; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_resize_auto == 1){ ?>
              <input name="pm_resize_auto" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_resize_auto" type="radio" value="1"/><?php echo $text_enabled;?>
                <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_resize_auto == 0){ ?>
               <input name="pm_resize_auto" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_resize_auto" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
                </div>   
                <div class="col-sm-5"><?php echo $entry_resize_auto_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-bord_size"><?php echo $entry_bord_size; ?></label>
            <div class="col-sm-5">
              <input name="pm_bord_size" type="text" value="<?php echo $pm_bord_size;?>" id="input-bord_size" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_bord_size_help; ?></div>
    </div>
        
    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-bord_color"><?php echo $entry_bord_color; ?></label>
            <div class="col-sm-5">
              <input size="25" name="pm_bord_color" type="text" value="<?php echo $pm_bord_color;?>" id="input-bord_color" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_bord_color_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-out_bord_size"><?php echo $entry_out_bord_size; ?></label>
            <div class="col-sm-5">
              <input name="pm_out_bord_size" type="text" value="<?php echo $pm_out_bord_size;?>" id="input-out_bord_size" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
    </div>
     
     <div class="form-group">
            <label class="col-sm-2 control-label" for="input-out_bord_color"><?php echo $entry_out_bord_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_out_bord_color" type="text" value="<?php echo $pm_out_bord_color;?>" id="input-out_bord_color" class="form-control" />
            </div>  
            <div class="col-sm-5"></div> 
    </div>
                 
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_radius; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
          <?php   if($pm_pic_radius == 1){ ?>
              <input  name="pm_pic_radius" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_pic_radius" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
          <?php   if($pm_pic_radius == 0){ ?>
               <input  name="pm_pic_radius" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input  name="pm_pic_radius" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
               </label>
          </div>                
            <div class="col-sm-5"></div> 
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-bord_radius"><?php echo $entry_bord_radius; ?></label>
            <div class="col-sm-5">
              <input name="pm_bord_radius" type="text" value="<?php echo $pm_bord_radius;?>" id="input-bord_radius" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
     </div>

    <div class="form-group">
               <label class="col-sm-2 control-label" for="input-maxim_pic_width"><?php echo $entry_maxim_pic_width; ?></label>
            <div class="col-sm-5">
              <input name="pm_maxim_pic_width" type="text" value="<?php echo $pm_maxim_pic_width;?>" id="input-maxim_pic_width" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_maxim_pic_width_help; ?></div>
    </div>
            
    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-maxim_pic_height"><?php echo $entry_maxim_pic_height; ?></label>
            <div class="col-sm-5">
              <input name="pm_maxim_pic_height" type="text" value="<?php echo $pm_maxim_pic_height;?>" id="input-maxim_pic_height" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
    </div>
                     
    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-max_pic_width"><?php echo $entry_max_pic_width; ?></label>
            <div class="col-sm-5">
              <input name="pm_max_pic_width" type="text" value="<?php echo $pm_max_pic_width;?>" id="input-max_pic_width" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_max_pic_width_help; ?></div>
     </div>

    <div class="form-group">
            <label class="col-sm-2 control-label" for="input-max_pic_height"><?php echo $entry_max_pic_height; ?></label>
            <div class="col-sm-5">
              <input name="pm_max_pic_height" type="text" value="<?php echo $pm_max_pic_height;?>" id="input-max_pic_height" class="form-control" />
            </div>
            <div class="col-sm-5"></div>
     </div>

    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_oversize_allowed; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
            <?php   if($pm_oversize_allowed == 1){ ?>
              <input name="pm_oversize_allowed" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_oversize_allowed" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
            <?php   if($pm_oversize_allowed == 0){ ?>
               <input name="pm_oversize_allowed" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_oversize_allowed" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?> 
                  </label>
               </div>   
                <div class="col-sm-5"><?php echo $entry_oversize_allowed_help; ?></div>
    </div>
  
      <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_disable_animation; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
           <?php   if($pm_disable_animation == 1){ ?>
              <input name="pm_disable_animation" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_disable_animation" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
           <?php   if($pm_disable_animation == 0){ ?>
               <input name="pm_disable_animation" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_disable_animation" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>     </div>   
                <div class="col-sm-5"><?php echo $entry_disable_animation_help; ?></div>
        </div>
   
       <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_slideshow_time; ?></label>
            <div class="col-sm-5">
              <input name="pm_slideshow_time" type="text" value="<?php  echo $pm_slideshow_time;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_slideshow_time_help; ?></div>
       </div>
 </div>    
<div class="tab-pane" id="tab-texts">       
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_comments; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_comments == 1){ ?>
              <input name="pm_comments" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_comments" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
             <?php   if($pm_comments == 0){ ?>
               <input name="pm_comments" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_comments" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?> 
                  </label>
               </div>
            <div class="col-sm-5"><?php echo $entry_comments_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_comm_text_size; ?></label>
            <div class="col-sm-5">
              <input name="pm_comm_text_size" type="text" value="<?php echo $pm_comm_text_size;?>" class="form-control" />
            </div>
            <div class="col-sm-5"><?php echo $entry_comm_text_size_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_comm_text_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_comm_text_color" type="text" value="<?php echo $pm_comm_text_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_comm_text_color_help; ?></div>
    </div>

    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_comm_text_font; ?></label>
            <div class="col-sm-5">
              <input size="17" name="pm_comm_text_font" type="text" value="<?php echo $pm_comm_text_font;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_comm_text_font_help; ?></div>
    </div>
            
    <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $entry_comm_text_align; ?></label>
            <div class="col-sm-5">
              <input name="pm_comm_text_align" type="text" value="<?php echo $pm_comm_text_align;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_comm_text_align_help; ?></div>
    </div>
 
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_comm_auto; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_comm_auto == 1){ ?>
              <input name="pm_comm_auto" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_comm_auto" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
            <?php   if($pm_comm_auto == 0){ ?>
               <input name="pm_comm_auto" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_comm_auto" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>  
                  </label>
                 </div>   
                <div class="col-sm-5"><?php echo $entry_comm_auto_help; ?></div>
    </div>
  
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_read_meta; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_read_meta == 1){ ?>
              <input name="pm_read_meta" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_read_meta" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
             <?php   if($pm_read_meta == 0){ ?>
               <input name="pm_read_meta" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_read_meta" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>  
                  </label>
                 </div>   
                <div class="col-sm-5"><?php echo $entry_read_meta_help; ?></div>
   </div>
            
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_viewercomments; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_viewercomments == 1){ ?>
              <input name="pm_viewercomments" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_viewercomments" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
             <?php   if($pm_viewercomments == 0){ ?>
               <input name="pm_viewercomments" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_viewercomments" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?> 
                  </label>
                  </div>   
                <div class="col-sm-5"><?php echo $entry_viewercomments_help; ?></div>
      </div>           
            
     <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_moderate_posts;?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
          <?php if($pm_moderate_posts == 1){ ?>
               <input  name="pm_moderate_posts" type="radio"  value="1" checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>    
               <input  name="pm_moderate_posts" type="radio" value="1"><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
          <?php if($pm_moderate_posts == 0){ ?>
               <input  name="pm_moderate_posts" type="radio" value="0" checked="checked"> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input  name="pm_moderate_posts" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?> 
                  </label>
                 </div>   
                <div class="col-sm-5"><?php echo $entry_moderate_posts_help; ?></div>
    </div>
         
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_vcomm_header_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_vcomm_header_color" type="text" value="<?php echo $pm_vcomm_header_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_vcomm_header_color_help; ?></div>
    </div>

 <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_vcomm_box_color; ?></label>
            <div class="col-sm-5">  
              <input type="text" name="pm_vcomm_box_color" value="<?php echo $pm_vcomm_box_color;?>" size="6" class="form-control"/>
               </div>   
                <div class="col-sm-5"><?php echo $entry_vcomm_box_color_help; ?></div>
   </div>

 <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_vcomm_text_color; ?></label>
                  <div class="col-sm-5">
                  <input type="text" name="pm_vcomm_text_color" value="<?php echo $pm_vcomm_text_color;?>" size="6" class="form-control"/>
               </div>   
                <div class="col-sm-5"><?php echo $entry_vcomm_text_color_help; ?></div>
      </div>
    
     <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_vcomm_timedate_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_vcomm_timedate_color" type="text" value="<?php echo $pm_vcomm_timedate_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_vcomm_timedate_color_help; ?></div>
   </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_vcomm_back_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_vcomm_back_color" type="text" value="<?php echo $pm_vcomm_back_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_vcomm_back_color_help; ?></div>
     </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_vcomm_bord_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_vcomm_bord_color" type="text" value="<?php echo $pm_vcomm_bord_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_vcomm_bord_color_help; ?></div>
      </div>
                        
  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_slideshow; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_slideshow == 1){ ?>
              <input name="pm_slideshow" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_slideshow" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_slideshow == 0){ ?>
               <input name="pm_slideshow" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_slideshow" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
                 </div>   
                <div class="col-sm-5"><?php echo $entry_slideshow_help; ?></div>
    </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_downloadpics; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_downloadpics == 1){ ?>
              <input name="pm_downloadpics" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_downloadpics" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
             <?php   if($pm_downloadpics == 0){ ?>
               <input name="pm_downloadpics" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_downloadpics" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
                  </div>   
                <div class="col-sm-5"><?php echo $entry_downloadpics_help; ?></div>
    </div>
     
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_checkgps; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_checkgps == 1){ ?>
              <input" name="pm_checkgps" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_checkgps" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
             <?php   if($pm_checkgps == 0){ ?>
               <input name="pm_checkgps" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input" name="pm_checkgps" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
                 </div>   
                <div class="col-sm-5"><?php echo $entry_checkgps_help; ?></div>
    </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_cellinfo; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
         <?php   if($pm_cellinfo == 1){ ?>
              <input name="pm_cellinfo" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_cellinfo" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
         <?php   if($pm_cellinfo == 0){ ?>
               <input name="pm_cellinfo" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_cellinfo" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
                  </div>   
                <div class="col-sm-5"><?php echo $entry_cellinfo_help; ?></div>
     </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_nav; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
           <?php   if($pm_show_nav == 1){ ?>
              <input name="pm_show_nav" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input  name="pm_show_nav" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
           <?php   if($pm_show_nav == 0){ ?>
               <input name="pm_show_nav" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_nav" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>       </div>   
                <div class="col-sm-5"><?php echo $entry_show_nav_help; ?></div>
    </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_nav_always; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
           <?php   if($pm_nav_always == 1){ ?>
              <input name="pm_nav_always" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input  name="pm_nav_always" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
           <?php   if($pm_nav_always == 0){ ?>
               <input name="pm_nav_always" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_nav_always" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>      </div>   
                <div class="col-sm-5"><?php echo $entry_nav_always_help; ?></div>
     </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_nav_pos; ?></label>
            <div class="col-sm-5">
              <input name="pm_nav_pos" type="text" value="<?php echo $pm_nav_pos;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_nav_pos_help; ?></div>
     </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_nav_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_nav_color" type="text" value="<?php echo $pm_nav_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_nav_color_help; ?></div>
    </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_nav_border_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_nav_border_color" type="text" value="<?php echo $pm_nav_border_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_nav_border_color_help; ?></div>
     </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_nav_style; ?></label>
            <div class="col-sm-5">
              <input name="pm_nav_style" type="text" value="<?php echo $pm_nav_style;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_nav_style_help; ?></div>
    </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_image_nav; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_show_image_nav == 1){ ?>
              <input name="pm_show_image_nav" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_show_image_nav" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_show_image_nav == 0){ ?>
               <input name="pm_show_image_nav" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_image_nav" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>            </div>   
                <div class="col-sm-5"><?php echo $entry_show_image_nav_help; ?></div>
    </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_image_nav_always; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_image_nav_always == 1){ ?>
              <input name="pm_image_nav_always" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_image_nav_always" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_image_nav_always == 0){ ?>
               <input name="pm_image_nav_always" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_image_nav_always" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>            </div>   
                <div class="col-sm-5"><?php echo $entry_image_nav_always_help; ?></div>
    </div>
     
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_share; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_show_share == 1){ ?>
              <input name="pm_show_share" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_show_share" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_show_share == 0){ ?>
               <input name="pm_show_share" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_share" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>
            </div>   
                <div class="col-sm-5"><?php echo $entry_show_share_help; ?></div>
     </div>
    
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_help; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
              <?php   if($pm_show_help == 1){ ?>
              <input name="pm_show_help" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_show_help" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
              <?php   if($pm_show_help == 0){ ?>
               <input name="pm_show_help" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_help" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>            </div>   
                <div class="col-sm-5"><?php echo $entry_show_help_help; ?></div>
    </div>
                           
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_help_pos; ?></label>
            <div class="col-sm-5">
              <input name="pm_help_pos" type="text" value="<?php echo $pm_help_pos;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_help_pos_help; ?></div>
    </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_preview; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
           <?php   if($pm_show_preview == 1){ ?>
              <input name="pm_show_preview" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_show_preview" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
           <?php   if($pm_show_preview == 0){ ?>
               <input name="pm_show_preview" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_preview" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?></label>            </div>   
                <div class="col-sm-5"><?php echo $entry_show_preview_help; ?></div>
                </div>
    
            <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_preview_style; ?></label>
            <div class="col-sm-5">
              <input name="pm_preview_style" type="text" value="<?php echo $pm_preview_style;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_preview_style_help; ?></div>
      </div>
    
     <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_preview_pics; ?></label>
            <div class="col-sm-5">
              <input name="pm_preview_pics" type="text" value="<?php echo $pm_preview_pics;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_preview_pics_help; ?></div>
     </div>
   
     <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_show_explorer; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
           <?php   if($pm_show_explorer == 1){ ?>
              <input name="pm_show_explorer" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_show_explorer" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
           <?php   if($pm_show_explorer == 0){ ?>
               <input name="pm_show_explorer" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_show_explorer" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?>
                  </label>            </div>   
                <div class="col-sm-5"><?php echo $entry_show_explorer_help; ?></div>
      </div>
   
      <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_explorer_padding; ?></label>
            <div class="col-sm-5">
              <input name="pm_explorer_padding" type="text" value="<?php echo $pm_explorer_padding;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_explorer_padding_help; ?></div>
      </div>
   
     <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_watermark_hori; ?></label>
            <div class="col-sm-5">
              <input name="pm_watermark_hori" type="text" value="<?php echo $pm_watermark_hori;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_watermark_hori_help; ?></div>
     </div>
  
     <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_watermark_vert; ?></label>
            <div class="col-sm-5">
              <input name="pm_watermark_vert" type="text" value="<?php echo $pm_watermark_vert;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_watermark_vert_help; ?></div></div>
  
            <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_watermark_size; ?></label>
            <div class="col-sm-5">
              <input name="pm_watermark_size" type="text" value="<?php echo $pm_watermark_size;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_watermark_size_help; ?></div>
      </div>

     <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_fade_color; ?></label>
            <div class="col-sm-5">
              <input name="pm_fade_color" type="text" value="<?php echo $pm_fade_color;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_fade_color_help; ?></div>
                </div>
    
            <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_fade_alpha; ?></label>
            <div class="col-sm-5">
              <input name="pm_fade_alpha" type="text" value="<?php echo $pm_fade_alpha;?>" class="form-control" />
            </div>   
                <div class="col-sm-5"><?php echo $entry_fade_alpha_help; ?></div>
    </div>
   
    <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_shade_while_loading; ?></label>
            <div class="col-sm-5">
                  <label class="radio-inline">
             <?php   if($pm_shade_while_loading == 1){ ?>
              <input name="pm_shade_while_loading" type="radio" value="1"  checked="checked"/> <?php echo $text_enabled;?>
               <?php } else{ ?>
              <input name="pm_shade_while_loading" type="radio" value="1"/><?php echo $text_enabled;?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
             <?php   if($pm_shade_while_loading == 0){ ?>
               <input name="pm_shade_while_loading" type="radio" value="0"  checked="checked"/> <?php echo $text_disabled;?>
               <?php } else{ ?>
               <input name="pm_shade_while_loading" type="radio" value="0"/> <?php echo $text_disabled;?>
               <?php } ?> 
                  </label>
                </div>   
                <div class="col-sm-5"><?php echo $entry_shade_while_loading_help; ?></div>
      </div>
  </div> 
  </div>
    </form>
    </div>
  </div>
</div>
<?php echo $footer;?>
