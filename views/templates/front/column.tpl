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

{*if !isset($priceDisplayPrecision)}
		{assign var='priceDisplayPrecision' value=2}
{/if}
{if !$priceDisplay || $priceDisplay == 2}
    {assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
    {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
{elseif $priceDisplay == 1}
    {assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
    {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
{/if*}

<h1>column.tpl</h1>
{assign var="assoc_increment" value=1}
{foreach from=$associated_mp3 item=items}
    <p class="music_shop_item">
    	<a data-href="{$modules_dir}roanjamusicshop/mp3/{$items.mp3_name}" title="{$items.author}-{$items.mp3_title}" class="sm2_button" data-place="preview">{$items.author}-{$items.mp3_title}</a>
        <span class="music_title">{$assoc_increment}. {$items.author|truncate:15}-{$items.mp3_title|truncate:15}</span>
        <a class="button ajax_add_to_cart_button music_cart_add btn btn-default" href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$items.linked_digital_id|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$items.linked_digital_id|intval}">
            <span>{l s='Add to cart'}</span>
        </a>
        {if $items.reduction_type == 'amount'}
        	<span class="assoc_price">{convertPrice price=$items.price - $items.reduction}</span>
        {else}
        	<span class="assoc_price">{convertPrice price=$items.price - ($items.price * $items.reduction)}</span>
        {/if}
    </p>
{$assoc_increment = $assoc_increment + 1}
{/foreach}
<div id="barra2" name="barra2" class="sm2-bar-ui full-width fixed hidden" data-ruta="{$modules_dir}">
 <div class="bd sm2-main-controls">
  <div class="sm2-inline-texture"></div>
  <div class="sm2-inline-gradient"></div>
  <div class="sm2-inline-element sm2-button-element">
   <div class="sm2-button-bd">
    <a id="playSound" href="#play" class="sm2-inline-button play-pause">Play / pause</a>
   </div>
  </div>
  <div class="sm2-inline-element sm2-inline-status">
   <div class="sm2-playlist">
    <div class="sm2-playlist-target"><ul class="sm2-playlist-bd"><li><b>Title</b> - LA<span class="label">Explicit</span></li></ul></div>
   </div>
   <div class="sm2-progress">
    <div class="sm2-row">
    <div class="sm2-inline-time">0:00</div>
     <div class="sm2-progress-bd">
      <div class="sm2-progress-track">
       <div class="sm2-progress-bar"></div>
       <div class="sm2-progress-ball"><div class="icon-overlay"></div></div>
      </div>
     </div>
     <div class="sm2-inline-duration">0:00</div>
    </div>
   </div>
  </div>
  <div class="sm2-inline-element sm2-button-element sm2-volume">
   <div class="sm2-button-bd">
    <span class="sm2-inline-button sm2-volume-control volume-shade"></span>
    <a href="#volume" class="sm2-inline-button sm2-volume-control">volume</a>
   </div>
  </div>
  <div class="sm2-inline-element sm2-button-element">
   <div class="sm2-button-bd">
    <a href="#prev" title="Previous" class="sm2-inline-button previous">&lt; previous</a>
   </div>
  </div>
  <div class="sm2-inline-element sm2-button-element">
   <div class="sm2-button-bd">
    <a href="#next" title="Next" class="sm2-inline-button next">&gt; next</a>
   </div>
  </div>
  <div class="sm2-inline-element sm2-button-element">
   <div class="sm2-button-bd">
    <a href="#repeat" title="Repeat playlist" class="sm2-inline-button repeat">∞ repeat</a>
   </div>
  </div>
  <!-- not implemented -->
  <!--
  <div class="sm2-inline-element sm2-button-element disabled">
   <div class="sm2-button-bd">
    <a href="#shuffle" title="Shuffle" class="sm2-inline-button shuffle">shuffle</a>
   </div>
  </div>
  -->
  <div class="sm2-inline-element sm2-button-element sm2-menu">
   <div class="sm2-button-bd">
    <a href="#menu" class="sm2-inline-button menu">menu</a>
   </div>
  </div>
 </div>
 <div class="bd sm2-playlist-drawer sm2-element">
  <!--
  <div class="sm2-inline-texture">
   <div class="sm2-box-shadow"></div>
  </div>
  -->
  <!-- playlist content is mirrored here -->
  <div class="sm2-playlist-wrapper">
    <ul class="sm2-playlist-bd">
     <!-- item with "download" link -->
     <li class="selected">
      <div class="sm2-row">
       <div class="sm2-col sm2-wide">
        <a id="playerSound100-2" href=""><b id="playerSoundTitle-2"></b><span class="label">Explicit</span></a>
       </div>
        <!--
       <div class="sm2-col">
        <a href="">Download this track</a>
       </div>
        -->
      </div>
     <!--<span class="label">{$valor.title|truncate:10}</span></a><button class="quitar-lista2">X</button></li>-->
     </li>
    </ul>  
  </div>
 </div>
</div>