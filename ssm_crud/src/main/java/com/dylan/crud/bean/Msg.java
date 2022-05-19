package com.dylan.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/12 20:12
 * @description 该类的作用是作为返回json数据的通用的返回类
 **/
public class Msg {
    /**
      状态码 200-成功,100-失败
     *
     */
    private int code;
    /**
      返回提示信息
     *
     */
    private String Msg;
    /**
     * 用户返回给浏览器的数据
     */
    Map<String,Object> extend=new HashMap<>();

    public Msg() {
    }

    public Msg(int code, String msg, Map<String, Object> extend) {
        this.code = code;
        Msg = msg;
        this.extend = extend;
    }

    public static Msg success()
    {
        com.dylan.crud.bean.Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理成功");
        return result;
    }
    public static Msg fail()
    {
        com.dylan.crud.bean.Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }






    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return Msg;
    }

    public void setMsg(String msg) {
        Msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
