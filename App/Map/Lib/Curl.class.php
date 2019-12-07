<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description cURL操作封装类
 *  @package Map\Lib
 */

namespace Map\Lib;

use \Think\Exception;

class Curl {

    /**
     *  cURL句柄存储变量
     *
     *  @var resource
     */

    private $_curl;

    /**
     *  请求URL存储变量
     *
     *  @var string
     */

    private $_requestUrl;

    /**
     *  请求参数存储变量
     *
     *  @var array
     */

    private $_requestData = array();

    /**
     *  cURL原始结果存储变量
     *
     *  @var mixed
     */

    private $_rawResult;

    /**
     *  构造函数
     *
     *  @param string $url 请求URL
     *  @return void
     */

    public function __construct($url) {
        if (empty($url)) {
            throw new Exception('请求URL不能为空');
        }
        $this->_requestUrl = $url;
        $this->_init();
    }

    /**
     *  初始化cURL句柄
     *
     *  @return void
     */

    private function _init() {
        $this->_curl = curl_init();
        $option = array(
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_HEADER         => 0
        );
        curl_setopt_array($this->_curl, $option);
    }

    /**
     *  为请求附上参数
     *
     *  @param array $data 请求数据
     *  @return Server\Lib\Curl
     */

    public function data($data) {
        $this->_requestData = $data;
        return $this;
    }

    /**
     *  执行GET请求
     *
     *  @return Server\Lib\Curl
     */

    public function get() {
        if (!empty($this->_requestData)) {
            $this->_requestUrl .= '?' . http_build_query($this->_requestData);
        }
        curl_setopt($this->_curl, CURLOPT_URL, $this->_requestUrl);
        $this->_rawResult = curl_exec($this->_curl);
        return $this;
    }

    /**
     *  执行POST请求
     *
     *  @return Server\Lib\Curl
     */

    public function post() {
        $option = array(
            CURLOPT_URL  => $this->_requestUrl,
            CURLOPT_POST => true
        );
        if (!empty($this->_requestData)) {
            $option[CURLOPT_POSTFIELDS] = http_build_query($this->_requestData);
        }
        curl_setopt_array($this->_curl, $option);
        $this->_rawResult = curl_exec($this->_curl);
        return $this;
    }

    /**
     *  输出抓取结果
     *
     *  @param boolean $convertArray 数组转换标记
     *  @return mixed
     */

    public function result($convertArray = false) {
        if ($convertArray) {
            return json_decode($this->_rawResult, true);
        } else {
            return $this->_rawResult;
        }
    }

}
