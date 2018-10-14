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

class Customer extends Model
{

    public function getCount($search = null){
        if ($search){
            //如果有查询限制
            $res = $this
                ->field('*')
                ->whereLike('phone','%'.$search.'%')
                ->count();
        }else{
            $res = $this
                ->field('*')
                ->count();
        }
        return $res;
    }

    // 添加客户信息
    public function addCustomer($data){
        $cus = self::get(['phone'=>$data['phone']]);
        if(empty($cus)) {
            $data['c_name'] = htmlspecialchars($data['c_name']);
            $data['passwd'] = $this->encryptPassWd($data['passwd']);
            $data['add_time']  = time();
            return $this->insert($data,false,true);
        }
        return $cus['id'];
    }

    //密码加密
    public function encryptPassWd($passwd){
        return md5(base64_encode($passwd));
    }


    // 客户登陆
    public function login($data){
        $cus    = self::get(['phone'=>$data['phone']]);
        $passwd = $this->encryptPassWd($data['passwd']);
        if(empty($cus))  return false;
        if( $cus['passwd'] != $passwd ) return false;
        return $cus;
    }


    public function getPage($curr_page,$limit,$search = null){
        $res = $this
            ->field('*')
            ->whereLike('phone','%'.$search.'%')
            ->limit($limit*($curr_page - 1),$limit)
            ->order('id desc')
            ->select();
        foreach ($res as $key => $v){
            $res[$key]['add_time'] = date('Y-m-d H:i:s',$v['add_time']);
        }
        return $res;
    }


    public function edit($id,$data){
        $opTag = isset($data['tag']) ? $data['tag']:'edit';
        if($opTag == 'del'){
            $cur = self::get($id);
            $tag = $cur->delete();
        }else{
            $tag = $this
                ->where('id',$id)
                ->update(
                    [
                        'c_name'  => $data['c_name'],
                        'phone'  => $data['phone'],
                        'is_vip' => $data['is_vip'],
                    ]);
        }
        return $tag;
    }

    public function getForPage($curr_page,$limit,$search = null){
        $res = $this
            ->field('*')
            ->whereLike('phone','%'.$search.'%')
            ->limit($limit*($curr_page - 1),$limit)
            ->select();
        foreach ($res as $key => $v){
            $res[$key]['add_time'] = date('Y-m-d H:i:s',$v['add_time']);
        }
        return $res;
    }


    public function verifyPhone($phone){
        if(!is_numeric($phone)) return false;
        if(strlen($phone) != 11) return false;
        if(!preg_match('/1\d{10}/',$phone)) return false;
        return true;
    }

}