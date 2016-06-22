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

    foreach ($musics as $key => $music)
    {
      $musics[$key]['status'] = RoanjaMusicShop::displayStatus($music['id_music'], $music['active']);
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

		return $this->module->display($this->file, 'list.tpl');
	}
}
