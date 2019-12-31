<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 首页重定向用控制器
 *  @package Map\Controller
 */

namespace Map\Controller;

use \Map\Lib\Controller\Webpage,
    \Map\Lib\Curl,
    \Think\Exception;

class IndexController extends Webpage {

    /**
     *  地图首页操作
     *
     *  @return void
     */

    public function indexAction() {
        $this->redirectTo('page/map');
    }

    /**
     *  每日机台分布数据下载操作
     *
     *  @return void
     */

    public function dailyDataDownloadAction() {
        $file = SITE_ROOT . DIRECTORY_SEPARATOR . 'App' . DIRECTORY_SEPARATOR . 'Runtime' . DIRECTORY_SEPARATOR . 'Temp' . DIRECTORY_SEPARATOR . 'dailydata.json';
        $raw = (new Curl(C('API_URL')))->get()->result(true);
        $dailyData = array(
            'date' => date('Y-m-d'),
            'data' => $raw
        );
        if (file_put_contents($file, json_encode($dailyData)) !== false) {
            die('OK' . PHP_EOL);
            header('HTTP/1.1 200 OK');
        } else {
            die('ERROR ON WRITING' . PHP_EOL);
            header('HTTP/1.1 404 Not Found');
        }
    }

}
