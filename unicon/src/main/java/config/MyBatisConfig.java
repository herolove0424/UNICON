package config;

import java.util.Properties;

import org.apache.ibatis.datasource.pooled.PooledDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

@Configuration
@MapperScan(basePackages = { "com.project.unicon.mappers" })
@EnableTransactionManagement
@PropertySource("/WEB-INF/config/jdbc/jdbc.properties")
public class MyBatisConfig {

	@Autowired
	Environment environment;

	@Bean(value = "dataSource")
	public PooledDataSource dataSource() {
		
		PooledDataSource dataSource = new PooledDataSource();
		
		dataSource.setDriver(environment.getProperty("jdbc.driverClassName"));
		
		dataSource.setUrl(environment.getProperty("jdbc.url"));
		
		dataSource.setUsername(environment.getProperty("jdbc.username"));
		
		dataSource.setPassword(environment.getProperty("jdbc.password"));

		return dataSource;
	}

	// TransactionManager 설정

	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}

	// SqlSessionFactory 빈 설정

	@Bean("sqlSessionFactory")
	public SqlSessionFactory sqlSessionFactory(PooledDataSource dataSource) throws Exception {
		
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		
		sessionFactory.setDataSource(dataSource);
		
		Resource resourceConfig = new DefaultResourceLoader().getResource("classpath:mybatis/model/modelConfig.xml");
		
		sessionFactory.setConfigLocation(resourceConfig);
		
		Resource[] resourceMappers = new PathMatchingResourcePatternResolver()
				.getResources("classpath:mybatis/mappers/*.xml");
		
		sessionFactory.setMapperLocations(resourceMappers);
		
		return sessionFactory.getObject();
	}

	// SqlSessionTemplate 설정

	@Bean("sqlSession")
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {

		return new SqlSessionTemplate(sqlSessionFactory);
	}
	
	@Bean("mailSender")
	public static JavaMailSender mailSender() {		
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.gmail.com");
		mailSender.setUsername("gmunicon1234@gmail.com");
		mailSender.setPassword("unicon0814");
		mailSender.setJavaMailProperties(additionalMailProperties());
		return mailSender;
	}
	
	private static Properties additionalMailProperties() {
		Properties properties = new Properties();
		properties.setProperty("mail.smtp.starttls.enable", "true");
		properties.setProperty("mail.smtp.auth", "true");		
		return properties;
	}
	
//	@Bean("multipartResolver")
//	public MultipartResolver multiPartResolver() {
//		StandardServletMultipartResolver multipartResolver = new StandardServletMultipartResolver();
//		return multipartResolver;
//	}
	
}
