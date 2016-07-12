function getImage(module_id,image_info, image_width, image_height, pm_max_pic_height,pm_bord_size,folder_id,image_id,pm_show_image_nav,txt_nav_close,txt_nav_download){
  // Fw Blend
  $("#fw_blend").css({"width":"100%"});
  $("#fw_blend").css({"height":"100%"});
  $("#fw_blend").css({"background":"#333333 none repeat scroll 0% 0%"});
  $("#fw_blend").css({"opacity":"0.98"});
  $("#fw_blend").css({"position":"fixed"});
  $("#fw_blend").css({"left":"0px"});
  $("#fw_blend").css({"top":"0px"});
  $("#fw_blend").css({"z-index":"10000"});
  $("#fw_blend").css({"display":"block"});
  // kiv picdiv
  $("#fw_blend").append('<div id="kiv_picdiv"></div>'); 
  $("#kiv_picdiv").css({"position":"fixed"});
  $("#kiv_picdiv").css({"z-index":"10000"});
  $("#kiv_picdiv").css({"background":"<?php echo $pm_bord_color ?>"});
  $("#kiv_picdiv").css({"padding":"0px"});
  $("#kiv_picdiv").css({"display":"block"});
  $("#kiv_picdiv").css({"overflow":"hidden"});
  $("#kiv_picdiv").css({"left":"50%"});
  $("#kiv_picdiv").css({"width":"0px"});
  $("#kiv_picdiv").css({"height":"1px"});

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
  // kiv inshadow
  $("#fw_blend").append('<div id="kiv_inshadow" class="nivoSlider"></div>');
  $("#kiv_inshadow").css({"position":"relative"});
  $("#kiv_inshadow").css({"left":"0%"});
  $("#kiv_inshadow").css({"top":"0%"});
  $("#kiv_inshadow").css({"z-index":"10000"});
  $("#kiv_inshadow").css({"background":"transparent none repeat scroll 0% 0%"});
  $("#kiv_inshadow").css({"padding":"0px"});
  $("#kiv_inshadow").css({"border":"10px solid rgb(102, 102, 102)"});
  $("#kiv_inshadow").css({"display":"block"});
  $("#kiv_inshadow").css({"overflow":"hidden"});
  $("#kiv_inshadow").css({"cursor":"pointer"});
  $("#kiv_inshadow").css({"margin-left":"auto"});
  $("#kiv_inshadow").css({"margin-right":"auto"});
  $("#kiv_inshadow").css({"margin-top": top+"px"})
  $("#kiv_inshadow").css({"width": img_width+"px"});
  $("#kiv_inshadow").css({"height": img_height+"px"});

  // Buttons
  $("#kiv_inshadow").append('<div id="kiv_closebutton"></div>');
  $("#kiv_closebutton").css({"position":"absolute"});
  $("#kiv_closebutton").css({"top":"0px"});
  $("#kiv_closebutton").css({"right":"0px"});
  $("#kiv_closebutton").css({"background":"rgb(102, 102, 102) none repeat scroll 0% 0%"});
  $("#kiv_closebutton").css({"z-index":"1000"});
  $("#kiv_closebutton").css({"padding":"1px 1px 3px"});
  $("#kiv_closebutton").css({"line-height":"12px"});
  $("#kiv_closebutton").css({"box-shadow":"0px 0px 10px rgb(0, 0, 0)"});
  $("#kiv_closebutton").append('<img id="pm_close" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_close.png" title="' + txt_close + '" onclick="closeImage();">');
  $("#pm_close").css({"cursor":"pointer"});
  $("#pm_close").css({"border":"0px"});
  $("#pm_close").css({"margin":"0px 2px 0px 2px"});
  $("#pm_close").css({"padding-top":"2px"});
  $("#pm_close").css({"display":"inline"});
  $("#pm_close").css({"z-index":"10006"});

  $("#fw_blend").append('<div id="kiv_help"></div>');
  $("#kiv_help").css({"color":"rgb(0, 0, 0)"});
  $("#kiv_help").css({"font":"12px/19px Tahoma,sans-serif"});
  $("#kiv_help").css({"position":"absolute"});
  $("#kiv_help").css({"left":"4px"});
  $("#kiv_help").css({"bottom":"4px"});
  $("#kiv_help").css({"text-align":"left"});
  $("#kiv_help").css({"z-index":"10000"});
  $("#kiv_help").css({"opacity":"0.51"});
  $("#kiv_help").append('<img class="img_info" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_info.png" alt=""/>');
  $(".img_info").css({"border":"0px"});
  $(".img_info").css({"vertical-align":"bottom"});
  $(".img_info").css({"display":"inline"});
  // Image 
  var pm_bord_size = pm_bord_size;

  var sizes = pm_bord_size*2;

  $("#kiv_inshadow").append('<div id="item"><img  id="thepicture" src="' + image_info + '" class="pm_fullimg"></div>');

  $("#thepicture").slideUp();
  $("#thepicture").slideDown();
  $("#thepicture").css({"z-index":"10000"});
  $("#thepicture").css({"margin-left":pm_bord_size+"px"});
  $("#thepicture").css({"margin-top":pm_bord_size+"px"});
  $("#thepicture").css({"width": img_width-sizes +"px"});
  $("#thepicture").css({"height":img_height-sizes +"px"});
  $("#thepicture").css({"display":"block"});
  // Comdiv 
  $("#kiv_inshadow").append('<div id="kiv_comdiv"></div>');
  $("#kiv_comdiv").css({"position":"fixed"});
  $("#kiv_comdiv").css({"z-index":"10000"});
  $("#kiv_comdiv").css({"background":"rgb(102, 102, 102) none repeat scroll 0% 0%"});
  $("#kiv_comdiv").css({"padding":"10px"});
  $("#kiv_comdiv").css({"display":"none"});
  $("#kiv_comdiv").css({"overflow":"hidden"});
  $("#kiv_comdiv").css({"font":"12px Tahoma,sans-serif"});
  $("#kiv_comdiv").css({"color":"rgb(0, 0, 0)"});
  $("#kiv_comdiv").css({"box-shadow":"0px 0px 10px rgb(0, 0, 0)"});
  $("#kiv_comdiv").css({"margin-left":pm_bord_size+"px"});
  $("#kiv_comdiv").css({"margin-top":pm_bord_size+"px"});

  // pm_loading
  $("#fw_blend").append('<img src="catalog/view/javascript/jquery/pm-gallery/image/pm_loading.gif" id="kiv_loading" title="' + txt_nav_download + '">');
  $("#kiv_loading").css({"margin":"-8px 0px 0px -8px"});
  $("#kiv_loading").css({"position":"fixed"});
  $("#kiv_loading").css({"top":"50%"});
  $("#kiv_loading").css({"left":"50%"});
  $("#kiv_loading").css({"z-index":"10000"});
  $("#kiv_loading").css({"padding":"0px"});
  $("#kiv_loading").css({"border":"0px none"});
  $("#kiv_loading").css({"display":"none"});
  $("#kiv_loading").css({"opacity":"1"});

  if(pm_show_image_nav == 1){

   var center = img_height/2;
   var thumbh  = center+150;
   var check = $( window ).width();
   var empty = check - img_width;
   var margin = empty/2-150;
   var twidth = pm_bord_size*2+150;

      $.ajax({
      url: 'index.php?route=module/pm_gallery/navpics',
      dataType: 'json',
      type:'post',
      data:'&module_id=' + module_id + '&folder_id=' + folder_id + '&image_id=' + image_id, 
      success: function(json) {
             if(json['prev']){
                var obj = json['prev'];
                if(obj['image']){
                   $("#fw_blend").append('<div id="kiv_wowdiv"></div>');
                   $("#kiv_wowdiv").css({"position":"relative"});
                   $("#kiv_wowdiv").css({"float":"left"});
                   $("#kiv_wowdiv").css({"vertical-align":"middle"});
                   $("#kiv_wowdiv").css({"z-index":"1000"});
                   $("#kiv_wowdiv").css({"height":"auto"});
                   $("#kiv_wowdiv").css({"padding":"10px"});
                   $("#kiv_wowdiv").css({"margin-top":"-" + thumbh +"px"});
                   $("#kiv_wowdiv").css({"margin-left": margin +"px"});
                   $("#kiv_wowdiv").css({"background":"rgb(102, 102, 102) none repeat scroll 0% 0%"});
                   $("#kiv_wowdiv").css({"box-shadow":"none"});
                   $("#kiv_wowdiv").css({"width":twidth + "px"});

                   $("#kiv_wowdiv").hover(function() {
                      $("#kiv_wowdiv").show();
                    //  $("#kiv_wowdiv").css({"margin-left": margin-100 +"px"});
                    });
                    $("#kiv_wowdiv").append('<img src="' + obj['image'] + '" style="width:150px" onload="this.style.visibility=\'visible\'" onclick="getImage(\'' + module_id + '\',\'' + obj['image'] + '\',\'' + obj['width'] + '\',\'' + obj['height'] + '\',\'' + pm_max_pic_height + '\',\'' + pm_bord_size + '\',\'' + folder_id +'\',\'' + obj['image_id'] + '\',\'' + pm_show_image_nav + '\');">');
              }
           }
           if(json['next']){
             var obj2 = json['next'];
                if(obj2['image']){
                    $("#fw_blend").append('<div id="kiv_prevdiv"></div>');
                    $("#kiv_prevdiv").css({"position":"relative"});
                    $("#kiv_prevdiv").css({"float":"right"});
                    $("#kiv_prevdiv").css({"vertical-align":"middle"});
                    $("#kiv_prevdiv").css({"z-index":"1000"});
                    $("#kiv_prevdiv").css({"background":"rgb(102, 102, 102) none repeat scroll 0% 0%"});
                    $("#kiv_prevdiv").css({"padding":"4px 2px"});
                    $("#kiv_prevdiv").css({"height":"auto"});
                    $("#kiv_prevdiv").css({"width":twidth + "px"});
                    $("#kiv_prevdiv").css({"margin-top":"-" + thumbh +"px"});
                    $("#kiv_prevdiv").css({"margin-right": margin +"px"});
                    $("#kiv_prevdiv").css({"overflow":"hidden"});
                    $("#kiv_prevdiv").css({"box-shadow":"0px 0px 10px rgb(0, 0, 0)"});

                   $("#kiv_prevdiv").hover(function() {
                      $("#kiv_prevdiv").show();
                    //  $("#kiv_prevdiv").css({"margin-right": margin-100 +"px"});
                    });

                    $("#kiv_prevdiv").append('<img src="' + obj2['image'] + '" style="width:150px" onload="this.style.visibility=\'visible\'" onclick="getImage(\'' + module_id + '\',\'' + obj2['image'] + '\',\'' + obj2['width'] + '\',\'' + obj2['height'] + '\', \'' + pm_max_pic_height + '\',\'' + pm_bord_size + '\', \'' + folder_id +'\',\'' + obj2['image_id'] + '\', \'' + pm_show_image_nav + '\');">');
                }
          }
        }
      });
  }

  $("#fw_blend").append('<div contr="open" id="kiv_share"></div>');
  $("#kiv_share").css({"position":"fixed"});
  $("#kiv_share").css({"width":"120px"});
  $("#kiv_share").css({"height":"30px"});
  $("#kiv_share").css({"margin-left":"48%"});
  $("#kiv_share").css({"background":"rgb(255, 255, 255) none repeat scroll 0% 0%"});
  $("#kiv_share").css({"border":"2px solid rgb(0, 0, 0)"});
  $("#kiv_share").css({"z-index":"10000"});
  $("#kiv_share").css({"padding":"3px 3px 30px"});
  $("#kiv_share").css({"overflow":"hidden"});
  $("#kiv_share").css({"line-height":"12px"});
  $("#kiv_share").css({"display":"block"});
  $("#kiv_share").css({"top":"0px"});

var filename = basename(image_info);
  $("#kiv_share").append('<img id="pm_nav_close" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_close.png" title="Close" onClick="closeImage();">');
  $("#kiv_share").append('<img id="pm_nav_comm" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_vcomm.png"  title="Add/See viewer comments" onClick="slide_vcomm(\'' + module_id + '\',\'' + folder_id + '\',\'' + image_id + '\',\'' + image_info + '\',\'' + image_width + '\',\'' + image_height + '\');">');
  $("#kiv_share").append('<a href="' + image_info + '" download="' + filename + '"><img alt="image" id="pm_nav_download" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_download.png" title="Download full resolution picture"></a>');



  $("#kiv_share").append('<img id="pm_nav_link" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_link.png" title="Link">');
  $("#pm_nav_link").css({"border":"0px"});
  $("#pm_nav_link").css({"margin":"0px 2px 0px 0px"});
  $("#pm_nav_link").css({"padding":"0px"});
  $("#pm_nav_link").css({"vertical-align":"top"});
  $("#pm_nav_link").css({"display":"inline"});

  $("#readonly").css({"width":"254px"});
  $("#readonly").css({"height":"17px"});
  $("#readonly").css({"padding":"1px"});
  $("#readonly").css({"line-height":"17px"});
  $("#readonly").css({"margin":"0px"});
  $("#readonly").css({"background-color":"#fff"});
  $("#readonly").css({"font-size":"12px"});
  $("#readonly").css({"font-weight":"normal"});
  $("#readonly").css({"color:":"000"});
  $("#readonly").css({"border":"1px solid #000"});

  $("#fw_blend").append('<div contr="open" id="kiv_tb"></div>');
  $("#pm_tab").css({"position":"fixed"});
  $("#pm_tab").css({"top":"-60px"});
  $("#pm_tab").css({"left":"50%"});
  $("#pm_tab").css({"margin-left":"-39px"});
  $("#pm_tab").css({"background":"rgb(255, 255, 255) none repeat scroll 0% 0%"});
  $("#pm_tab").css({"border":"2px solid rgb(0, 0, 0)"});
  $("#pm_tab").css({"z-index":"10000"});
  $("#pm_tab").css({"padding":"20px 3px 3px"});
  $("#pm_tab").css({"line-height":"12px"});
  $("#pm_tab").css({"display":"block"});  $("#pm_nav_close").css({"cursor":"pointer"});
  $("#pm_nav_close").css({"border":"0px"});
  $("#pm_nav_close").css({"margin":"0px 2px 0px 2px"});
  $("#pm_nav_close").css({"padding-top":"2px"});
  $("#pm_nav_close").css({"display":"inline"});

  $("#pm_nav_comm").css({"cursor":"pointer"});
  $("#pm_nav_comm").css({"border":"0px"});
  $("#pm_nav_comm").css({"margin":"0px 2px 0px 2px"});
  $("#pm_nav_comm").css({"padding-top":"2px"});
  $("#pm_nav_comm").css({"display":"inline"});

  $("#pm_nav_download").css({"cursor":"pointer"});
  $("#pm_nav_download").css({"border":"0px"});
  $("#pm_nav_download").css({"margin":"0px 2px 0px 2px"});
  $("#pm_nav_download").css({"padding-top":"2px"});
  $("#pm_nav_download").css({"display":"inline"});

}
function closeImage(){
  $("#fw_blend").empty();
  $("#fw_blend").hide();
}
