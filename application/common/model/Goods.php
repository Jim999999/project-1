<?php
namespace app\common\model;
use think\Db;
use \think\Model;
/**
 * Created by PhpStorm.
 * User: moTzxx
 * Date: 2018/1/11
 * Time: 16:45
 */

class Goods extends Model
{

    public function getCount($search = null){
        $res = $this
            ->field('*')
            ->where('is_del',0)
            ->count();

        return $res;
    }



    public function getPage($curr_page,$limit){
        $res = $this
            ->field('*')
            ->where('is_del',0)
            ->limit($limit*($curr_page - 1),$limit)
            ->order('id desc')
            ->select();
        foreach ($res as $key => $v){
            $res[$key]['add_time'] = date('Y-m-d H:i:s',$v['add_time']);
        }
        return $res;
    }


    public function add($data){
        $this->title = $data['title'];
        $this->desc  = $data['desc'];
        $this->status= $data['status'];
        $this->is_top= $data['is_top'];
        $this->img   = $data['img'];
        $this->price = $data['price'];
        $this->game_id = $data['game_id'];
        $this->add_time = time();
        return $this->save();
    }


    public function edit($id,$data){
        $opTag = isset($data['tag']) ? $data['tag']:'edit';
        if($opTag == 'del'){
            $cur = self::get($id);
            $cur->is_del = 1;
            $tag = $cur->save();
        }else{
            $update =  [
                'title'   => $data['title'],
                'desc'    => $data['desc'],
                'is_top'  => $data['is_top'],
                'price'   => $data['price'],
                'status'  => $data['status'],
                'game_id' => $data['game_id'],
            ];
            //过滤掉默认的图片
            if( empty(strpos($data['img'],'nav_default'))){
                $update['img'] = $data['img'];
            }
            $tag = $this
                ->where('id',$id)
                ->update($update);
        }
        return $tag;
    }


    public function getGoodsList(){
        return self::all(['is_del'=>0,'status'=>1]);
    }

}