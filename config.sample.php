<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 站点配置文件
 */

return array(
    'database'  => array(
        'server'     => array(
            'host'   => 'mysql',
            'port'   => 3306,
            'db'     => 'maidx_map',
            'prefix' => 'maidx_'
        ),
        'authentication' => array(
            'user'       => 'root',
            'pass'       => ''
        )
    ),
    'dxservice' => array(
        'url'   => 'http://wc.wahlap.net/maidx/rest/location'
    )
);
