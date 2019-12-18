<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 程序配置文件
 */

$config = require_once SITE_ROOT . DIRECTORY_SEPARATOR . 'config.php';

return array(

    /* 接口地址配置 */

    'API_URL'              => $config['dxservice']['url'],

    /* 模板变量配置 */

    'TMPL_TEMPLATE_SUFFIX' => '.tpl',
    'TMPL_L_DELIM'         => '{{',
    'TMPL_R_DELIM'         => '}}',
    'TMPL_PARSE_STRING'    => array(
        '__CSS__'          => BASE_URL . '/Static/css',
        '__IMG__'          => BASE_URL . '/Static/img',
        '__JS__'           => BASE_URL . '/Static/js'
    ),

    /* 每日机台分布数据下载操作认证参数 */

    'AUTH_USER'            => $config['dailydata']['authentication']['user'],
    'AUTH_PASS'            => password_hash($config['dailydata']['authentication']['pass'], PASSWORD_DEFAULT),

    /* 杂项配置 */

    'SITE_NAME'            => '舞萌DX店铺分布可视化地图',
    'PAGE_TITLE_DELIMITER' => '-',
    'ACTION_SUFFIX'        => 'Action',
    'URL_MODEL'            => 2,
    'URL_CASE_INSENSITIVE' => true

);
