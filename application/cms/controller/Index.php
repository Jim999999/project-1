<?php
namespace app\cms\controller;
use app\common\controller\Base;
use app\common\model\Admins;
use app\common\model\NavMenus;
use think\facade\Session;

/**
 * Created by PhpStorm.
 * User: moTzxx
 * Date: 2018/1/23
 * Time: 15:54
 */
class Index{
    private $menuModel;
    private $adminModel;
    public function __construct()
    {
        $this->menuModel = new NavMenus();
        $this->adminModel = new Admins();
    }

    /**
     * 后台首页
     * @return \think\response\View
     */
    public function index(){
        $cmsAID = Session::get('cmsAID');
        $menuList = $this->menuModel->getNavMenusShow($cmsAID);
        $start_time = strtotime(date('Y-m-d 00:00:00',time()));
        $order_nums = \app\common\model\Order::where('add_time', '>=',$start_time)->count();
        if (!$cmsAID || !$menuList){
            //TODO 页面跳转至登录页
            return redirect('cms/login/index',302);
        }else{
            $adminInfo = $this->adminModel->getAdminData($cmsAID);
            $data = [
                'menus' => $menuList,
                'admin' => $adminInfo,
                'order_nums' => $order_nums,
            ];
            return view('index',$data);
        }
    }
    public function home(){
        return view('home');
    }

    public function toLogin(){
        return redirect('cms/login/index',302);
    }
}