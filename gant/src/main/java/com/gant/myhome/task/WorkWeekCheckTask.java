package com.gant.myhome.task;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.gant.myhome.service.AttService;





@Service
@EnableScheduling // 아래의 클래스를 스케줄링 목적으로 사용하도록 하겠다는 명시합니다. @Configuration와 같이 사용해야 합니다.
@Configuration // @Configuration을 사용하지 않으면 스케줄링이 동작하지 않습니다.
public class WorkWeekCheckTask {


	private static final Logger logger = LoggerFactory.getLogger(WorkWeekCheckTask.class);
	    
	
	    @Autowired
	    private AttService attService;
			
	    
		public WorkWeekCheckTask(AttService attService) {
			this.attService = attService;
		}
	
		
		 
		// cron 사용법
		// seconds(초:0~59) minutes(분:0~59) hours(시:0~23) day(일:1~31)
		// month(달:1~12) day of week(요일:0~6) year(optional)     
		//월요일에 주간 총 근무시간 리셋!
		//0과 7은 일요일이고 1부터 월요일 ~ 6은 토요일이다.
		@Scheduled(cron = "0 0 0 ? * MON")//순서대로 초 분 시 일 달 요일  // * : 모든 시간 달 요일 일 에 구애받지 않겠다.
		public void checkFiles() throws Exception {
			
			logger.info("주간 총 근무시간 리셋");
			
			int result = attService.Resetwork_week();
			
		    if(result == 0 ) {
		    	logger.info("주간 총 근무시간 리셋 실패하였습니다.");
		    }else {
		    	logger.info("주간 총 근무시간 리셋 성공하였습니다.");
		    }
		    	
		    	
		}
		
} 
