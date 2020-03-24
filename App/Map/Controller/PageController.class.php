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
    \Map\Model\DataSourceModel,
    \Think\Exception;

class PageController extends Webpage {

    /**
     *  构造函数
     *
     *  @return void
     */

    public function __construct() {
        parent::__construct();
        $this->model->data = new DataSourceModel();
    }

    /**
     *  地图首页操作
     *
     *  @return void
     */

    public function mapAction() {
        $this->page('get', function() {
            if (!empty(I('get.location'))) {
                $this->assign('query', I('get.location'));
            }
            if (!empty(I('get.query'))) {
                $this->assign('query', I('get.query'));
            }
            $this->assign('apiUrl', BASE_URL . '/api/query.json');
            $this->display();
        });
    }

    /**
     *  机台数据变更一览页面操作
     *
     *  @return void
     */

    public function statsAction() {
        $this->page('get', function() {
            $opr = array(
                'start' => strtotime(date('Y-m-d') . ' ' . C('DAILY_STAT_OPR_START')),
                'stop'  => strtotime(date('Y-m-d') . ' ' . C('DAILY_STAT_OPR_STOP')),
            );
            $now = time();
            if (($now >= $opr['start']) && ($now <= $opr['stop'])) {
                $this->assign('isOpr', true);
                $this->assign('oprStart', C('DAILY_STAT_OPR_START'));
                $this->assign('oprStop', C('DAILY_STAT_OPR_STOP'));
            } else {
                $result = $this->model->data->getStats();
                $this->assign('isOpr', false);
                $this->assign('oprStart', C('DAILY_STAT_OPR_START'));
                $this->assign('time', date('Y-m-d H:i'));
                $this->assign('total', $result['total']);
                $this->assign('delta', $result['delta']);
                $this->assign('shop', $result['shop']);
            }
            $this->display();
        }, '机台数据变更一览');
    }

}
