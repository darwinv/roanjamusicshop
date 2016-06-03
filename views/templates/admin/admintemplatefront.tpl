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
         <i class="icon-cogs"></i> {l s='Add your own MP3 file and Name' mod='roanjamusicshop'}
      </div>
      <div class="form-wrapper">
          <div class="form-group">
            <label class="control-label col-lg-3 required">
            	{l s='Associate Mp3 file with other Virtual Products:' mod='roanjamusicshop'}
            </label>
            <div class="col-lg-9 ">
                <select name="virtual_prod_assoc" class="fixed-width-xl" id="virtual_prod_assoc">
                  <option value="0">{l s=' -- Select your Associated Virtual Product -- ' mod='roanjamusicshop'}</option>
                  {foreach from=$virtual_products item=items}
                      <option value="{$items.id_product}">{$items.name}</option>
                  {/foreach}
                </select>
                <p class="help-block">
                   {l s='If you associate your product with another one from the above, please upload an mp3 file here which represents the associated product. It will add a BUY BUTTON linked to the associated product in the product page and a PREVIEW of the associated file.' mod='roanjamusicshop'}
                </p>
            </div>
          </div>
          <div class="form-group">				
            <label class="control-label col-lg-2" for="author_{$default_language}">
                {l s='Author'  mod='roanjamusicshop'}					
            </label>
            <div class="col-lg-9">
                {include file="controllers/products/input_text_lang.tpl"
                    languages=$languages                    
                    input_name='author'
                    input_value=''}
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-lg-2" for="mp3_title_{$default_language}">
              {l s='Title'  mod='roanjamusicshop'}          
            </label>
            <div class="col-lg-9">
              {include file="controllers/products/input_text_lang.tpl"
                languages=$languages                
                input_name='mp3_title'
                input_value=''}
            </div>
          </div>  
          <div class="form-group">        
            <label class="control-label col-lg-2" for="genero_{$default_language}">         
                {l s='Genero'  mod='roanjamusicshop'}        
            </label>
            <div class="col-lg-9">
              {include file="controllers/products/input_text_lang.tpl"
                languages=$languages                
                input_name='genero'
                input_value=''}
            </div>
          </div>  
          <div class="form-group">        
            <label class="control-label col-lg-2">
              {l s='Enabled'}
            </label>
            <div class="col-lg-9">
              <span class="switch prestashop-switch fixed-width-lg">
                <input type="radio" name="active_music" id="active_music_on" value="1" checked="checked" />
                <label for="active_music_on" class="radioCheck">
                  {l s='Yes'}
                </label>
                <input type="radio" name="active_music" id="active_music_off" value="0" />
                <label for="active_music_off" class="radioCheck">
                  {l s='No'}
                </label>
                <a class="slide-button btn"></a>
              </span>
            </div>
          </div>  
          <div class="form-group">
                <label class="control-label col-lg-3 required">
                 {l s='Upload your MP3/WAV/OGG here' mod='roanjamusicshop'}
                </label>
                <div class="col-lg-9 ">
                   <div class="form-group">
                      <div class="col-sm-6">
                         <input id="mp3_name" type="file" name="mp3_name" class="hide">
                         <div class="dummyfile input-group">
                            <span class="input-group-addon"><i class="icon-file"></i></span>
                            <input id="mp3_name-name" type="text" name="filename" readonly>
                            <span class="input-group-btn">
                            <button id="mp3_name-selectbutton" type="button" name="submitAddAttachments" class="btn btn-default">
                            <i class="icon-folder-open"></i> {l s='Add file' mod='roanjamusicshop'}</button>
                            </span>
                         </div>
                      </div>
                   </div>
                   <script type="text/javascript">
                      $(document).ready(function(){
                      	$('#mp3_name-selectbutton').click(function(e) {
                      		$('#mp3_name').trigger('click');
                      	});
                      
                      	$('#mp3_name-name').click(function(e) {
                      		$('#mp3_name').trigger('click');
                      	});
                      
                      	$('#mp3_name-name').on('dragenter', function(e) {
                      		e.stopPropagation();
                      		e.preventDefault();
                      	});
                      
                      	$('#mp3_name-name').on('dragover', function(e) {
                      		e.stopPropagation();
                      		e.preventDefault();
                      	});
                      
                      	$('#mp3_name-name').on('drop', function(e) {
                      		e.preventDefault();
                      		var files = e.originalEvent.dataTransfer.files;
                      		$('#mp3_name')[0].files = files;
                      		$(this).val(files[0].name);
                      	});
                      
                      	$('#mp3_name').change(function(e) {
                      		if ($(this)[0].files !== undefined)
                      		{
                      			var files = $(this)[0].files;
                      			var name  = '';
                      
                      			$.each(files, function(index, value) {
                      				name += value.name+', ';
                      			});
                      
                      			$('#mp3_name-name').val(name.slice(0, -2));
                      		}
                      		else // Internet Explorer 9 Compatibility
                      		{
                      			var name = $(this).val().split(/[\\/]/);
                      			$('#mp3_name-name').val(name[name.length-1]);
                      		}
                      	});
                      
                      	if (typeof mp3_name_max_files !== 'undefined')
                      	{
                      		$('#mp3_name').closest('form').on('submit', function(e) {
                      			if ($('#mp3_name')[0].files.length > mp3_name_max_files) {
                      				e.preventDefault();
                      				alert('You can upload a maximum of  files');
                      			}
                      		});
                      	}
                      });
                   </script>
                   <p class="help-block">
                   	{l s='Maximum MP3 size is :' mod='roanjamusicshop'} {$max_mp3_size}{l s='. - PLEASE NOTE THAT SOME BROWSERS DO NOT SUPPORT MP4/AAC, OGG, WAV MUSIC FORMATS' mod='roanjamusicshop'}
                     
                   </p>
                </div>
          </div>         
      </div>
      <!-- /.form-wrapper -->
      <div class="panel-footer">
        <a href="{$link->getAdminLink('AdminProducts')}" class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Cancel'|escape:'html' mod='prestamusicshop'}</a>
        <input type="hidden" name="submitMusic" id="submitMusic" value="1"/>
        <input type="hidden" name="id_product" id="productId" value="{$id_product|escape:'html'}"/>
        <input type="hidden" name="deleteroanjamusicshop" id="deleteroanjamusicshop" value=""/>
        <button type="submit" name="submitAddproduct" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Save'}</button>
        <button type="submit" name="submitAddproductAndStay" id="submitAddproductAndStayMusic" class="btn btn-default pull-right"><i class="process-icon-save"></i> {l s='Save and stay'}</button>
      </div>
   </div>
<script type="text/javascript">
  if (tabs_manager.allow_hide_other_languages)
    hideOtherLanguage({$default_language});
</script>
<script type="text/javascript">
  $(document).ready(function(){


  	$('.{$db_prefix}').find('.delete').attr('onclick','');

  	$('.{$db_prefix}rj_music_lang').find('.delete').on('click',function(e){
  		if (confirm('Delete this item?')){
  			e.preventDefault();
  			var delStr = $(this).prop('href');
  			var delStrSubstr1 = delStr.indexOf("&id=");
  			var delStrSubstr2 = delStr.indexOf("&del");
  			var linkToDelete = delStr.substring(delStrSubstr1+4, delStrSubstr2);
  			$('#deleteroanjamusicshop').val(linkToDelete);
  			$('#submitAddproductAndStayMusic').trigger('click');
  		}else{
  			e.preventDefault();
  		}
  	}) 
  })  
</script>
