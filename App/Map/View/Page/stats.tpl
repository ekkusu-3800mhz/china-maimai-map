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
        <style type="text/css">
            body {
                padding-top: 70px;
                font-family: "Noto Sans SC", 微软雅黑, Arial, 黑体, 宋体, sans-serif !important;
            }
            div.count-panel > div.panel-body {
                text-align: center;
            }
            div.count-panel > div.panel-body > div.row > div.count-cell > p.count-num {
                font-size: 48px;
                font-weight: bold;
                padding-bottom: 5px;
            }
            div.count-panel > div.panel-body > div.row > div.count-cell {
                padding-top: 20px;
                padding-bottom: 20px;
            }
            .table {
                margin-bottom: 0px;
            }
            h4.shop-name {
                margin-top: 3px;
                font-weight: bold;
            }
            p.shop-description {
                margin-bottom: 0px;
            }
            span.badge {
                margin-top: -3px;
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
                    <a href="/page/map.html" class="navbar-brand">舞萌DX店铺分布可视化地图</a>
                </div>
                <div class="collapse navbar-collapse" id="navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active"><a href="/page/stats.html"><span class="fa fa-bar-chart"></span> 数据变更一览</a></li>
                        <li><a href="http://wc.wahlap.net/maidx/location/index.html" target="_blank"><span class="fa fa-window-restore"></span> 官方店铺列表</a></li>
                        <li><a href="https://www.wjx.cn/jq/52799413.aspx" target="_blank"><span class="fa fa-comment"></span> 问题反馈</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-md-3 hidden-xs"></div>
                <div class="col-md-6">
                    <if condition="$opr">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span class="fa fa-info-circle"></span> 模块维护中</h3>
                            </div>
                            <div class="panel-body">
                                <p>店铺数据变更一览模块正在维护中。</p>
                                <p>
                                    我们将在每日的 <strong class="text-info">{{$oprStop}}</strong> 至 <strong class="text-info">{{$oprStop}}</strong> 对昨日的变更数据进行统计存档，
                                    <br>
                                    以进行次日的店铺数据变更比对。
                                </p>
                                <p>对您造成的不便，敬请谅解。</p>
                            </div>
                        </div>
                    <else />
                        <div class="panel panel-success count-panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span class="fa fa-pie-chart"></span> 数据概览</h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6 count-cell">
                                        <p>店铺总数 <if condition="$delta.machine gt 0"><if condition="$delta.shop gt 0"><span class="text-danger">(+{{$delta.shop}})</span></if></if></p>
                                        <p class="count-num text-info">{{$total.shop}}</p>
                                    </div>
                                    <div class="col-sm-6 count-cell">
                                        <p>机台总数 <if condition="$delta.machine gt 0"><span class="text-danger">(+{{$delta.machine}})</span></if></p>
                                        <p class="count-num text-success">{{$total.machine}}</p>
                                    </div>
                                </div>
                                <p>截至 {{$time}}</p>
                                <p>（店铺增量数据将于次日 {{$oprStart}} 统计存档）</p>
                            </div>
                        </div>
                        <if condition="$delta.machine gt 0">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><span class="fa fa-map"></span> 店铺数据变更一览</h3>
                                </div>
                                <ul class="list-group">
                                    <foreach name="shop" item="s">
                                        <li class="list-group-item">
                                            <h4 class="shop-name">{{$s.arcadeName}} <span class="badge"><span class="fa fa-map-marker"></span> {{$s.province}}</span></h4>
                                            <p class="shop-description">地址：{{$s.address}} &nbsp;&nbsp;/&nbsp;&nbsp; 数量：{{$s.machineCount}}组</p>
                                        </li>
                                    </foreach>
                                </ul>
                            </div>
                        <else />
                            <div class="alert alert-info">
                                <span class="fa fa-info-circle"></span> 当前未检测到数据发生变更的店铺。
                                <br>若您需要查看完整的店铺信息，请参阅 <a href="http://wc.wahlap.net/maidx/location/index.html" target="_blank"><span class="fa fa-window-restore"></span> 官方店铺列表</a></a>
                            </div>
                        </if>
                    </if>
                </div>
                <div class="col-md-3 hidden-xs"></div>
            </div>
        </div>
        <script src="https://cdn.bootcss.com/jquery/1.10.0/jquery.min.js"></script>
        <script src="https://cdn.bootcss.com/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>
