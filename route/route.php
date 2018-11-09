<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
/**
 * 前台页面
 */
Route::get('/','index');
Route::get('test','index/index/test');
Route::get('article/:id','index/index/article');
Route::get('/index/review','index/index/review');
Route::get('/index/contact','index/index/contact');


/**
 * 后台 CMS配置
 */
Route::any('cms/index','cms/index/index');
Route::get('cms/home','cms/index/home');

Route::get('cms/menu/index','cms/navMenu/index');
Route::any('cms/menu/add','cms/navMenu/add');
Route::any('cms/menu/edit/:id','cms/navMenu/edit');
Route::post('cms/menu/ajaxOpForPage','cms/navMenu/ajaxOpForPage');


Route::get('cms/todayWord/index','cms/todayWord/index');
Route::any('cms/todayWord/add','cms/todayWord/add');
Route::any('cms/todayWord/edit/:id','cms/todayWord/edit');
Route::post('cms/todayWord/ajaxOpForPage','cms/todayWord/ajaxOpForPage');

Route::get('cms/article/index','cms/article/index');
Route::any('cms/article/add','cms/article/add');
Route::any('cms/article/edit/:id','cms/article/edit');
Route::post('cms/article/ajaxOpForPage','cms/article/ajaxOpForPage');


Route::any('cms/admin/index','cms/admin/index');
Route::any('cms/admin/add','cms/admin/add');
Route::any('cms/admin/edit/:id', 'cms/admin/edit');
Route::post('cms/admin/ajaxOpForPage', 'cms/admin/ajaxOpForPage');

Route::any('cms/admin/role','cms/admin/role');
Route::any('cms/admin/addRole','cms/admin/addRole');
Route::any('cms/admin/editRole/:id', 'cms/admin/editRole');

Route::get('cms/login/index','cms/login/index');
Route::post('cms/login/ajaxLogin','cms/login/ajaxLogin');
Route::post('cms/login/ajaxCheckLoginStatus','cms/login/ajaxCheckLoginStatus');

//会员，
Route::get('cms/customer/index','cms/customer/index');
Route::any('cms/customer/add','cms/customer/add');
Route::any('cms/customer/edit/:id','cms/customer/edit');
Route::get('cms/customer/del','cms/customer/del');
Route::post('cms/customer/ajaxOpForPage', 'cms/customer/ajaxOpForPage');

//订单
Route::get('cms/order/index','cms/order/index');
Route::any('cms/order/add','cms/order/add');
Route::any('cms/order/edit/:id','cms/order/edit');
Route::get('cms/order/del','cms/order/del');
Route::post('cms/order/ajaxOpForPage', 'cms/order/ajaxOpForPage');
Route::any('cms/order/nums','cms/order/nums');

// 商品
Route::get('cms/goods/index','cms/goods/index');
Route::any('cms/goods/add','cms/goods/add');
Route::any('cms/goods/edit/:id','cms/goods/edit');
Route::get('cms/goods/del','cms/goods/del');
Route::post('cms/goods/ajaxOpForPage', 'cms/goods/ajaxOpForPage');

// 游戏
Route::get('cms/game/index','cms/game/index');
Route::any('cms/game/add','cms/game/add');
Route::any('cms/game/edit/:id','cms/game/edit');
Route::get('cms/game/del','cms/game/del');
Route::post('cms/game/ajaxOpForPage', 'cms/game/ajaxOpForPage');


//前端 登陆，注册
Route::get('/login/login','login/login');
Route::get('/login/register','login/register');
Route::get('/login/logout','login/logout');

//游戏前台
Route::get('/index/game','index/game');
Route::get('/index/detail/:id','index/detail');
Route::get('/index/order','index/createOrder');
Route::any('/index/callbackAction','index/callbackAction');




/**
 * 工具类
 */
Route::post('api/upload/img_file','api/upload/img_file');
Route::any('api/upload/test','api/upload/test');








