package com.stock.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUpload {

    //썸네일 생성
    public static String getImage(String fileName, String filePath) throws IOException, InterruptedException {
       
       log.info("파일경로 ----" + filePath);
       log.info("uid파일이름----" + fileName);

       double ratio = 5; //이미지 축소비율
       String type = fileName.substring(fileName.lastIndexOf(".") + 1);
       
       if(type.equalsIgnoreCase("png") || type.equalsIgnoreCase("jpg")) {
          
          log.info("이미지파일입니다");
       
       // 저장된 원본파일로부터 BufferedImage 객체를 생성합니다.
          BufferedImage srcImg = ImageIO.read(new File(filePath + "\\" + fileName)); 
         
      	int tWidth = (int) (srcImg.getWidth() / ratio); // 생성할 썸네일이미지의 너비
      	int tHeight = (int) (srcImg.getHeight() / ratio); // 생성할 썸네일이미지의 높이

      	BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
      	Graphics2D graphic = tImage.createGraphics();
      	Image image = srcImg.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
      	graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
      	graphic.dispose(); // 리소스를 모두 해제
      	
        String thumbName = "THUMB_" + fileName; 
        File thumbFile = new File(filePath, thumbName);
        
        //이미지 생성
        ImageIO.write(tImage, type, thumbFile);
        
        Thread.sleep(1500);	//이클립스 동기화때문에 딜레이줌 
        
        return thumbName;
       }

       return null;
    } //end 썸네일메소드
    
    //파일중복명 UUID
    public static String getUUID(String originalName) {
       
      UUID uid = UUID.randomUUID();
      String UUIDFileName = uid.toString() + "_" + originalName;
      
      return UUIDFileName;
    } //end 파일중복명 UUID 메소드
    
    
    //날짜별 폴더생성
    public static String days() {
       
          Date dt = new Date();
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          String datefolder =sdf.format(dt).toString();
          log.info(datefolder);

          File dir = new File("C:\\Users\\PoPo\\Documents\\kimBoard\\board2\\src\\main\\webapp\\resources\\images", datefolder);
          // 폴더가 없으면 생성     
          if(!dir.exists()){
             dir.mkdir();
          }
          
       return datefolder;

    } //end 날짜별폴더생성 메소드
	
	
}
