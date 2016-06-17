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
include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('roanjamusicshop.php');

$home_music = new RoanjaMusicShop();
$musics = array();

//if (!Tools::isSubmit('secure_key') || Tools::getValue('secure_key') != $home_music->secure_key || !Tools::getValue('action'))
//	die(1);

if(Tools::getValue("action") == "setUrlYoutube"){
    $table="rj_music_urlyt";
    $id_product=Tools::getValue("id_product");
    $url_music=Tools::getValue("url");
    $id_lang=Tools::getValue("language");
    $id_employe=Tools::getValue("employe");
    $has_url=Db::getInstance()->getValue("SELECT count(id_product) from " . _DB_PREFIX_ . "rj_music_urlyt "
            . "where id_product=" . (int)$id_product . " and id_lang=" . (int)$id_lang);
    if($has_url==0){
        $insert=array("id_product"=>$id_product,
                      "url_music"=>$url_music,
                      "id_lang"=>$id_lang,
                      "id_employer"=>$id_employe,
                      "status_url"=>1,
                     );
        $res=Db::getInstance()->insert($table,$insert);
    }else{
        $insert=array("url_music"=>$url_music,
                      "id_lang"=>$id_lang,
                      "id_employer"=>$id_employe,
                      "status_url"=>1,
                     );
        $res=Db::getInstance()->update($table, $insert,"id_product=" . (int)$id_product);
    }
}
if (Tools::getValue('action') == 'updateMusicPosition' && Tools::getValue('musics'))
{
	$musics = Tools::getValue('musics');

	foreach ($musics as $position => $id_music)
		$res = Db::getInstance()->execute('
			UPDATE `'._DB_PREFIX_.'rj_music` SET `position` = '.(int)$position.'
			WHERE `id_music` = '.(int)$id_music
		);

	$home_music->clearCache();
}
if(Tools::getValue('action')=='getSongs'){
    $id=Tools::getValue('id');
    $id_lang=Configuration::get('PS_LANG_DEFAULT');
    $id_shop=Configuration::get('PS_SHOP_ENABLE');
    $sql_songs="select a.price,b.* from `" . _DB_PREFIX_ . "product` as a,`" . _DB_PREFIX_ . "rj_music_lang` as b,`" . _DB_PREFIX_ . "rj_music_shop` as c
    where (`linked_digital_id`=" . (int)$id . " or b.id_product=" .(int)$id . ") and a.id_product=b.id_product
    and id_lang=" . $id_lang . " AND b.id_music=c.id_music and c.id_shop=" . (int)$id_shop;
    $res=Db::getInstance()->executeS($sql_songs);
    $images = Image::getImages((int)$id_lang, (int)$id);
    $id_image = Product::getCover($id);
    // get Image by id

     $image = new Image($id_image['id_image']);
     // get image full URL
     $image_url = _PS_BASE_URL_._THEME_PROD_DIR_.$image->getExistingImgPath().".jpg";

    $res[0]['cover']=$image_url;

    $res[0]['price']=$home_music->GetPriceFormat($res[0]['price']);
    
    echo json_encode($res);
}
if(Tools::getValue('action')=='setCookie'){
    if(!isset($_COOKIE['lista'])){
        $i=0;
        $lista=array();
    }else{
        $lista=unserialize($_COOKIE['lista']);
        $i=count($lista);
    }
    $res=Tools::getValue('song');
    foreach($res as $r=>$valor){
        $lista[$i]['id']=$valor["id_product"];
        $lista[$i]['name']=$valor["mp3_name"];
        $lista[$i]['title']=$valor["mp3_title"];
        $lista[$i]['id_music']=$valor["id_music"];
        $lista[$i]['price']=$valor["price"];
        $lista[$i]['youtube']=$valor["url_youtube"];
        $lista[$i]['genero']=$valor["genero"];
        $lista[$i]['author']=$valor["author"];
        $i++;
    }
    setcookie('lista', serialize($lista), time()+3600*24*30,'/');
}
if(Tools::getValue('action')=='removeSongs'){
    $id=(int)Tools::getValue('id');
    $lista=unserialize($_COOKIE['lista']);
    $listaId=$home_music->array_columns($lista,"id_music");
    for($i=0;$i<count($listaId);$i++){
        if($listaId[$i]==$id){
            unset($lista[$i]);
        }
    }
    $lista=array_values($lista);
    if(!empty($lista)){
        setcookie('lista', serialize($lista), time()+3600*24*30,'/');
    }else{
        setcookie('lista', serialize($lista), time()-3600,'/');
    }
}
if(Tools::getValue('action')=='removeSong'){
    $id=(int)Tools::getValue('id');
    $lista=unserialize($_COOKIE['lista']);
    $listaId=$home_music->array_columns($lista,"id_music");
    for($i=0;$i<count($listaId);$i++){
        if($listaId[$i]==$id){
            unset($lista[$i]);
        }
    }
    $lista=array_values($lista);
    if(!empty($lista)){
        setcookie('lista', serialize($lista), time()+3600*24*30,'/');
    }else{
        setcookie('lista', serialize($lista), time()-3600,'/');
    }
}
