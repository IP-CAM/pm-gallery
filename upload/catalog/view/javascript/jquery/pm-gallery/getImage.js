function getImage(module_id,image_info, image_width, image_height, pm_max_pic_height, pm_bord_size, folder_id, image_id, txt_next,txt_prev){
  // Fw Blend
  $("#fw_blend").css({"width":"100%"});
  $("#fw_blend").css({"height":"100%"});
  $("#fw_blend").css({"background":"#e3e3e3 none repeat scroll 0% 0%"});
  $("#fw_blend").css({"opacity":"0.96"});
  $("#fw_blend").css({"position":"fixed"});
  $("#fw_blend").css({"left":"0px"});
  $("#fw_blend").css({"top":"0px"});
  $("#fw_blend").css({"z-index":"10000"});
  $("#fw_blend").css({"display":"block"});
  $("#fw_blend").css({"text-align":"center"});

  var height = $("#fw_blend").height();

  var img_height = pm_max_pic_height*height;
  var image = image_info;
  var percent = 100;
  var top = 0;
  if(image_height > img_height || img_height > image_height ){
     percent = img_height/image_height;
     img_width = Math.round((percent*image_width),0);
     if(image_height > img_height){
        top_x = height-img_height;
        top = top_x/2;
     } 
  } else{
     img_height = image_height;
     img_width = image_width;
  }
  // slideshow
  $("#fw_blend").append('<div id="slideshow0" class="owl-carousel owl-theme" style="opacity: 1; display: block;"></div>'); 
  $("#slideshow0").css({"margin-left":"auto"});
  $("#slideshow0").css({"margin-right":"auto"});
  $("#slideshow0").css({"width":img_width +"px"});
  $("#slideshow0").css({"margin-top": top+"px"});

  var next;
  var prev;
      $.ajax({
      url: 'index.php?route=module/pm_gallery/slider',
      dataType: 'json',
      type:'post',
      data:'&module_id=' + module_id + '&folder_id=' + folder_id + '&image_id=' + image_id, 
      success: function(json) {

           for(var i = 0;i<json.length;i++){
             if( json[i]['image_id'] == image_id ){
              prev = i-1;
              next = i+1;
               $("#slideshow0").html('<div class="owl-wrapper-outer"><div style="width: 4560px; left: 0px; display: block; transition: all 1000ms ease 0s; transform: translate3d(0px, 0px, 0px);" class="owl-wrapper"><div style="width: ' + img_width + 'px;" class="owl-item"><div class="item"><img style="width:' + img_width + 'px;" src="' + json[i]['gallery'] +  json[i]['folder'] + '/' + json[i]['filename'] + '" alt="' + json[i]['title'] + '" class="img-responsive" /><div class="col-sm-12">' + json[i]['title'] + '</div></div></div></div></div>'); 
             }
           }

           if(json.length > 1){
              $("#slideshow0").append('<div id="img-nav" class="col-sm-12 col-lg-12 col-md-12 col-xs-12" style="margin-top:2px;background:#ffffff;">');
           for(var i = 0;i<json.length;i++){
              if(i == prev){
                 $("#img-nav").append('<div style="width: auto;height:80px;position:relative;float:left;"><a onclick="getImage(\'' + module_id + '\',\'' + json[i]['filename'] + '\',\'' + json[i]['width'] +'\',\'' + json[i]['height'] + '\',\'' + pm_max_pic_height + '\',\'' + pm_bord_size + '\',\'' + folder_id + '\',\'' + json[i]['image_id'] + '\',\'' + txt_next + '\',\'' + txt_prev + '\');"><img style="height:80px;" src="' + json[i]['gallery'] +  json[i]['folder'] + '/' + json[i]['filename'] + '" alt="' + json[i]['title'] + '" title="Prev"/></a></div>'); 
              }
              if(i == next){
                 $("#img-nav").append('<div style="width: auto;height:80px;position:relative;float:right;"><a onclick="getImage(\'' + module_id + '\',\'' + json[i]['filename'] + '\',\'' + json[i]['width'] +'\',\'' + json[i]['height'] + '\',\'' + pm_max_pic_height + '\',\'' + pm_bord_size + '\',\'' + folder_id + '\',\'' + json[i]['image_id'] + '\',\'' + txt_next + '\',\'' + txt_prev + '\');"><img style="height:80px;" src="' + json[i]['gallery'] +  json[i]['folder'] + '/' + json[i]['filename'] + '" alt="' + json[i]['title'] + '" title="Next"/></a></div>'); 
              }
            }
              $("#slideshow0").append('</div>');
            }

        }
     });
}
function closeImage(){
  $("#fw_blend").empty();
  $("#fw_blend").hide();
}
