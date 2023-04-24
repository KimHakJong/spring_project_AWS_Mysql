package com.gant.myhome.domain;

import org.springframework.web.multipart.MultipartFile;

public class Note {

private String id; //id
private int note_num; //쪽지번호
private String subject; //쪽지 제목
private String content; // 쪽지 내용
private String write_date; // 쪽지 작성일
private int file_num;  // 파일 번호
private String original_filename; // 원본파일명
private MultipartFile uploadfile; //쪽지 작성후 파일을 넘겨받을때 정보 
private String extension; // 확장자
private String save_folder; //저장경로
private String to_id;  //받는사람 id
private String read_check; //읽음표시 체크
private int delete_num;//휴지통 번호
private String kind; // 보낸쪽지테이블이면"from" 받은 쪽지 테이블이면 "to"
private String delete_table; //휴지통 버리기를 선택했다면"yes" 선택하지 않았다면 "no"
private String from_name; //보낸사람이름
private String to_name; //받은사람이름

public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public int getNote_num() {
	return note_num;
}
public void setNote_num(int note_num) {
	this.note_num = note_num;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getWrite_date() {
	return write_date;
}
public void setWrite_date(String write_date) {
	this.write_date = write_date;
}
public int getFile_num() {
	return file_num;
}
public void setFile_num(int file_num) {
	this.file_num = file_num;
}
public String getOriginal_filename() {
	return original_filename;
}
public void setOriginal_filename(String original_filename) {
	this.original_filename = original_filename;
}
public String getExtension() {
	return extension;
}
public void setExtension(String extension) {
	this.extension = extension;
}
public String getSave_folder() {
	return save_folder;
}
public void setSave_folder(String save_folder) {
	this.save_folder = save_folder;
}
public String getTo_id() {
	return to_id;
}
public void setTo_id(String to_id) {
	this.to_id = to_id;
}
public String getRead_check() {
	return read_check;
}
public void setRead_check(String read_check) {
	this.read_check = read_check;
}
public int getDelete_num() {
	return delete_num;
}
public void setDelete_num(int delete_num) {
	this.delete_num = delete_num;
}
public MultipartFile getUploadfile() {
	return uploadfile;
}
public void setUploadfile(MultipartFile uploadfile) {
	this.uploadfile = uploadfile;
}
public String getDelete_table() {
	return delete_table;
}
public void setDelete_table(String delete_table) {
	this.delete_table = delete_table;
}
public String getKind() {
	return kind;
}
public void setKind(String kind) {
	this.kind = kind;
}
public String getFrom_name() {
	return from_name;
}
public void setFrom_name(String from_name) {
	this.from_name = from_name;
}
public String getTo_name() {
	return to_name;
}
public void setTo_name(String to_name) {
	this.to_name = to_name;
}
	
}
