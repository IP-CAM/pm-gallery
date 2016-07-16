<style type="text/css">
.pm_thumbnail{
  border:<?php echo $pm_th_bord_size;?>px solid <?php echo $pm_th_bord_color;?>; 
  width:<?php echo $pm_th_width;?>px;
  height:<?php echo $pm_th_height;?>px;
  margin-left:<?php echo $pm_th_margin_left;?>px;
  z-index:1;
<?php if($pm_th_radius == 1){?>
  -webkit-border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px;
  -moz-border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px;
  -khtml-border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px;
  border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px
<?php } ?>
}
<?php if($pm_th_title == 1){ ?>
.thumb_title{
  height:15px;
  text-align:center;
  font-weight:bold;
}
<?php } ?>
.pic > img{
<?php if($pm_th_radius == 1){?>
  -webkit-border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px;
  -moz-border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px;
  -khtml-border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px;
  border-radius: <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px <?php echo $pm_th_bord_radius;?>px
<?php } ?>        
}
</style>


 <div id="gallery-content" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

 <?php if($pm_breadcrumbs == 1){?>
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php } ?>

           <div id="galleries" class="row">
                <div id="folder-controller">
                </div> 
          </div>
</div>
<?php
   if(!$album){
      $sql = "SELECT * FROM ". DB_PREFIX ."pm_gallery_folder pmgf LEFT JOIN ". DB_PREFIX ."pm_gallery_folder_description pmgi ON (pmgf.folder_id = pmgi.folder_id) WHERE pmgf.module_id = '" . $module_id . "'";
   } elseif ($album > 0){
       $sql = "SELECT * FROM ". DB_PREFIX ."pm_gallery_folder pmgf LEFT JOIN ". DB_PREFIX ."pm_gallery_folder_description pmgfd ON (pmgf.folder_id = pmgfd.folder_id) WHERE pmgf.module_id = '" . $module_id . "' AND pmgf.folder_id = '" . $album . "'";
   }

    $query = $db->query($sql);
    $c = count($query->rows);

if($query->num_rows){
 $i = 0;

   foreach($query->rows as $result){  ?>   

<h2 class="gallery"><?php echo $result['title'];?></h2>
  <div class="folder-description"><?php echo !empty($result['description']) ? $result['description']: '';?></div>
  <div class="pm_gallery col-md-12 col-lg-12 col-xs-12"  title="<?php echo $result['folder'];?>" id="0_<?php echo $i;?>" OnMouseOut="closeButtons('<?php echo $pm_fr_height;?>','0_<?php echo $i;?>');" OnMouseOver="lourButtons('<?php echo $result['folder_id'];?>','0_<?php echo $i;?>','<?php echo $pm_fr_height;?>','<?php echo $pm_th_title;?>','<?php echo $txt_nav_maxi;?>','<?php echo $txt_max;?>');">

<?php
 
       $sql = "SELECT * FROM `". DB_PREFIX ."pm_gallery_folder` pmgf LEFT JOIN `". DB_PREFIX ."pm_gallery_image` pmgi ON (pmgf.folder_id = pmgi.folder_id) WHERE pmgf.module_id = '" . $module_id . "' AND pmgi.folder_id = '" . $result['folder_id'] . "'";

      $query2 = $db->query($sql);   

      if($query2->num_rows){
          $x = 0;
            foreach ($query2->rows as $file) {
                if( is_file( $pm_galleries . $file['folder'] . '/' . $file['filename'] ) ){
                
                           if($pm_th_title == 1){ ?>
                                <div class="pm_thumbnail col-sm-<?php echo $pm_th_per_line?> col-md-<?php echo $pm_th_per_line;?> col-lg-<?php echo $pm_th_per_line;?> col-xs-12" style="height:auto;padding:0px;background:#ffffff;margin_top:15px; margin-left:<?php echo $pm_th_margin_left;?>px;">
                                <div class="0_<?php echo $i;?> pic" style="width:100%;text-align:center;">
                                 <img id="0_<?php echo $i;?>_<?php echo $x;?>" src="<?php echo $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'];?>" onclick="getImage('<?php echo $module_id;?>','<?php echo $pm_galleries . $file['folder'] . '/' . $file['filename'];?>', '<?php echo $file['width'];?>','<?php echo $file['height'];?>', '<?php echo $pm_max_pic_height;?>','<?php echo $pm_bord_size;?>', '<?php echo $file['folder_id'];?>', '<?php echo $file['id'];?>', '<?php echo $pm_show_image_nav;?>','<?php echo $txt_nav_close;?>','<?php echo $txt_nav_download;?>');" onload="this.style.visibility='visible'" alt="0_0_0" style="width:<?php echo $pm_th_perc_width;?>%;margin-top:10px;"/>
                                    </div>
                                    <div class="thumb_title"><?php echo $file['title'];?></div>
                                    </div>
                          <?php }
                          if($pm_th_title == 0){?>
                            <img id="0_<?php echo $i;?>_<?php echo $x;?>" src="<?php echo $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'];?>" onclick="getImage('<?php echo $module_id;?>','<?php echo $pm_galleries . $file['folder'] . '/' . $file['filename'];?>', '<?php echo $file['width'];?>','<?php echo $file['height'];?>','<?php echo $pm_max_pic_height;?>','<?php echo $pm_bord_size;?>','<?php echo $file['folder_id'];?>','<?php echo $file['id'];?>','<?php echo $pm_show_image_nav;?>','<?php echo $txt_nav_close;?>','<?php echo $txt_nav_download;?>');" class="pm_thumbnail col-md-<?php echo $pm_th_per_line;?> col-lg-<?php echo $pm_th_per_line;?>' col-xs-12" style="width:<?php echo $pm_th_perc_width;?>%;margin-left:<?php echo $pm_th_margin_left;?>px;" onload="this.style.visibility='visible'" alt="0_0_0"/>;   
                          <?php } 
                }                        
            }
      } ?>
</div>
<?php
$i++;

   } 
}
?>
<script type="text/javascript">
  $("#gallery-content").append('<div id="fw_blend"></div>');
  $('.pm_gallery').css({"height":"<?php echo $pm_fr_height;?>px"});
  $('.pm_gallery').css({"background-color":"<?php echo $pm_fr_color;?>"});
  $('.pm_gallery').css({"border":"solid 1px #000000"});

  function slide_vcomm(module_id,folder_id,image_id,file,width,height){
      $("#kiv_share").hide();
      $("#thepicture").slideUp();
      $("#kiv_inshadow").append('<div id="pm_vcomm"></div>');
      $("#pm_vcomm").css({"width":width + "px"});
      $("#pm_vcomm").css({"height":height + "15px"});
      $("#pm_vcomm").css({"background":"<?php echo $pm_vcomm_header_color;?>"});

      if(width > height){
        var laske1 = width/100*24;
        var laske2a = width/100*65;
        var laske2 = laske2a/100*83;
        var input_width = laske2-20;
        var top_height = 250;
        var top_width = 90;
        var thumb_height = "200";
        var comm_left_width = "24";
        var comm_right_width = "65";
        var comm_margin_right = "10";
        var comm_width2 = "75";
        var div_class="pull-right";
        var input="form-control";
        var col_left = "2";
        var col_right = "10";
      }
      if(height > width){
        var laske1 = width/100*10;
        var laske2 = width/100*70-6;
        var input_width = laske2-420;
        var top_height = 300;
        var top_width = 100;
        var thumb_height = "100";
        var comm_left_width = "10";
        var comm_right_width = "70";
        var comm_margin_right = "20";
        var col_left = "12";
        var col_right = "12";
        var div_class="pull-center";
        var input="form-input";
      }

      var bottom_height = height-top_height;
      $("#pm_vcomm").html('<div id="comment-top" style="margin-top:-20px;background:#ffffff;height:' + top_height + 'px;float:left;width:' + width + 'px;"><div onClick="thePicture();" style="float:left;width:' + laske1 + 'px;text-align:center;line-height:' + top_height + 'px;"><img src="' + file + '" style="height:' + thumb_height + 'px;" alt=""></div><div id="comment" style="float:right;width:' + laske2 + 'px;margin-right:' + comm_margin_right + '%;padding-right:10px;"><h2><?php echo $txt_vcomm_lac;?></h2><form method="post" id="comment-form"><div class="form-group"><label class="col-sm-' + col_left + ' control-label" for="input-name"><span data-toggle="tooltip" title="<?php echo $txt_vcomm_name;?>"><?php echo $txt_vcomm_name;?></span></label><div class="col-sm-' + col_right + '"><input type="text" name="name" value="" placeholder="<?php echo $txt_vcomm_name;?>" id="form-input" class="' + input + '" /></div></div><div class="form-group"><label class="col-sm-' + col_left + ' control-label" for="input-comment"><?php echo $txt_vcomm_comm;?></label><div class="col-sm-' + col_right + '"><textarea name="pm_vcomm_comm" rows="5" placeholder="<?php echo $txt_vcomm_comm;?>" id="form-textarea" class="' + input + '"></textarea></div></div><div class="' + div_class + '"><button type="button" id="send-post" data-toggle="tooltip" title="<?php echo $txt_vcomm_post;?>" class="btn btn-primary"><i class="fa fa-save"></i></button><a href="" data-toggle="tooltip" title="<?php echo $txt_cancel;?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div></form></div></div><div id="comment-bottom"></div>');

      if(height > width){
        $('.pull-center').css({"text-align":"left"});
        $('#form-input').css({"width":input_width + "px"});
        $('#form-textarea').css({"width":input_width + "px"});
      }

  $("#send-post").click( function(){

        var name = $("input[name='name']").val();
        var comment = $("textarea#form-textarea").val();

        $("input[name='name']").val("");
        $("textarea#form-textarea").val("");

      $.ajax({
      url: 'index.php?route=module/pm_gallery/vcomm',
      type: 'post',
      data: '&module_id=' + module_id + '&folder_id=' + folder_id + '&image_id=' + image_id + '&file=' + file + '&name=' + name + '&comment=' + comment,
      success: function(json) {
          if(json['success']){
             $("#pm_vcomm").append('<div class="success" style="position:absolute;color:#666666;"><b>' + json['success'] + '</b></div>');
          }
          if(json['error']){
             $("#pm_vcomm").append('<div class="warning" style="position:absolute;color:#666666;"><b>' + json['error'] + '</b></div>');
          }
        }
      });
   });

     $("#comment-bottom").css({"padding-left":"10px"});
     $("#comment-bottom").css({"padding-right":"60px"});
     $("#comment-bottom").css({"width":width + "px"});
     $("#comment-bottom").css({"height":bottom_height + "px"});
     $("#comment-bottom").css({"background":"#e3e3e3"});

     $("#comment-bottom").append('<div id="comments" style="width:90%;"><h3><?php echo $txt_vcomm_title;?></h3></div>');

      $.ajax({
      url: 'index.php?route=module/pm_gallery/comment',
      dataType: 'json',
      type:'post',
      data:'&module_id=' + module_id + '&folder_id=' + folder_id + '&image_id=' + image_id, 
      success: function(json) {
        var cwidth = width-20;
             if(json['success']){
             var obj = json['comments'];
                if(obj.length > 0){
                  for(i=0; i<obj.length;i++){
                    $("#comments").append('<div class="comment" class="col-sm-12" style="width:' + cwidth + 'px;"><div class="col-sm-12" style="background:#666666;border:1px yellow;"><label class="col-sm-3" style="position:relative;float:left;height:22px;text-align:left;font-weight:bold;color:#ffffff;">' + obj[i]['name'] + '</label><label class="col-sm-2" style="heigth:22px;font-weight:bold;text-align:right;color:#ffffff;">' + obj[i]['date'] + '</label></div><div class=col-sm-12" style="padding:10px;border:1px solid #ffffff;">' + obj[i]['comment'] + '</div></div>');
                  }
                }
                if(obj.length == 0){
                    $("#comments").append('<div class="comment" class="col-sm-12" style="width:' + cwidth + 'px;"><?php echo $txt_vcomm_ncy;?></div>');
                }
           }
        }
      });
}
function startExplorer(folder_id,frame_id,pm_th_title){
  $("body").append('<div id="pm_maindiv"></div>');
  $("#pm_maindiv").css({"background":"rgb(255, 255, 255) none repeat scroll 0% 0%"});
  $("#pm_maindiv").css({"position":"fixed"});
  $("#pm_maindiv").css({"left":"0px"});
  $("#pm_maindiv").css({"top":"0px"});
  $("#pm_maindiv").css({"z-index":"100002"});
  $("#pm_maindiv").css({"overflow-x":"hidden"});
  $("#pm_maindiv").css({"overflow-y":"auto"});
  $("#pm_maindiv").css({"display":"block"});
  $("#pm_maindiv").css({"width":"100%"});
  $("#pm_maindiv").css({"height":"100%"});
        $.ajax({
        url: 'index.php?route=module/pm_gallery/explorer&pm_galleries=<?php echo $pm_galleries;?>&module_id=<?php echo $module_id;?>&folder_id=' + folder_id,
        dataType: 'json',
        success: function(json) {
          var thumbs = $.parseJSON.json;
             for(var i = 0; i< thumbs.length;i++){   
            if(pm_th_title == 1){
              $( "#pm_maindiv" ).append('<div class="pm_thumbnail col-sm-<?php echo $pm_th_per_line;?> col-md-<?php echo $pm_th_per_line;?> col-lg-<?php echo $pm_th_per_line;?> col-xs-12" style="height:auto;padding:0px;background:#ffffff;margin_top:15px;margin-left:<?php echo $pm_th_margin_left;?>px;"><div class="pic" style="width:100%;text-align:center;"><img id="' + frame_id + '_' + i + '"  src="' + thumbs[i][thumb] + '" onclick="getImage(\''+ thumbs[i]['image'] + '\',\''+ thumbs[i]['width'] + '\',\'' + thumbs[i]['height'] + '\',\'<?php echo $pm_max_pic_height;?>\',\'<?php echo $pm_bord_size;?>\',\'' + folder_id + '\',\'' + thumbs[i]['image_id'] + '\',\'<?php echo $pm_show_image_nav;?>\',\'<?php echo $txt_nav_close;?>\',\'<?php echo $txt_nav_download;?>\');" onload="this.style.visibility=\'visible\'" alt="0_0_0" style="width:<?php echo $pm_th_perc_width;?>%;margin-top:10px;"/></div><div class="thumb_title">' + thumbs[i][title] + '</div></div>');            
            } 
            if(pm_th_title == 0){                         
              $( "#pm_maindiv" ).append('<img class="pm_thumbnail" id="' + frame_id + '_' + i + '" src="' + thumbs[i][thumb] + '"  onclick="getImage(\''+ thumbs[i]['image'] + '\',\''+ thumbs[i]['width'] + '\',\'' + thumbs[i]['height'] + '\',\'<?php echo $pm_max_pic_height;?>\',\'<?php echo $pm_bord_size;?>\',\'' + folder_id + '\',\'' + thumbs[i]['image_id'] + '\',\'<?php echo $pm_show_image_nav;?>\',\'<?php echo $txt_nav_close;?>\',\'<?php echo $txt_nav_download;?>\');" class="col-md-<?php echo $pm_th_per_line;?> col-lg-<?php echo $pm_th_per_line;?> col-xs-12" style="width:<?php echo $pm_th_perc_width;?>%; margin-left:<?php echo $pm_th_margin_left;?>px;" onload="this.style.visibility=\'visible\'"  alt="0_0_0" class="pm_thumbnail"/>');   
            }
          }
       }});
}
function basename(path) {
    return path.replace(/\\/g,'/').replace( /.*\//, '' );
}
</script>
