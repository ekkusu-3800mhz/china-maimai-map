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
                        <li><a href="/page/stats.html"><span class="fa fa-bar-chart"></span> 数据变更一览</a></li>
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
        <script type="text/javascript">$(document).ready(function(){var d="{{$apiUrl}}";var g=new BMap.Map("map");var b=new BMap.Point(114.313886,30.601948);var a=new BMap.Geolocation();var f=new BMap.Geocoder();g.centerAndZoom(b,6);g.enableScrollWheelZoom(true);g.addControl(new BMap.ScaleControl());g.addControl(new BMap.NavigationControl());g.addControl(new BMap.GeolocationControl({offset:new BMap.Size(15,50)}));function c(j,i){if(i.count>1){var m="__IMG__/map-icon-multi.png"}else{var m="__IMG__/map-icon-single.png"}var o=new BMap.Icon(m,new BMap.Size(40,40),{anchor:new BMap.Size(20,20)});var k=new BMap.Marker(j,{icon:o});g.addOverlay(k);var n={width:250,height:110,title:i.title};var l=new BMap.InfoWindow(i.content,n);k.addEventListener("click",function(){g.openInfoWindow(l,j)})}function e(j,i){j.done(function(k){if(k.status==200){g.clearOverlays();var m=k.data.rows;var l=false;if(m.length>1){l=true}m.forEach(function(n){f.getPoint(n.address,function(p){if(p){var o={title:n.name,content:'<span style="font-size: 11px; color: #666;">店铺地址：'+n.address+'</span><br><span style="font-size: 11px; color: #666;">机台数量：'+n.count+"组</span>",count:n.count};if(n.lnglat!=null){p=new BMap.Point(n.lnglat.lng,n.lnglat.lat)}c(p,o);if(i){if(l){g.centerAndZoom(p,6)}else{g.centerAndZoom(p,17)}}}},n.province)})}else{alert("发生请求错误，请刷新页面重试")}});j.fail(function(){alert("发生请求错误，请刷新页面重试")});j.always(function(){$("#loader").fadeOut("fast");a.getCurrentPosition(function(k){if(this.getStatus()==BMAP_STATUS_SUCCESS){g.panTo(k.point)}})})}var h=$.get(d+"?query={{$query}}");if("{{$query}}"==""){e(h,false)}else{e(h,true)}$("#home").on("click",function(j){j.preventDefault();$("#loader").fadeIn("fast");var i=$("#query").val();h=$.get(d);history.pushState(null,"{{$pageTitle}}","map.html");e(h,false)});$("#search-form").on("submit",function(j){j.preventDefault();$("#loader").fadeIn("fast");var i=$("#query").val();h=$.get(d+"?query="+i);history.pushState(null,"{{$pageTitle}}","map.html?query="+i);e(h,true)})});</script>
    </body>
</html>
