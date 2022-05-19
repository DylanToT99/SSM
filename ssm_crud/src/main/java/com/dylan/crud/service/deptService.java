package com.dylan.crud.service;

import com.dylan.crud.bean.Dept;
import com.dylan.crud.dao.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/13 20:47
 * @description TODO
 **/
@Service
public class deptService {
    @Autowired
    DeptMapper deptMapper;

    public List<Dept> getAllDept()
    {
        return deptMapper.selectByExample(null);
    }
}
