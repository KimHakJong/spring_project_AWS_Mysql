package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling //스케줄러 적용합니다.
public class GantApplication {

	public static void main(String[] args) {
		SpringApplication.run(GantApplication.class, args);
	}

}
