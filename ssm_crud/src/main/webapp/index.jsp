<%--
  Created by IntelliJ IDEA.
  User: Dylan
  Date: 2022/5/12
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<head>
    <title>员工列表</title>

    <%--引入标签库--%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%--引入jquery--%>
    <%--  web路径
      不以/相对路径,找资源,以当前资源路径为基准,经常容易出问题
      以/开始的相对路径,找资源,以服务器的路径为标准(http://localhost:8080)
      http://localhost:8080/ssm_crud
      --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery1.10.1min.js"></script>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
</head>

<body>

<%--修改员工的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputAddEmpName" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update"></p>
                        </div>
                    </div>
                    <div class="form-group ">
                        <label for="inputEmail3" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_Update_input" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sex</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="gender1_Update_input" value="man" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="gender2_Update_input" value="woman">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptId</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="deptInfo">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<!--员工添加的模态框-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="AddempModal">
                    <div class="form-group">
                        <label for="inputAddEmpName" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputAddEmpName" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group ">
                        <label for="inputEmail3" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="inputEmail3" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sex</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="gender_add1" value="man" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="gender_add2" value="woman">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptId</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveAdd">添加</button>
            </div>
        </div>
    </div>
</div>

<%--使用bootstrap搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--两个按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success btn-sm" id="emp_add_modal_btn">新增
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
            <button class="btn btn-danger btn-sm" id="emp_del_modal_btn">删除
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="checkAll"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>sex</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <%--显示分页--%>
    <div class="row">
        <div class="col-md-6" id="page_nav">
        </div>
        <div class="col-md-6" id="page_info_area">
        </div>
    </div>
</div>

<script type="text/javascript">
        //1.页面加载完成后,发送ajax请求要到分页数据
        var totalNums,currentPageNum,pageSize;
    $(function (){
       toPage(1);
    });
    function toPage(pn) {
        $("#checkAll").prop("checked",false)
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNum="+pn,
            type:"GET",
            success:function(result){
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息数据
                build_page_Info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        });
    }
    //显示员工表单
    function build_emps_table(result){
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function(index,item){
            // <input type="checkbox" id="checkAll"/>
            var checkbox=$("<td></td>").append("<input type='checkbox' class='check_item'/>")
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var sex=item.sex=="man"?"男":"女";
            var empemailTd=$("<td></td>").append(item.email);
            var empDeptNameTd=$("<td></td>").append(item.dept.deptName);
            /**
             *  <button class="btn btn-success btn-sm">增加
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
             */
            var editBtn=$("<button></button>")
                .addClass("btn btn-success btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit-id",item.empId);
            /**
             * <button class="btn btn-danger btn-sm">删除
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
             * @type *|jQuery
             */
            var delBtn=$("<button></button>")
                .addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil "))
                .append("删除");
            delBtn.attr("delete-id",item.empId);

            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkbox)
                .append(empIdTd)
                .append(empNameTd)
                .append(sex)
                .append(empemailTd)
                .append(empDeptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
        function  build_page_Info(result){
            $("#page_info_area").empty();
            var pageInfo=result.extend.pageInfo;
            //当前处在页.共页,记录数
            $("#page_info_area").append("当前处在"+pageInfo.pageNum+"页,"+"共"+pageInfo.pages+"页,")
                .append(pageInfo.total)
                .append("记录数");
            totalNums=result.extend.pageInfo.pages;
            currentPageNum=result.extend.pageInfo.pageNum;
            pageSize=result.extend.pageInfo.size
        }
    //解析显示分页条
        function build_page_nav(result){
            $("#page_nav").empty();
            //构建元素
            var nums=result.extend.pageInfo;
            var ul=$("<ul></ul>").addClass("pagination");
            var firstPage=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePage=$("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));

            var lastPage=$("<li></li>").append($("<a></a>").append("末页").attr("href","##"));

            var nextPage=$("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")));
            if(nums.hasPreviousPage==false){
                prePage.addClass("disabled");
                firstPage.addClass("disabled");
            }
            else{
                firstPage.click(function (){
                    toPage(1);
                });
                    prePage.click(function (){
                        toPage(nums.pageNum-1)
                    })

            }
            if(nums.hasNextPage==false){
                nextPage.addClass("disabled");
                lastPage.addClass("disabled");
            }else{
                lastPage.click(function (){
                    toPage(nums.pages)
                });
                nextPage.click(function (){
                    toPage(nums.pageNum+1)
                })

            }

            //为元素添加翻页事件
            ul.append(firstPage).append(prePage);
            $.each(nums.navigatepageNums,function (index,item){
                var numLi=$("<li></li>").append($("<a></a>").append(item));
                if(nums.pageNum==item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    toPage(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPage).append(lastPage);
            var nav=$("<nav></nav>").append(ul);
            nav.appendTo("#page_nav");
      }

      function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
          $(ele).find("*").removeClass("has-error has-success")
          $(ele).find(".help-block").text("")
      }

      //点击新增按钮弹出新增员工框
      $("#emp_add_modal_btn").click(function(){
          //弹出模态框之前,清除表单数据以及引入的提示类(样式)
          reset_form("#empAddModal form")
          //发送ajax请求,查询部门信息,显示在模态框的下拉列表中
          getDepts("#deptId");
          //弹出模态框
          $("#empAddModal").modal({
              backdrop:"static"
          })
      })

        //查出所有的部门信息,并显示在下拉列表中
        function getDepts(ele) {
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result){
                    var Alldepts=result.extend.depts;
                    $.each(Alldepts,function(index,item){
                        var option=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                        option.appendTo(ele)
                    })
                }
            })
        }

        //校验方法
        function validate_add_form(){
            //拿到要校验的数据,使用正则表达式进行校验
            var empName=$("#inputAddEmpName").val();
            var regName=/(^([a-z0-9A-Z]+\s)*[a-z0-9A-Z]{2,20}$)|(^[\u4e00-\u9fa5]{2,5})/;
           if(!regName.test(empName)) {
               //alert("用户名必须为2到20位英文和数字的组合或2到5位中文")
               show_validate_msg("#inputAddEmpName","error","用户名必须为2到20位英文和数字的组合或2到5位中文")
              return  false;
           }
           else {
               show_validate_msg("#inputAddEmpName","success","")
           }

           var email=$("#inputEmail3").val();
           var regEmail=/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/
            if(!regEmail.test(email)){
                //alert("输入的邮箱无效")
                show_validate_msg("#inputEmail3","error","输入的邮箱无效")
                return false;
            }
            else{
                show_validate_msg("#inputEmail3","success","")
            }
               return true;
        }
        function show_validate_msg(ele,status,msg){
            //清除状态
            $(ele).parent().removeClass("has-success has-error")
            $(ele).next("span").text("")
            if("success"==status)
            {
                $(ele).parent().addClass("has-success");
                $("ele").next("span").text(msg)
            }
            else if("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg)
            }
        }
        //校验用户名是否可用
        $("#inputAddEmpName").change(function (){
            //发送ajax请求,校验用户名是否可用
            var empName=this.value;
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"POST",
                success:function(result){
                    if(result.code==200){
                        show_validate_msg("#inputAddEmpName","success","用户名可用")
                        $("#saveAdd").attr("ajax-va","success")
                    }else{
                        show_validate_msg("#inputAddEmpName","error","用户名")
                        $("#saveAdd").attr("ajax-va","error")
                    }
                }
            })
        })

        //添加功能
       $("#saveAdd").click(function(){
           // 将模态框中的数据对应到员工类中,并将其添加到数据库中
           // 对模态框中的数据进行校验
            if(!validate_add_form()){
                return false;
            }
            //判断之前的用户名是否可用,可用的话保存才可以点击
           if($(this).attr("ajax-va")=="error"){
               return;
           }
            //当点击按钮时,发送ajax请求保存员工
           $("#AddempModal").serialize()
           $.ajax({
               url:"${APP_PATH}/emps",
               type:"POST",
                data:$("#AddempModal").serialize(),
               success:(function(result){
                   //根据后端校验的结果来决定是否关闭模态框
                   if(result.code==200){
                   //处理成功后,关闭模态框,
                   $("#empAddModal").modal('hide');
                    //并跳转到最后一条数据
                   //发送ajax请求,显示最后一页数据+1
                  toPage(totalNums+1);
                   }else{
                       //若校验失败:则显示失败信息
                       //有那个字段的错误信息就显示哪个字段的错误信息
                       if(undefined!=result.extend.errorFailedMap.email){
                       //显示邮箱错误信息
                           show_validate_msg("#inputEmail3","error","输入的邮箱无效")
                       }
                       if(undefined!=result.extend.errorFailedMap.empName){

                       show_validate_msg("#inputAddEmpName","error","用户名必须为2到20位英文和数字的组合或2到5位中文")
                       }
                   }
           })
       });
       })

        //按钮创建之前就绑定了click
        $(document).on("click",".edit_btn",function(){
            //1.查询出部门信息,并显示部门列表
            //2.查出员工信息,显示员工信息
            getDepts("#deptInfo")
            getEmp($(this).attr("edit-id"))
            //3.将员工id绑定到更新按钮上
            $("#emp_update_btn").attr("edit-save-id",$(this).attr("edit-id"))
            $("#empUpdateModal").modal({
                backdrop:"static"
            })
        })

        function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emps/"+id,
            type:"GET",
            success:function(result){
                //console.log(result)
                var empEle=result.extend.emp;
                $("#empName_update").text(empEle.empName)
                $("#email_Update_input").val(empEle.email)
                $("#empUpdateModal input[type='radio']").val([empEle.sex])
                $("#empUpdateModal select").val([empEle.dId])
            }
        })
        }

        //点击修改,则修改员工
        $("#emp_update_btn").click(function (){
            //1.验证邮箱是否合法
            var email=$("#email_Update_input").val();
            var regEmail=/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
            if(!regEmail.test(email)){
                //alert("输入的邮箱无效")
                show_validate_msg("#email_Update_input","error","输入的邮箱无效")
                return false;
            }
            else{
                show_validate_msg("#email_Update_input","success","")
            }
            //2.发送ajax请求保存数据
            $.ajax({
                url:"${APP_PATH}/emps/"+$(this).attr("edit-save-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function(result){
                   //alert(result.msg)
                    //处理成功后,关闭编辑页面
                    $("#empUpdateModal").modal('hide');
                    //回到页面
                    toPage(currentPageNum)
                }
            })
        })
        //单个删除
        //弹出确认删除的对话框
        $(document).on("click",".delete_btn",function(){
            var empName1=$(this).parents("tr").find("td:eq(1)").text();
            var empId=$(this).attr("delete-id")
            if(confirm("确认删除名为:"+empName1+"的员工吗?")){
                //点击确认则发送ajax请求
                $.ajax({
                    url:"${APP_PATH}/emps/"+empId,
                    type:"DELETE",
                    success:function(result){
                        //处理成功后,
                        alert(result.msg)
                        //回到页面
                        toPage(currentPageNum)
                    }
                })
            }
        })
        //完成全选全不选功能
        $("#checkAll").click(function (){
            //attr获取checked值是undefined
            //我们这些dom原生的属性:没有checked属性;因此attr主要用来获取我们自定义的属性,而获取原生属性prop获取
            //$(this).prop("checked")
            //则所有的有chek_item的class的选择框都会和checkall属性对应
            $(".check_item").prop("checked",$(this).prop("checked"));
        })
        //chek_item
        $(document).on("click",".check_item",function (){
            //$("#checkAll").prop("checked")
            //若当前页面的员工全部选中,则该属性复制为true,为选中状态,否则不选中
            var flag=$(".check_item").length==$(".check_item:checked").length
                $("#checkAll").prop("checked",flag)
        })
        $("#emp_del_modal_btn").click(function (){
            var empNames="";
            var empIdstr="";
            $.each($(".check_item:checked"),function(){
                empNames+=$(this).parents("tr").find("td:eq(2)").text()+","
                empIdstr+=$(this).parents("tr").find("td:eq(1)").text()+"-"
            })
            if(empNames.length!=0){
                //组装员工名字的字符串
            empNames=empNames.substring(0,empNames.length-1)
            }if(empNames.length!=0){
                //组装员工id的字符串
                empIdstr=empIdstr.substring(0,empIdstr.length-1)
            if(confirm("确认删除"+empNames+"这些员工记录吗?")){
                $.ajax({
                    url:"${APP_PATH}/emps/"+empIdstr,
                    type:"DELETE",
                    success:function(result){
                        //处理成功后,
                        alert(result.msg)
                        //回到页面
                        toPage(currentPageNum)
                    }
                })
            }
            }

        })

</script>
</body>
</html>
