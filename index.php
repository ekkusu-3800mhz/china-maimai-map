<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 入口文件
 */

// 检测PHP环境
if (version_compare(PHP_VERSION, '5.3.0', '<')) {
    die('PHP版本过低，请更新PHP至5.3.0以上版本');
}

// 开启调试模式 建议开发阶段开启 部署阶段注释或者设为false
define('APP_DEBUG', false);

// 绑定模块
define('BIND_MODULE', 'Map');

// 定义环境常量
define('APP_PATH', './App/');
define('SITE_ROOT', dirname(__FILE__));
define('BASE_URL', '');

// 引入ThinkPHP入口文件
require './Framework/ThinkPHP.php';
