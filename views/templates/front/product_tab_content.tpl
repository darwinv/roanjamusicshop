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
<script src='{$modules_dir}prestamusicshop/js/soundmanager2en.js' type='text/javascript'></script>
{if !isset($priceDisplayPrecision)}
		{assign var='priceDisplayPrecision' value=2}
{/if}
{if !$priceDisplay || $priceDisplay == 2}
    {assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
    {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
{elseif $priceDisplay == 1}
    {assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
    {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
{/if}
<script>
function checkIfIncluded(file) {
    var links = document.getElementsByTagName("link");
    for(var i = 0; i < links.length; i++) {
        if (links[i].href.substr(-file.length) == file)
            return true;
    }

    var scripts = document.getElementsByTagName("script");
    for(var i = 0; i < scripts.length; i++) {
        if (scripts[i].src.substr(-file.length) == file)
            return true;
    }

    return false;
}
function loadjscssfile(filename, filetype){
 if (filetype=="js"){ //if filename is a external JavaScript file
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
 }
 else if (filetype=="css"){ //if filename is an external CSS file
  var fileref=document.createElement("link")
  fileref.setAttribute("rel", "stylesheet")
  fileref.setAttribute("type", "text/css")
  fileref.setAttribute("href", filename)
 }
 if (typeof fileref!="undefined")
  document.getElementsByTagName("head")[0].appendChild(fileref)
}
$(document).ready(function(){
	if(checkIfIncluded("soundmanager2.js")){
		$("script[src='soundmanager2en.js']").remove()
		loadjscssfile("{$modules_dir}prestamusicshop/css/mp3-player-button-tab.css", "css") //dynamically load and add this .css file
		loadjscssfile("{$modules_dir}prestamusicshop/js/mp3-player-button.js", "js") //dynamically load and add this .js file
	}else{
		//loadjscssfile("{$modules_dir}prestamusicshop/js/soundmanager2.js", "js")
		loadjscssfile("{$modules_dir}prestamusicshop/css/mp3-player-button-tab.css", "css")
		loadjscssfile("{$modules_dir}prestamusicshop/js/mp3-player-button.js", "js")
	}
})
</script>
<h1>product_tab_content</h1>
<h3 id="" class="idTabHrefShort page-product-heading">{l s='TRACKS'}</h3>
{assign var="assoc_increment" value=1}
{foreach from=$associated_mp3 item=items}
    <p class="music_shop_item">
       	<a data-href="{$modules_dir}prestamusicshop/mp3/{$items.mp3_name}" title="{$items.author}-{$items.mp3_title}" class="sm2_button">{$items.author}-{$items.mp3_title}</a>
        <span class="music_title">{$assoc_increment}. {$items.author}-{$items.mp3_title}</span>
        <a class="button ajax_add_to_cart_button music_cart_add btn btn-default" href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$items.linked_digital_id|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$items.linked_digital_id|intval}">
            <span>{l s='Add to cart'}</span>
        </a>
        {if $items.reduction_type == 'amount'}
        	<span class="assoc_price">{convertPrice price=$items.price - $items.reduction}Product_tab_content.tpl</span>
        {else}
        	<span class="assoc_price">{convertPrice price=$items.price - ($items.price * $items.reduction)}</span>
        {/if}
    </p>
{$assoc_increment = $assoc_increment + 1}
{/foreach}

{foreach from=$product_mp3 item=items}
    <p class="music_shop_item">
    	<a data-href="{$modules_dir}prestamusicshop/mp3/{$items.mp3_name}" title="{$items.author}-{$items.mp3_title}" class="sm2_button">{$items.author}-{$items.mp3_title}</a>
        <span class="music_title">{$assoc_increment}. {$items.author}-{$items.mp3_title}</span>
        <a class="button ajax_add_to_cart_button music_cart_add btn btn-default" href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$items.product_id|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$items.product_id|intval}">
            <span>{l s='Add to cart'}</span>
        </a>
        <span class="our_price_display" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
            {if $product->quantity > 0}<link itemprop="availability" href="http://schema.org/InStock"/>{/if}
            {if $priceDisplay >= 0 && $priceDisplay <= 2}
                <span id="our_price_display_music" itemprop="price">{convertPrice price=$productPrice}</span>
                <!--{if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                    {if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}
                {/if}-->
                <meta itemprop="priceCurrency" content="{$currency->iso_code}" />
                {hook h="displayProductPriceBlock" product=$product type="price"}
            {/if}
        </span>
    </p>
{$assoc_increment = $assoc_increment + 1}
{/foreach}