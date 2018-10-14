<?php

namespace app\cms\Controller;

use app\common\controller\Base;
use app\common\model\AdminRoles;
use app\common\model\Admins;
use app\common\model\NavMenus;
use think\Exception;
use think\facade\Session;
use think\Request;
use think\Db;

class NavMenu extends Base
{
    private $menuModel;
    //定义每页的记录数
    private $page_limit;
    public function __construct()
    {
        parent::__construct();
        $this->menuModel = new NavMenus();
        $this->page_limit = config('app.CMS_PAGE_SIZE');
    }

    /**
     * 菜单导航列表页
     */
    public function index(Request $request){
        $search = $request->param('str_search');
        $record_num = $this->menuModel->getNavMenusCount($search);
        $list = $this->menuModel->getNavMenusForPage(1,$this->page_limit,$search);

        return view('index',
            [
                'menus' => $list,
                'search' => $search,
                'record_num' => $record_num,
                'page_limit' => $this->page_limit,
            ]);
    }

    /**
     * ajax 获取当前页面数据
     * @param Request $request
     */
    public function ajaxOpForPage(Request $request){
        $curr_page = $request->param('curr_page',1);
        $list = $this->menuModel->getNavMenusForPage($curr_page,$this->page_limit);
        return showMsg(1,'**',$list);
    }

    /**
     * 增加新导航标题 功能
     * @param Request $request
     * @return \think\response\View|void
     */
    public function add(Request $request){
        $Tag = $request->Method();
        $rootMenus = $this->menuModel->getNavMenus();
        if ($Tag == 'POST'){
            $input = $request->param();
            Db::startTrans();
            try{
                $menu_id = $this->menuModel->addNavMenu($input);
                //给超级管理员角色 ID =1 添加菜单显示
                if($menu_id){
                    $admin_id = Session::get('cmsAID');
                    $role_id  = Admins::where('id',$admin_id)->value('role_id');
                    $data =  AdminRoles::get($role_id);
                    $nav_menu_ids = $data->nav_menu_ids ? $data->nav_menu_ids . $menu_id.'|' : $menu_id.'|';
                    $data->nav_menu_ids = $nav_menu_ids;
                    $data->save();
                }
                Db::commit();
            }catch (Exception $exception){
                Db::rollback();
                throw new \Error($exception->getMessage());
            }
            return showMsg(1,'添加成功');
        }else{
            return view('add',[
                'rootMenus'=>$rootMenus,
            ]);
        }
    }

    /**
     * 编辑导航菜单数据
     * @param Request $request
     * @param $id 菜单 ID
     */
    public function edit(Request $request,$id){
        $Tag = $request->Method();
        $rootMenus = $this->menuModel->getNavMenus();
        if($id == 0) $id=$request->param('id');
        $current_menu = $this->menuModel->getMenuById($id);
        $parent_id = $current_menu['parent_id'];
        $menuData = $this->menuModel->getNavMenuByID($id,$parent_id);
        if ($Tag == 'POST'){
            //TODO 修改对应的菜单
            $input = $request->param();
            $opID = $input['id'];
            $tag = $this->menuModel->editNavMenu($opID,$input);
            return showMsg($tag,'操作成功');
        }else{
            return view('edit',[
                'rootMenus' => $rootMenus,
                'menuData' => $menuData
            ]);
        }
    }
}
