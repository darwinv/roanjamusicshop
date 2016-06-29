<?php

class RoanjaMusicShopDisplayAdminProductsExtraController
{
	public function __construct($module, $file, $path)
	{
		$this->file = $file;
		$this->module = $module;
		$this->context = Context::getContext();
		$this->_path = $path;
	}

	public function run()
	{ 

    $musics = RoanjaMusicShop::getMusic();
//  $valores=$musics;
		// Build ajax url
$ajax_action_url =$this->context->link->getAdminLink('AdminModules', true);
$ajax_action_url = str_replace('index.php', 'ajax-tab.php',$ajax_action_url);
$action_url = $this->context->link->getAdminLink('AdminRoanjaMusicShop', true);

    foreach ($musics as $key => $music)
    {
      $musics[$key]['status'] = RoanjaMusicShop::displayStatus($music['id_music'], $music['active']);
      $associated_shop_ids = RoanjaMusic::getAssociatedIdsShop((int)$music['id_music']);
      if ($associated_shop_ids && count($associated_shop_ids) > 1)
        $musics[$key]['is_shared'] = true;
      else
        $musics[$key]['is_shared'] = false;
    }

		$this->context->smarty->assign('action_url', $action_url);
		$this->context->smarty->assign('ajax_action_url', $ajax_action_url);
		$this->context->smarty->assign('pc_base_dir', __PS_BASE_URI__.'modules/'.$this->module->name.'/');
    $this->context->smarty->assign(
      array(
        'id_product' => (int)Tools::getValue('id_product'),
        'link' => $this->context->link,
        'musics' => $musics,
        'music_baseurl' => $this->_path.'mp3/'
      )
    );

		return $this->module->display($this->file, 'list.tpl');
	}

}
