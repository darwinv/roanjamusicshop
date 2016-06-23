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
<div class="content-right-musicshop">

<ul>
  <li class="interior-release-chart-content-item">
    <span class="category">
      {l s='Title' mod='prestasmusicshop'}</span><span class="value">{$associated_mp3.0.mp3_title}</span></li>
  <li class="interior-release-chart-content-item">
    <span class="category">
      {l s='Artists' mod='prestasmusicshop'}</span><span class="value">{$associated_mp3.0.author}</span></li>
  <li class="interior-release-chart-content-item">
    <span class="category">
      {l s='Gender' mod='prestasmusicshop'}</span><span class="value">{$associated_mp3.0.genero}</span></li>
  <li>
    <span class="sm2-col buk-track-command">
      <a data-idmusic="{$associated_mp3.0.id_music}"data-idproduct="{$associated_mp3.0.id_product}" data-href="{$modules_dir}roanjamusicshop/mp3/{$associated_mp3.0.mp3_name}" class="sm2_button" title="{$associated_mp3.0.mp3_title}" data-youtube="{if !empty($associated_mp3.0.url_youtube)}{$associated_mp3.0.url_youtube}{/if}" ><div class="btn-rjm-list btn-action"><i class="fa fa-play" aria-hidden="true"></i></div>
      </a>
      <a class="{$associated_mp3.0.clase} playlist{$associated_mp3.0.id_music}" title="Agregar a lista" >
        <div class="btn-rjm-list btn-action"><i class="fa fa-list" aria-hidden="true"></i>
        </div>
      </a>
      {if !empty($associated_mp3.0.url_youtube)}
          <a class="youtube roanjayt fancybox fancybox.iframe"  title="Ver Video" href="https://www.youtube.com/embed/{$associated_mp3.0.url_youtube}?autoplay=1" >
            <div class="btn-rjm-list btn-youtube">
              <i class="fa fa-play" aria-hidden="true"></i>
            </div>
          </a>
      {else}
        <a class="youtube noYoutube">
          <div class="btn-rjm-list btn-youtube">
            <i class="fa fa-play" aria-hidden="true"></i>
          </div>
        </a>
      {/if}
    </span>
  </li>
</ul>
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
