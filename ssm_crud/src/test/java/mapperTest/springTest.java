package mapperTest;

import com.dylan.crud.bean.Emp;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.Result;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/12 14:33
 * @description 使用spring的单元测试
 **/
@RunWith(SpringJUnit4ClassRunner.class)
//有@WebAppConfiguration就可以自动装配spring自身的ioc容器
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class springTest {
    //传入springMVc的Ioc容器
    @Autowired
    WebApplicationContext webApplicationContext;

    //虚拟mvc请求,获取处理结果
    MockMvc mockMvc;

    @Before
   public void initMockMvc()
   {
       DefaultMockMvcBuilder defaultMockMvcBuilder = MockMvcBuilders.webAppContextSetup(webApplicationContext);
       mockMvc= defaultMockMvcBuilder.build();
   }
   @Test
   public void testPage() throws Exception {
        //模拟请求,拿到返回值
       MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum","2")).andReturn();
        //请求成功后,请求域中会有pageInfo
       Object pageInfo = result.getRequest().getAttribute("pageInfo");
       PageInfo pageInfo1=(PageInfo)pageInfo;
       System.out.println("当前页码: " +pageInfo1.getPageNum());
       System.out.println("总页码: "+pageInfo1.getSize());
       System.out.println("总记录数 "+pageInfo1.getTotal());
       List<Emp> emps=pageInfo1.getList();
       for(Emp emp:emps){
           System.out.println("员工id;"+ emp.getEmpId());
       }
   }
}
