<?php

namespace app\cms\Controller;

use app\common\controller\Base;
use think\Request;

class Game extends Base
{
    private $gameModel;
    //定义每页的记录数
    private $page_limit;
    public function __construct()
    {
        parent::__construct();
        $this->gameModel = new \app\common\model\Game();
        $this->page_limit = config('app.CMS_PAGE_SIZE');
    }

    /**
     * 列表页
     */
    public function index(Request $request){
        $search = $request->param('str_search');
        $record_num = $this->gameModel->getCount($search);
        $list = $this->gameModel->getPage(1,$this->page_limit,$search);

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
        $list = $this->gameModel->getPage($curr_page,$this->page_limit);
        return showMsg(1,'**',$list);
    }

    /**
     * 增加
     * @param Request $request
     * @return \think\response\View|void
     */
    public function add(Request $request){
        $Tag = $request->Method();
        if ($Tag == 'POST'){
            $input = $request->param();
            $this->gameModel->add($input);
            return showMsg(1,'添加成功');
        }else{
            return view('add');
        }
    }

    /**
     * 编辑
     * @param Request $request
     * @param $id
     */
    public function edit(Request $request,$id){
        $Tag = $request->Method();
        if($id == 0) $id=$request->param('id');
        $current = \app\common\model\Game::get($id);

        if ($Tag == 'POST'){
            $input = $request->param();
            $opID = $input['id'];
            $tag = $this->gameModel->editGame($opID,$input);
            return showMsg($tag,'操作成功');
        }else{
            return view('edit',[
                'menuData' => $current
            ]);
        }
    }






}