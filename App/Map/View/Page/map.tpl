<!DOCTYPE html>
<html lang="zh_CN">
    <head>
        <meta charset="utf-8">
        <meta name="theme-color" content="#222">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <title>{{$pageTitle}}</title>
        <link rel="icon" type="image/x-icon" href="__IMG__/favicon.png">
        <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <style type="text/css">
            html {
                height: 100%;
            }
            body {
                height: 100%;
                margin: 0px;
                padding-top: 51px;
                font-family: "Noto Sans CJK SC", 微软雅黑, Arial, 黑体, 宋体, sans-serif !important;
            }
            #map {
                width: 100%;
                height: 100%;
                overflow: hidden;
                margin: 0;
            }
            #loader {
                position: absolute;
                width: 100%;
                height: 100%;
                text-align: center;
                z-index: 1000;
                top: 0px;
                left: 0px;
                background-color: rgba(0, 0, 0, 0.8);
                color: #fff;
            }
            #loader > img {
                -webkit-animation:fa-spin 5s infinite linear;
                animation:fa-spin 5s infinite linear
            }
            #loader > p {
                padding-top: 15px;
            }
            @media (max-width: 768px) {
                #loader {
                    padding-top: 280px;
                }
            }
            @media (min-width: 768px) {
                #loader {
                    padding-top: 340px;
                }
            }
        </style>
        <!--[if lt IE 9]>
            <script src="https://cdn.bootcss.com/html5shiv/r29/html5.min.js"></script>
            <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a href="#" id="home" class="navbar-brand">舞萌DX店铺分布可视化地图</a>
                </div>
                <div class="collapse navbar-collapse" id="navbar-collapse">
                    <form id="search-form" class="navbar-form navbar-left">
                        <div class="form-group">
                            <div class="input-group">
                                <input id="query" type="text" name="query" class="form-control" placeholder="键入省份或店铺名称..." required>
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-primary"><span class="fa fa-search"></span> 搜索店铺</button>
                                </span>
                            </div>
                        </div>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/page/stats.html"><span class="fa fa-bar-chart"></span> 机台分布统计</a></li>
                        <li><a href="http://wc.wahlap.net/maidx/location/index.html" target="_blank"><span class="fa fa-window-restore"></span> 官方店铺列表</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div id="map"></div>
        <div id="loader">
            <img src="__IMG__/favicon.png">
            <p>Now Loading</p>
        </div>
        <script src="https://cdn.bootcss.com/jquery/1.10.0/jquery.min.js"></script>
        <script src="https://cdn.bootcss.com/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://api.map.baidu.com/api?v=3.0&ak=B76Awux7dA2KsTvntDGj0cpw2yWQi4GM"></script>
        <script type="text/javascript">
            $(document).ready(function() {

                /**
                 *  初始化百度地图
                 */

                var queryUrl = '{{$apiUrl}}';
                var map = new BMap.Map("map");
                var point = new BMap.Point(114.313886,30.601948);
                var geolocation = new BMap.Geolocation();
                var geocoder = new BMap.Geocoder();
                map.centerAndZoom(point, 6);
                map.enableScrollWheelZoom(true);
                map.addControl(new BMap.ScaleControl());
                map.addControl(new BMap.NavigationControl());
                map.addControl(new BMap.GeolocationControl({offset: new BMap.Size(15, 50)}));

                /**
                 *  封装快捷添加标记点函数
                 *
                 *  @param {BMap.Point} point 百度地图点对象
                 *  @param {Object} attr 标记点属性
                 *  @return {Void}
                 */

                function addMarker(point, attr) {
                    if (attr.count > 1) {
                        var icon = '__IMG__/map-icon-multi.png';
                    } else {
                        var icon = '__IMG__/map-icon-single.png';
                    }
                    var dxIcon = new BMap.Icon(icon, new BMap.Size(40, 40), {
                        anchor: new BMap.Size(20, 20)
                    });
                    var marker = new BMap.Marker(point, {icon: dxIcon});
                    map.addOverlay(marker);
                    var opts = {
                        width: 250,
                        height: 110,
                        title: attr.title
                    }
                    var infoWindow = new BMap.InfoWindow(attr.content, opts);
                    marker.addEventListener("click", function() {
                        map.openInfoWindow(infoWindow, point);
                    });
                }

                /**
                 *  封装XHR事件函数
                 *
                 *  @param {jqXHR} xhr jQuery XHR对象
                 *  @param {Boolean} setCenter 是否设置中点
                 *  @return {Void}
                 */

                function addXhrEvents(xhr, setCenter) {
                    xhr.done(function(res) {
                        if (res.status == 200) {
                            map.clearOverlays();
                            var shops = res.data.rows;
                            var multi = false;
                            if (shops.length > 1) {
                                multi = true;
                            }
                            shops.forEach(function(shop) {
                                geocoder.getPoint(shop.address, function(point) {
                                    if (point) {
                                        var attr = {
                                            title: `${shop.name}`,
                                            content: `<span style="font-size: 11px; color: #666;">店铺地址：${shop.address}</span><br><span style="font-size: 11px; color: #666;">机台数量：${shop.count}组</span>`,
                                            count: shop.count
                                        };
                                        if (shop.lnglat != null) {
                                            point = new BMap.Point(shop.lnglat.lng, shop.lnglat.lat);
                                        }
                                        addMarker(point, attr);
                                        if (setCenter) {
                                            if (multi) {
                                                map.centerAndZoom(point, 6);
                                            } else {
                                                map.centerAndZoom(point, 17);
                                            }
                                        }
                                    }
                                }, shop.province);
                            });
                        } else {
                            alert('发生请求错误，请刷新页面重试');
                        }
                    });
                    xhr.fail(function() {
                        alert('发生请求错误，请刷新页面重试');
                    });
                    xhr.always(function() {
                        $('#loader').fadeOut('fast');
                        geolocation.getCurrentPosition(function(res) {
                            if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                                map.panTo(res.point);
                            }
                        });
                    });
                }

                /**
                 *  通过Ajax加载所有店铺
                 */

                var xhr = $.get(queryUrl);
                addXhrEvents(xhr, false);

                $('#home').on('click', function(e) {
                    e.preventDefault();
                    $('#loader').fadeIn('fast');
                    var query = $('#query').val();
                    xhr = $.get(queryUrl);
                    addXhrEvents(xhr, false);
                });

                $('#search-form').on('submit', function(e) {
                    e.preventDefault();
                    $('#loader').fadeIn('fast');
                    var query = $('#query').val();
                    xhr = $.get(queryUrl + '?query=' + query);
                    addXhrEvents(xhr, true);
                });

            });
        </script>
    </body>
</html>
