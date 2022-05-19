package com.dylan.crud.service;

import com.dylan.crud.bean.Emp;
import com.dylan.crud.bean.EmpExample;
import com.dylan.crud.dao.EmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/12 14:14
 * @description TODO
 **/
@Service
public class empService {
    @Autowired
    EmpMapper empMapper;


    //检验用户名是否重复

    public boolean checkUser(String name) {
        EmpExample example=new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(name);
        long count= empMapper.countByExample(example);
        return count==0;
    }

    /**
     * 查询所有员工
     * @return
     */
    public List<Emp> getAll() {
        return empMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Emp emp){
        empMapper.insertSelective(emp);
    }


    public Emp getEmp(Integer id) {
        return empMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Emp emp) {
        empMapper.updateByPrimaryKeySelective(emp);

    }

    public void deleteEmp(Integer empId) {
        empMapper.deleteByPrimaryKey(empId);
    }

    public void deleteBatch(List<Integer> empIds) {
        EmpExample example=new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        //delete from xx where emp_Id in empIds
        criteria.andEmpIdIn(empIds);
        empMapper.deleteByExample(example);
    }
}
