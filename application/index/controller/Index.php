<?php
namespace app\index\controller;

use app\common\model\Articles;
use app\common\model\Game;
use app\common\model\Goods;
use app\common\model\Order;
use app\common\model\TodayWords;
use think\Exception;
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
            'cus_id'=> isset($cus_id) ? $cus_id: null,
            'c_name'=> isset($cus_name )?$cus_name: null,
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
        $c_phone = Session::get('CUS_PHONE');
        //判断是否可允许下载
        $order = Order::get(['phone'=>$c_phone,'gid'=>$id]);
        $is_allow_down = isset($order['status']) && $order['status'] == 1 ? true : false ;

        return view('game-detail',[
            'goods'=>$goods,
            'games'=>$games,
            'is_allow_down'=>$is_allow_down,
            'c_id' =>isset($c_id) ?$c_id: null,
        ]);
    }


    //下单
    public function createOrder(Request $request){
        $gid = $request->get('gid',0);
        if(empty($gid)) throw new Exception('无该商品');
        $goods = Goods::get(['id'=>$gid]);
        if(empty($goods)) throw new Exception('无该商品');
        $c_phone = Session::get('CUS_PHONE');
        $c_name  = Session::get('CUS_NAME');
        $order = Order::get(function ($query) use ($c_phone,$gid) {
            $query->where(['phone'=>$c_phone])
                ->where(['gid'=>$gid])
                ->where(['is_del'=>0]);
        });

        $order_money = $goods['price'];
        $data = [
            'gid'      =>$gid,
            'phone'    =>$c_phone,
            'c_name'   =>$c_name,
            'pay_money'=>$order_money,
        ];
        if(empty($order)){
            //创建订单
            $res = (new Order())->createOrder($data);
            if($res){
                return '下单失败!';
            }
        }
         //下过单，但该订单的支付时间 已超过30天
         $t_time  = time() - 30 * 24 * 3600;
         if($order['pay_time'] != 0 && $order['pay_time'] < $t_time ){
             //重新下单
             $res = (new Order())->createOrder($data);
             if(!$res){
                 return '下单失败!';
             }
         }

         if($order['pay_time'] != 0  && $order['pay_time'] >= $t_time  ){
             return '你已订购过该商品!';
         }

        return view('validate');
    }



    //回调地址
    public function callbackAction(Request $request){
         if($request->method() == 'POST'){
             $data = file_get_contents("php://input");
             file_put_contents('./callback.log', $data);
         }else{
             return '非法请求回调地址';
         }
    }



}
