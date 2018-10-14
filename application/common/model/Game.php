<?php
namespace app\common\model;
use \think\Model;
/**
 * Created by PhpStorm.
 * User: moTzxx
 * Date: 2018/1/11
 * Time: 16:45
 */

class Game extends Model
{

    public function getCount($search = null){
        $res = $this
            ->field('*')
            ->where('is_del',0)
            ->count();

        return $res;
    }

    public function add($data){
        $this->title = $data['title'];
        $this->desc  = $data['desc'];
        $this->img   = $data['img'];
        $this->down_url   = $data['down_url'];
        $this->add_time   = time();
        return $this->save();
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


    public function editGame($id,$data){
        $opTag = isset($data['tag']) ? $data['tag']:'edit';
        if($opTag == 'del'){
            $cur = self::get($id);
            $cur->is_del = 1;
            $tag = $cur->save();
        }else{
            $update = [
                'title'   => $data['title'],
                'desc'    => $data['desc'],
                'down_url'=> $data['down_url'],
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

}