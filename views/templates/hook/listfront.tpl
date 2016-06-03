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

{if $associated_mp3}
<div class="sm2-bar-ui">
  <div class="bd sm2-main-controls">
    <div class="sm2-inline-texture"></div>
    <div class="sm2-inline-gradient"></div>
    <div class="sm2-inline-element sm2-button-element">
      <div class="sm2-button-bd"> <a href="#play" class="sm2-inline-button play-pause">{l s='Play / pause' mod='prestasmusicshop'}</a> </div>
    </div>
    <div class="sm2-inline-element sm2-inline-status">
      <div class="sm2-playlist">
        <div class="sm2-playlist-target"> 
          <!-- playlist <ul> + <li> markup will be injected here --> 
          <!-- if you want default / non-JS content, you can put that here. -->
          <noscript>
          <p>{l s='JavaScript is required.' mod='prestasmusicshop'}</p>
          </noscript>
        </div>
      </div>
      <div class="sm2-progress">
        <div class="sm2-row">
          <div class="sm2-inline-time">0:00</div>
          <div class="sm2-progress-bd">
            <div class="sm2-progress-track">
              <div class="sm2-progress-bar"></div>
              <div class="sm2-progress-ball">
                <div class="icon-overlay"></div>
              </div>
            </div>
          </div>
          <div class="sm2-inline-duration">0:00</div>
        </div>
      </div>
    </div>
    <div class="sm2-inline-element sm2-button-element sm2-volume">
      <div class="sm2-button-bd"> 
        <span class="sm2-inline-button sm2-volume-control volume-shade"></span> 
        <a href="#volume" class="sm2-inline-button sm2-volume-control">{l s='volumen' mod='prestasmusicshop'}</a> 
      </div>
    </div>
    <div class="sm2-inline-element sm2-button-element sm2-menu">
      <div class="sm2-button-bd"> 
        <a href="#menu" class="sm2-inline-button menu">{l s='menu' mod='prestasmusicshop'}</a> 
      </div>
    </div>
  </div>
  <div class="bd sm2-playlist-drawer sm2-element">
    <div class="sm2-inline-texture">
      <div class="sm2-box-shadow"></div>
    </div>    
    <!-- playlist content is mirrored here -->    
    <div class="sm2-playlist-wrapper">
      <ul class="sm2-playlist-bd">        
        <!-- example: playable link, "buy" link, "download" link -->        
        {foreach from=$associated_mp3 item=items}
          <li>
            <div class="sm2-row">
              <div class="sm2-col sm2-wide"> 
                <a data-href="{$modules_dir}prestamusicshop/mp3/{$items.mp3_name}" title="{$items.author}-{$items.mp3_title}" class="exclude button-exclude inline-exclude">
                  <b>{$items.mp3_title|truncate:10}</b> - {$items.author|truncate:10}
                  
                    {if $items.reduction_type == 'amount'}
                      <span title="{$items.author|truncate:10}" class="label">{convertPrice price=$items.price - $items.reduction}</span>
                    {else}
                      <span title="{$items.author|truncate:10}" class="label">{convertPrice price=$items.price - ($items.price * $items.reduction)}{l s='tax excl.'}</span>
                    {/if}
                  {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                    {if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}
                {/if}
                </a> 
              </div>
              <div class="sm2-col"> 
                <a href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$items.linked_digital_id|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="ajax_id_product_{$items.linked_digital_id|intval}" title="{l s='Add to cart'}" data-id-product="{$items.linked_digital_id|intval}" class="button ajax_add_to_cart_button sm2-icon sm2-cart">{l s='Add to cart'}</a> 
              </div>
            </div>
          </li>        
        {/foreach}
      </ul>
    </div>    
  </div>
</div>
{/if}

