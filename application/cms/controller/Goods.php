<?php

namespace app\cms\Controller;

use app\common\controller\Base;
use think\Request;

class Goods extends Base
{
    private $goodsModel;
    //定义每页的记录数
    private $page_limit;
    public function __construct()
    {
        parent::__construct();
        $this->goodsModel = new \app\common\model\Goods();
        $this->page_limit = config('app.CMS_PAGE_SIZE');
    }

    /**
     * 列表页
     */
    public function index(Request $request){
        $search = $request->param('str_search');
        $record_num = $this->goodsModel->getCount($search);
        $list = $this->goodsModel->getPage(1,$this->page_limit,$search);

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
        $list = $this->goodsModel->getPage($curr_page,$this->page_limit);
        return showMsg(1,'**',$list);
    }

    /**
     * 增加
     * @param Request $request
     * @return \think\response\View|void
     */
    public function add(Request $request){
        $Tag = $request->Method();
        $games = \app\common\model\Game::all(['is_del'=>0]);

        if ($Tag == 'POST'){
            $input = $request->param();
            $input['game_id'] = implode(',',$input['game_id']);
            $this->goodsModel->add($input);
            return showMsg(1,'添加成功');
        }else{
            return view('add',[
                'games'=>$games
            ]);
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
        $games = \app\common\model\Game::all(['is_del'=>0]);
        $current = \app\common\model\Goods::get($id);
        if ($Tag == 'POST'){
            $input = $request->param();
            $opID = $input['id'];
            $input['game_id'] = implode(',',$input['game_id']);
            $tag = $this->goodsModel->edit($opID,$input);
            return showMsg($tag,'操作成功');
        }else{
            return view('edit',[
                'data' => $current,
                'games' => $games,
            ]);
        }
    }
}
