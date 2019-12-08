/**
 *  舞萌DX店铺分布可视化地图
 *
 *  @author Hayao Midoriya <zs6096@gmail.com>
 *  @license WTFPL
 *  @description 店铺地理位置纠偏数据表
 */

DROP TABLE IF EXISTS maidx_location_fix;
CREATE TABLE maidx_location_fix (
    shop_id INT UNSIGNED NOT NULL COMMENT "店铺ID",
    shop_location TEXT NOT NULL COMMENT "店铺实际位置JSON对象（坐标系为BD09）",
    PRIMARY KEY (shop_id)
) ENGINE = MyISAM DEFAULT CHARSET = 'utf8';
