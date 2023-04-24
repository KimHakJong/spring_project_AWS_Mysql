package com.gant.myhome.task;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import com.gant.myhome.domain.NoteSaveFolder;
import com.gant.myhome.service.NoteService;





//휴지보관함에보관한지 1주일이 지나면 자동 삭제되게하기위한 클래스
@Service
@EnableScheduling // 아래의 클래스를 스케줄링 목적으로 사용하도록 하겠다는 명시합니다. @Configuration와 같이 사용해야 합니다.
@Configuration // @Configuration을 사용하지 않으면 스케줄링이 동작하지 않습니다.
public class BasketCheckTask {


	private static final Logger logger = LoggerFactory.getLogger(BasketCheckTask.class);
	    
	
	    @Autowired
	    private NoteService noteService;
			
	    
		public BasketCheckTask(NoteService noteService) {
			this.noteService = noteService;
		}
	
		
		 
		// cron 사용법
		// seconds(초:0~59) minutes(분:0~59) hours(시:0~23) day(일:1~31)
		// month(달:1~12) day of week(요일:0~6) year(optional)     
		//월요일에 주간 총 근무시간 리셋!
		//0과 7은 일요일이고 1부터 월요일 ~ 6은 토요일이다.
		@Scheduled(cron = "0 0 0 * * *")//순서대로 초 분 시 일 달 요일  // * : 모든 시간 달 요일 일 에 구애받지 않겠다.
		public void BasketCheck() throws Exception {
			
			logger.info("쪽지 휴지통 청소 시작");
			 //현재 날짜를 yyyyMMdd 형태로 받아온다.
			 LocalDate today = LocalDate.now(); //YYYY-MM-DD  형태인 현재날짜
			 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
			 String formattedDate = today.format(formatter); //형태변형
			
			 //삭제일이 오늘인 delete_num 테이블의 delete_num을 가져온다.
			List<Integer> delete_nums = noteService.selectDeleteDate(formattedDate);
			
			// 삭제할 테이블이 있을때
			if(delete_nums.size() > 0) {
				
				int result = 0;
				
				for(int delete_num : delete_nums ) {
					result += noteService.Delete(delete_num);
				}
			    	
			    if(result == 0) {
			    	logger.info("쪽지 휴지통 청소 실패 ");
			    }else {
			    	logger.info("쪽지 휴지통 청소 성공 ");
			    }
			    
			
			}else{
				logger.info("쪽지 휴지통 청소할 데이터가 없습니다. ");
			}
			
			
			logger.info("쪽지 휴지통 청소 종료.");
		}
		
} 
