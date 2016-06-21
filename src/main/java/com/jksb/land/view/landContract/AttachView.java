package com.jksb.land.view.landContract;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;

import com.jksb.land.entity.landContract.ContractAttach;
import com.jksb.land.entity.landContract.LandContract;
import com.jksb.land.service.landContract.LandContractService;

public class AttachView {
	
	private String[] fileNameArray;
	
	private String[] originFileNameArray;
	
	private List<ContractAttach> attachList=new ArrayList<ContractAttach>();

	public String[] getFileNameArray() {
		return fileNameArray;
	}

	public void setFileNameArray(String[] fileNameArray) {
		this.fileNameArray = fileNameArray;
	}

	public String[] getOriginFileNameArray() {
		return originFileNameArray;
	}

	public void setOriginFileNameArray(String[] originFileNameArray) {
		this.originFileNameArray = originFileNameArray;
	}

	public List<ContractAttach> getAttachList(HttpServletRequest request) {
		attachList.clear();
		int size=0;
		if(fileNameArray!=null){
			size=fileNameArray.length;
		}
		if (size>0) {
			String absoluteDirTmp = request.getSession().getServletContext()
					.getRealPath(LandContractService.UPLOAD_DIR_TMP);
			String absoluteDir = request.getSession().getServletContext()
					.getRealPath(LandContractService.UPLOAD_DIR);
			File saveDir = new File(absoluteDir);
			if (!saveDir.exists()) {
				saveDir.mkdirs();
			}
			for (int i = 0; i < size; i++) {
				ContractAttach attach = new ContractAttach();
				String fileName = fileNameArray[i];
				attach.setFileName(fileName);
				attach.setOriginFileName(originFileNameArray[i]);
				//设置相对路径
				attach.setFileSrc(LandContractService.UPLOAD_DIR);

				String suffix = fileName.substring(fileName.lastIndexOf("."));
				attach.setSuffix(suffix);
				attach.setCreateTime(new Date());

				//将文件从临时目录复制到正式目录
				File from = new File(absoluteDirTmp + "/" + fileName);
				attach.setFileSize(String.valueOf(from.length()));
				try {
					FileUtils.copyFileToDirectory(from, saveDir);
				} catch (IOException e) {
					e.printStackTrace();
				}

				attachList.add(attach);
			}
		}
		return attachList;
	}
	
	public List<ContractAttach> getAttachList(LandContract contract,HttpServletRequest request) {
		getAttachList(request);
		for(ContractAttach attach : attachList){
			attach.setLandContract(contract);
		}
		return attachList;
	}

}
