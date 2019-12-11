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
            body {
                padding-top: 70px;
                font-family: "Noto Sans CJK SC", 微软雅黑, Arial, 黑体, 宋体, sans-serif !important;
            }
            div.machine-count-panel > div.panel-body {
                text-align: center;
            }
            div.machine-count-panel > div.panel-body > p.machine-count-num {
                font-size: 48px;
                font-weight: bold;
                padding-bottom: 5px;
            }
            .table {
                margin-bottom: 0px;
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
                        <li class="active"><a href="/page/stats.html"><span class="fa fa-bar-chart"></span> 机台分布统计</a></li>
                        <li><a href="http://wc.wahlap.net/maidx/location/index.html" target="_blank"><span class="fa fa-window-restore"></span> 官方店铺列表</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-sm-3 hidden-xs"></div>
                <div class="col-sm-6">
                    <div class="panel panel-success machine-count-panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">机台总数</h3>
                        </div>
                        <div class="panel-body">
                            <p>全国已上线机台总数</p>
                            <p class="machine-count-num text-success">{{$count}}</p>
                            <p>截至 {{$time}}&nbsp;&nbsp; / &nbsp;&nbsp;单位：组</p>
                        </div>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">各省分布</h3>
                        </div>
                        <div class="panel-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="width: 70%;">已上线省份</th>
                                        <th style="width: 30%; text-align: right;">机台数量</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <foreach name="province" key="prov" item="num">
                                        <tr>
                                            <td>{{$prov}}</td>
                                            <td style="text-align: right;">{{$num}}组</td>
                                        </tr>
                                    </foreach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3 hidden-xs"></div>
            </div>
        </div>
        <script src="https://cdn.bootcss.com/jquery/1.10.0/jquery.min.js"></script>
        <script src="https://cdn.bootcss.com/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>
