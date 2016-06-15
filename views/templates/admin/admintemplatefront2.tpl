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
<div id="product-roanjamusicshop" class="panel product-tab">
    <input type="hidden" name="submitted_tabs[]" value="roanjamusicshop"/>
    <div class="panel-heading">
        <h3><i class="icon-cogs"></i> {l s='Add your own MP3 file and Name' mod='roanjamusicshop'}</h3>
    </div>
    <div class="form-group">
			<label class="control-label col-lg-2" for="mp3_title_{$default_language}">				
					{l s='Titulo'  mod='roanjamusicshop'}		
			</label>
			<div class="col-lg-9">
				{include file="controllers/products/input_text_lang.tpl"
					languages=$languages
					input_name='mp3_title'
          input_value=''}
			</div>
		</div>

		
	  <!-- /.form-wrapper -->
    <div class="panel-footer">
        <a href="{$link->getAdminLink('AdminProducts')}" class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Cancel'|escape:'html' mod='roanjamusicshop'}</a>
         <input type="hidden" name="id_music" value=""/>
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
  	
  	$('.{$db_prefix}rj_music_lang').find('.delete').attr('onclick','');

  	$('.{$db_prefix}rj_music_lang').find('.delete').on('click',function(e){
  		if (confirm('Delete this item?')){
  			e.preventDefault();
  			var delStr = $(this).prop('href');
  			var delStrSubstr1 = delStr.indexOf("&id=");
  			var delStrSubstr2 = delStr.indexOf("&del");
  			var linkToDelete = delStr.substring(delStrSubstr1+4, delStrSubstr2);
  			$('#delete_id_music').val(linkToDelete);
  			$('#submitAddproductAndStayMusic').trigger('click');
  		}else{
  			e.preventDefault();
  		}
  	})
  	 
  })
  
</script>