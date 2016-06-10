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

<div class="content-bar-musicshop">

  
<div class="sm2-bar-ui playlist-open pos-init full-width">

 <div class="bd sm2-playlist-drawer sm2-element">

  <div class="sm2-inline-texture">
   <div class="sm2-box-shadow"></div>
  </div>

  <!-- playlist content is mirrored here -->


<style type="text/css">
      .bucket-track-header-meta {
          margin-left: 50px;
      }      
      .bd.sm2-main-controls {
          display: block;
      }
      .buk-track-title {
          width: 30% !important;
      }
      .buk-track-plus {
          width: 35px !important;
          float: left;
      }

      .buk-track-artists {
          width: 20% !important;
      }
      .buk-track-genre {
          width: 20% !important;
      }
      .buk-track-cash {
          width: 20% !important;
      }


      .sm2-bar-ui .sm2-inline-element,  .sm2-playlist-wrapper ul li .sm2-col  {
          display: inline-block !important;
      }
</style>


  
  <div class="sm2-playlist-wrapper">
    <div class="bd sm2-main-controls">
      <div class="bucket-track-header-meta">
        <p class="sm2-inline-element buk-track-title">Título</p>
        <p class="sm2-inline-element buk-track-artists">Artistas</p>
        <p class="sm2-inline-element buk-track-genre">Género</p>
        <p class="sm2-inline-element buk-track-cash"></p>
      </div>
    </div>
    <ul class="sm2-playlist-bd">
    {counter start=0 skip=1 print=false}
    {foreach from=$associated_mp3 item=items}
       <li>
        <div class="sm2-row">
          <div class="sm2-col buk-track-plus">
            <span>{counter}</span>
          </div>
          <div class="buk-track-meta-parent">
            <div class="sm2-col buk-track-title">
              <i class="fa fa-play" aria-hidden="true"></i>
              <i class="fa fa-list" aria-hidden="true"></i>
              <i class="fa fa-play" aria-hidden="true"></i>          
              <a href="{$modules_dir}roanjamusicshop/mp3/{$items.mp3_name}">
                <b>{$items.mp3_title} {$items.author}</b>
              </a>
            </div>
            <div class="sm2-col buk-track-artists">       
              <b>{$items.author}</b>
            </div>
            <div class="sm2-col buk-track-genre">       
              <b>{$items.genero}</b>
            </div>
            <div class="sm2-col buk-track-cash">
                {if $items.reduction_type == 'amount'}
                  <span class="assoc_price">{convertPrice price=$items.price - $items.reduction}</span>
                {else}
                  <span class="assoc_price">{convertPrice price=$items.price - ($items.price * $items.reduction)}</span>
                {/if}
            <a href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$items.linked_digital_id|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$items.linked_digital_id|intval}" class="ajax_add_to_cart_button music_cart_add sm2-icon sm2-cart sm2-exclude">&msp;</a> 
           </div>
          </div>          
      </li>
      
    {/foreach}

    </ul>
  
  </div>

  <div class="sm2-extra-controls">

   <div class="bd">

    <div class="sm2-inline-element sm2-button-element hide">
     <a href="#prev" title="Previous" class="sm2-inline-button previous">&lt; previous</a>
    </div>

    <div class="sm2-inline-element sm2-button-element hide">
     <a href="#next" title="Next" class="sm2-inline-button next">&gt; next</a>
    </div>

    <!-- not implemented -->
    <!--
    <div class="sm2-inline-element sm2-button-element disabled">
     <div class="sm2-button-bd">
      <a href="#repeat" title="Repeat playlist" class="sm2-inline-button repeat">&infin; repeat</a>
     </div>
    </div>

    <div class="sm2-inline-element sm2-button-element disabled">
     <a href="#shuffle" title="Shuffle" class="sm2-inline-button shuffle">shuffle</a>
    </div>
    -->

   </div>

  </div>

 </div>

</div>


</div>
<script type="text/javascript">
$(document).ready(function() {
  $(".roanjayt").fancybox({
    maxWidth  : 800,
    maxHeight : 600,
    fitToView : false,
    width   : '70%',
    height    : '70%',
    autoSize  : false,
    closeClick  : false,
    openEffect  : 'none',
    closeEffect : 'none'
  });
});</script>