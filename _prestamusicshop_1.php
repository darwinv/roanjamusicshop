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

include_once(_PS_MODULE_DIR_.'homeslider/HomeSlide.php');

class PrestaMusicShop extends Module
{
	protected $position = 1;
	public function __construct()
	{
		$this->name = 'prestamusicshop';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'Lapusanu Patriciu Alex';
		$this->need_instance = 0;
		$this->bootstrap = true;
		
		parent::__construct();
		
		$this->displayName = $this->l('Music Shop Module by Rapty');
		$this->description = $this->l('Module for adding mp3 preview on your products page.');
		$this->ps_versions_compliancy = array('min' => '1.6.0.4', 'max' => _PS_VERSION_);
	}

	public function install()
	{
		if (!parent::install() || 			
			!$this->registerHook('ActionProductDelete') || 
			!$this->registerHook('displayAdminProductsExtra') || 
			!$this->registerHook('displayRightColumnProduct') ||
			!$this->registerHook('displayProductListReviews') ||  
			!$this->registerHook('displayProductTabContent') || 
			!$this->registerHook('actionProductUpdate') || 
			!$this->registerHook('displayFooter') || 
			!$this->registerHook('displayHeader') 
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

			//if (!Db::getInstance()->Execute($sql)) return false;
				//Configuration::updateValue('MUSIC_POSITION', 1);
			/* Creates tables */
			$res &= $this->createTable();
			return (bool)$res;
		}	
		return false;
	}



	public function uninstall()

	{

		if (parent::uninstall())

		{

			//Db::getInstance()->execute('DROP TABLE IF EXISTS`' . _DB_PREFIX_ . 'music_shop`');

			$res &= Configuration::deleteByName('MUSIC_POSITION');

			return (bool)$res;

		}

		return false;



		/*Configuration::deleteByName('MUSIC_POSITION');

		Db::getInstance()->execute('DROP TABLE IF EXISTS`' . _DB_PREFIX_ . 'music_shop`');

		return parent::uninstall();*/		

	}



	public function createTable()

	{
		/* Music prew */

		$res = (bool)Db::getInstance()->execute('
			CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'music_shop` (
				`id_music_shop` int(10) unsigned NOT NULL AUTO_INCREMENT,
				`id_shop` int(10) unsigned NOT NULL,
				PRIMARY KEY (`id_id_music_shop`, `id_shop`)
			) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=UTF8;

		');
		$res &= Db::getInstance()->execute('
			CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'music_shop_music` (
			  `id_music_shop` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  `position` int(10) unsigned NOT NULL DEFAULT \'0\',
			  `active` tinyint(1) unsigned NOT NULL DEFAULT \'0\',
			  PRIMARY KEY (`id_music_shop`)
			) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=UTF8;

		');
		$res &= Db::getInstance()->execute('
			CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'music_shop_music_lang` (
			`id_music_shop` int(10) unsigned NOT NULL auto_increment,
			`mp3_name` varchar(256) NOT NULL,
			`mp3_title` varchar(256) NOT NULL,
			`author` varchar(256) NOT NULL,
			`genero` varchar(256) NOT NULL,
			`product_id` varchar(256) NOT NULL,
			`linked_digital_id` varchar(256) NOT NULL,
			PRIMARY KEY (`id_music_shop`,`id_lang`)
			)ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;
		');
		return $res;
	}



	public function getContent()
	{
		if (Tools::getValue('submitMusicSettings')) Configuration::updateValue('MUSIC_POSITION', Tools::getValue('MUSIC_POSITION'));
		return $this->renderForm();
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
		$helper->shopLinkType = '';
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->module = $this;
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitMusicSettings';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false);
		$helper->currentIndex = $helper->currentIndex . '&configure=' . $this->name . '&tab_module=';
		$helper->currentIndex = $helper->currentIndex . $this->tab . '&module_name=' . $this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues() ,
		);
		return $helper->generateForm(array(
			$fields_form
		));
	}



	public function getConfigFieldsValues()
	{
		return array(
			'MUSIC_POSITION' => Tools::getValue('MUSIC_POSITION', Configuration::get('MUSIC_POSITION')) ,
		);
	}



	public function hookDisplayHeader()	
	{
			$this->context->controller->addCSS($this->_path.'css/mp3-player-button.css', 'all');			
			$this->context->controller->addCSS($this->_path.'css/mp3-bar-ui.css', 'all');			
			$this->context->controller->addCSS($this->_path.'css/mp3-player-ui.css', 'all');
		  	$this->context->controller->addJS($this->_path.'js/soundmanager2.js');   
        	/*$this->context->controller->addJS($this->_path.'js/mp3-bar-ui.js'); 
        	$this->context->controller->addJS($this->_path.'js/mp3-ui.js'); */
         	$this->context->controller->addJS($this->_path.'js/mp3-player-button.js');         	    	
	}

	public function hookDisplayFooter()	
	{
		return $this->display(__FILE__, 'bar-ui.tpl');
	}

	public function hookBlockFooter2($params)	
	{
		return $this->hookDisplayFooter($params);
	}

	public function hookdisplayRightColumnProduct()
	{
		if (Tools::getValue('MUSIC_POSITION', Configuration::get('MUSIC_POSITION')) == 1)
		{
			$mp3_sql = 'SELECT a.*, b.* , c.reduction, c.reduction_type FROM `' . _DB_PREFIX_ . 'music_shop` AS a INNER JOIN `' . _DB_PREFIX_ . 'product` AS b ON a.linked_digital_id = "" AND a.product_id = ' . (int)Tools::getValue('id_product') . ' AND b.id_product = ' . (int)Tools::getValue('id_product') . ' LEFT JOIN `' . _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = ' . (int)Tools::getValue('id_product');
			$mp3 = Db::getInstance()->ExecuteS($mp3_sql);
			$associated_mp3_sql = 'SELECT a.*, b.* , c.reduction, c.reduction_type FROM `' . _DB_PREFIX_ . 'music_shop` AS a INNER JOIN `' . _DB_PREFIX_ . 'product` AS b ON a.linked_digital_id != "" AND a.product_id = ' . (int)Tools::getValue('id_product') . ' AND b.id_product = a.linked_digital_id LEFT JOIN `' . _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = b.id_product';
			$associated_mp3 = Db::getInstance()->ExecuteS($associated_mp3_sql);
			if (version_compare(_PS_VERSION_, '1.5.6.2', '<') == 1)
			{
				$this->context->smarty->assign(array(
					'product_mp3' => $mp3,
					'associated_mp3' => $associated_mp3,
				));
			}
		    else
			{
				$this->smarty->assign(array(
					'product_mp3' => $mp3,
					'associated_mp3' => $associated_mp3,
				));
			}

			if (version_compare(_PS_VERSION_, '1.5.6.2', '>') == 1)
			{
				return $this->display(__FILE__, 'views/templates/front/column.tpl');
			}
     	    else
			{
				return $this->display(__FILE__, 'views/templates/front/column15.tpl');
			}

		}

	}



	public function hookDisplayProductTabContent()
	{
		if (Tools::getValue('MUSIC_POSITION', Configuration::get('MUSIC_POSITION')) == 2)
		{
			$mp3_sql = 'SELECT a.*, b.* , c.reduction, c.reduction_type FROM `' . _DB_PREFIX_ . 'music_shop` AS a INNER JOIN `' . _DB_PREFIX_ . 'product` AS b ON a.linked_digital_id = "" AND a.product_id = ' . (int)Tools::getValue('id_product') . ' AND b.id_product = ' . (int)Tools::getValue('id_product') . ' LEFT JOIN `' . _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = ' . (int)Tools::getValue('id_product');
			$mp3 = Db::getInstance()->ExecuteS($mp3_sql);
			$associated_mp3_sql = 'SELECT a.*, b.* , c.reduction, c.reduction_type FROM `' . _DB_PREFIX_ . 'music_shop` AS a INNER JOIN `' . _DB_PREFIX_ . 'product` AS b ON a.linked_digital_id != "" AND a.product_id = ' . (int)Tools::getValue('id_product') . ' AND b.id_product = a.linked_digital_id LEFT JOIN `' . _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = b.id_product';
			$associated_mp3 = Db::getInstance()->ExecuteS($associated_mp3_sql);
			if (version_compare(_PS_VERSION_, '1.5.6.2', '<') == 1)
			{
				$this->context->smarty->assign(array(
					'product_mp3' => $mp3,
					'associated_mp3' => $associated_mp3,
				));
			}
		    else
			{
				$this->smarty->assign(array(
					'product_mp3' => $mp3,
					'associated_mp3' => $associated_mp3,
				));
			}

			if (version_compare(_PS_VERSION_, '1.5.6.2', '>') == 1)
			{
				return $this->display(__FILE__, 'views/templates/front/product_tab_content.tpl');
			}
		    else
			{
				return $this->display(__FILE__, 'views/templates/front/product_tab_content15.tpl');
			}

		}

	}


	public function hookDisplayProductListReviews($params)
	{
		$id_product = (int)$params['product']['id_product'];

		/*if (!$this->isCached('list.tpl', $this->getCacheId($id_product)))

		{*/

			$mp3_sql = 'SELECT a.*, b.* , c.reduction, c.reduction_type FROM `' 

			. _DB_PREFIX_ . 'music_shop` AS a INNER JOIN `' 

			. _DB_PREFIX_ . 'product` AS b ON a.linked_digital_id = "" AND a.product_id = ' 

			. $id_product . ' AND b.id_product = '.(int)$id_product.' LEFT JOIN `' 

			. _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = '.(int)$id_product;

			$mp3 = Db::getInstance()->ExecuteS($mp3_sql);

			$associated_mp3_sql = 'SELECT a.*, b.* , c.reduction, c.reduction_type FROM `' 

			. _DB_PREFIX_ . 'music_shop` AS a INNER JOIN `' 

			. _DB_PREFIX_ . 'product` AS b ON a.linked_digital_id != "" AND a.product_id = ' 

			. (int)$id_product .' AND b.id_product = a.linked_digital_id LEFT JOIN `' 

			. _DB_PREFIX_ . 'specific_price` AS c ON c.id_product = b.id_product';

			$associated_mp3 = Db::getInstance()->ExecuteS($associated_mp3_sql);

			/*

		}*/

		$this->context->smarty->assign(array(			
			'associated_mp3' => $associated_mp3,
		));

			return $this->display(__FILE__, 'mp3_button.tpl');		
	}



	public function getCacheId($id_product = null)

	{

		return parent::getCacheId().'|'.(int)$id_product;

	}



	public function hookActionProductUpdate()
	{
		if (Tools::getValue('deletelinkIdMusic'))
		{
			$delete_list_sql = 'DELETE FROM `' . _DB_PREFIX_ . 'music_shop` WHERE `id` = ' . (int)Tools::getValue('deletelinkIdMusic') . '';
			if (!Db::getInstance()->Execute($delete_list_sql)) return false;
			return true;
		}

		if (Tools::isSubmit('submitMusic') && Tools::getValue('VIDEO_LINK') == "")
		{
			if (!isset($_FILES['NEW_MEDIA_MP3']) && !Tools::getValue('NEW_MEDIA_AUTHOR')) 
				return $this->displayError($this->l('Invalid MP3 file or you did not complete all the fields'));
			 else
			 {
				$file_name = $_FILES['NEW_MEDIA_MP3'];
				if (!move_uploaded_file($_FILES['NEW_MEDIA_MP3']['tmp_name'], dirname(__FILE__) . DIRECTORY_SEPARATOR . 'mp3' . DIRECTORY_SEPARATOR . $file_name['name'])) 
					return $this->displayError($this->l('An error occurred while attempting to upload the file.'));
				else
				{
					$values['NEW_MEDIA_MP3'] = $file_name;
					$update_mp3_values = true;
				}
			 }

			if ($update_mp3_values)
			{
				if (Tools::getValue('virtual_prod_assoc') != 0)
				{
					Db::getInstance()->execute('INSERT INTO `' . _DB_PREFIX_ . 'music_shop` (mp3_name,mp3_title,author,product_id,linked_digital_id)
						VALUES ("' . $values['NEW_MEDIA_MP3']['name'] . '","' . Tools::getValue('NEW_MEDIA_TITLE') . '","' . Tools::getValue('NEW_MEDIA_AUTHOR') . '","' . (int)Tools::getValue('id_product') . '","' . (int)Tools::getValue('virtual_prod_assoc') . '");');

				}
				else
				{
					Db::getInstance()->execute('INSERT INTO `' . _DB_PREFIX_ . 'music_shop` (mp3_name,mp3_title,author,product_id)
						VALUES ("' . $values['NEW_MEDIA_MP3']['name'] . '","' . Tools::getValue('NEW_MEDIA_TITLE') . '","' . Tools::getValue('NEW_MEDIA_AUTHOR') . '","' . (int)Tools::getValue('id_product') . '");');

				}

				return true;

			}

		}

	}



	public function hookDisplayAdminProductsExtra()
	{
		if (Validate::isLoadedObject($product = new Product((int)Tools::getValue('id_product'))))
		{
			$get_list_sql = 'SELECT * FROM `' . _DB_PREFIX_ . 'music_shop` WHERE `product_id` = ' . (int)Tools::getValue('id_product') . ';';
			$default_lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
			if ($list_result = Db::getInstance()->ExecuteS($get_list_sql))
			{
				$this->fields_list = array(
					'id_music_shop' => array(
						'title' => $this->l('ID') ,
						'width' => 20,
						'type' => 'text',
					) ,
					'mp3_title' => array(
						'title' => $this->l('Mp3 Title') ,
						'width' => 140,
						'type' => 'text',
					) ,
					'mp3_name' => array(
						'title' => $this->l('Mp3 Name') ,
						'width' => 140,
						'type' => 'text',
					) ,
					'linked_digital_id' => array(
						'title' => $this->l('Associated Product ID') ,
						'width' => 50,
						'type' => 'text',
					) ,
				);
			 }

				$helper_list = new HelperList();
				$helper_list->shopLinkType = '';
				$helper_list->simple_header = true;
				// Actions to be displayed in the "Actions" column
				$helper_list->actions = array(
					'delete'
				);
				$helper_list->identifier = 'id';
				$helper_list->show_toolbar = true;
				$helper_list->title = 'Mp3 songs previews active for this product';
				$helper_list->table = _DB_PREFIX_ . 'music_shop';
				$helper_list->token = Tools::getValue('token');
				$helper_list->currentIndex = AdminController::$currentIndex;
				// Get All Virtual Products and assign them to variables
				$get_virtual_products = 'SELECT a.*, b.* FROM `' . _DB_PREFIX_ . 'product_download` AS a INNER JOIN `' . _DB_PREFIX_ . 'product_lang` AS b ON a.active = 1 AND a.id_product = b.id_product AND b.id_lang = ' . $default_lang->id . '';
				$virtual_products = Db::getInstance()->ExecuteS($get_virtual_products);
				
			if (version_compare(_PS_VERSION_, '1.5.6.2', '<') == 1)
			{
				$this->context->smarty->assign(array(
					'product_id' => (int)Tools::getValue('id_product') ,
					'product_lang_id' => $default_lang->id,
					'virtual_products' => $virtual_products,
					'max_mp3_size' => ini_get('upload_max_filesize') ,
					'db_prefix' => _DB_PREFIX_
				));
			}
			else
			{
				$this->smarty->assign(array(
					'product_id' => (int)Tools::getValue('id_product'),
					'product_lang_id' => $default_lang->id,
					'virtual_products' => $virtual_products,
					'max_mp3_size' => ini_get('upload_max_filesize'),
					'db_prefix' => _DB_PREFIX_
				));
			 }

			if (version_compare(_PS_VERSION_, '1.5.6.2', '>') == 1)
			{
				return $this->display(__FILE__, 'views/templates/admin/admintemplatefront.tpl') . $helper_list->generateList($list_result, $this->fields_list);
			}
			else
			{
				return $this->display(__FILE__, 'views/templates/admin/admintemplatefront15.tpl') . $helper_list->generateList($list_result, $this->fields_list);
			}
		}
	}

	public function clearCache()
	{
		$this->_clearCache('bar-ui.tpl');
		$this->_clearCache('mp3_button.tpl');
	}

	public function displayStatus($id_music, $active)
	{
		$title = ((int)$active == 0 ? $this->l('Disabled') : $this->l('Enabled'));
		$icon = ((int)$active == 0 ? 'icon-remove' : 'icon-check');
		$class = ((int)$active == 0 ? 'btn-danger' : 'btn-success');
		$html = '<a class="btn '.$class.'" href="'.AdminController::$currentIndex.
			'&configure='.$this->name.'
				&token='.Tools::getAdminTokenLite('AdminModules').'
				&changeStatus&id_music='.(int)$id_music.'" title="'.$title.'"><i class="'.$icon.'"></i> '.$title.'</a>';
		return $html;
	}

	public function musicExists($id_music)
	{
		$req = 'SELECT hs.`id_music_shop` as id_music
				FROM `'._DB_PREFIX_.'homeslider` hs
				WHERE hs.`id_music_shop` = '.(int)$id_music;
		$row = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow($req);
		return ($row);
	}
}

?>