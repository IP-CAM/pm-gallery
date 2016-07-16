 function lourButtons(folder_id,frame_id,frame_height,pm_th_title,txt_nav_maxi,txt_max){
    var height = parseInt(frame_height)+80;
    var bheight = height-46;
    $('#'+frame_id).append('<div id="test_' + frame_id + '_hide_tb" onClick="startExplorer(\'' + folder_id + '\',\'' + frame_id + '\',\'' + pm_th_title + '\');"></div>');
    $('#'+frame_id).css({"height": + height + "px"});
    $('#test_'+frame_id + '_hide_tb').css({"position":"relative"}); 
    $('#test_'+frame_id + '_hide_tb').css({"float":"right"});
    $('#test_'+frame_id + '_hide_tb').css({"z-index":"100"});   
    $('#test_'+frame_id + '_hide_tb').css({"width":"37px"});
    $('#test_'+frame_id + '_hide_tb').css({"height":"37px"});
    $('#test_'+frame_id + '_hide_tb').css({"text-align":"right"});
    $('#test_'+frame_id + '_hide_tb').css({"margin-top":bheight + "px"});
    $('#test_'+frame_id + '_hide_tb').css({"background":"#ffffff none repeat scroll 0% 0%"});
    $('#test_'+frame_id + '_hide_tb').css({"border":"2px solid rgb(0, 0, 0)"});
    $('#test_'+frame_id + '_hide_tb').css({"padding":"3px"});
    $('#test_'+frame_id + '_hide_tb').show(); 

    $('#test_'+frame_id + '_hide_tb').append('<img id="pm_nav_full" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_full.png" onClick="startExplorer(\'' + folder_id + '\',\'' + frame_id + '\',\'' + pm_th_title + '\');" title="'+ txt_nav_maxi + '" alt="' + txt_max + '">'); 
    $("#pm_nav_full").css({"cursor":"pointer"});
    $("#pm_nav_full").css({"border":"0px"});
    $("#pm_nav_full").css({"margin":"0px 2px 0px 2px"});
    $("#pm_nav_full").css({"padding-top":"2px"});
    $("#pm_nav_full").css({"display":"inline"});
/*
    $('#test_'+frame_id + '_hide_tb').append('<img id="pm_nav_play" src="catalog/view/javascript/jquery/pm-gallery/image/pm_nav_play.png" onClick="slideshow(\'' + module_id + '\',\'' + frame_id + '\');" title="Start slideshow" alt="Slideshow"/>'); 
    */
    $("#pm_nav_play").css({"cursor":"pointer"});
    $("#pm_nav_play").css({"border":"0px"});
    $("#pm_nav_play").css({"margin":"0px 2px 0px 2px"});
    $("#pm_nav_play").css({"padding-top":"2px"});
    $("#pm_nav_play").css({"display":"inline"});
  }
  function closeButtons(frame_height,frame_id){
    $('#test_'+frame_id + '_hide_tb').empty(); 
    $('#test_'+frame_id + '_hide_tb').hide(); 
    $('#'+frame_id).css({"height": + frame_height + "px"});
  }
