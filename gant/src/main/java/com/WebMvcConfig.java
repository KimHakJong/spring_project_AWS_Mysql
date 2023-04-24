package com;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;



@Configuration
public class WebMvcConfig implements WebMvcConfigurer{

	@Value("${filebox.loadpath}")
	private String saveFolder;
	
	private static final String[] CLASSPATH_RESOURCE_LOCATIONS
	= {
			"classpath:/static/",
			"classpath:/resources/",
			"classpath:/META-INF/resources"
	};

	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		  registry.addResourceHandler("/resources/**")
		  .addResourceLocations(CLASSPATH_RESOURCE_LOCATIONS); 
		  
		  registry.addResourceHandler("/fileboxupload/**")
		  .addResourceLocations( saveFolder ); 
	}
}