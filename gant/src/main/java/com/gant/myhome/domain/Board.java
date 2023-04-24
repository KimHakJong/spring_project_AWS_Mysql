package com.gant.myhome.domain;

import org.springframework.web.multipart.MultipartFile;

public class Board {
	private String id; // 작성자 id
	private String id_profileimg; // 작성자 프로필이미지 
	private int    board_num; //글번호
	private String board_name; // 작성자
	private String board_pass; // 비밀번호
	private String board_subject; // 제목
	private String board_content; // 내용
	private String board_file; // 실제 저장된 파일의 이름
	private MultipartFile uploadfile;
    private String board_original; // 첨부될 파일의 이름
	private int    board_re_ref; //답변글 작성시 참조되는 글의 번호
	private int    board_re_lev; // 답변 글의 깊이 (원문글:0,답변:1,답변의 답변2)
	private int    board_re_seq; // 답변 글의 순서 (원문글 기준으로 보여주느 순서)
	private int    board_readcount; // 글의 조회수
	private String board_date; //글의 작성날짜
	private int    cnt;
	private int    board_like ; // 좋아요수
	private String board_notice; // 공지사항글이면 true 아니면 false 
	private String fontColor; // 글색
	private String fontSize; // 글 사이즈
	private int fontWeight; // 글 굵기
	
		
	public String getFontColor() {
		return fontColor;
	}
	public void setFontColor(String fontColor) {
		this.fontColor = fontColor;
	}
	public String getFontSize() {
		return fontSize;
	}
	public void setFontSize(String fontSize) {
		this.fontSize = fontSize;
	}
	public int getFontWeight() {
		return fontWeight;
	}
	public void setFontWeight(int fontWeight) {
		this.fontWeight = fontWeight;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getBoard_pass() {
		return board_pass;
	}
	public void setBoard_pass(String board_pass) {
		this.board_pass = board_pass;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}
	public int getBoard_re_ref() {
		return board_re_ref;
	}
	public void setBoard_re_ref(int board_re_ref) {
		this.board_re_ref = board_re_ref;
	}
	public int getBoard_re_lev() {
		return board_re_lev;
	}
	public void setBoard_re_lev(int board_re_lev) {
		this.board_re_lev = board_re_lev;
	}
	public int getBoard_re_seq() {
		return board_re_seq;
	}
	public void setBoard_re_seq(int board_re_seq) {
		this.board_re_seq = board_re_seq;
	}
	public int getBoard_readcount() {
		return board_readcount;
	}
	public void setBoard_readcount(int board_readcount) {
		this.board_readcount = board_readcount;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date; 
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	public int getBoard_like() {
		return board_like;
	}
	public void setBoard_like(int board_like) {
		this.board_like = board_like;
	}
	public String getBoard_notice() {
		return board_notice;
	}
	public void setBoard_notice(String board_notice) {
		this.board_notice = board_notice;
	}
	public String getId_profileimg() {
		return id_profileimg;
	}
	public void setId_profileimg(String id_profileimg) {
		this.id_profileimg = id_profileimg;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getBoard_original() {
		return board_original;
	}
	public void setBoard_original(String board_original) {
		this.board_original = board_original;
	}
	
}
