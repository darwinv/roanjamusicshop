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
<div class="btn-bar-rjm">

	<a data-id="{$id_product}" data-href="{$modules_dir}roanjamusicshop/mp3/{$mp3_name}"class="sm2_button" title="{$mp3_title}"><div class="btn-rjm"><i class="fa fa-play" aria-hidden="true"></i></div>
	</a>

	<a class="{$clase}" title="Agregar a lista" ><div class="btn-rjm"><i class="fa fa-list" aria-hidden="true"></i></div>
	</a>

	{if !empty($url_youtube)}
	<a class="roanjayt fancybox fancybox.iframe"  title="Ver Video" href="https://www.youtube.com/embed/{$url_youtube}?autoplay=1" ><div class="btn-rjm">
		<i class="fa fa-play" aria-hidden="true"></i> </div></a>
	{/if}

<a title="Precio" >
	<div class="btn-rjm" id="pricerjm">{$precio}</div>
</a>

</div>
<script type="text/javascript">
$(document).ready(function() {
	$(".roanjayt").fancybox({
		maxWidth	: 800,
		maxHeight	: 600,
		fitToView	: false,
		width		: '70%',
		height		: '70%',
		autoSize	: false,
		closeClick	: false,
		openEffect	: 'none',
		closeEffect	: 'none'
	});
});
$(window).ready(function(){
          $('.content_price').addClass('hidden');
  });
</script>
