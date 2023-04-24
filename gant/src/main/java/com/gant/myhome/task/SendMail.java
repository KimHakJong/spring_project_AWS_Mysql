package com.gant.myhome.task;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import com.gant.myhome.domain.MailVO;

@Component
public class SendMail {

   private static final Logger logger = LoggerFactory.getLogger(SendMail.class);
   
   private JavaMailSenderImpl mailSender;
   
   @Autowired
   public SendMail(JavaMailSenderImpl mailSender) {
      this.mailSender = mailSender;
   }
   
   
   public void sendMail(MailVO vo) {
      
      MimeMessagePreparator mp = new MimeMessagePreparator() {
         
         
         @Override
         //추상 메서드
         public void prepare(MimeMessage mimeMessage) throws Exception {
         
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"UTF-8"); 
            helper.setFrom(vo.getFrom());
            helper.setTo(vo.getTo());
            helper.setSubject(vo.getSubject());
            helper.setText("<h3>" + vo.getContent() + "</h3>",true);
            
            
         } //prepare end
         
      }; // new MimeMessagePreparator() end
      
        mailSender.send(mp); //메일 전송합니다.
        logger.info("메일 전송했습니다.");
     
   }// sendMail(MailVO vo) end


}// class SendMail end