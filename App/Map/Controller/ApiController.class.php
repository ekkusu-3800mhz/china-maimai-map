<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description API控制器类
 *  @package Map\Controller
 */

namespace Map\Controller;

use \Map\Lib\Controller\Api,
    \Map\Model\DataSourceModel,
    \Think\Exception;

class ApiController extends Api {

    /**
     *  构造函数
     *
     *  @return void
     */

    public function __construct() {
        parent::__construct();
        $this->model->dataSource = new DataSourceModel();
    }

    /**
     *  查询店铺列表操作
     *
     *  @return void
     */

    public function queryAction() {
        $this->response('get', function() {
            $result = $this->model->dataSource->queryShop(I('get.query'));
            $this->setStatus(200)->setData($result);
        });
    }

}
