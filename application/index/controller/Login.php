<?php
namespace app\index\controller;

use app\common\model\Customer;
use think\Request;
use think\facade\Session;

class Login
{
    private $cusModel;

    public function __construct()
    {
        $this->cusModel = new Customer();
    }

    public function login(){
        return view('register',
            ['action'=>'login']
        );
    }

    public function register(){
        return view('register',
            ['action'=>'register']
        );
    }


    public function ajaxRegister(Request $request){
        $method = $request->Method();
        if ($method == 'POST'){
            $input = $request->param();
            $flag = $this->cusModel->verifyPhone($input['phone']);
            if(!$flag) return showMsg(0,'手机号格式不正确');
            $tag_id = $this->cusModel->addCustomer($input);
            if ($tag_id){
                Session::set('CUS_ID', $tag_id);
                Session::set('CUS_PHONE', $input['phone']);
                Session::set('CUS_NAME', $input['c_name']);
                return showMsg(1,'注册成功');
            }else{
                return showMsg(0,'注册失败，请检查您的信息');
            }
        }else{
            return showMsg(0,'sorry,您的请求不合法！');
        }
    }


    public function ajaxLogin(Request $request){
        $method = $request->Method();
        if ($method == 'POST'){
            $input = $request->param();
            $flag = $this->cusModel->verifyPhone($input['phone']);
            if(!$flag) return showMsg(0,'手机号格式不正确');

            $tag = $this->cusModel->Login($input);
            if ($tag){
                Session::set('CUS_ID', $tag['id']);
                Session::set('CUS_PHONE', $tag['phone']);
                Session::set('CUS_NAME', $tag['c_name']);
                return showMsg(1,'登录成功');
            }else{
                return showMsg(0,'登录失败，请检查您的信息');
            }
        }else{
            return showMsg(0,'sorry,您的请求不合法！');
        }
    }

    public function logout(){
        Session::delete('CUS_ID');
        Session::delete('CUS_NAME');
        Session::delete('CUS_PHONE');
        return redirect('/',302);
    }


    //返回miss路由的方法
    public function lost(){
        return view('lost');
    }

}
