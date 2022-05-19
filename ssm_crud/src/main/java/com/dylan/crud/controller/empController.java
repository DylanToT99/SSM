package com.dylan.crud.controller;

import com.dylan.crud.bean.Emp;
import com.dylan.crud.bean.Msg;
import com.dylan.crud.service.empService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.javafx.collections.MappingChange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;
import java.util.stream.Stream;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/12 14:11
 * @description 处理crud请求
 **/
@Controller
public class empController {

    @Autowired
    empService service;

    /**
     * 导入jackson包使responseBody正常工作
     * @param pageNum
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum)
    {
        PageHelper.startPage(pageNum,10);
        //startPage紧跟的查询就是一个分页查询
        List<Emp> emps=service.getAll();
        //使用pageInfo包装查询后的信息,只需要将pageInfo交给页面就行,第二个参数为连续显示的页码
        PageInfo page=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 员工保存
     * @return
     */
    @ResponseBody
    @RequestMapping(value={"/emps"},method= RequestMethod.POST)
    public Msg saveEmp(@Valid Emp emp, BindingResult result)
    {
        Map<String,Object> map=new HashMap<>();
        //校验失败,应该返回失败,在模态框中显示校验失败的错误信息
        if(result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError error : fieldErrors){
                System.out.println("错误的字段名:"+error.getField());
                System.out.println("错误信息:"+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFailedMap",map);
        }else{
            service.saveEmp(emp);
            return Msg.success();
        }
    }

    /**
     * 要支持jsr303校验,需要导入Hibernate validator
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUserName(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx="(^([a-z0-9A-Z]+\\s)*[a-z0-9A-Z]{2,20}$)|(^[\\u4e00-\\u9fa5]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须为2到20位英文和数字的组合或2到5位中文");
        }
        //格式合法后才有必要进行数据库重复检查
        boolean b=service.checkUser(empName);
        if(b){
            return Msg.success();
        }
        else{
            return Msg.fail().add("va_msg","用户名已存在");
        }

    }

    @RequestMapping( value = "/emps/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpById(@PathVariable("id")Integer id)
    {
        Emp emp=service.getEmp(id);
        return Msg.success().add("emp",emp);
    }

    /**
     * 使用ajax发送put请求时,请求体中有数据
     * 但是Emp对象封装不上;
     * 原因:
     * TOMCAT:
     *      1.将请求体的数据封装为一个MAP
     *      2.request.getParameter("xxx")会从这个map中取值
     *      3.springmvc封装pojo对象时,
     *              会将pojo中每个属性的值映射
     *ajax发送PUT请求:
     *          put请求,请求体的数据,request.getparameter("xx")也拿不到
     *          tomcat一看是put请求则不会封装请求体中的数据为map,只有post形式的请求才封装请求体为map
     *          要能直接发送put,delete请求,则需要在web.xml中配置上FormContentFilter过滤器
     *          FormContentFilter过滤器,该过滤器的作用就是将请求体中的数据封装成map对象,
     *          request被重新包装,request.getparameter()方法被重写,这样就会从自己的方法中取出数据
     *
     *
     */
    @ResponseBody
    @RequestMapping(value = "/emps/{empId}",method = RequestMethod.PUT)
    public Msg saveEdit(Emp emp){
        System.out.println(emp);
        service.updateEmp(emp);
        return Msg.success();
    }

    /**
     * 单个删除与批量删除二合一
     * 批量删除则多个id可以用-隔开,如1-2-3-5
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "emps/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            //批量删除
            String[] empIds = ids.split("-");
            List<Integer> empId=new ArrayList<>();
           for(String Id : empIds){
               Integer id=Integer.parseInt(Id);
               empId.add(id);
           }
            service.deleteBatch(empId);
        }else{
            Integer empId = Integer.parseInt(ids);
            //单个删除
        service.deleteEmp(empId);
        }
        return Msg.success();
    }
    // @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum, Model model)
    {

        //引入pageHelper分页插件
        PageHelper.startPage(pageNum,10);
        //startPage紧跟的查询就是一个分页查询
        List<Emp> emps=service.getAll();
        //使用pageInfo包装查询后的信息,只需要将pageInfo交给页面就行,第二个参数为连续显示的页码
        PageInfo page=new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
