{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
   <input type="hidden" name="submitMp3Settings" value="1">
   <div class="panel" id="fieldset_0_1_1">
      <div class="panel-heading">
         
      </div>
      <div class="form-wrapper">
        <div class="form-group">
           <label class="control-label col-lg-3 required">
          	Associate Mp3 file with other Virtual Products:
           </label>
           <div class="col-lg-9 ">
              <select name="virtual_prod_assoc" class="fixed-width-xl" id="virtual_prod_assoc">
                <option value="0"> -- Select your Associated Virtual Product -- </option>
                {foreach from=$virtual_products item=items}
                    <option value="{$items.id_product}">{$items.name}</option>
                {/foreach}
              </select>
              <p class="help-block">
                 If you associate your product with another one from the above, please upload an mp3 file here which represents the associated product. It will add a BUY BUTTON linked to the associated product in the product page and a PREVIEW of the associated file.
              </p>
        	</div>
        </div>
         <div class="form-group">
            <label class="control-label col-lg-3 required">
            Author 
            </label>
            <div class="col-lg-9 ">
               <input type="text" name="NEW_MEDIA_AUTHOR" id="NEW_MEDIA_AUTHOR" value="" class="">
            </div>
         </div>
         <div class="form-group">
            <label class="control-label col-lg-3 required">
            Name of your song 
            </label>
            <div class="col-lg-9 ">
               <input type="text" name="NEW_MEDIA_TITLE" id="NEW_MEDIA_TITLE" value="" class="">
            </div>
         </div>
         <div class="form-group">
            <label class="control-label col-lg-3 required">
            Upload your MP3/WAV/OGG here 
            </label>
            <div class="col-lg-9 ">
               <div class="form-group">
                  <div class="col-sm-6">
                     <input id="NEW_MEDIA_MP3" type="file" name="NEW_MEDIA_MP3" class="hide">
                     <div class="dummyfile input-group">
                        <span class="input-group-addon"><i class="icon-file"></i></span>
                        <input id="NEW_MEDIA_MP3-name" type="text" name="filename" readonly="" style="display:none;">
                        <span class="input-group-btn" style="display:none;">
                        <button id="NEW_MEDIA_MP3-selectbutton" type="button" name="submitAddAttachments" class="btn btn-default">
                        <i class="icon-folder-open"></i> Add file</button>
                        </span>
                     </div>
                  </div>
               </div>
               <script type="text/javascript">
                  $(document).ready(function(){
                  	$('#NEW_MEDIA_MP3-selectbutton').click(function(e) {
                  		$('#NEW_MEDIA_MP3').trigger('click');
                  	});
                  
                  	$('#NEW_MEDIA_MP3-name').click(function(e) {
                  		$('#NEW_MEDIA_MP3').trigger('click');
                  	});
                  
                  	$('#NEW_MEDIA_MP3-name').on('dragenter', function(e) {
                  		e.stopPropagation();
                  		e.preventDefault();
                  	});
                  
                  	$('#NEW_MEDIA_MP3-name').on('dragover', function(e) {
                  		e.stopPropagation();
                  		e.preventDefault();
                  	});
                  
                  	$('#NEW_MEDIA_MP3-name').on('drop', function(e) {
                  		e.preventDefault();
                  		var files = e.originalEvent.dataTransfer.files;
                  		$('#NEW_MEDIA_MP3')[0].files = files;
                  		$(this).val(files[0].name);
                  	});
                  
                  	$('#NEW_MEDIA_MP3').change(function(e) {
                  		if ($(this)[0].files !== undefined)
                  		{
                  			var files = $(this)[0].files;
                  			var name  = '';
                  
                  			$.each(files, function(index, value) {
                  				name += value.name+', ';
                  			});
                  
                  			$('#NEW_MEDIA_MP3-name').val(name.slice(0, -2));
                  		}
                  		else // Internet Explorer 9 Compatibility
                  		{
                  			var name = $(this).val().split(/[\\/]/);
                  			$('#NEW_MEDIA_MP3-name').val(name[name.length-1]);
                  		}
                  	});
                  
                  	if (typeof NEW_MEDIA_MP3_max_files !== 'undefined')
                  	{
                  		$('#NEW_MEDIA_MP3').closest('form').on('submit', function(e) {
                  			if ($('#NEW_MEDIA_MP3')[0].files.length > NEW_MEDIA_MP3_max_files) {
                  				e.preventDefault();
                  				alert('You can upload a maximum of  files');
                  			}
                  		});
                  	}
                  });
               </script>
               <p class="help-block">
                  Maximum MP3 size is : {$max_mp3_size}. - PLEASE NOTE THAT SOME BROWSERS DO NOT SUPPORT MP4/AAC, OGG, WAV MUSIC FORMATS
               </p>
            </div>
         </div>
      </div>
      <!-- /.form-wrapper -->
      <div class="panel-footer">
       <input type="hidden" name="submitMusic" id="submitMusic" value="1"/>
       <input type="hidden" name="productId" id="productId" value="{$product_id|escape:'html'}"/>
       <input type="hidden" name="deletelinkIdMusic" id="deletelinkIdMusic" value=""/>
      </div>
   </div>
   
<script type="text/javascript">
$(document).ready(function(){
	
	$('.{$db_prefix}music_shop').find('.delete').attr('onclick','');

	$('.{$db_prefix}music_shop').find('.delete').on('click',function(e){
		if (confirm('Delete this item?')){
			e.preventDefault();
			var delStr = $(this).prop('href');
			var delStrSubstr1 = delStr.indexOf("&id=");
			var delStrSubstr2 = delStr.indexOf("&del");
			var linkToDelete = delStr.substring(delStrSubstr1+4, delStrSubstr2);
			$('#deletelinkIdMusic').val(linkToDelete);
			$('#desc-product-save').trigger('click');
		}else{
			e.preventDefault();
		}
	})
	 
})

</script>
