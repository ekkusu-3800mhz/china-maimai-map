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

}
