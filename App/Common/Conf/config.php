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

    /* MySQL数据源配置 */

    'DB_TYPE'              => 'mysql',
    'DB_HOST'              => $config['datasource']['mysql']['host'],
    'DB_PORT'              => $config['datasource']['mysql']['port'],
    'DB_USER'              => $config['datasource']['mysql']['user'],
    'DB_PWD'               => $config['datasource']['mysql']['password'],
    'DB_NAME'              => $config['datasource']['mysql']['database'],
    'DB_PREFIX'            => $config['datasource']['mysql']['prefix'],
    'DB_CHARSET'           => 'utf8',

    /* 数据缓存配置 */

    'DATA_CACHE_TYPE'      => 'Redis',
    'REDIS_HOST'           => $config['cache']['redis']['host'],
    'REDIS_PORT'           => $config['cache']['redis']['port'],
    'REDIS_AUTH'           => $config['cache']['redis']['password'],
    'REDIS_TIMEOUT'        => '300',
    'DATA_CACHE_PREFIX'    => $config['cache']['redis']['prefix'],
    'DATA_CACHE_TIME'      => $config['cache']['redis']['expires'],

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

    /* 杂项配置 */

    'SITE_NAME'            => '舞萌DX店铺分布可视化地图',
    'PAGE_TITLE_DELIMITER' => '-',
    'ACTION_SUFFIX'        => 'Action',
    'URL_MODEL'            => 2,
    'URL_CASE_INSENSITIVE' => true

);
