package com.dylan.crud.bean;

import javax.validation.constraints.Pattern;

public class Emp {
    private Integer empId;

    @Pattern(regexp ="(^([a-z0-9A-Z]+\\s)*[a-z0-9A-Z]{2,20}$)|(^[\\u4e00-\\u9fa5]{2,5})"
    ,message = "用户名必须为2到20位英文和数字的组合或2到5位中文")
    private String empName;

    private String sex;

    @Pattern(regexp = "^([a-zA-Z\\d])(\\w|\\-)+@[a-zA-Z\\d]+\\.[a-zA-Z]{2,4}$"
    ,message = "输入的邮箱无效")
    private String email;

    private Integer dId;

    //希望查询员工的同时,部门信息也能够查出来
    private Dept dept;

    public Emp(Integer empId, String empName, String sex, String email, Integer dId, Dept dept) {
        this.empId = empId;
        this.empName = empName;
        this.sex = sex;
        this.email = email;
        this.dId = dId;
        this.dept = dept;
    }

    public Emp() {
    }

    public Emp(String empName, String sex, String email, Dept dept) {
        this.empName = empName;
        this.sex = sex;
        this.email = email;
        this.dept = dept;
    }

    public Emp(Integer empId, String empName, String sex, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.sex = sex;
        this.email = email;
        this.dId = dId;
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "Emp{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", sex='" + sex + '\'' +
                ", email='" + email + '\'' +
                ", dId=" + dId +
                ", dept=" + dept +
                '}';
    }
}