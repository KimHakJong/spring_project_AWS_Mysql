package com.gant.myhome.task;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.gant.myhome.service.ReservationCheckService;
import com.gant.myhome.service.ReservationCountService;
import com.gant.myhome.service.ReservationService;


@Service
@EnableScheduling // 아래의 클래스를 스케줄링 목적으로 사용하도록 하겠다는 명시합니다. @Configuration와 같이 사용해야 합니다.
@Configuration // @Configuration을 사용하지 않으면 스케줄링이 동작하지 않습니다.
public class DeletePastTask {


	private static final Logger logger = LoggerFactory.getLogger(DeletePastTask.class);
	
	    //추가
	    @Autowired
	    private ReservationService reservationservice;
	    @Autowired
		private ReservationCheckService reservationcheckservice;
	    @Autowired
	    private ReservationCountService reservationcountservice;
	    

		public DeletePastTask() {
		}
		
		//스케줄러를 이용해서 주기적으로
		//매일 , 매주 , 매월 프로그램 실행을 위한 작업을 실시합니다.
		// 1000 : 밀리세컨드 단위입니다. (1초)
		//@Scheduled(fixedDelay = 1000)
		public void test() throws Exception{
		}
		
		 
		// seconds(초:0~59) minutes(분:0~59) hours(시:0~23) day(일:1~31)
		// month(달:1~12) day of week(요일:0~6) year(optional)     
		@Scheduled(cron = "0 1 0 * * *")//순서대로 초 분 시 일 달 요일  // * : 모든 시간 달 요일 일 에 구애받지 않겠다.
	    public void checkFiles() throws Exception {
			Calendar c1 = Calendar.getInstance();
			c1.add(Calendar.DATE, -1);
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
			String yesterday = sd.format(c1.getTime());
			
			int result = reservationservice.deletePastData(yesterday);
			int result2 = reservationcheckservice.deletePastData(yesterday);
			int result3 = reservationcountservice.resetCount();
			logger.info("지난예약목록 삭제:"+result+"지난예약시간삭제:"+result2+"횟수갱신:"+result3);
		}
		
} 
