<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description API控制器扩展类
 *  @package Map\Lib\Controller
 */

namespace Map\Lib\Controller;

use \Think\Controller,
    \Think\Exception;

class Api extends Controller {

    /**
     *  API数据存储对象
     *
     *  @var array
     */

    protected $data = array();

    /**
     *  API返回状态码存储对象
     *
     *  @var int
     */

    protected $status = 200;

    /**
     *  模型实例存储对象
     *
     *  @var \StdClass
     */

    protected $model;

    /**
     *  引用类库实例存储对象
     *
     *  @var \StdClass
     */

    protected $import;

    /**
     *  构造函数
     *
     *  @return void
     */

    public function __construct() {
        parent::__construct();
        $this->model = new \StdClass();
        $this->import = new \StdClass();
    }

    /**
     *  空操作
     *
     *  @return void
     */

    public function _empty() {
        $this->setStatus(404)->setData(array('error' => 'Invalid Request'));
    }

    /**
     *  对客户端请求作出响应
     *
     *  @param string $type 请求方式 (GET/POST)
     *  @param callback $action API操作的回调函数体
     *  @return void
     */

    protected function response($type, $action) {
        if ((I('server.REQUEST_METHOD') == $type) || (strtolower(I('server.REQUEST_METHOD')) == $type)) {
            call_user_func($action);
        } else {
            $this->setStatus(404)->setData(array('error' => 'Invalid Request'));
        }
    }

    /**
     *  绑定数据
     *
     *  @param array $data 返回的数据集合而成的数组
     *  @return Common\Lib\Controller
     */

    protected function setData(array $data) {
        foreach ($data as $key => $value) {
            $this->data[$key] = $value;
        }
        return $this;
    }

    /**
     *  设置返回状态码
     *
     *  @param int $status 状态码
     *  @return Common\Lib\Controller
     */

    protected function setStatus($status) {
        if (!is_numeric($status) || $status < 100) {
            $this->status = 200;
        } else {
            $this->status = $status;
        }
        return $this;
    }

    /**
     *  输出API结果
     *
     *  @return void
     */

    protected function output() {
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: no-store, no-cache, must-revalidate");
        header("Cache-Control: post-check=0, pre-check=0", false);
        header("Pragma: no-cache");
        header("Content-Type: application/json; charset=utf-8");
        header("Access-Control-Allow-Origin: *");
        if (empty($this->data)) {
            $result = array('status' => $this->status);
        } else {
            $result = array('status' => $this->status, 'data' => $this->data);
        }
        print json_encode($result);
    }

    /**
     *  析构函数
     *
     *  @return void
     */

    public function __destruct() {
        $this->output();
        parent::__destruct();
    }

}
