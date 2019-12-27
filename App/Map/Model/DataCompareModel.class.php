<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 店铺数据对比模型类
 *  @package Map\Model
 */

namespace Map\Model;

use \Map\Lib\Curl,
    \Think\Exception;

class DataCompareModel {

    /**
     *  店铺数据接口URL存储变量
     *
     *  @var string
     */

    private $_apiUrl;

    /**
     *  店铺实时数据存储数组
     *
     *  @var array
     */

    private $_realtimeData = array();

    /**
     *  店铺昨日数据存储数组
     *
     *  @var array
     */

    private $_dailyData = array();

    /**
     *  数据发生变动的店铺数据存储数组
     *
     *  @var array
     */

    private $_compared = array();

    /**
     *  构造函数
     *
     *  @return void
     */

    public function __construct() {
        $this->_apiUrl = C('API_URL');
        $this->_realtimeData = (new Curl($this->_apiUrl))->get()->result(true);
        $this->_getDailyData();
        $this->_compare();
    }

    /**
     *  读取稍旧的店铺数据
     *
     *  @return void
     */

    private function _getDailyData() {
        $file = SITE_ROOT . DIRECTORY_SEPARATOR . 'App' . DIRECTORY_SEPARATOR . 'Runtime' . DIRECTORY_SEPARATOR . 'Temp' . DIRECTORY_SEPARATOR . 'dailydata.json';
        $data = json_decode(file_get_contents($file), true);
        $this->_dailyData = $data['data'];
    }

    /**
     *  比较数据
     *
     *  @return void
     */

    private function _compare() {
        $data = array();
        foreach ($this->_realtimeData as $realtime) {
            if (array_search($realtime, $this->_dailyData) === false) {
                $data[] = $realtime;
            }
        }
        $this->_compared = $data;
    }

    /**
     *  对店铺数据进行比对
     *
     *  @return array
     */

    public function getCompared() {
        $machine = 0;
        foreach ($this->_compared as $compared) {
            $machine += $compared['machineCount'];
        }
        return array(
            'count' => array(
                'shop'    => count($this->_compared),
                'machine' => $machine
            ),
            'data'  => $this->_compared
        );
    }
}
