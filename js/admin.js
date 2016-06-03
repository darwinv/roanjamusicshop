$(document).ready(function(){
  $('#active_youtube_on').click(function() {
     if ($(this).is(":checked"))
	      $('#yt_url').attr('disabled', false);
  });
  $('#active_youtube_off').click(function() {
      if ($(this).is(":checked"))
	      $('#yt_url').attr('disabled', true);
  }); 
  $("#submitAddYoutube").click(function(){
     var boton=$(this);      
     var url=$("#yt_url").val();
     var ruta=boton.data("ruta");
     var id_product=boton.data("idproduct");
     var language=boton.data("language");
     var employe=boton.data("employe");
     boton.attr("disabled","disabled");
     $.ajax({
        url:ruta + "ajax_roanjamusicshop.php",
        data:{action:"setUrlYoutube",url:url,id_product:id_product,language:language,employe:employe},
        type:"POST",
        dataType:"html",
        success:function(data){
            boton.attr("disabled",false);
        },
        error:function(){
            boton.attr("disabled",false);
        }
     });
  });
});