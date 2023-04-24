package com.gant.myhome.task;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.BoardSaveFolder;
import com.gant.myhome.service.BoardService;





@Service
@EnableScheduling // 아래의 클래스를 스케줄링 목적으로 사용하도록 하겠다는 명시합니다. @Configuration와 같이 사용해야 합니다.
@Configuration // @Configuration을 사용하지 않으면 스케줄링이 동작하지 않습니다.
public class FileCheckTask {


	private static final Logger logger = LoggerFactory.getLogger(FileCheckTask.class);

	    @Autowired
	    private BoardSaveFolder  boardsavefolder;
	    
	    @Autowired
	    private BoardService boardService;
			
	    
		public FileCheckTask(BoardService boardService) {
		this.boardService = boardService;
		}
	
		
		 
		// cron 사용법
		// seconds(초:0~59) minutes(분:0~59) hours(시:0~23) day(일:1~31)
		// month(달:1~12) day of week(요일:0~6) year(optional)     
		@Scheduled(cron = "0 55 * * * *")//순서대로 초 분 시 일 달 요일  // * : 모든 시간 달 요일 일 에 구애받지 않겠다.
	    public void checkFiles() throws Exception {
			//추가
			String saveFolder = boardsavefolder.getSavefolder();
			
			logger.info("checkFiles");
			
			List<String> deleteFileList = boardService.getdeleteFileList();
			
			//for(String filename : deleteFileList{
			for(int i = 0 ; i < deleteFileList.size(); i++) {
				String filename = deleteFileList.get(i);
				File file = new File(saveFolder + filename);
				if(file.exists()) {
					
					if(file.delete()) {
						logger.info(file.getPath() + " 삭제되었습니다.");
						boardService.deleteFileList(filename);
					}
					
				}else {
					logger.info(file.getPath() + " 파일이 존재하지 않습니다.");
				}
			}
		}
		
} 
