<?php
/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description Map模块静态路由表
 */

return array(
    'URL_ROUTER_ON'  => true,
    'URL_MAP_RULES'  => array(
        'page/map'   => 'Page/map',
        'page/stats' => 'Page/stats',
        'api/query'  => 'Api/query'
    )
);
