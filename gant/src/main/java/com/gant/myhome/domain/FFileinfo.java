package com.gant.myhome.domain;

public class FFileinfo {
	private int file_num;
	private String file_name;
	private String extension;
	private int included_folder_num;
	private String file_save_path;

	public int getFile_num() {
		return file_num;
	}
	public void setFile_num(int file_num) {
		this.file_num = file_num;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public int getIncluded_folder_num() {
		return included_folder_num;
	}
	public void setIncluded_folder_num(int included_folder_num) {
		this.included_folder_num = included_folder_num;
	}
	public String getFile_save_path() {
		return file_save_path;
	}
	public void setFile_save_path(String file_save_path) {
		this.file_save_path = file_save_path;
	}
}
