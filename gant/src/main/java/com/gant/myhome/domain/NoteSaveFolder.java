package com.gant.myhome.domain;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "note")
/*
  application.properties에서 설정한 내용 중
  note로 시작하는 키에 대한 값을 필드에 주입합니다.
  note.savefolder==c:/noteupload
 */

public class NoteSaveFolder {
  private String savefolder;
  
  
	public String getSavefolder() {
		return savefolder;
	}
	
	public void setSavefolder(String savefolder) {
		this.savefolder = savefolder;
	}
	
}
