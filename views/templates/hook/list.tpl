{*
* 2007-2015 PrestaShop
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
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<div class="panel"><h3><i class="icon-list-ul"></i> {l s='Music list' mod='roanjamusicshop'}
	</h3>
	<div id="musicsContent" data-urlaux='{$link->getAdminLink('AdminModules')}&id_product={$id_product}'>
		<div id="musics">
			{foreach from=$musics item=music}
				<div id="musics_{$music.id_music}" class="panel portlet">
					<div class="row">
						<div class="col-lg-1 sortable-header">
							<span><i class="icon-arrows"></i></span>
						</div>
						<div class="col-md-3">
							<audio controls>
							  <source src="{$music_baseurl}{$music.mp3_name}" type="audio/mpeg">
							</audio>
						</div>

							<div class="btn-group-action pull-right">
								{$music.status}
								<!-- <a class="btn btn-default"
									href="{$link->getAdminLink('AdminModules')}&id_product={$id_product}&configure=roanjamusicshop&changeStatus&id_mp3={$music.id_music}">
									<i class="icon-edit"></i>
									{l s='Edit' mod='roanjamusicshop'}
								</a> -->
								{*<button type="submit" name="deleteroanjamusicshop" class="btn btn-danger"><i class="icon-trash"></i> {l s='Delete' mod='roanjamusicshop'}</button>*}
								<a class="btn btn-default"
									href="{$link->getAdminLink('AdminModules')}&id_product={$id_product}&configure=roanjamusicshop&deleteroanjamusicshop={$music.id_music}">
									<i class="icon-trash"></i>
									{l s='Delete' mod='roanjamusicshop'}
								</a>
							</div>
					</div>
						<div class="row">
							<div class="">
								<h4 class="pull-left">
	<div class="col-md-4">
		{l s='Music Title' mod='roanjamusicshop'}	:
		 <input type="text" name="cancion" class="nomb_cancion_{$music.id_music}" value="{$music.mp3_title}" >
	 </div>
	 <div class="col-md-4">
		{l s='Author' mod='roanjamusicshop'}:
		<input type="text" name="autor" class="nomb_autor_{$music.id_music}" value="{$music.author}" >
		</div>
		<div class="col-md-4">
						{l s='Genre' mod='roanjamusicshop'} :
						 <input type="text" name="genero" class="nomb_genero_{$music.id_music}" value="{$music.genero}" >
		</div>
									{if $music.is_shared}
										<div>
											<span class="label color_field pull-left" style="background-color:#108510;color:white;margin-top:5px;">
												{l s='Shared music' mod='roanjamusicshop'}
											</span>
										</div>
									{/if}
								</h4>
							</div>
						</div>
<div class="row">
	<div class="col-md-1 pull-right">
<a class="btn btn-default update-nombres" data-idcancion="{$music.id_music}">
	<i class="icon-save"></i>&nbsp;{l s='Save' mod='roanjamusicshop'} </a>
	</div>
</div>
				</div>
			{/foreach}
		</div>
	</div>
</div>
<script type="text/javascript" src="{$pc_base_dir}views/js/update-music-songs.js"></script>
