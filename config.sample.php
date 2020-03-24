<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 站点配置文件
 */

return array(
    'datasource' => array(
        'mysql' => array(
            'host'     => '127.0.0.1',
            'port'     => 3306,
            'user'     => '',
            'password' => '',
            'database' => '',
            'prefix'   => 'dxmap_',
        ),
    ),
    'cache' => array(
        'redis' => array(
            'host'     => '127.0.0.1',
            'port'     => 6379,
            'password' => NULL,
            'prefix'   => 'DXMAP_',
            'expires'  => 300,
        ),
    ),
    'dxservice' => array(
        'url'         => 'http://wc.wahlap.net/maidx/rest/location',
        'oprduration' => array(
            'start' => '04:00',
            'end'   => '07:00',
        ),
    ),
);
