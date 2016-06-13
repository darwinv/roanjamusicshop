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
  
<div class="sm2-bar-musicshop pos-init full-width">

 <div class="bd sm2-element">

  <div class="sm2-inline-texture">
   <div class="sm2-box-shadow"></div>
  </div>

  <!-- playlist content is mirrored here -->
  
  <div class="sm2-playlist-wrapper list-music-shop">
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
        
          <div class="sm2-inline-element buk-track-plus">
            <span>{counter}</span>

            <span class="sm2-col buk-track-command">
              <a data-id="{$items.id_product}" data-href="{$modules_dir}roanjamusicshop/mp3/{$items.mp3_name}" class="sm2_button" title="{$items.mp3_title}" data-youtube="{if !empty($items.url_youtube)}{$items.url_youtube}{/if}" ><div class="btn-rjm"><i class="fa fa-play" aria-hidden="true"></i></div>
              </a>
              <a class="agregar-lista" title="Agregar a lista" >
                <div class="btn-rjm"><i class="fa fa-list" aria-hidden="true"></i>
                </div>
              </a>
              {if !empty($items.url_youtube)}
               <a class="roanjayt fancybox fancybox.iframe"  title="Ver Video" href="https://www.youtube.com/embed/{$items.url_youtube}?autoplay=1" ><div class="btn-rjm"> <i class="fa fa-play" aria-hidden="true"></i></div></a>
              {/if}

              
            </span>
          </div>
          <div class="buk-track-meta-parent">
            <div class="sm2-inline-element buk-track-title">
              <a data-id="{$items.id_product}" data-href="{$modules_dir}roanjamusicshop/mp3/{$items.mp3_name}" class="sm2_button pointer" title="{$items.mp3_title}" data-youtube="{if !empty($items.url_youtube)}{$items.url_youtube}{/if}">
               <span class="list-titlesound"  ><b>{$items.mp3_title}</b></span> <b> {$items.author}</b>
              </a>
            </div>
            <div class="sm2-inline-element buk-track-artists">
              <b>{$items.author}</b>
            </div>
            <div class="sm2-inline-element buk-track-genre">
              <b>{$items.genero}</b>
            </div>
            <div class="sm2-inline-element buk-track-cash">
                {if $items.reduction_type == 'amount'}
                  <span class="assoc_price">{convertPrice price=$items.price - $items.reduction}</span>
                {else}
                  <span class="assoc_price">{convertPrice price=$items.price - ($items.price * $items.reduction)}</span>
                {/if}
            <a href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$items.linked_digital_id|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$items.linked_digital_id|intval}" class="ajax_add_to_cart_button music_cart_add sm2-icon sm2-cart sm2-exclude">&msp;</a> 
           </div>
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


<style type="text/css">
.sm2-bar-musicshop > .bd {
 width: 80%;
 margin: auto;
}
.sm2-bar-musicshop {
 position: absolute;
 display: inline-block;
 width: 100%;
 font-family: helvetica, arial, verdana, sans-serif;
 font-weight: normal;
 /* prevent background border bleed */
 -webkit-background-clip: padding-box;
 background-clip: padding-box;
 /* because indeed, fonts do look pretty "fat" otherwise in this case. */
 -moz-osx-font-smoothing: grayscale;
 -webkit-font-smoothing: antialiased;
 /* general font niceness? */
 font-smoothing: antialiased;
 text-rendering: optimizeLegibility;
 min-width: 20em;
 max-width: 30em;
 /* take out overflow if you want an absolutely-positioned playlist dropdown. */
 border-radius: 2px;
 overflow: hidden;
 /* just for fun (animate normal / full-width) */
 transition: max-width 0.2s ease-in-out;
 text-align: left
}

.sm2-bar-musicshop .sm2-playlist li {
 text-align: center;
 margin-top: -2px;
 font-size: 95%;
 line-height: 1em;
}

.sm2-bar-musicshop.compact {
 min-width: 1em;
 max-width: 15em;
}

.sm2-bar-musicshop ul {
 line-height: 1em;
}

/* want things left-aligned? */
.sm2-bar-musicshop.left .sm2-playlist li {
 text-align: left;
}

.sm2-bar-musicshop .sm2-playlist li .load-error {
  cursor: help;
}

.sm2-bar-musicshop.full-width {
 max-width: 100%;
 z-index: 5;
}

.sm2-bar-musicshop.fixed {
 position: fixed;
 top: auto;
 bottom: 0px;
 left: 0px;
 border-radius: 0px;
 /* so the absolutely-positioned playlist can show... */
 overflow: visible;
 /* and this should probably have a high z-index. tweak as needed. */
 z-index: 999;
}

.sm2-bar-musicshop.fixed .bd,
.sm2-bar-musicshop.bottom .bd {
 /* display: table; */
 border-radius: 0px;
 border-bottom: none;
}

.sm2-bar-musicshop.bottom {
 /* absolute bottom-aligned UI */
 top: auto;
 bottom: 0px;
 left: 0px;
 border-radius: 0px;
 /* so the absolutely-positioned playlist can show... */
 overflow: visible;
}

.sm2-bar-musicshop.playlist-open .bd {
 border-bottom-left-radius: 0px;
 border-bottom-right-radius: 0px;
 border-bottom-color: transparent;
}

.sm2-bar-musicshop .bd,
.sm2-bar-musicshop .sm2-extra-controls {
 position: relative;
 background-color: #232E35;
 /*
 transition: background 0.2s ease-in-out;
 */
}



.sm2-bar-musicshop .sm2-inline-gradient {
 /* gradient */
 position: absolute;
 left: 0px;
 top: 0px;
 width: 100%;
 height: 100%;
 background-image: -moz-linear-gradient(to bottom, rgba(255,255,255,0.125) 5%, rgba(255,255,255,0.125) 45%, rgba(255,255,255,0.15) 52%, rgba(0,0,0,0.01) 51%, rgba(0,0,0,0.1) 95%); /* W3C */
 background-image: linear-gradient(to bottom, rgba(255,255,255,0.125) 5%, rgba(255,255,255,0.125) 45%, rgba(255,255,255,0.15) 50%, rgba(0,0,0,0.1) 51%, rgba(0,0,0,0.1) 95%); /* W3C */
}

.sm2-bar-musicshop.flat .sm2-inline-gradient {
 background-image: none;
}

.sm2-bar-musicshop.flat .sm2-box-shadow {
 display: none;
 box-shadow: none;
}

.sm2-bar-musicshop.no-volume .sm2-volume {
 /* mobile devices (android + iOS) ignore attempts to set volume. */
 display: none;
}

.sm2-bar-musicshop.textured .sm2-inline-texture {
 position: absolute;
 top: 0px;
 left: 0px;
 width: 100%;
 height: 100%;
 /* for example */
 /* background-image: url(../image/wood_pattern_dark.png); */
 /* additional opacity effects can be applied here. */
 opacity: 0.75;

}

.sm2-bar-musicshop.textured.dark-text .sm2-inline-texture {
 /* dark text + textured case: use light wood background (for example.) */
 /* background-image: url(../image/patterns/wood_pattern.png); */
}

.sm2-bar-musicshop.textured.dark-text .sm2-playlist-wrapper {
 /* dark text + textured case: ditch 10% dark on playlist body. */
 background-color: transparent;
}

.sm2-bar-musicshop.textured.dark-text .sm2-playlist-wrapper ul li:hover a,
.sm2-bar-musicshop.textured.dark-text .sm2-playlist-wrapper ul li.selected a {
 /* dark + textured case: dark highlights */
 background-color: rgba(0,0,0,0.1);
 background-image: url(../image/black-10.png);
 /* modern browsers don't neeed the image */
 background-image: none, none;
}

.sm2-bar-musicshop .bd {
 display: table;
 border-bottom: none;
}

.sm2-bar-musicshop .sm2-playlist-wrapper {
 background-color: rgba(0,0,0,0.1);
}

.sm2-bar-musicshop .sm2-extra-controls .bd {
 background-color: rgba(0,0,0,0.2);
}


.sm2-bar-musicshop.textured .sm2-extra-controls .bd {
 /* lighten extra color overlays */
 background-color: rgba(0,0,0,0.05);
}

.sm2-bar-musicshop .sm2-extra-controls {
 background-color: transparent;
 border: none;
}

.sm2-bar-musicshop .sm2-extra-controls .bd {
 /* override full-width table behaviour */
 display: block;
 border: none;
}

.sm2-bar-musicshop .sm2-extra-controls .sm2-inline-element {
 display: inline-block;
}

.sm2-bar-musicshop,
.sm2-bar-musicshop .bd a {
 color: #fff;
}

.sm2-bar-musicshop.dark-text,
.sm2-bar-musicshop.dark-text .bd a {
 color: #000;
}


/* --- full width stuff --- */


.content-bar-musicshop .sm2-inline-element {
 display: table-cell;
}

.content-bar-musicshop .sm2-inline-element {
 /* collapse */
 width: 1%;
}
.content-bar-musicshop .sm2-extra-controls .sm2-inline-element {
 width: 25px; /* bare minimum */
 min-height: 1.75em;
 min-width: 2.5em;
}

.content-bar-musicshop .sm2-inline-status {
 line-height: 100%;
 /* how much to allow before truncating song artist / title with ellipsis */
 display: inline-block;
 min-width: 200px;
 max-width: 20em;
 /* a little more spacing */
 padding-left: 0.75em;
 padding-right: 0.75em;
}
.content-bar-musicshop .sm2-inline-element,
.content-bar-musicshop .sm2-button-element .sm2-button-bd {
 /**
  * if you play with UI width/height, these are the important ones.
  * NOTE: match these values if you want square UI buttons.
  */
 min-width: 2.8em;
 min-height: 2.8em;
}
.content-bar-musicshop .sm2-extra-controls .sm2-inline-element {
 display: inline-block;
}
.content-bar-musicshop .sm2-inline-element {
 position: relative;
 display: inline-block;
 vertical-align: middle;
 padding: 10px;
 overflow: hidden;
}

.content-bar-musicshop .sm2-inline-element,
.content-bar-musicshop .sm2-button-element .sm2-button-bd {
 position: relative;
 /**
  * .sm2-button-bd exists because of a Firefox bug from 2000
  * re: nested relative / absolute elements inside table cells.
  * https://bugzilla.mozilla.org/show_bug.cgi?id=63895
  */
}
.content-bar-musicshop .sm2-inline-element {
 /* extra-small em scales up nicely, vs. 1px which gets fat */
 border-right: 0.075em dotted #666; /* legacy */
 border-right: 0.075em solid rgba(0,0,0,0.1);
}

.content-bar-musicshop .sm2-inline-element.noborder {
 border-right: none;
}

.content-bar-musicshop .sm2-inline-element.compact {
 min-width: 2em;
 padding: 10px 0.25em;
}

.content-bar-musicshop .sm2-inline-element:first-of-type {
 border-top-left-radius: 3px;
 border-bottom-left-radius: 3px;
 overflow: hidden;
}

.content-bar-musicshop .sm2-inline-element:last-of-type {
 border-right: none;
 border-top-right-radius: 3px;
 border-bottom-right-radius: 3px;
}








      .list-music-shop .bucket-track-header-meta, .list-music-shop .buk-track-meta-parent {
          margin-left: 150px;
      }
      .list-music-shop .buk-track-plus {
        width: 150px;
        float: left;
      }
      .list-music-shop .buk-track-command {
        width: 55px;
        float: right;
      }
      .list-music-shop .bd.sm2-main-controls {
          display: block;
      }             
      .list-music-shop .buk-track-title {
          width: 30%;
      }
      .list-music-shop .buk-track-artists {
          width: 20%;
      }
      .list-music-shop .buk-track-genre {
          width: 20%;
      }
      .list-music-shop .buk-track-cash {
          width: 20%;
      }
      .list-music-shop .sm2-inline-element, .list-music-shop  .sm2-playlist-wrapper ul li .sm2-col  {
          display: inline-block;
       }
      .list-music-shop .sm2-main-controls, .list-music-shop .bucket-track-header-meta {
          padding-left: 10px;
          padding-right: 10px;
      }
      .list-music-shop span.sm2-col.buk-track-command > a {
          padding: 0px;
          display: inline-block;
      }
      .list-music-shop span.sm2-col.buk-track-command > a > div{
          width: 100%;
      }
      .list-music-shop span.sm2-col.buk-track-command {
        width: 90px;
      }
      .pointer{
        cursor: pointer;
      }
</style>
