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

class Order extends Model
{

    public function getCount($search = null){
        if ($search){
            //如果有查询限制
            $res = $this
                ->field('*')
                ->where('is_del',0)
                ->whereLike('phone','%'.$search.'%')
                ->count();
        }else{
            $res = $this
                ->where('is_del',0)
                ->field('*')
                ->count();
        }
        return $res;
    }



    public function getPage($curr_page,$limit,$search = null){
        $res = $this
            ->field('*')
            ->whereLike('phone','%'.$search.'%')
            ->where('is_del',0)
            ->limit($limit*($curr_page - 1),$limit)
            ->order('id desc')
            ->select();
        foreach ($res as $key => $v){
            $res[$key]['add_time'] = date('Y-m-d H:i:s',$v['add_time']);
            $res[$key]['pay_time'] = $v['pay_time'] ? date('Y-m-d H:i:s',$v['pay_time']) : '';
        }
        return $res;
    }


    public function edit($id,$data){
        $opTag = isset($data['tag']) ? $data['tag']:'edit';
        if($opTag == 'del'){
            $cur = self::get($id);
            $cur->is_del = 1;
            $tag = $cur->save();
        }else{
            $tag = $this
                ->where('id',$id)
                ->update(
                    [
                        'c_name'  => $data['c_name'],
                        'phone'   => $data['phone'],
                        'status'  => $data['status'],
                    ]);
        }
        return $tag;
    }

    public function getForPage($curr_page,$limit,$search = null){
        $res = $this
            ->field('*')
            ->whereLike('phone','%'.$search.'%')
            ->where('is_del',0)
            ->limit($limit*($curr_page - 1),$limit)
            ->order('id desc')
            ->select();
        foreach ($res as $key => $v){
            $res[$key]['add_time'] = date('Y-m-d H:i:s',$v['add_time']);
            $res[$key]['pay_time'] = $v['pay_time'] ? date('Y-m-d H:i:s',$v['pay_time']) : '';
        }
        return $res;
    }


    /**
     *  创建订单
     * @param $data
     * @return int
     */
    function createOrder($data){
        $data['order_sn'] = date('YmdHis').rand(1000,9999);
        $data['add_time'] = time();
        $id = Db::table(self::getTable())->insert($data,false,true);
        return $id;
    }


}