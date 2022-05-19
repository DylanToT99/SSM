package mapperTest;

import com.dylan.crud.bean.Dept;
import com.dylan.crud.bean.Emp;
import com.dylan.crud.dao.DeptMapper;
import com.dylan.crud.dao.EmpMapper;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.apache.ibatis.io.Resources;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.InputStream;
import java.util.UUID;

/**
 * @author Dylan
 * @version 1.0
 * @date 2022/5/12 12:29
 * @description 测试dao层的工作,spring的项目推荐使用spring的单元测试,可以自动注入我们需要的组件:
 * 1.导入spring Test依赖
 * 2.使用@ContextConfiguration注解,标定spring配置文件的位置
 * 3.接下来需要使用那些组件时,直接autowired
 **/
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class mapperTest {

    @Autowired
    DeptMapper deptmapper;
    @Autowired
    EmpMapper empMapper;
    @Autowired
    SqlSessionTemplate sqlsession;
    /**
     * 测试department的mapper
     * @throws Exception
     */
    @Test
    public void testMapper01() throws Exception {
        EmpMapper mapper = sqlsession.getMapper(EmpMapper.class);
        for (int i = 2; i < 1002; i++) {
            String namestring = UUID.randomUUID().toString().substring(0, 5)+i;
            empMapper.insertSelective(new Emp(i,namestring,"man",namestring+"@Dylan.com",12306+(i%2),null));
        }
    }
}
