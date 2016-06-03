

	<!--<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="active" type="radio" onclick=""}</span></div>
		<label class="control-label col-lg-2">
			{l s='Enabled'}
		</label>
		<div class="col-lg-9">
			<span class="switch prestashop-switch fixed-width-lg">
				<input onclick="toggleDraftWarning(false);showOptions(true);showRedirectProductOptions(false);" type="radio" name="active" id="active_on" value="1" {if $product->active || !$product->isAssociatedToShop()}checked="checked" {/if} />
				<label for="active_on" class="radioCheck">
					{l s='Yes'}
				</label>
				<input onclick="toggleDraftWarning(true);showOptions(false);showRedirectProductOptions(true);"  type="radio" name="active" id="active_off" value="0" {if !$product->active && $product->isAssociatedToShop()}checked="checked"{/if} />
				<label for="active_off" class="radioCheck">
					{l s='No'}
				</label>
				<a class="slide-button btn"></a>
			</span>
		</div>
	</div>-->
