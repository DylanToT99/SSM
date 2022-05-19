package com.dylan.crud.dao;

import com.dylan.crud.bean.Emp;
import com.dylan.crud.bean.EmpExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmpMapper {
    int countByExample(EmpExample example);

    int deleteByExample(EmpExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Emp record);

    int insertSelective(Emp record);

    List<Emp> selectByExample(EmpExample example);

    Emp selectByPrimaryKey(Integer empId);

    List<Emp> selectByExampleWithDept(EmpExample example);

    Emp selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Emp record, @Param("example") EmpExample example);

    int updateByExample(@Param("record") Emp record, @Param("example") EmpExample example);

    int updateByPrimaryKeySelective(Emp record);

    int updateByPrimaryKey(Emp record);
}