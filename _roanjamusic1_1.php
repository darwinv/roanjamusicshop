<?php
/*
* 2007-2015 PrestaShop
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
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

class RoanjaMusic extends ObjectModel
{
	public $mp3_name;
	public $mp3_title;
	public $author;
	public $genero;
	public $linked_digital_id;
	public $active;
	public $position;
	public $id_shop;
	public $id_product;

	/**
	 * @see ObjectModel::$definition
	 */
	public static $definition = array(
		'table' => 'music_shop_item',
		'primary' => 'id_music_shop',
		'multilang' => true,
		'fields' => array(
			'active' =>			array('type' => self::TYPE_BOOL, 'validate' => 'isBool', 'required' => true),
			'position' =>		array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt', 'required' => true),
			

			// Lang fields
			//'mp3_name' =>		array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 255),
			'mp3_title' =>		array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 255),
			//'author' =>			array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 255),
			//'genero' =>			array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 255),
			'id_product' =>     array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
			//'linked_digital_id' =>	array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 255),
		)
	);

	public	function __construct($id_music = null, $id_lang = null, $id_shop = null, Context $context = null)
	{
		parent::__construct($id_music, $id_lang, $id_shop);
	}

	public function add($autodate = true, $null_values = false)
	{
		$context = Context::getContext();
		$id_shop = $context->shop->id;

		$res = parent::add($autodate, $null_values);
		$res &= Db::getInstance()->execute('
			INSERT INTO `'._DB_PREFIX_.'music_shop` (`id_shop`, `id_music_shop`)
			VALUES('.(int)$id_shop.', '.(int)$this->id.')'
		);
		return $res;
	}

	public function delete()
	{
		$res = true;

		$mp3_names = $this->mp3_name;
		foreach ($mp3_names as $mp3_name)
		{
			if (preg_match('/sample/', $image) === 0)
				if ($mp3_name && file_exists(dirname(__FILE__).'/mp3/'.$mp3_name))
					$res &= @unlink(dirname(__FILE__).'/mp3/'.$mp3_name);
		}

		$res &= $this->reOrderPositions();

		$res &= Db::getInstance()->execute('
			DELETE FROM `'._DB_PREFIX_.'music_shop`
			WHERE `id_music_shop` = '.(int)$this->id
		);

		$res &= parent::delete();
		return $res;
	}

	public function reOrderPositions()
	{
		$id_music = $this->id;
		$context = Context::getContext();
		$id_shop = $context->shop->id;

		$max = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
			SELECT MAX(hss.`position`) as position
			FROM `'._DB_PREFIX_.'music_shop_item` hss, `'._DB_PREFIX_.'music_shop` hs
			WHERE hss.`music_shop_item` = hs.`id_music_shop` AND hs.`id_shop` = '.(int)$id_shop
		);

		if ((int)$max == (int)$id_music)
			return true;

		$rows = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
			SELECT hss.`position` as position, hss.`id_music_shop` as id_music
			FROM `'._DB_PREFIX_.'music_shop_item` hss
			LEFT JOIN `'._DB_PREFIX_.'music_shop` hs ON (hss.`id_music_shop` = hs.`id_music_shop`)
			WHERE hs.`id_shop` = '.(int)$id_shop.' AND hss.`position` > '.(int)$this->position
		);

		foreach ($rows as $row)
		{
			$current_music = new RoanjaMusic($row['id_music']);
			--$current_music->position;
			$current_music->update();
			unset($current_music);
		}

		return true;
	}

	public static function getAssociatedIdsShop($id_music)
	{
		$result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
			SELECT hs.`id_shop`
			FROM `'._DB_PREFIX_.'id_music` hs
			WHERE hs.`id_music_shop` = '.(int)$id_music
		);

		if (!is_array($result))
			return false;

		$return = array();

		foreach ($result as $id_shop)
			$return[] = (int)$id_shop['id_shop'];

		return $return;
	}

}
