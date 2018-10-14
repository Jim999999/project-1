<?php
namespace app\index\controller;

use app\common\model\Articles;
use app\common\model\Game;
use app\common\model\Goods;
use app\common\model\TodayWords;
use think\facade\Session;
use think\Request;

class Index
{
    private $articleModel;
    private $todayWordModel;
    private $goodsModel;

    public function __construct()
    {
        $this->articleModel = new Articles();
        $this->todayWordModel = new TodayWords();
        $this->goodsModel = new Goods();
    }

    /**
     * PC 端首页
     * @return \think\response\View
     */
    public function index()
    {
        return redirect('game');
        $todayWordsData = $this->todayWordModel->getTodayWord();
        $articleList = $this->articleModel->getArticleList();
        $recommendList = $this->articleModel->getRecommendList();
        $photos = $this->articleModel->getPhotos();
        $cus_id = Session::get('CUS_ID');
        $cus_name = Session::get('CUS_NAME');
        $data = [
            'name'=>'welcome',
            'cus_id'=> $cus_id ?? null,
            'c_name'=> $cus_name ?? null,
            'list'  => $articleList,
            'todayWord'=>$todayWordsData,
            'recommendList' => $recommendList,
            'photos' => $photos
        ];
        return view('index',$data);
    }


    /**
     * 文章列表页
     * @return \think\response\View
     */
    public function review(){

        $articleList = $this->articleModel->getArticleList();
        $data = [
            'name'=>'welcome',
            'List'=>$articleList,
        ];
        return view('review',$data);
    }
    public function contact(){
        return view('contact');
    }

    /**
     * 文章详情页
     * @param $id 文章ID
     * @return \think\response\View
     */
    public function article($id)
    {
        $articleInfo = $this->articleModel->getInfoByID(intval($id));
        $data = [
            'name'=>'welcome',
            'article'=>$articleInfo,
        ];
        return view('article',$data);
    }





/** ==================== 前台游戏展示 ============================ **/


    //游戏列表
    public function game(){
        $goods = $this->goodsModel->getGoodsList();
        return view('game',['goods'=>$goods]);
    }

    //游戏详情
    public function detail(Request $request){
        $id = $request->param('id',0);
        if(empty($id)) return redirect(url('index/game'));
        $goods = Goods::get(['id'=>$id]);

        //根据game_ids 获取 游戏信息
        $games = Game::whereIn('id',$goods['game_id'])->where('is_del',0)->select();

        //判断是否有登陆
        $c_id = Session::get('CUS_ID');

        return view('game-detail',[
            'goods'=>$goods,
            'games'=>$games,
            'c_id' =>$c_id ?? null,
        ]);
    }



}
