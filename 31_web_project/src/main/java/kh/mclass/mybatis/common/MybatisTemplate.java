package kh.mclass.mybatis.common;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisTemplate {
	public static SqlSession getSqlSession() {
		String resource = "mybatis-config.xml";
		SqlSession sqlSession = null;
		try {
			// InputStream으로 Mybatis의 설정 정보를 읽어 온다
			// InputStream is = Resources.getResourceAsStream(resource);
			// 읽어 온 Mybatis의 설정 정보를 바탕으로 SqlSessionFactoryBuilder를 생성한다
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			sqlSession = sqlSessionFactory.openSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return sqlSession;
	}
}
