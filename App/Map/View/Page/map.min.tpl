<!DOCTYPE html>
<html lang="zh_CN">
    <head>
        <meta charset="utf-8">
        <meta name="theme-color" content="#222">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <title>{{$pageTitle}}</title>
        <link rel="icon" type="image/x-icon" href="__IMG__/favicon.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+SC:400,700&display=swap">
        <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <style type="text/css">html{height:100%}body{height:100%;margin:0;padding-top:51px;font-family:"Noto Sans SC",微软雅黑,Arial,黑体,宋体,sans-serif!important}#map{width:100%;height:100%;overflow:hidden;margin:0}#loader{position:absolute;width:100%;height:100%;text-align:center;z-index:1000;top:0;left:0;background-color:rgba(0,0,0,0.8);color:#fff}#loader>img{-webkit-animation:fa-spin 5s infinite linear;animation:fa-spin 5s infinite linear}#loader>p{padding-top:15px}@media(max-width:768px){#loader{padding-top:280px}}@media(min-width:768px){#loader{padding-top:340px}}</style>
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
                                <input id="query" type="text" name="query" value="{{$query}}" class="form-control" placeholder="键入省份或店铺名称..." required>
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-primary"><span class="fa fa-search"></span> 搜索店铺</button>
                                </span>
                            </div>
                        </div>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/page/stats.html"><span class="fa fa-bar-chart"></span> 机台分布统计</a></li>
                        <li><a href="http://wc.wahlap.net/maidx/location/index.html" target="_blank"><span class="fa fa-window-restore"></span> 官方店铺列表</a></li>
                        <li><a href="https://www.wjx.cn/jq/52799413.aspx" target="_blank"><span class="fa fa-comment"></span> 问题反馈</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div id="map"></div>
        <div id="loader">
            <img src="__IMG__/favicon.png">
            <p>NOW LOADING</p>
        </div>
        <script src="https://cdn.bootcss.com/jquery/1.10.0/jquery.min.js"></script>
        <script src="https://cdn.bootcss.com/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://api.map.baidu.com/api?v=3.0&ak=B76Awux7dA2KsTvntDGj0cpw2yWQi4GM"></script>
        <script src="https://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
        <script src="https://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
        <script type="text/javascript">$(document).ready(function(){function f(l,k){if(k.count>1){var o="__IMG__/map-icon-multi.png"}else{var o="__IMG__/map-icon-single.png"}var q=new BMap.Icon(o,new BMap.Size(40,40),{anchor:new BMap.Size(20,20)});var m=new BMap.Marker(l,{icon:q});var p={width:250,height:110,title:k.title};var n=new BMap.InfoWindow(k.content,p);m.addEventListener("click",function(){a.openInfoWindow(n,l)});d.push(m)}function b(l,k){l.done(function(m){if(m.status==200){d=[];var o=m.data.rows;var n=false;if(o.length>1){n=true}o.forEach(function(p){c.getPoint(p.address,function(r){if(r){var q={title:p.name,content:'<span style="font-size: 11px; color: #666;">店铺地址：'+p.address+'</span><br><span style="font-size: 11px; color: #666;">机台数量：'+p.count+"组</span>",count:p.count};if(p.lnglat!=null){r=new BMap.Point(p.lnglat.lng,p.lnglat.lat)}f(r,q);if(k){if(n){a.centerAndZoom(r,6)}else{a.centerAndZoom(r,17)}}}},p.province)})}else{console.error(m.data.error);alert("发生请求错误，请刷新页面重试")}});l.fail(function(m){console.error(m);alert("发生请求错误，请刷新页面重试")});l.always(function(){setTimeout(function(){j.addMarkers(d);$("#loader").fadeOut("fast");e.getCurrentPosition()},800)})}var g="{{$apiUrl}}";var d=[];var a=new BMap.Map("map");var h=new BMap.Point(114.313886,30.601948);var e=new BMap.Geolocation();var c=new BMap.Geocoder();var j=new BMapLib.MarkerClusterer(a,{minClusterSize:2});a.centerAndZoom(h,6);a.enableScrollWheelZoom(true);a.addControl(new BMap.ScaleControl());a.addControl(new BMap.NavigationControl());a.addControl(new BMap.GeolocationControl({offset:new BMap.Size(15,50)}));var i=$.get(g+"?query={{$query}}");if("{{$query}}"==""){b(i,false)}else{b(i,true)}$("#home").on("click",function(l){l.preventDefault();j.clearMarkers();$("#loader").fadeIn("fast");var k=$("#query").val();i=$.get(g);history.pushState(null,"{{$pageTitle}}","map.html");b(i,false)});$("#search-form").on("submit",function(l){l.preventDefault();j.clearMarkers();$("#loader").fadeIn("fast");var k=$("#query").val();i=$.get(g+"?query="+k);history.pushState(null,"{{$pageTitle}}","map.html?query="+k);b(i,true)});a.addEventListener("zoomend",function(){j.addMarkers(d)})});</script>
    </body>
</html>
