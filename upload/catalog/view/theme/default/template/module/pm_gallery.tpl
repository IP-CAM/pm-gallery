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
<?php if($pm_slider_type == 'slice'){?>
<script type="text/javascript" src="catalog/view/javascript/jquery/pm-gallery/jquery.slicebox.js"></script>
<?php } ?>
 <div id="gallery-content" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

<?php if($pm_slider_type == 'pmslider'){?>
  <div id="fw_blend">
    <div id="pmslider">
  <div id="pm_inshadow"><div id="pm_close"></div></div>
      <div id="pmslider0" class="nivoSlider"></div>
    </div>
      <div id="img-nav">
        <div id="prev"></div>
        <div id="next"></div>
      </div>

  </div>
<?php } ?>
         
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
<?php if($pm_slider_type == 'pmslider'){?>
<h2 class="gallery"><?php echo $result['title'];?></h2>
<?php } ?>
  <div class="folder-description"><?php echo !empty($result['description']) ? $result['description']: '';?></div>
  <div class="<?php if($pm_slider_type == 'pmslider'){?>pm_gallery<?php } else {?>slicebox<?php } ?> col-md-12 col-lg-12 col-xs-12"<?php if($pm_slider_type == 'pmslider'){?>  title="<?php echo $result['folder'];?>"<?php }?> id="0_<?php echo $i;?>">

      <div class="wrapper">
        <ul id="sb-slider" class="sb-slider">
<?php
 
       $sql = "SELECT * FROM `". DB_PREFIX ."pm_gallery_folder` pmgf LEFT JOIN `". DB_PREFIX ."pm_gallery_image` pmgi ON (pmgf.folder_id = pmgi.folder_id) WHERE pmgf.module_id = '" . $module_id . "' AND pmgi.folder_id = '" . $result['folder_id'] . "'";

      $query2 = $db->query($sql);   

      if($query2->num_rows){
          $x = 0;
            foreach ($query2->rows as $file) {
                if( is_file( $pm_galleries . $file['folder'] . '/' . $file['filename'] ) ){
                    if($pm_slider_type == 'pmslider'){
                           if($pm_th_title == 1){ ?>
                                <div class="pm_thumbnail col-sm-<?php echo $pm_th_per_line?> col-md-<?php echo $pm_th_per_line;?> col-lg-<?php echo $pm_th_per_line;?> col-xs-12" style="height:auto;padding:0px;background:#ffffff;margin_top:15px; margin-left:<?php echo $pm_th_margin_left;?>px;">
                                <div class="0_<?php echo $i;?> pic" style="width:100%;text-align:center;">
                                 <img id="0_<?php echo $i;?>_<?php echo $x;?>" src="<?php echo $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'];?>" onclick="getImage('<?php echo $module_id;?>', '<?php echo $pm_galleries . $file['folder'] . '/' . $file['filename'];?>',  '<?php echo $file['width'];?>', '<?php echo $file['height'];?>', '<?php echo $pm_max_pic_height;?>', '<?php echo $pm_bord_size;?>', '<?php echo $file['folder_id'];?>','<?php echo $file['id'];?>','<?php echo $txt_next;?>','<?php echo $txt_prev;?>');" onload="this.style.visibility='visible'" alt="0_0_0" style="width:<?php echo $pm_th_perc_width;?>%;margin-top:10px;"/>
                                    </div>
                                    <div class="thumb_title"><?php echo $file['title'];?></div>
                                    </div>
                          <?php }
                          if($pm_th_title == 0){?>
                            <img id="0_<?php echo $i;?>_<?php echo $x;?>" src="<?php echo $pm_galleries . $file['folder'] . '/thumbs/' . $file['filename'];?>" onclick="getImage('<?php echo $module_id;?>','<?php echo $pm_galleries . $file['folder'] . '/' . $file['filename'];?>','<?php echo $file['width'];?>','<?php echo $file['height'];?>','<?php echo $pm_max_pic_height;?>','<?php echo $pm_bord_size;?>','<?php echo $file['folder_id'];?>','<?php echo $file['id'];?>','<?php echo $txt_next;?>','<?php echo $txt_prev;?>');" class="pm_thumbnail col-md-<?php echo $pm_th_per_line;?> col-lg-<?php echo $pm_th_per_line;?>' col-xs-12" style="width:<?php echo $pm_th_perc_width;?>%;margin-left:<?php echo $pm_th_margin_left;?>px;" onload="this.style.visibility='visible'" alt="0_0_0"/>;   
                          <?php }
                          } 
if($pm_slider_type == 'slice'){?>
<script type="text/javascript">
  var aheight = $(window).height();
  var width = $("#content").width();
  var aimg_height = <?php echo $pm_max_pic_height;?>*aheight;
  var percent = 100;
  var top = 0;
  var image_height = '<?php echo $file['height'];?>';
  var image_width = '<?php echo $file['width'];?>';
  if(image_height > aimg_height || aimg_height == image_height ){
     percent = aimg_height/image_height;
    var img_width = Math.round((percent*image_width),0);
  } else{
    var img_width = image_width;
  }
  var swidth = width-img_width;
  var mleft = swidth/2/2;
  var cwidth = width-mleft;

$("#gallery-content").css({"width":width + "px"});
$(".folder-description").css({"width":100+img_width + "px"});
$("#sb-slider").css({"padding-left":mleft + "px"});
</script>
                          <li class="sb">
                             <img  src="<?php echo $pm_galleries . $file['folder'] . '/' . $file['filename'];?>" id="image<?php echo $x;?>"/>
                             <div class="sb-description" style="width:100%">
                              <h3><?php echo $file['title'];?></h3>
                             </div>
                          </li>
 
<script type="text/javascript">
  var height = $(window).height();
  var width = $("#gallery-content").width();
  var img_height = <?php echo $pm_max_pic_height;?>*height;
  var percent = 100;
  var top = 0;
  var image_height = '<?php echo $file['height'];?>';
  var image_width = '<?php echo $file['width'];?>';
  if(image_height > img_height || img_height == image_height ){
     percent = img_height/image_height;
    var img_width = Math.round((percent*image_width),0);
  } else{
     img_height = image_height;
    var img_width = image_width;
  }

$("#image<?php echo $x;?>").css({"height":img_height + "px"});
$(".sb-description").css({"width":img_width + "px"});
</script>
              <?php  }   
              $x++;
              }                     
            }
      } ?>
      </ul>

</div>
<?php if($pm_slider_type == 'slice'){?>
        <div id="shadow" class="shadow"></div>
        <div id="nav-arrows" class="nav-arrows">
          <a href="#">Next</a>
          <a href="#">Previous</a>
        </div>
        <div id="nav-dots" class="nav-dots">
          <span class="nav-dot-current"></span>
      <?php if($query2->num_rows){
              if(count($query2->rows) > 1){
                for ($i=1; $i < count($query2->rows); $i++) { ?>
                  <span></span>
      <?php     }
              }
          } ?>
        </div>
<?php } ?>
</div>
<?php
$i++;

   } 
}

?>
<script type="text/javascript">
  $('.pm_gallery').css({"background-color":"<?php echo $pm_fr_color;?>"});
  $('.pm_gallery').css({"border":"solid 1px #000000"});

  function slide_vcomm(module_id,folder_id,image_id,file,width,height){
      $("#kiv_share").hide();
      $("#thepicture").slideUp();
      $("#pm_inshadow").append('<div id="pm_vcomm"></div>');
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
      $("#pm_vcomm").html('<div id="comment-top" style="margin-top:-20px;background:#ffffff;height:' + top_height + 'px;float:left;width:' + width + 'px;"><div onClick="thePicture();" style="float:left;width:' + laske1 + 'px;text-align:center;line-height:' + top_height + 'px;"><img src="' + file + '" style="height:' + thumb_height + 'px;" alt=""></div><div id="comment" style="float:right;width:' + laske2 + 'px;margin-right:' + comm_margin_right + '%;padding-right:10px;"><h2><?php echo $txt_vcomm_lac;?></h2><form method="post" id="comment-form"><div class="form-group"><label class="col-sm-' + col_left + ' control-label" for="input-name"><span data-toggle="tooltip" title="<?php echo $pm_vcomm_name;?>"><?php echo $txt_vcomm_name;?></span></label><div class="col-sm-' + col_right + '"><input type="text" name="name" value="" placeholder="<?php echo $txt_vcomm_name;?>" id="form-input" class="' + input + '" /></div></div><div class="form-group"><label class="col-sm-' + col_left + ' control-label" for="input-comment"><?php echo $txt_vcomm_comm;?></label><div class="col-sm-' + col_right + '"><textarea name="pm_vcomm_comm" rows="5" placeholder="<?php echo $txt_vcomm_comm;?>" id="form-textarea" class="' + input + '"></textarea></div></div><div class="' + div_class + '"><button type="button" id="send-post" data-toggle="tooltip" title="<?php echo $txt_vcomm_post;?>" class="btn btn-primary"><i class="fa fa-save"></i></button><a href="" data-toggle="tooltip" title="<?php echo $txt_cancel;?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div></form></div></div><div id="comment-bottom"></div>');

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
           }
        }
      });
}
function basename(path) {
    return path.replace(/\\/g,'/').replace( /.*\//, '' );
}
</script>
<script type="text/javascript">
function getImage(module_id,image_info, image_width, image_height, pm_max_pic_height, pm_bord_size, folder_id, image_id, txt_next,txt_prev){
  // Fw Blend
 $("#fw_blend").css({"width":"100%"});
  $("#fw_blend").css({"height":"100%"});
  $("#fw_blend").css({"opacity":"0.96"});
  $("#fw_blend").css({"position":"fixed"});
  $("#fw_blend").css({"left":"0px"});
  $("#fw_blend").css({"top":"0px"});
  $("#fw_blend").css({"z-index":"1000"});
  $("#fw_blend").css({"display":"block"});
  $("#fw_blend").css({"background":"#e3e3e3 none repeat scroll 0% 0%"});

  // pmslider
  var next;
  var prev;
  var title_height;
  var timage_height;
      $.ajax({
      url: 'index.php?route=module/pm_gallery/slider',
      dataType: 'json',
      type:'post',
      data:'&module_id=' + module_id + '&folder_id=' + folder_id + '&image_id=' + image_id, 
      success: function(json) {

  var height = $(window).height();
  var width = $("body").width();
  var img_height = pm_max_pic_height*height;
  var image = image_info;
  var percent = 100;
  var top = 0;
  image_height = image_height;
  if(image_height > img_height || img_height > image_height ){
     percent = img_height/image_height;
     img_width = Math.round((percent*image_width),0);
  } else{
     img_height = image_height;
     img_width = image_width;
  }
  var xwidth = width-img_width;
  var sleft = xwidth/2;
  $("#pmslider").css({"margin-left":sleft+"px"});
  $("#pmslider").css({"width":img_width +"px"});

           for(var i = 0;i<json.length;i++){
             if( json[i]['image_id'] == image_id ){
              prev = i-1;
              next = i+1;
               $("#pmslider0").html('<img id="thepicture" style="position:relative;float:left;width:' + img_width + 'px;" src="' + json[i]['gallery'] +  json[i]['folder'] + '/' + json[i]['filename'] + '" alt="' + json[i]['title'] + '"/>'); 
               $("#pmslider0").append('<div id="img-title" style="position:relative;height:auto;z-index:1000;width:' + img_width + 'px;clear:both;float:left;background:#ffffff;">' + json[i]['title'] + '</div>');

        title_height = $("#img-title").height();
        timage_height = img_height+title_height+80;
        top_x = height-timage_height;
        top = top_x/2;
             }
           }

           $("#pmslider").css({"top": top});
           pmslider();
          // inshadow
          $("#pm_inshadow").css({"position":"absolute"});
          $("#pm_inshadow").css({"margin-left":"0%"});
          $("#pm_inshadow").css({"margin-top":"0%"});
          $("#pm_inshadow").css({"z-index":"10001"});
          $("#pm_inshadow").css({"background":"transparent none repeat scroll 0% 0%"});
          $("#pm_inshadow").css({"padding":"0px"});
          $("#pm_inshadow").css({"display":"block"});
          $("#pm_inshadow").css({"overflow":"hidden"});
          $("#pm_inshadow").css({"cursor":"pointer"});
          $("#pm_inshadow").css({"width": img_width+"px"});

          // Buttons
          $("#pm_close").css({"position":"relative"});
          $("#pm_close").css({"float":"right"});
          $("#pm_close").css({"width":"20px"});
          $("#pm_close").css({"height": "20px"});
          $("#pm_close").css({"background":"rgb(102, 102, 102) none repeat scroll 0% 0%"});
          $("#pm_close").css({"z-index":"10000"});
          $("#pm_close").css({"padding":"1px 1px 3px"});
          $("#pm_close").css({"line-height":"12px"});
          $("#pm_close").css({"box-shadow":"0px 0px 10px rgb(0, 0, 0)"});
          $("#pm_close").html('<img id="close" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_close.png" title="<?php echo $txt_nav_close;?>" onclick="closeImage();">');
          $("#close").css({"cursor":"pointer"});
          $("#close").css({"border":"0px"});
          $("#close").css({"margin":"0px 2px 0px 2px"});
          $("#close").css({"float":"right"});
          $("#close").css({"z-index":"10006"});

           if(json.length > 1){
            var mtop = top+img_height+title_height+1;
              $("#img-nav").css({"width":img_width + "px"});
              $("#img-nav").css({"margin-left":sleft+"px"});
              $("#img-nav").css({"margin-top":mtop+"px"});



              var end = json.length;
            for(var i = 0;i<json.length;i++){
                if(i == prev){
                 $("#prev").html('<a onclick="getImage(\'' + module_id + '\',\'' + json[i]['filename'] + '\',\'' + json[i]['width'] +'\',\'' + json[i]['height'] + '\',\'' + pm_max_pic_height + '\',\'' + pm_bord_size + '\',\'' + folder_id + '\',\'' + json[i]['image_id'] + '\',\'' + txt_next + '\',\'' + txt_prev + '\');"><img style="height:80px;" src="' + json[i]['gallery'] +  json[i]['folder'] + '/' + json[i]['filename'] + '" alt="' + json[i]['title'] + '" title="' + txt_prev + '"/></a>'); 
                }
                if(i == next  && next < end){
                 $("#next").html('<a onclick="getImage(\'' + module_id + '\',\'' + json[i]['filename'] + '\',\'' + json[i]['width'] +'\',\'' + json[i]['height'] + '\',\'' + pm_max_pic_height + '\',\'' + pm_bord_size + '\',\'' + folder_id + '\',\'' + json[i]['image_id'] + '\',\'' + txt_next + '\',\'' + txt_prev + '\');"><img style="height:80px;" src="' + json[i]['gallery'] +  json[i]['folder'] + '/' + json[i]['filename'] + '" alt="' + json[i]['title'] + '" title="' + txt_next + '"/></a>'); 
                }
                if(prev < 0){
                   $("#prev").empty();               
                }
                if(next == end){
                   $("#next").empty();               
                }
             }
            }

        }
     });
}
function closeImage(){
  $("#fw_blend").empty();
  $("#fw_blend").hide();
}
</script>
<?php if($pm_slider_type == 'slice'){?>
<script type="text/javascript">
      $(function() {

        var Page = (function() {

          var $navArrows = $( '#nav-arrows' ).hide(),
            $navDots = $( '#nav-dots' ).hide(),
            $nav = $navDots.children( 'span' ),
            $shadow = $( '#shadow' ).hide(),
            slicebox = $( '#sb-slider' ).slicebox( {
              onReady : function() {

                $navArrows.show();
                $navDots.show();
                $shadow.show();

              },
              onBeforeChange : function( pos ) {

                $nav.removeClass( 'nav-dot-current' );
                $nav.eq( pos ).addClass( 'nav-dot-current' );

              }
            } ),
            
            init = function() {

              initEvents();
              
            },
            initEvents = function() {

              // add navigation events
              $navArrows.children( ':first' ).on( 'click', function() {

                slicebox.next();
                return false;

              } );

              $navArrows.children( ':last' ).on( 'click', function() {
                
                slicebox.previous();
                return false;

              } );

              $nav.each( function( i ) {
              
                $( this ).on( 'click', function( event ) {
                  
                  var $dot = $( this );
                  
                  if( !slicebox.isActive() ) {

                    $nav.removeClass( 'nav-dot-current' );
                    $dot.addClass( 'nav-dot-current' );
                  
                  }
                  
                  slicebox.jump( i + 1 );
                  return false;
                
                } );
                
              } );

            };

            return { init : init };

        })();

        Page.init();

      });
</script>
<?php } ?>
