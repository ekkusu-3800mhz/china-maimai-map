<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 页面控制器类
 *  @package Map\Controller
 */

namespace Map\Controller;

use \Map\Lib\Controller\Webpage,
    \Think\Exception;

class PageController extends Webpage {

    /**
     *  地图首页操作
     *
     *  @return void
     */

    public function mapAction() {
        $this->page('get', function() {
            $this->assign('apiUrl', BASE_URL . '/api/query.json');
            $this->display();
        });
    }

}
