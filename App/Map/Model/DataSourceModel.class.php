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

use \Think\Model,
    \Map\Lib\Curl,
    \Think\Exception;

class DataSourceModel extends Model {

    /**
     *  定义数据表名称
     *
     *  @var string
     */

    protected $tableName = 'location_fix';

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
        parent::__construct();
        $this->_apiUrl = C('API_URL');
        $raw = (new Curl($this->_apiUrl))->get()->result(true);
        $data = array();
        foreach ($raw as $shop) {
            $data[] = array(
                'id'       => $shop['id'],
                'name'     => $shop['arcadeName'],
                'province' => $shop['province'],
                'address'  => $shop['address'],
                'count'    => $shop['machineCount'],
                'lnglat'   => NULL
            );
        }
        $this->_rawData = $data;
        $this->_fixLocation();
    }

    /**
     *  对店铺位置进行纠偏
     *
     *  @return void
     */

    private function _fixLocation() {
        $result = $this->order('shop_id ASC')->select();
        for ($i = 0; $i < count($this->_rawData); $i++) {
            foreach ($result as $fix) {
                if ($this->_rawData[$i]['id'] == $fix['shop_id']) {
                    $this->_rawData[$i]['lnglat'] = json_decode($fix['shop_location'], true);
                }
            }
        }
    }

    /**
     *  按照店铺名称片段过滤结果
     *
     *  @param string $query 查询字段
     *  @return array
     */

    public function queryShop($query = '') {
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
            if (strpos($shop['province'], $query) !== false) {
                $result[] = $shop;
            }
        }
        return array(
            'count' => count($result),
            'rows'  => $result
        );
    }

    /**
     *  统计各省份所拥有的机台数量
     *
     *  @return array
     */

    public function getStats() {
        $provinces = array();
        $stats = array();
        $shopNum = 0;
        $machineNum = 0;
        foreach ($this->_rawData as $raw) {
            $provinces[] = $raw['province'];
        }
        $provincesUnique = array_unique($provinces);
        for ($i = 0; $i < count($this->_rawData); $i++) {
            foreach ($provincesUnique as $prov) {
                if ($this->_rawData[$i]['province'] == $prov) {
                    $stats[$prov]['machine'] += $this->_rawData[$i]['count'];
                    $machineNum += $this->_rawData[$i]['count'];
                }
            }
        }
        foreach (array_count_values($provinces) as $prov => $num) {
            $stats[$prov]['shop'] = $num;
            $shopNum += $num;
        }
        return array(
            'count' => array(
                'shop'    => $shopNum,
                'machine' => $machineNum
            ),
            'stats' => $stats
        );
    }

}
