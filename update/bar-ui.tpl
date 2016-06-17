<div id="barra" name="barra" class="sm2-bar-ui full-width fixed {$oculto}" data-ruta="{$modules_dir}">
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
  {if $id_url}<div class="sm2-inline-element sm2-button-element">
   <div class="sm2-button-bd">
	<a class="roanjayt youtube fancybox fancybox.iframe youtube sm2-inline-button" href="https://www.youtube.com/embed/{$id_url}" >
	 </a>
   </div>
  </div>{/if}
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
        <a id="playerSound100" href=""><b id="playerSoundTitle"></b><span class="label">Explicit</span></a>
       </div>
        <!--
       <div class="sm2-col">
        <a href="">Download this track</a>
       </div>
        -->
      </div>
     <!--<span class="label">{$valor.title|truncate:10}</span></a><button class="quitar-lista2">X</button></li>-->
     </li>
        {if !empty($lista)}
            {foreach $lista as $lis=>$valor}
                <li class="{$valor.id}" data-id="{$valor.id_music}">
                  <a href="{$modules_dir}roanjamusicshop/mp3/{$valor.name}">
                      <b>{$valor.name} - {$valor.title}</b>
                  </a>
                  <a class="quitar-lista2"><span><i class="fa fa-remove"></i></span></a>
                  <a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_{$valor.id}" href="{$link->getPageLink('cart')|escape:'html'}?qty=1&amp;id_product={$valor.id}&amp&amp;add" title="{l s='Add to cart' mod='homefeatured'}" data-id-product="{$valor.id}">&nbsp;&nbsp;
                  <span>{$valor.price|string_format:"%.2f"}&nbsp;&nbsp;<i class="fa fa-shopping-cart"></i></span>
                  </a>
                </li>
            {/foreach}
        {/if}
    </ul>
  </div>
 </div>
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
});</script>
