<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 店铺数据模型类
 *  @package Map\Model
 */

namespace Map\Model;

use \Map\Lib\Curl,
    \Think\Exception;

class DataSourceModel {

    /**
     *  店铺数据接口URL存储变量
     *
     *  @var string
     */

    private $_apiUrl;

    /**
     *  店铺原始数据存储变量
     *
     *  @var array
     */

    private $_rawData = array();

    /**
     *  构造函数
     *
     *  @return void
     */

    public function __construct() {
        $this->_apiUrl = C('API_URL');
        $raw = (new Curl($this->_apiUrl))->get()->result(true);
        $data = array();
        foreach ($raw as $shop) {
            $data[] = array(
                'name'     => $shop['arcadeName'],
                'province' => $shop['province'],
                'address'  => $shop['address'],
                'count'    => $shop['machineCount']
            );
        }
        $this->_rawData = $data;
    }

    /**
     *  按照店铺名称片段过滤结果
     *
     *  @param string $query 查询字段
     *  @return array
     */

    public function queryShop($query) {
        if (empty($query)) {
            return array(
                'count' => count($this->_rawData),
                'rows'  => $this->_rawData
            );
        }
        $result = array();
        foreach ($this->_rawData as $shop) {
            if (strpos($shop['name'], $query) !== false) {
                $result[] = $shop;
            }
        }
        return array(
            'count' => count($result),
            'rows'  => $result
        );
    }

    /**
     *  获取已上线省份列表
     *
     *  @return array
     */

    public function getProvince() {
        $provinces = array();
        $data = array();
        foreach ($this->_rawData as $shop) {
            $provinces[] = $shop['province'];
        }
        foreach (array_unique($provinces) as $province) {
            $data[] = $province;
        }
        return $data;
    }

}
