package com.dylan.crud.controller;

import com.dylan.crud.bean.Dept;
import com.dylan.crud.bean.Msg;
import com.dylan.crud.service.deptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/13 20:45
 * @description TODO
 **/
@Controller
public class deptController {
    @Autowired
    deptService deptService;


    @RequestMapping("/depts")
    @ResponseBody
    public Msg getAllDepts() {
        List<Dept> allDept = deptService.getAllDept();
        return Msg.success().add("depts",allDept);
    }
}
