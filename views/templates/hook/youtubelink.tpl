<div class="panel">
    <h3><i class="icon-list-ul"></i>{l s="Youtube link" mod="roanjamusicshop"}</h3>
    <div class="form-wrapper">
        <div class="form-group">
            <label class="control-label col-lg-3">{l s="Linked to youtube" mod="roanjamusicshop"}</label>
            <div class="col-lg-9">
                <span class="switch prestashop-switch fixed-width-lg">
                    <input type="radio" name="active_youtube" id="active_youtube_on" value="1" 
                           {if isset($url_music) and $status_url eq '1'} checked="checked" {/if}>
                    <label for="active_youtube_on">{l s="Yes" mod="roanjamusicshop"}</label>
                    <input type="radio" name="active_youtube" id="active_youtube_off" value="0" 
                           {if isset($url_music) and $status_url eq '0'} checked="checked" {/if}>
                    <label for="active_youtube_off">{l s="No" mod="roanjamusicshop"}</label>
                    <a class="slide-button btn"></a>
                </span>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-lg-3">{l s="Link" mod="roanjamusicshop"}</label>
            <div class="col-lg-9">
                <input type="text" name="yt_url" id="yt_url" value="{$url_music}" {if !isset($url_music) or $status_url eq '0'}
                       disabled {/if}</input>
            </div>
        </div>
    </div>

    <div class="panel-footer">
        <div id="submitAddYoutube" name="submitAddYoutube" class="btn btn-default pull-right" data-ruta="{$module_dir}" data-idproduct="{$id_product}"
             data-language="{$language}" data-employe="{$employe}">
            <i class="process-icon-save"></i>{l s="Save" mod="roanjamusicshop"}
        </div>
    </div>
</div>
