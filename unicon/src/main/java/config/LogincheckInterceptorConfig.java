package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import common.intercepter.LoginCheckInterceptor;

@Configuration
public class LogincheckInterceptorConfig {
	
	@Bean
	public WebMvcConfigurer checkInterceptorConfig() {
		return new WebMvcConfigurer() {

			@Override
			public void addInterceptors(InterceptorRegistry registry) {
				registry.addInterceptor(new LoginCheckInterceptor()).addPathPatterns("/*/*.ddun");
			}
			
			
		};
		
	}

}
