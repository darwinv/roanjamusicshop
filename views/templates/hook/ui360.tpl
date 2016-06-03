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
{foreach from=$associated_mp3 item=items}


<div class="ui360 ui360-vis" style="background-image: none;">
	<div class="sm2-360ui">
		<canvas class="sm2-canvas hi-dpi" width="50" height="50"></canvas> 
		<span class="sm2-360btn sm2-360btn-default"></span> 
		<div class="sm2-timing alignTweak"></div> 
		<div class="sm2-cover"></div>
	</div>
	<a href="{$modules_dir}prestamusicshop/mp3/{$items.mp3_name}" class="sm2_link">{$items.mp3_title|truncate:10}</a>
</div>

{/foreach}
{/if}