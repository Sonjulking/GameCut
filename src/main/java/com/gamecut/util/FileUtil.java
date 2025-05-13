package com.gamecut.util;

import com.gamecut.dao.*;
import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.FileVO;
import com.gamecut.vo.PhotoVO;
import com.gamecut.vo.UserVO;
import com.gamecut.vo.VideoVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class FileUtil {
    static int mb = 1000;
    static int maxSize = 1024 * 1024 * mb; //1000mb

    public static MultipartRequest uploadFile(
            HttpServletRequest request,
            String fileParam,
            String type,
            int order
    ) throws IOException {
        String tempDir = "upload";
        String tempRealPath = request.getServletContext().getRealPath(tempDir);

        MultipartRequest multi = new MultipartRequest(
                request,
                tempRealPath,
                maxSize,
                "utf-8",
                new DefaultFileRenamePolicy()
        );
        int userNo = 0;
        if (multi.getParameter("userNo") != null) {
            userNo = Integer.parseInt(multi.getParameter("userNo"));
        }

        //세션확인
        UserVO loginUser = (UserVO) request.getSession().getAttribute("loginUSER");
        String userId = null;
        if (loginUser != null) {
            userId = loginUser.getUserId();   // 유저 아이디
            userNo = loginUser.getUserNo();
        }


        String originalFileName = multi.getOriginalFileName(fileParam); //원본 파일명
        String savedFileName = multi.getFilesystemName(fileParam); //서버에 저장되는 파일명

        if (originalFileName == null || savedFileName == null) {
            return multi;
        } else {
            //확장자 확인
            String ext = "";
            int lastDot = originalFileName.lastIndexOf("."); //.있는 위치를 반환 없으면 -1
            if (lastDot != -1) { //.이 없으면 실행 안됨
                ext = originalFileName.substring(lastDot + 1).toLowerCase(); //확장자 소문자로 변환
            }
            String mimeType = URLConnection.guessContentTypeFromName(savedFileName);
            String uploadType = getUploadType(ext);
            if (uploadType.equals("Not Supported")) { //지원하지않는 확장자
                File invalidFile = new File(tempRealPath + File.separator + savedFileName);  //File.separator : 슬래시, 역슬래시
                if (invalidFile.exists()) {
                    invalidFile.delete();
                }
                request.setAttribute("uploadError", "지원하지 않는 파일 형식입니다.");
                return null;
            }
            File uploadedFile = new File(tempRealPath + File.separator + savedFileName);
            long fileSize = uploadedFile.length();  // byte 단위

            // 이미지라면 30MB 초과인지 검사
            if (uploadType.equals("img") && fileSize > (1024 * 1024 * 30)) {
                uploadedFile.delete();  // 삭제
                request.setAttribute("uploadError", "이미지 최대 용량(" + mb + "MB)을 초과했습니다.");
                return null;
            }

            // 비디오라면 1000MB 초과인지 검사
            if (uploadType.equals("videos") && fileSize > (1024 * 1024 * 1000)) {
                uploadedFile.delete();
                request.setAttribute("uploadError", "비디오 최대 용량(" + mb + "MB)을 초과했습니다.");
                return null;
            }

            String datePath = new SimpleDateFormat("yyyy" + File.separator + "MM").format(new Date());
            String uploadDir = "upload" + File.separator + uploadType + File.separator + datePath;
            String realPath = request.getServletContext().getRealPath(uploadDir);

            // 폴더 없으면 생성
            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String uuid = UUID.randomUUID().toString();

            //54942ea7-5ced-41aa-a429-2b39a6791fae_userId.png
            String newFileName = uuid + "_" + userId + "." + ext;

            File oldFile = new File(tempRealPath + File.separator + savedFileName);
            File newFile = new File(realPath + File.separator + newFileName);
            //db처리부분
            if (oldFile.renameTo(newFile)) { //파일이 옮겨졌다면..
                FileDAO fileDAO = new FileDAO();
                FileVO fileVO = new FileVO();
                fileVO.setUserNo(userNo);
                fileVO.setUuid(uuid);


                String relativePath = uploadDir + File.separator + newFileName;
                //웹경로에서는 슬래시 사용
                fileVO.setFileUrl(relativePath.replace(File.separatorChar, '/'));
                fileVO.setRealPath(realPath + File.separator + newFileName);
                fileVO.setMimeType(mimeType);
                fileVO.setOriginalFileName(originalFileName);
                int attachNo = fileDAO.insertFile(fileVO);

                //아이템일때
                if (type.equals("item")) {
                    ItemDAO itemDAO = new ItemDAO();
                    itemDAO.insertItem(attachNo, multi.getParameter("itemName"), Integer.parseInt(multi.getParameter("itemPrice")));
                    return multi;
                }

                if (uploadType.equals("videos")) { //비디오 일떄
                    VideoDAO videoDAO = new VideoDAO();
                    VideoVO videoVO = new VideoVO();
                    videoVO.setAttachNo(attachNo);
                    int videoNo = videoDAO.insertVideo(videoVO);
                    request.setAttribute("videoNo", videoNo);
                } else { //사진일때
                    PhotoDAO photoDAO = new PhotoDAO();
                    PhotoVO photoVO = new PhotoVO();
                    photoVO.setAttachNo(attachNo);
                    photoVO.setPhotoOrder(order);
                    int photoNo = photoDAO.insertPhoto(photoVO, type);
                    request.setAttribute("photoNo", photoNo);
                }
            }
        }
        return multi;
    }

    //파일삭제
    public static boolean deleteFile(int userNo, int attachNo, String realPath) {
        FileDAO fileDAO = new FileDAO();
        PhotoDAO photoDAO = new PhotoDAO();
        FileVO fvo = fileDAO.selectProfileFileByUserId(userNo);
        if (realPath == null || realPath.trim().isEmpty()) {
            return false;
        }

        File file = new File(realPath);
        if (file.exists()) {
            //TODO : DB 처리!!
            photoDAO.deletePhotoByAttachNo(attachNo);
            fileDAO.deleteFileByAttachNo(attachNo);
            return file.delete();
        }
        return false;
    }

    private static String getUploadType(String ext) {
        String[] imgExts = {"jpg", "jpeg", "png", "gif", "webp"};
        String[] videoExts = {"mp4", "avi"};

        for (String imgExt : imgExts) {
            if (ext.equals(imgExt)) {
                return "img";
            }
        }
        for (String videoExt : videoExts) {
            if (ext.equals(videoExt)) {
                return "videos";
            }
        }
        return "Not Supported";
    }

}