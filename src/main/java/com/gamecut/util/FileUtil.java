package com.gamecut.util;

import com.gamecut.dao.FileDAO;
import com.gamecut.vo.FileVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class FileUtil {
    static int maxSize = 1024 * 1024 * 1000; //1000mb

    public static MultipartRequest uploadFile(
            HttpServletRequest request,
            String fileParam
    ) throws IOException {
        String tempDir = "upload";
        String tempRealPath = request.getServletContext().getRealPath(tempDir);

        FileDAO fileDAO = new FileDAO();
        FileVO fileVO = new FileVO();

        MultipartRequest multi = new MultipartRequest(
                request,
                tempRealPath,
                maxSize,
                "utf-8",
                new DefaultFileRenamePolicy()
        );

        //세션확인
        String userId = multi.getParameter("userId");

        int userNo = 0;
        if (multi.getParameter("userNo") != null) {
            userNo = Integer.parseInt(multi.getParameter("userNo"));
        }

        String originalFileName = multi.getOriginalFileName(fileParam); //원본 파일명
        String savedFileName = multi.getFilesystemName(fileParam); //서버에 저장되는 파일명
        if (originalFileName != null && savedFileName != null) {
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
                request.setAttribute("uploadError", "이미지 최대 용량(30MB)을 초과했습니다.");
                return null;
            }

// 비디오라면 1000MB 초과인지 검사
            if (uploadType.equals("videos") && fileSize > (1024 * 1024 * 1000)) {
                uploadedFile.delete();
                request.setAttribute("uploadError", "비디오 최대 용량(1000MB)을 초과했습니다.");
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
            String newFileName = uuid + "_" + userId + "_" + originalFileName;

            File oldFile = new File(tempRealPath + File.separator + savedFileName);
            File newFile = new File(realPath + File.separator + newFileName);
            if (oldFile.renameTo(newFile)) {
                fileVO.setUserNo(userNo);
                fileVO.setUuid(uuid);
                fileVO.setFileUrl(realPath + File.separator + newFileName);
                fileVO.setMimeType(mimeType);
                fileVO.setOriginalFileName(originalFileName);
                fileDAO.insertFile(fileVO);
                return multi;
            } else {
                return null;
            }

        }
        return null;
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