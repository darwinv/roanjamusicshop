var someSound;
$(document).ready(function(){
   $(document).on("click",".agregar-lista",function(){ dom.playlistContainer.style.height = '222px';
      var actual=$(this).parent().find("a").first();
      var act=$(this);
      var id=actual.data("id");
      var ruta=$("#barra").data("ruta");
      $.ajax({
          url:ruta + "roanjamusicshop/ajax_roanjamusicshop.php",
          data:{action:"getSongs",id:id},
          type:"POST",
          dataType:"json",
          success:function(data){
          for (i=0;i<data.length;i++) {
                var song=ruta + "roanjamusicshop/mp3/" + data[i]['mp3_name'];
                var title=data[i]['mp3_title'];
                var precio=data[i]['price'];
                var price = parseFloat(precio).toFixed(2);
                var newsong="<li class='" + data[i]['id_product'] + " item-list' data-id='" + data[i]['id_music'] + "'>";
                newsong+="<a href='" + song + "' class='dat-list' data-youtube='" + data[i]['url_youtube'] + "'><span class='list-titlesound'><b>" + title + "</b></span> -" + data[i]['genero'] + "<br>"+ data[i]['author'] + " </a>";
                newsong+="<a class='quitar-lista2'><div class='ico-x'></div></a>";
                newsong+="<a class='exclusive ajax_add_to_cart_button cart-list-ico' rel='ajax_id_product_"+ data[i]['id_product'] + "' href='{$link->getPageLink('cart')|escape:'html'}?qty=1&amp;id_product="+ data[i]['id_product'] + "&amp&amp;add' title='Add to cart' data-id-product='"+ data[i]['id_product'] + "'>";
                newsong+="&nbsp;&nbsp;<span class='price-list'>" + price + "&nbsp;&nbsp;</span><div class='ico-cart'></div></a></li>";
//                newsong+="<a href='" + song + "'><b>" + title + "</b> - " + title + "<span class='label'>Explicit</span></a><button class='quitar-lista2'>X</button></li>";
                $("#barra").find(".sm2-playlist-wrapper").find(".sm2-playlist-bd").append(newsong);
           }
           act.addClass("quitar-lista");
           act.removeClass("agregar-lista");
           if($("div#barra").hasClass("hidden"))
           $("div#barra").removeClass("hidden");
           //window.sm2BarPlayers[0].actions.play();
           $.ajax({
               url:ruta + "roanjamusicshop/ajax_roanjamusicshop.php",
               data:{action:"setCookie",song:data},
               type:"POST",
               dataType:"html",
               success:function(data){
                   console.log(data);
               }
           });
          }
      });
   });
   $(document).on("click",".quitar-lista",function(){
      var actual=$(this).parent().find("a").first();
      var act=$(this);
      var id=actual.data("id");
      var ruta=$("#barra").data("ruta");
      $.ajax({
          url:ruta + "roanjamusicshop/ajax_roanjamusicshop.php",
          data:{action:"removeSongs",id:id},
          type:"POST",
          dataType:"html",
          success:function(data){
              $("#barra").find(".sm2-playlist-bd>." + id).remove();
          }
      });
      act.addClass("agregar-lista");
      act.removeClass("quitar-lista");
   });
   $(document).on("click","a.quitar-lista2",function(e){
       e.preventDefault();
       var actual=$(this).parent();
       var id=actual.data("id");
       var ruta=$("#barra").data("ruta");
       $("#barra").find(actual).remove();
       $.ajax({
          url:ruta + "roanjamusicshop/ajax_roanjamusicshop.php",
          data:{action:"removeSong",id:id},
          type:"POST",
          dataType:"html",
          success:function(data){
              console.log(data);
          }
       });
   });

   $(document).on("click",".sm2_button",function(e){






      e.preventDefault();
      var actual=$(this);
      if(actual.data("place")!=undefined && $("section#columns").attr("id")==undefined){
          var lugar="barra2";
      }else{
          var lugar="barra";
      }

      if(!actual.hasClass("sm2_playing")){
          var song=actual.data("href");
          var title=actual.attr("title");
          

          setYoutube(actual.data("youtube"));


          $("a.sm2_playing").removeClass("sm2_playing");
          playerMusic(song,title,lugar);
          
      }else{
          actual.removeClass("sm2_playing");
          //soundManager.stopAll();
          if(lugar=="barra2")
            $("div#barra2").addClass("hidden");
          if(lugar=="barra"){
              document.getElementById("playerSound100").href="";
              document.getElementById("playerSoundTitle").innerHTML = "";
          }else{
              document.getElementById("playerSound100-2").href="";
              document.getElementById("playerSoundTitle-2").innerHTML = "";
          }
      }
   });

   $(document).on("click",".play-pause",function(e){
	  //var str=soundManager.soundIDs[0];
	  //  var res = str.substring(4);
    var actualID=window.soundManager.soundIDs.length-1
	if($('#barra').hasClass("playing")){

	  soundManager.pause(soundManager.soundIDs[actualID]);
	//window.sm2BarPlayers[res].actions.pause();
	$('#barra').removeClass("playing");
	$('#barra').addClass("paused");
	}
	else{
	    if($('#barra').hasClass("paused")){
	   soundManager.resume(soundManager.soundIDs[actualID]);
	   $('#barra').removeClass("paused");
	   $('#barra').addClass("playing");
	   }
	 }

  $(document).on("click",".youtube",function(e){
    if($(this).hasClass("youtubeDisable")){
       e.preventDefault();
    }
  });


	});
 

   function playerMusic(song,title,lugar){
      var mp3btn="playermp3";
      if($("#" + lugar).hasClass("hidden"))
      $("#" + lugar).removeClass("hidden");
      //someSound.play();

      if(lugar=="barra"){ //
          document.getElementById("playerSound100").href = song;
          $(".sm2-playlist-target").find("li:first-child").html('<b>'+title+'</b>');
          //document.getElementById("playerSoundTitle").innerHTML = title;
          if($("div#barra2").attr("id")==undefined){
            window.sm2BarPlayers[0].actions.play(mp3btn);
          }else{
            window.sm2BarPlayers[1].actions.play();
          }
      }else{
          document.getElementById("playerSound100-2").href = song;
          document.getElementById("playerSoundTitle-2").innerHTML = title;
          window.sm2BarPlayers[0].actions.play();
      }
   }

   function setYoutube(youtube_emb) {
      if (youtube_emb === undefined || youtube_emb=='' || youtube_emb === null) {
        $('#barra').find('.fancybox.youtube').attr("href",'').addClass('youtubeDisable').removeClass('youtubeActive roanjayt');      
      }else{
        var youtube='https://www.youtube.com/embed/'+youtube_emb+'?autoplay=1';
        $('#barra').find('.fancybox.youtube').attr("href",youtube).removeClass('youtubeDisable').addClass('youtubeActive roanjayt');
      }
    }

});
