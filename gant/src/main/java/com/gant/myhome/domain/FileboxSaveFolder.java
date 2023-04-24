package com.gant.myhome.domain;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "filebox")

public class FileboxSaveFolder {
  private String savefolder;
  private String loadpath;
  
	public String getSavefolder() {
		return savefolder;
	}
	
	public void setSavefolder(String savefolder) {
		this.savefolder = savefolder;
	}

	public String getLoadpath() {
		return loadpath;
	}

	public void setLoadpath(String loadpath) {
		this.loadpath = loadpath;
	}
	
}
