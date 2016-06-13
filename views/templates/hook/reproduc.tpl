<script>
	function playerMusic(parm1, parm2){
		 document.getElementById("playerSound100").href = "{$modules_dir}prestamusicshop/mp3/"+ parm1;
		 document.getElementById("playerSoundTitle").innerHTML = parm2;
		 window.sm2BarPlayers[0].actions.play();
	}
</script>  
<section class="player-container player-section zero-state">
  <span class="zero-track">
    <svg viewBox="0 0 200 200" class="player-zero-music-icon">
      <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-music"></use>
    </svg>
    <p class="zero-track-message">No hay nada en el reproductor. Elige una pista y escúchala o agrégala a la cola para empezar.</p>
  </span>
  <div class="player-current-track-container">
    <a href="https://pro.beatport.com/track/plastic-dreams-hoxton-whores-hxtn-remix/6946438" class="track-artwork-link">
      <img class="track-artwork" src="https://geo-media.beatport.com/image_size/45x45/12040424.jpg">
    </a>
    <div class="player-track-name-artist player-track-name-artist-standard">
      <span class="track-title">
        <a href="https://pro.beatport.com/track/plastic-dreams-hoxton-whores-hxtn-remix/6946438" class="track-artwork-link"><span class="primary-title">Plastic Dreams</span> <span class="remixed">Hoxton Whores, HXTN Remix</span></a>
      </span>
      <span class="track-artist"><a href="/artist/jaydee/7632">Jaydee</a></span>
    </div>
    <marquee class="player-track-name-artist player-track-name-artist-marquee"><span class="track-title"><a href="https://pro.beatport.com/track/plastic-dreams-hoxton-whores-hxtn-remix/6946438" class="track-artwork-link"><span class="primary-title">Plastic Dreams</span> <span class="remixed">Hoxton Whores, HXTN Remix</span></a></span><span class="track-artist"><a href="/artist/jaydee/7632">Jaydee</a></span></marquee>
    <div class="info-button-parent">
      <a href="#" class="track-info-button">INFO</a>
      <!-- Info Drop Down -->
      <div class="info-drop">
        <ul class="info">
  <li>
    <span class="category">artists</span>
    <span class="value"><a href="/artist/jaydee/7632">Jaydee</a></span>
  </li>

  <li>
    <span class="category">genres</span>
    <span class="value">Tech House</span>
  </li>

  <li>
    <span class="category">label</span>
    <span class="value">Whore House</span>
  </li>

  <li>
    <span class="category">released</span>
    <span class="value">2015-08-27</span>
  </li>

  <li>
    <span class="category">bpm</span>
    <span class="value">124</span>
  </li>

  <li>
    <span class="category">key</span>
    <span class="value">C min</span>
  </li>

  <li>
    <span class="category">length</span>
    <span class="value">8:39</span>
  </li>
</ul>
        <div class="player-share-links">
          <a href="#" class="player-share-link twitter">
            <svg viewBox="0 0 200 200" class="player-twitter-icon">
              <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-twitter"></use>
            </svg>
          </a>
          <a href="#" class="player-share-link facebook">
            <svg viewBox="0 0 200 200" class="player-facebook-icon">
              <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-facebook"></use>
            </svg>
          </a>
        </div>
        <p class="launch-keyboard-shortcuts-link-parent">
          <a href="#" class="launch-keyboard-shortcuts-link">Ver el método abreviado del teclado<svg viewBox="0 0 200 200" class="keyboard-icon"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-keyboard"></use></svg></a>
        </p>
      </div>
      <!-- End Info Drop Down -->
    </div>
    <!-- End Info Button Parent -->
    <!--div class="share-button-parent">
      <a href="#" class="track-share-button">
        <svg viewBox="0 0 200 200" class="track-share-button-icon">
          <use xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-share"></use>
        </svg>
      </a>
      <!-- Share Drop Down -->
      <div class="share-drop" style="display: none;">
        <p class="player-share-links">
          <a href="#" class="player-share-link twitter">
            <svg viewBox="0 0 200 200" class="player-twitter-icon">
              <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-twitter"></use>
            </svg>Compartir en Twitter
          </a>
          <a href="#" class="player-share-link facebook">
            <svg viewBox="0 0 200 200" class="player-facebook-icon">
              <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-facebook"></use>
            </svg>Compartir en Facebook
          </a>
        </p>
      </div>
      <!-- End Share Drop Down -->
    
    <!-- End Share Button Parent -->
    <div class="stem-button-parent">
      <a href="#">
        <img src="/static/c571365566ef78fe5b91a6612e90e7f38d6bc43f/images/stems/Stem_Bars.svg">
        STEM
      </a>
    </div>
  </div>

  <div class="player-waveform-container" style="display: none;">
    <a href="#" class="zoom-button zoom-out" style="opacity: 1;">
      <svg viewBox="0 0 200 200" class="zoom-in-icon">
        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-plus"></use>
      </svg>
      <svg viewBox="0 0 200 200" class="zoom-out-icon">
        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-minus"></use>
      </svg>
    </a>
    <div class="player-waveform-bpm-key-container">
      <span class="player-waveform-bpm">124 bpm</span> / <span class="player-waveform-key">C min</span>
    </div>
    <div class="player-scrubbable player-clickzone" style="margin-left: 375.5996382848px; width: 217.029120192298px; height: 45px;"></div>
    
    
    <div class="player-wavelength-mask-right" style="height: 45px; position: absolute; margin-left: 592.628758477098px; width: 346.371241522902px; background-color: rgba(0, 0, 0, 0.4);"></div><div class="player-wavelength-mask-left" style="height: 45px; position: absolute; width: 375.5996382848px; background-color: rgba(0, 0, 0, 0.4);"></div><div class="player-scrubbable player-progress-bar" style="height: 45px; width: 469.971998551137px;"></div>
    <canvas class="track-waveform" width="939" height="45"></canvas>
    <span class="disabled-message">
      (Stem Player Active) - To reactivate full player controls, you'll need to play a new song
    </span>

  </div>

  <div class="player-buttons-container">

    <!-- New Buy Button -->
    <div class="buy-button" data-track="6946438" style="visibility: visible;">
      <button class="add-to-default">
        <svg viewBox="0 0 200 200" class="add-to-default-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-cart"></use>
        </svg>
        <span class="add-to-default-price">€2.17</span>
      </button>
      <button class="launch-menu">
        <svg viewBox="0 0 200 200" class="launch-menu-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-chevron-down"></use>
        </svg>
        <svg viewBox="0 0 200 200" class="loading-menu-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-spinner"></use>
        </svg>
      </button>
    </div>

    <!-- Old Buy Button
    <a href="#" class="buy-button">
      <span class="icon icon-cart"></span>
      <span class="button-text"></span>
    </a> -->

    <div class="volume-button-parent">
      <a class="volume-button">
        <svg viewBox="0 0 200 200" class="volume-on-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-volume-on"></use>
        </svg>
        <svg viewBox="0 0 200 200" class="volume-off-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-volume-off"></use>
        </svg>
      </a>
      <div class="volume-drop" style="display: none;">
        <input type="range" orient="vertical" class="volume-drop-range">
      </div>
    </div>
    <div class="player-controls">
      <a href="#" class="prev-button">
        <svg viewBox="0 0 200 200" class="prev-button-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-prev"></use>
        </svg>
      </a>
      <a href="#" class="play-button pause">
        <svg viewBox="0 0 200 200" class="play-button-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-play"></use>
        </svg>
        <svg viewBox="0 0 200 200" class="pause-button-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-pause"></use>
        </svg>
      </a>
      <a href="#" class="next-button">
        <svg viewBox="0 0 200 200" class="next-button-icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-next"></use>
        </svg>
      </a>
    </div>
    <div class="menu-queue-buttons-parent">
      <a href="#" class="player-queue-button">
        <svg viewBox="0 0 200 200" class="player-queue-button-img                                      ">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-queue"></use>
        </svg>
      </a>
      <a href="#" class="player-menu-button">
        <svg viewBox="0 0 200 200" class="player-menu-button-img animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate animate">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/static/fd9a859f1205a0b5d5b2d6c9f28aee0f274cd4d9/images/defs.svg#icon-menu"></use>
        </svg>
      </a>
      <!-- Queue Drop Down -->
      <div class="queue-drop" style="display: none;">
        <div class="queue-drop-title">Cola de reproducción <a href="" class="queue-drop-clear-all">Eliminar cola</a></div>
        <ul class="queue"></ul>
      </div>
      <!-- End Queue Drop Down -->
    </div>
  </div>
</section>