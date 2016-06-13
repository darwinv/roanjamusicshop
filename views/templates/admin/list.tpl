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
	<span class="panel-heading-action">
		<a id="desc-product-new" class="list-toolbar-btn" href="{$link->getAdminLink('AdminProducts')}&configure=roanjamusicshop&addMusic=1">
			<span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="{l s='Add new' mod='roanjamusicshop'}" data-html="true">
				<i class="process-icon-new "></i>
			</span>
		</a>
	</span>
	</h3>
	<div id="musicsContent">
		<div id="musics">
			{foreach from=$musics item=music}
				<div id="musics_{$music.id_music}" class="panel">
					<div class="row">
						<div class="col-lg-1">
							<span><i class="icon-arrows "></i></span>
						</div>
						<div class="col-md-3">
							<audio controls>							  
							  <source src="{$music_baseurl}{$music.mp3_name}" type="audio/mpeg">							
							</audio>							
						</div>
						<div class="col-md-8">
							<h4 class="pull-left">
								#{$music.id_music} - {$music.mp3_title}
								{if $music.is_shared}
									<div>
										<span class="label color_field pull-left" style="background-color:#108510;color:white;margin-top:5px;">
											{l s='Shared music' mod='roanjamusicshop'}
										</span>
									</div>
								{/if}
							</h4>
							<div class="btn-group-action pull-right">
								{$music.status}

								<a class="btn btn-default"
									href="{$link->getAdminLink('AdminProducts')}&configure=roanjamusicshop&id_music={$music.id_music}">									
									<i class="icon-edit"></i>
									{l s='Edit' mod='roanjamusicshop'}
								</a>
								<a class="btn btn-default"
									href="{$currentIndex|escape:'html':'UTF-8'}&amp;delete=true&amp;updateproduct&amp;token={$token|escape:'html':'UTF-8'}&amp;id_product={$product->id}">
									<i class="icon-trash"></i>
									{l s='Delete' mod='roanjamusicshop'}
								</a>
							</div>
						</div>
					</div>
				</div>
			{/foreach}
		</div>
	</div>
</div>
