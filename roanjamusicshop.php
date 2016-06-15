<?php

/**
 * 2007-2014 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 *    @author    PrestaShop  SA  <contact@prestashop.com>
 * @copyright 2007-2014 PrestaShop SA
 *  @license   http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */



if (!defined('_PS_VERSION_'))
exit;

include_once(_PS_MODULE_DIR_.'roanjamusicshop/roanjamusic.php');

class RoanjaMusicShop extends Module
{
	protected $position = 1;
    protected $timeCookie = 2592000;
	public $_html = '';
	public function __construct()
	{
		$this->name = 'roanjamusicshop';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'Romell Jaramillo';
		$this->need_instance = 0;
		$this->secure_key = Tools::encrypt($this->name);
		$this->bootstrap = true;

		parent::__construct();

		$this->displayName = $this->l('Roanja Music Shop');
		$this->description = $this->l('Module for adding mp3 preview on your products page.');
		$this->ps_versions_compliancy = array('min' => '1.6.0.4', 'max' => _PS_VERSION_);
	}

	public function install()
	{
		if (parent::install() &&
			$this->registerHook('ActionProductDelete') &&
			$this->registerHook('displayAdminProductsExtra') &&
			$this->registerHook('displayRightColumnProduct') &&
			$this->registerHook('displayProductTabContent') &&
			$this->registerHook('actionProductUpdate') &&
			$this->registerHook('displayProductListReviews')&&
			$this->registerHook('displayProductSpecial')&&
			$this->registerHook('displayFooter') &&
			$this->registerHook('displayHeader')
			)
		{
			$shops = Shop::getContextListShopID();
			$shop_groups_list = array();

			foreach ($shops as $shop_id)
			{
				$shop_group_id = (int)Shop::getGroupFromShop($shop_id, true);

				if (!in_array($shop_group_id, $shop_groups_list))
					$shop_groups_list[] = $shop_group_id;
				/* Sets up configuration */
				$res = Configuration::updateValue('MUSIC_POSITION', $this->position, false, $shop_group_id, $shop_id);
			}
			if (count($shop_groups_list))
			{
				foreach ($shop_groups_list as $shop_group_id)
				{
					$res &= Configuration::updateValue('MUSIC_POSITION', $this->position, false, $shop_group_id);
				}
			}

			$res &= Configuration::updateValue('MUSIC_POSITION', $this->position);

			/* Creates tables */
			$res &= $this->createTable();

			/* Adds samples */
			if ($res)
				$this->installSamples();

			// Disable on mobiles and tablets
		//	$this->disableDevice(Context::DEVICE_MOBILE);

			return (bool)$res;
		}
		return false;
	}

	protected function installSamples()
	{
		$languages = Language::getLanguages(false);
		for ($i = 1; $i <= 3; ++$i)
		{
			$music = new RoanjaMusic();
            $music->position = $i;
            $music->active = 1;
            foreach ($languages as $language)
            {
                $music->mp3_name[$language['id_lang']] = 'sample-'.$i.'.mp3';
                $music->mp3_title[$language['id_lang']] = 'Sample-'.$i;
                $music->author[$language['id_lang']] = 'Roanja';
                $music->genero[$language['id_lang']] = 'Sample';
                $music->id_product[$language['id_lang']] = $i;
                $music->linked_digital_id[$language['id_lang']] = $i;
                $music->url_youtube[$language['id_lang']] = 'fLexgOxsZu0';
            }
            $music->add();
		}
	}
	public function uninstall()
	{
		/* Deletes tables */
		$res = $this->deleteTables();

		if (parent::uninstall())
		{
			$res &= Db::getInstance()->execute('DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'rj_music_shop`,`'._DB_PREFIX_.'rj_music`, `'._DB_PREFIX_.'rj_music_lang`');
			$res &= Configuration::deleteByName('MUSIC_POSITION');
			return (bool)$res;
		}
		return false;
	}

	protected function createTable()
	{

		$res = (bool)Db::getInstance()->execute('
			CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'rj_music_shop` (
				`id_music` int(10) unsigned NOT NULL AUTO_INCREMENT,
				`id_shop` int(10) unsigned NOT NULL,
				PRIMARY KEY (`id_music`, `id_shop`)
			) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=UTF8;

		');
		$res &= Db::getInstance()->execute('
			CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'rj_music` (
			  `id_music` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  `position` int(10) unsigned NOT NULL DEFAULT \'0\',
			  `active` tinyint(1) unsigned NOT NULL DEFAULT \'0\',
			  PRIMARY KEY (`id_music`)
			) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=UTF8;

		');
		$res &= Db::getInstance()->execute('
			CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'rj_music_lang` (
			`id_music` int(10) unsigned NOT NULL,
			`id_lang` int(10) unsigned NOT NULL,
			`mp3_name` varchar(255) NOT NULL,
			`mp3_title` varchar(255) NOT NULL,
			`author` varchar(255) NOT NULL,
			`genero` varchar(255) NOT NULL,
			`id_product` int(10) unsigned NOT NULL,
			`linked_digital_id` varchar(255) NOT NULL,
			`url_youtube` varchar(255) NOT NULL,
			PRIMARY KEY (`id_music`,`id_lang`)
			)ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=UTF8;
		');

		return $res;
	}

	protected function deleteTables()
	{
		/*$music = $this->getMusic();
		foreach ($musics as $music)
		{
			$to_del = new RoanjaMusic($music['id_music']);
			$to_del->delete();
		}*/

		return Db::getInstance()->execute('
			DROP TABLE IF EXISTS `'._DB_PREFIX_.'rj_music_shop`, `'._DB_PREFIX_.'rj_music`, `'._DB_PREFIX_.'rj_music_lang`;
		');
	}

	public function getContent()
	{
		//$this->_html .= $this->headerHTML();

		if (Tools::getValue('submitMusicSettings'))
			Configuration::updateValue('MUSIC_POSITION', Tools::getValue('MUSIC_POSITION'));


		/* Validate & process */
		if (Tools::isSubmit('submitMusic') || Tools::isSubmit('deleteroanjamusicshop') ||
			Tools::isSubmit('changeStatus')
		)
		{
			if ($this->_postValidation())
			{
				$this->_postProcess();
				$this->_html .= $this->renderForm();
			}

			$this->clearCache();
		}
		else // Default viewport
		{
			$this->_html .= $this->getWarningMultishopHtml().$this->getCurrentShopInfoMsg().$this->renderForm();
		}

		return $this->_html;
	}

	public function renderForm()
	{
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Settings') ,
					'icon' => 'icon-cogs'
				) ,
				'input' => array(
					array(
						'type' => 'select',
						'lang' => false,
						'label' => $this->l('Select your position') ,
						'name' => 'MUSIC_POSITION',
						'options' => array(
							'query' => array(
								array(
									'id' => '1',
									'name' => $this->l('Right Column Product')
								) ,
								array(
									'id' => '2',
									'name' => $this->l('Product Tabs')
								) ,
							) ,
							'id' => 'id',
							'name' => 'name',
						)
					) ,
				) ,
				'submit' => array(
					'title' => $this->l('Save')
				)
			) ,
		);

		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$this->fields_form = array();
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitMusicSettings';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');

		/*$helper->shopLinkType = '';
		$helper->module = $this;*/

		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);

		return $helper->generateForm(array($fields_form));
	}

	public function getConfigFieldsValues()
	{
		$id_shop_group = Shop::getContextShopGroupID();
		$id_shop = Shop::getContextShopID();
		return array(
			'MUSIC_POSITION' => Tools::getValue('MUSIC_POSITION', Configuration::get('MUSIC_POSITION', null, $id_shop_group, $id_shop)),
		);
	}

	public function hookDisplayHeader()
	{
			$this->context->controller->addCSS($this->_path.'css/mp3-player-button.css', 'all');
			$this->context->controller->addCSS($this->_path.'css/mp3-bar-ui.css', 'all');
			$this->context->controller->addCSS($this->_path.'css/mp3-player-ui.css', 'all');
		  	$this->context->controller->addJS($this->_path.'js/soundmanager2.js');
        	$this->context->controller->addJS($this->_path.'js/mp3-bar-ui.js');
            $this->context->controller->addJS($this->_path.'js/funciones.js');
	}

	public function hookDisplayFooter()
	{

			if(isset($_COOKIE['lista'])){
					$lista=unserialize($_COOKIE['lista']);
					$oculto="";
			}else{
					$lista=array();
					$oculto="hidden";

			}
		$this->context->smarty->assign(array('lista' => $lista,
											'oculto' => $oculto));
	return $this->display(__FILE__, 'bar-ui.tpl');
}

	public function GetSoundsOfProduct()
	{
		$id_shop = $this->context->shop->id;
		$id_lang = $this->context->language->id;

		 $associated_mp3_sql = 'SELECT ml.*, b.* , c.reduction, c.reduction_type FROM `'
			. _DB_PREFIX_ . 'rj_music_lang` AS ml INNER JOIN `'
			. _DB_PREFIX_ . 'product` AS b ON ml.linked_digital_id != "" AND ml.id_lang='. $id_lang . '  AND ml.id_product = '
			. (int)Tools::getValue('id_product') . ' AND b.id_product = ml.linked_digital_id LEFT JOIN `'
			. _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = b.id_product left Join ps_rj_music AS m ON m.id_music = ml.id_music AND m.active = 1 left Join ps_rj_music_shop AS ms ON ms.id_music = ml.id_music AND ms.id_shop = '. $id_shop ;

		$results= Db::getInstance()->ExecuteS($associated_mp3_sql);
		if($results){
			$i=0;
			foreach ($results as $data)
			{
				if(isset($_COOKIE['lista'])){
					$lista=unserialize($_COOKIE['lista']);
					$lista=$this->array_columns($lista,"id");
					if(in_array($data['id_product'],$lista)){
						$clase="quitar-lista";
					}else{
						$clase="agregar-lista";
					}
				}else{
					$clase="agregar-lista";
				}
				$results[$i]["clase"]=$clase;
				$i++;
			}
		}

		return $results;
	}
	public function hookdisplayRightColumnProduct()
	{
		$this->context->controller->addCSS($this->_path.'css/mp3-productDetail.css', 'all');
		if (Tools::getValue('MUSIC_POSITION', Configuration::get('MUSIC_POSITION')) == 1)
		{
			$associated_mp3 = $this->GetSoundsOfProduct();
			if(!empty($associated_mp3)){
 				$this->context->smarty->assign(array(
					'associated_mp3' => $associated_mp3,
				));

       		}
		}

		return $this->display(__FILE__, 'views/templates/front/column.tpl');
	}
	public function hookDisplayProductTabContent()
	{
		if (Tools::getValue('MUSIC_POSITION', Configuration::get('MUSIC_POSITION')) == 2)
		{
			$associated_mp3 = $this->GetSoundsOfProduct();
			if(!empty($associated_mp3)){
 				$this->context->smarty->assign(array(
					'associated_mp3' => $associated_mp3,
				));
	            return $this->display(__FILE__, 'views/templates/front/product_tab_content.tpl');
       		}

		}
	}

	public function  array_columns( array $input, $column_key, $index_key = null ) {
		$result = array();
		foreach( $input as $k => $v )
				$result[ $index_key ? $v[ $index_key ] : $k ] = $v[ $column_key ];

		return $result;
	}

	public function hookDisplayProductListReviews($params){
		$id_product = (int)$params['product']['id_product'];
		$this->context = Context::getContext();
		$id_shop = $this->context->shop->id;
		$id_lang = $this->context->language->id;

		$id_sql='SELECT a.* from `' . _DB_PREFIX_ . 'rj_music_lang` as a,`' . _DB_PREFIX_ . 'rj_music_shop` as b where linked_digital_id=' . (int)$id_product
		. ' or (linked_digital_id!="" and id_product=' . (int)$id_product . ') AND id_lang=' . (int)$id_lang
		. ' AND a.id_music=b.id_music and b.id_shop=' . (int)$id_shop . ' limit 1';
		$item_mp3=Db::getInstance()->ExecuteS($id_sql);

		$this->product = new Product($id_product, false,$this->context->language->id);
		$precioconv=Tools::convertPrice($this->product->price, $this->context->currency);
		$arrdata["price"]=number_format($precioconv, 2, ",", "");
		$arrdata['sign']=$this->context->currency->sign;

		if(!empty($item_mp3)){
			if(isset($_COOKIE['lista'])){
				$lista=unserialize($_COOKIE['lista']);
				$lista=$this->array_columns($lista,"id");
				if(in_array($id_product,$lista)){
					$clase="quitar-lista";
				}else{
					$clase="agregar-lista";
				}
			}else{
				$clase="agregar-lista";
			}

    if(empty($item_mp3[0]["url_youtube"])){
			$style_width="width:33.33%";
			}
			else {
			$style_width="";
			}

			$this->context->smarty->assign(array(
			 	'id_product' => $id_product,
				'mp3_name' => $item_mp3[0]["mp3_name"],
				'mp3_title' => $item_mp3[0]["mp3_title"],
				'url_youtube' => $item_mp3[0]["url_youtube"],
				'precio' => $arrdata["price"].$arrdata['sign'] ,
				'clase' => $clase,
				'style_width'=>$style_width
			));
			return $this->display(__FILE__, 'mp3_button.tpl');
		}
	}

	public function hookDisplayProductSpecial($params){
		$id_product = (int)$params['product']['id_product'];
		$this->context = Context::getContext();
		$id_shop = $this->context->shop->id;
		$id_lang = $this->context->language->id;

				$id_sql='SELECT a.* from `' . _DB_PREFIX_ . 'rj_music_lang` as a,`' . _DB_PREFIX_ . 'rj_music_shop` as b where linked_digital_id=' . (int)$id_product
				. ' or (linked_digital_id!="" and id_product=' . (int)$id_product . ') AND id_lang=' . (int)$id_lang
				. ' AND a.id_music=b.id_music and b.id_shop=' . (int)$id_shop . ' limit 1';
				$item_mp3=Db::getInstance()->ExecuteS($id_sql);

						 $this->product = new Product($id_product, false,$this->context->language->id);
								$precioconv=Tools::convertPrice($this->product->price, $this->context->currency);
								$arrdata["price"]=number_format($precioconv, 2, ",", "");
								$arrdata['sign']=$this->context->currency->sign;

				if(!empty($item_mp3)){

						if(isset($_COOKIE['lista'])){
							 $lista=unserialize($_COOKIE['lista']);
							 $lista=$this->array_columns($lista,"id");
						 if(in_array($id_product,$lista)){
						$clase="quitar-lista";
							 }else{
						$clase="agregar-lista";
							 }
					}else{
							 $clase="agregar-lista";
					}
						$this->context->smarty->assign(array(
							//'item_mp3' => $item_mp3,

											 'id_product' => $id_product,
												'mp3_name' => $item_mp3[0]["mp3_name"],
												'mp3_title' => $item_mp3[0]["mp3_title"],
						'url_youtube' => $item_mp3[0]["url_youtube"],
						'precio' => $arrdata["price"].$arrdata['sign'] ,
												'clase' => $clase,

						));
						return $this->display(__FILE__, 'mp3_button_special.tpl');
				}

	}
	public function getCacheId($id_product = null)
	{
		return parent::getCacheId().'|'.(int)$id_product;
	}

	public function headerHTML()
	{
		if (Tools::getValue('controller') != 'AdminModules' && Tools::getValue('configure') != $this->name)
			return;

		$this->context->controller->addJqueryUI('ui.sortable');
		$html = '<script type="text/javascript">
					$(function() {
						var $myMusics = $("#musics");
						$myMusics.sortable({
							opacity: 0.6,
							cursor: "move",
							update: function() {
								var order = $(this).sortable("serialize") + "&action=updateMusicPosition";
								$.post("'.$this->context->shop->physical_uri.$this->context->shop->virtual_uri.'modules/'.$this->name.'/ajax_'.$this->name.'.php?secure_key='.$this->secure_key.'", order);
								}
							});
						$myMusics.hover(function() {
							$(this).css("cursor","move");
							},
							function() {
							$(this).css("cursor","auto");
						});
					});
				</script>';
		return $html;
	}

	public function getNextPosition()
	{
		$row = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow('
			SELECT MAX(a.`position`) AS `next_position`
			FROM `'._DB_PREFIX_.'rj_music` a, `'._DB_PREFIX_.'rj_music_shop` b
			WHERE a.`id_music` = b.`id_music` AND b.`id_shop` = '.(int)$this->context->shop->id
		);

		return (++$row['next_position']);
	}

	protected function _postValidation()
	{
		$errors = array();

		if (Tools::isSubmit('changeStatus'))
		{
			if (!Validate::isInt(Tools::getValue('id_mp3')))
				$errors[] = $this->l('Invalid music');
		}

		if (Tools::isSubmit('submitMusic'))
		{
			if (!Validate::isInt(Tools::getValue('active_music')) || (Tools::getValue('active_music') != 0 && Tools::getValue('active_music') != 1))
				$errors[] = $this->l('Invalid music state.');

			if (!Validate::isInt(Tools::getValue('position')) || (Tools::getValue('position') < 0))
				$errors[] = $this->l('Invalid music position.');

			if (Tools::isSubmit('id_mp3'))
			{

				//d(var_dump(Tools::getValue('id_mp3')));
				if (!Validate::isInt(Tools::getValue('id_mp3')) && !$this->musicExists(Tools::getValue('id_mp3')))
					$errors[] = $this->l('Invalid music ID');
			}
			/* Checks title/url/legend/description/image */
			$languages = Language::getLanguages(false);
			foreach ($languages as $language)
			{
				if (Tools::strlen(Tools::getValue('mp3_title_'.$language['id_lang'])) > 255)
					$errors[] = $this->l('The title is too long.');
				if (Tools::strlen(Tools::getValue('author_'.$language['id_lang'])) > 255)
					$errors[] = $this->l('The caption is too long.');
				if (Tools::strlen(Tools::getValue('genero_'.$language['id_lang'])) > 255)
					$errors[] = $this->l('The URL is too long.');
				if (Tools::strlen(Tools::getValue('url_youtube_'.$language['id_lang'])) > 255)
					$errors[] = $this->l('The URL is too long.');
				if (Tools::getValue('mp3_name_'.$language['id_lang']) != null && !Validate::isFileName(Tools::getValue('mp3_name_'.$language['id_lang'])))
					$errors[] = $this->l('Invalid filename.');
				if (Tools::getValue('mp3_name_old_'.$language['id_lang']) != null && !Validate::isFileName(Tools::getValue('mp3_name_old_'.$language['id_lang'])))
					$errors[] = $this->l('Invalid filename.');
			}

			/* Checks title/url/legend/description for default lang */
			$id_lang_default = (int)Configuration::get('PS_LANG_DEFAULT');
			if (Tools::strlen(Tools::getValue('mp3_title_'.$id_lang_default)) == 0)
				$errors[] = $this->l('The title is not set.');
			if (Tools::strlen(Tools::getValue('author_'.$id_lang_default)) == 0)
				$errors[] = $this->l('The caption is not set.');
			if (Tools::strlen(Tools::getValue('genero_'.$id_lang_default)) == 0)
				$errors[] = $this->l('The URL is not set.');
			if (Tools::strlen(Tools::getValue('url_youtube_'.$id_lang_default)) == 0)
				$errors[] = $this->l('The URL is not set.');
			if (!Tools::isSubmit('has_music') && (!isset($_FILES['mp3_name_'.$id_lang_default]) || empty($_FILES['mp3_name_'.$id_lang_default]['tmp_name'])))
				$errors[] = $this->l('The music is not set.');
			if (Tools::getValue('mp3_name_old_'.$id_lang_default) && !Validate::isFileName(Tools::getValue('mp3_name_old_'.$id_lang_default)))
				$errors[] = $this->l('The image is not set.');
		} /* Validation for deletion */
		elseif (Tools::isSubmit('delete_id_music') && (!Validate::isInt(Tools::getValue('delete_id_music')) || !$this->musicExists((int)Tools::getValue('delete_id_music'))))
			$errors[] = $this->l('Invalid music ID');

		/* Display errors if needed */
		if (count($errors))
		{
			$this->_html .= $this->displayError(implode('<br />', $errors));

			return false;
		}

		/* Returns if validation is ok */

		return true;
	}

	public function _postProcess()
	{

		$errors = array();
		$shop_context = Shop::getContext();

		if (Tools::isSubmit('changeStatus') && Tools::isSubmit('id_mp3'))
		{
			$music = new RoanjaMusic((int)Tools::getValue('id_mp3'));
			if ($music->active == 0)
				$music->active = 1;
			else
				$music->active = 0;
			$res = $music->update();
			$this->clearCache();


			if (!$res){
				$this->_html .= $this->displayError('The configuration could not be updated');
			}
			else{
				$this->_html .= ($res ? $this->displayConfirmation($this->l('Configuration updated')) : $this->displayError($this->l('The configuration could not be updated.')));
				Tools::redirectAdmin($this->context->link->getAdminLink('AdminProducts',false).'&id_product='.(int)Tools::getValue('id_product').'&updateproduct&key_tab=ModuleRoanjamusicshop&conf=1&token='.Tools::getAdminTokenLite('AdminProducts'));
			}
		}
		elseif (Tools::isSubmit('submitMusic'))
		{

	    	if (Tools::getValue('id_mp3'))
			{
				$music = new RoanjaMusic((int)Tools::getValue('id_mp3'));
				if (!Validate::isLoadedObject($music))
				{
					$this->_html .= $this->displayError($this->l('Invalid Music ID'));
					return false;
				}
			}
			else
				$music = new RoanjaMusic();
			/* Sets position */
			$music->position = (int)Tools::getValue('position');
			/* Sets active */
			$music->active = (int)Tools::getValue('active_music');

			/* Sets each langue fields */
			$languages = Language::getLanguages(false);

			if (!isset($_FILES['mp3_name']))
					return $this->displayError($this->l('Invalid MP3 file or you did not complete all the fields'));
			else
			{
				$file_name = $_FILES['mp3_name'];
				if (!move_uploaded_file($_FILES['mp3_name']['tmp_name'], dirname(__FILE__) . DIRECTORY_SEPARATOR . 'mp3' . DIRECTORY_SEPARATOR . $file_name['name']))
					return $this->displayError($this->l('An error occurred while attempting to upload the file.'));
			}

			foreach ($languages as $language)
			{
				//$salt = sha1(microtime());
				$music->mp3_name[$language['id_lang']] = $_FILES['mp3_name']['name'];//$file_name;
				$music->mp3_title[$language['id_lang']] = Tools::getValue('mp3_title_'.$language['id_lang']);
				$music->author[$language['id_lang']] = Tools::getValue('author_'.$language['id_lang']);
				$music->genero[$language['id_lang']] = Tools::getValue('genero_'.$language['id_lang']);
				$music->url_youtube[$language['id_lang']] = Tools::getValue('url_youtube_'.$language['id_lang']);
				$music->id_product[$language['id_lang']] = (int)Tools::getValue('id_product');
				$music->linked_digital_id[$language['id_lang']] = Tools::getValue('virtual_prod_assoc');
			}


			if (!$errors)
			{
				/* Adds */
				if (!Tools::getValue('id_mp3'))
				{
					if (!$music->add())
						$errors[] = $this->displayError($this->l('The music could not be added.'));
				}
				/* Update */
				elseif (!$music->update())
					$errors[] = $this->displayError($this->l('The music could not be updated.'));
				$this->clearCache();
			}
		} /* Deletes */	//elseif (Tools::isSubmit('delete_id_music'))
		elseif(Tools::isSubmit('deleteroanjamusicshop'))
		{
			$music = new RoanjaMusic((int)Tools::getValue('deleteroanjamusicshop'));
			$res = $music->delete();
			$this->clearCache();
			if (!$res){
				$this->_html .= $this->displayError('Could not delete.');
			}
			else{
				Tools::redirectAdmin($this->context->link->getAdminLink('AdminProducts',false).'&id_product='.(int)Tools::getValue('id_product').'&updateproduct&key_tab=ModuleRoanjamusicshop&conf=1&token='.Tools::getAdminTokenLite('AdminProducts'));
			}

		}

		/* Display errors if needed */
		if (count($errors))
			$this->_html .= $this->displayError(implode('<br />', $errors));
		elseif (Tools::isSubmit('submitMusic') && Tools::getValue('id_mp3'))
			Tools::redirectAdmin($this->context->link->getAdminLink('AdminProducts').'&id_product='.(int)Tools::getValue('id_product').'&updateproduct&conf=4&key_tab=Module'.$this->name.$this->token);
		elseif (Tools::isSubmit('submitMusic'))
			Tools::redirectAdmin($this->context->link->getAdminLink('AdminProducts').'&id_product='.(int)Tools::getValue('id_product').'&updateproduct&conf=3&key_tab=ModuleRoanjamusicshop'.$this->token);
	}

	public function hookActionProductUpdate()
	{
		$errors = array();
		$shop_context = Shop::getContext();

		if (Tools::isSubmit('submitMusic'))
		{

	    	if (Tools::getValue('id_mp3'))
			{
				$music = new RoanjaMusic((int)Tools::getValue('id_mp3'));
				if (!Validate::isLoadedObject($music))
				{
					$this->_html .= $this->displayError($this->l('Invalid Music ID'));
					return false;
				}
			}
			else
				$music = new RoanjaMusic();

			$music->position = (int)Tools::getValue('position');

			$music->active = (int)Tools::getValue('active_music');


			$languages = Language::getLanguages(false);

			if (!isset($_FILES['mp3_name']))
					return $this->displayError($this->l('Invalid MP3 file or you did not complete all the fields'));
			else
			{
				$file_name = $_FILES['mp3_name'];
				if (!move_uploaded_file($_FILES['mp3_name']['tmp_name'], dirname(__FILE__) . DIRECTORY_SEPARATOR . 'mp3' . DIRECTORY_SEPARATOR . $file_name['name']))
					return $this->displayError($this->l('An error occurred while attempting to upload the file.'));
			}

			foreach ($languages as $language)
			{
				$music->mp3_name[$language['id_lang']] = $_FILES['mp3_name']['name'];
				$music->mp3_title[$language['id_lang']] = Tools::getValue('mp3_title_'.$language['id_lang']);
				$music->author[$language['id_lang']] = Tools::getValue('author_'.$language['id_lang']);
				$music->genero[$language['id_lang']] = Tools::getValue('genero_'.$language['id_lang']);
				$music->url_youtube[$language['id_lang']] = Tools::getValue('url_youtube_'.$language['id_lang']);
				$music->id_product[$language['id_lang']] = (int)Tools::getValue('id_product');
				$music->linked_digital_id[$language['id_lang']] = Tools::getValue('virtual_prod_assoc');
			}


			if (!$errors)
			{

				if (!Tools::getValue('id_mp3'))
				{
					if (!$music->add())
						$errors[] = $this->displayError($this->l('The music could not be added.'));
				}

				elseif (!$music->update())
					$errors[] = $this->displayError($this->l('The music could not be updated.'));
				$this->clearCache();
			}
		}


		if (count($errors))
			$this->_html .= $this->displayError(implode('<br />', $errors));
		elseif (Tools::isSubmit('submitMusic') && Tools::getValue('id_mp3'))
			Tools::redirectAdmin($this->context->link->getAdminLink('AdminProducts').'&id_product='.(int)Tools::getValue('id_product').'&updateproduct&conf=4&key_tab=Module'.$this->name.$this->token);
		elseif (Tools::isSubmit('submitMusic'))
			Tools::redirectAdmin($this->context->link->getAdminLink('AdminProducts').'&id_product='.(int)Tools::getValue('id_product').'&updateproduct&conf=3&key_tab=ModuleRoanjamusicshop'.$this->token);
	}

	public function hookDisplayAdminProductsExtra()
	{
		//echo "<script src='" . $this->_path . "js/admin.js'></script>"; //ojo cambiar
		$this->_html .= $this->headerHTML();
		return $this->_html .= $this->prepareForm()  . $this->renderList();
	}

	public function prepareForm()
	{

		$virtual_products = $this->getVirtualProducts ();
		$product = new Product((int)Tools::getValue('id_product'));

		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Slide information'),
					'icon' => 'icon-cogs'

				),
				'input' => array(

					array(
			            'type' => 'select',
			            'lang' => true,
			            'label' => $this->l('Associate Virtual Products:'),
			            'name' => 'virtual_prod_assoc',
			            'desc' => $this->l('Associate Mp3 file with other Virtual Products'),
			            'options' => array(
			              'query' => $virtual_products,
			              'id' => 'id_product',
			              'name' => 'name'
			            ),
			        ),
					array(
						'type' => 'file',
						'label' => $this->l('Select a file'),
						'name' => 'mp3_name',
						'required' => true,
						'desc' => sprintf($this->l('Maximum music size: %s.'), ini_get('upload_max_filesize'))
					),
					array(
						'type' => 'text',
						'label' => $this->l('Music Title'),
						'name' => 'mp3_title',
						'required' => true,
						'lang' => true,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Author'),
						'name' => 'author',
						'required' => true,
						'lang' => true,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Genero'),
						'name' => 'genero',
						'required' => true,
						'lang' => true,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Url Youtube'),
						'name' => 'url_youtube',
						'desc' => $this->l('Id url youtube https://www.youtube.com/watch?v=   (fLexgOxsZu0)'),
						'lang' => true,
					),
					array(
						'type' => 'switch',
						'label' => $this->l('Enabled'),
						'name' => 'active_music',
						'is_bool' => true,
						'values' => array(
							array(
								'id' => 'active_on',
								'value' => 1,
								'label' => $this->l('Yes')
							),
							array(
								'id' => 'active_off',
								'value' => 0,
								'label' => $this->l('No')
							)
						),
					),
				),
				'submit' => array(
					'title' => $this->l('Save'),
				)
			),
		);
		if (Tools::isSubmit('id_music') && $this->musicExists((int)Tools::getValue('id_music')))
		{
			$music = new RoanjaMusic((int)Tools::getValue('id_music'));
			$fields_form['form']['input'][] = array('type' => 'hidden', 'name' => 'id_music');
			$fields_form['form']['mp3_name'] = $music->mp3_name;

			$has_music = true;

			//foreach (Language::getLanguages(false) as $lang)
				if (!isset($music->mp3_name))
					$has_music &= false;

			if ($has_music)
				$fields_form['form']['input'][] = array('type' => 'hidden', 'name' => 'has_music');
		}
		$fields_form['form']['input'][] = array('type' => 'hidden', 'name' => 'submitMusic', 'value' =>'1');
		$fields_form['form']['input'][] = array('type' => 'hidden', 'name' => 'productId', 'value' =>(int)Tools::getValue('id_product'));
		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$this->fields_form = array();
		$helper->module = $this;
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitAddproductAndStay';
		$language = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->tpl_vars = array(
			'base_url' => $this->context->shop->getBaseURL(),
			'language' => array(
				'id_lang' => $language->id,
				'iso_code' => $language->iso_code
			),
			'fields_value' => $this->getAddFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id,
			'image_baseurl' => $this->_path.'images/'
		);

		$helper->override_folder = '/';

		$languages = Language::getLanguages(false);

		if (count($languages) > 1)
			return $this->getMultiLanguageInfoMsg().$helper->generateForm(array($fields_form));
		else
			return $helper->generateForm(array($fields_form));
	}

	public function getFormValues()
	{
		$fields_value = array();
		$id_music = (int)Tools::getValue('id_music');
		foreach (Language::getLanguages(false) as $lang)
			if ($id_music)
			{
				$music = new RoanjaMusic((int)$id_music);
				$fields_value['mp3_title'][(int)$lang['id_lang']] = $music->mp3_title[(int)$lang['id_lang']];
			}
			else
				$fields_value['mp3_title'][(int)$lang['id_lang']] = Tools::getValue('mp3_title_'.(int)$lang['id_lang'], '');

		$fields_value['id_music'] = $id_music;

		return $fields_value;
	}

	public function getVirtualProducts ()
	{
		$this->context = Context::getContext();
		$id_shop = $this->context->shop->id;
		$id_lang = $this->context->language->id;

		// Get All Virtual Products and assign them to variables

		$get_virtual_products = 'SELECT wp.`id_product`, pl.`name`, pl.`id_product`
								 FROM `'._DB_PREFIX_.'product_download` wp
								 LEFT JOIN `'._DB_PREFIX_.'product` p ON p.`id_product` = wp.`id_product`
								 '.Shop::addSqlAssociation('product', 'p').'
								 LEFT JOIN `'._DB_PREFIX_.'product_lang` pl ON pl.`id_product` = wp.`id_product`'.Shop::addSqlRestrictionOnLang('pl').'
								 WHERE pl.`id_lang` = '.(int)($id_lang);

		return Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS($get_virtual_products);
	}

	public function renderList()
	{
		$musics = $this->getMusic();
		foreach ($musics as $key => $music)
		{
			$musics[$key]['status'] = $this->displayStatus($music['id_music'], $music['active']);
			$associated_shop_ids = RoanjaMusic::getAssociatedIdsShop((int)$music['id_music']);
			if ($associated_shop_ids && count($associated_shop_ids) > 1)
				$musics[$key]['is_shared'] = true;
			else
				$musics[$key]['is_shared'] = false;
		}

		$this->context->smarty->assign(
			array(
				'id_product' => (int)Tools::getValue('id_product'),
				'link' => $this->context->link,
				'musics' => $musics,
				'music_baseurl' => $this->_path.'mp3/'
			)
		);

		return $this->display(__FILE__, 'list.tpl');
	}

	public function getMusic($id_product=null,$active = null)
	{
		if(is_null($id_product)){
			$id_product=(int)Tools::getValue('id_product');
		}
		$this->context = Context::getContext();
		$id_shop = $this->context->shop->id;
		$id_lang = $this->context->language->id;

		return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
			SELECT a.`id_music` as id_mp3, b.`position`, b.`active`, c.`id_music`, c.`mp3_name`,
		 c.`mp3_title`, c.`author`, c.`genero`, c.`url_youtube`,c.`linked_digital_id`,c.`id_product`
		 FROM '._DB_PREFIX_.'rj_music_shop a
		 LEFT JOIN '._DB_PREFIX_.'rj_music b ON (a.id_music = b.id_music)
		 LEFT JOIN '._DB_PREFIX_.'rj_music_lang c ON (b.id_music = c.id_music)
		 WHERE c.id_product = ' . $id_product . ' AND  a.id_shop = '.(int)$id_shop.'
			AND c.id_lang = '.(int)$id_lang. ' '.Shop::addSqlRestrictionOnLang().($active ? ' AND b.`active` = 1' : ' ').'
			ORDER BY b.position'
		);
	}

	public function getAddFieldsValues()
	{
		$fields = array();

		if (Tools::isSubmit('id_mp3') && $this->musicExists((int)Tools::getValue('id_mp3')))
		{
			$music = new RoanjaMusic((int)Tools::getValue('id_mp3'));
			$fields['id_mp3'] = (int)Tools::getValue('id_mp3', $music->id);
		}
		else
			$music = new RoanjaMusic();

		$fields['active_music'] = Tools::getValue('active_music', $music->active);
		$fields['has_music'] = true;

		$languages = Language::getLanguages(false);

		foreach ($languages as $lang)
		{
			$fields['mp3_name'][$lang['id_lang']] = Tools::getValue('mp3_name_'.(int)$lang['id_lang']);
			$fields['mp3_title'][$lang['id_lang']] = Tools::getValue('mp3_title_'.(int)$lang['id_lang'], $music->mp3_title[$lang['id_lang']]);
			$fields['author'][$lang['id_lang']] = Tools::getValue('author_'.(int)$lang['id_lang'], $music->author[$lang['id_lang']]);
			$fields['genero'][$lang['id_lang']] = Tools::getValue('genero_'.(int)$lang['id_lang'], $music->genero[$lang['id_lang']]);
			$fields['url_youtube'][$lang['id_lang']] = Tools::getValue('url_youtube_'.(int)$lang['id_lang'], $music->genero[$lang['id_lang']]);
			$fields['id_product'] = (int)Tools::getValue('id_product');
			$fields['linked_digital_id'] = Tools::getValue('virtual_prod_assoc');
		}
		return $fields;
	}

	public function clearCache()
	{
		$this->_clearCache('bar-ui.tpl');
		$this->_clearCache('mp3_button.tpl');
		$this->_clearCache('mp3_button_special.tpl');
	}

	public function displayStatus($id_mp3, $active)
	{
		$title = ((int)$active == 0 ? $this->l('Disabled') : $this->l('Enabled'));
		$icon = ((int)$active == 0 ? 'icon-remove' : 'icon-check');
		$class = ((int)$active == 0 ? 'btn-danger' : 'btn-success');
		$html = '<a class="btn '.$class.'" href="'.$this->context->link->getAdminLink('AdminModules').
			'&configure='.$this->name.'
				&token='.Tools::getAdminTokenLite('AdminModules').'&id_product='.(int)Tools::getValue('id_product').'
				&changeStatus&id_mp3='.(int)$id_mp3.'" title="'.$title.'"><i class="'.$icon.'"></i> '.$title.'</a>';
		return $html;
	}

	public function musicExists($id_mp3)
	{
		$req = 'SELECT a.`id_music` as id_mp3
				FROM `'._DB_PREFIX_.'rj_music` a
				WHERE a.`id_music` = '.(int)$id_mp3;
		$row = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow($req);
		return ($row);
	}

	protected function getMultiLanguageInfoMsg()
	{
		return '<p class="alert alert-warning">'.
					$this->l('Since multiple languages are activated on your shop, please mind to upload your image for each one of them').
				'</p>';
	}

	protected function getWarningMultishopHtml()
	{
		if (Shop::getContext() == Shop::CONTEXT_GROUP || Shop::getContext() == Shop::CONTEXT_ALL)
			return '<p class="alert alert-warning">'.
						$this->l('You cannot manage Musics items from a "All Shops" or a "Group Shop" context, select directly the shop you want to edit').
					'</p>';
		else
			return '';
	}

	protected function getShopContextError($shop_contextualized_name, $mode)
	{
		if (is_array($shop_contextualized_name))
			$shop_contextualized_name = implode('<br/>', $shop_contextualized_name);

		if ($mode == 'edit')
			return '<p class="alert alert-danger">'.
							sprintf($this->l('You can only edit this Music from the shop(s) context: %s'), $shop_contextualized_name).
					'</p>';
		else
			return '<p class="alert alert-danger">'.
							sprintf($this->l('You cannot add Musics from a "All Shops" or a "Group Shop" context')).
					'</p>';
	}

	protected function getCurrentShopInfoMsg()
	{
		$shop_info = null;

		if (Shop::isFeatureActive())
		{
			if (Shop::getContext() == Shop::CONTEXT_SHOP)
				$shop_info = sprintf($this->l('The modifications will be applied to shop: %s'), $this->context->shop->name);
			else if (Shop::getContext() == Shop::CONTEXT_GROUP)
				$shop_info = sprintf($this->l('The modifications will be applied to this group: %s'), Shop::getContextShopGroup()->name);
			else
				$shop_info = $this->l('The modifications will be applied to all shops and shop groups');

			return '<div class="alert alert-info">'.
						$shop_info.
					'</div>';
		}
		else
			return '';
	}

	protected function getShopAssociationError($id_mp3)
	{
		return '<p class="alert alert-danger">'.
						sprintf($this->l('Unable to get slide shop association information (id_mp3: %d)'), (int)$id_mp3).
				'</p>';
	}

	protected function getSharedMusicWarning()
	{
		return '<p class="alert alert-warning">'.
					$this->l('This Music is shared with other shops! All shops associated to this music will apply modifications made here').
				'</p>';
	}
}

?>
