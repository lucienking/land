package com.jksb.land.service.landContract;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.constant.LandContractState;
import com.jksb.land.entity.landContract.ContractAttach;
import com.jksb.land.entity.landContract.ContractRegion;
import com.jksb.land.entity.landContract.LandContract;
import com.jksb.land.repository.landContract.ContractAttachDao;
import com.jksb.land.repository.landContract.ContractRegionDao;
import com.jksb.land.repository.landContract.LandContractDao;
import com.jksb.land.view.landContract.AbstractContractView;
import com.jksb.land.view.landContract.AttachView;
import com.jksb.land.view.landContract.LandRegionView;

@Service
@Transactional
public class LandContractService {
	
	public static final String UPLOAD_DIR_TMP="/upload/tmp";//上传附件临时存放目录
	
	public static final String UPLOAD_DIR="/upload/contract";//保存数据后文件存放的目录
	
	@Autowired
	private LandContractDao landContractDao;
	
	@Autowired
	private ContractRegionDao contractRegionDao;
	
	@Autowired
	private ContractAttachDao contractAttachDao;
	
	protected SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmssSSS");
	
	public long saveContract(AbstractContractView vo,LandRegionView regionVo,AttachView attachVo,int contractState,int contractType,HttpServletRequest request){
		LandContract contract=new LandContract();
		try {
			PropertyUtils.copyProperties(contract, vo);
			contract.setState(contractState);
			contract.setContractType(contractType);
			contract.setContractNumber(contract.getContractFarm()+"场字["+contract.getContractYear()+"]"+contract.getContractCode()+"号");
			
			List<ContractRegion> regionList=regionVo.getRegionList(contract);
			if(regionList.size()>0){
				contract.setRegionList(regionList);
			}
			
			List<ContractAttach> attachList=attachVo.getAttachList(contract, request);
			if(attachList.size()>0){
				contract.setAttachList(attachList);
			}
			
			String userAccount=PrincipalUtil.getCurrentUserAccount();
			String userFarmCode=PrincipalUtil.getCurrentUserDepartmentCode();
			contract.setFarmCode(userFarmCode);
			contract.setCreator(userAccount);
			contract.setLastEditor(userAccount);
			contract.setCreateTime(new Date());
			contract.setLastEditTime(new Date());
			
			landContractDao.save(contract);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
		return contract.getId();
	}
	
	public void editContract(AbstractContractView vo,LandRegionView regionVo,AttachView attachVo,int contractState,long id,Long[] delIdArray,Long[] delAttachIdArray,HttpServletRequest request){
		LandContract contract=this.landContractDao.findOne(id);
		if(LandContractState.LEGAL==contract.getState()){
			return;
		}
		try {
			PropertyUtils.copyProperties(contract, vo);
			contract.setState(contractState);
			contract.setContractNumber(contract.getContractFarm()+"场字["+contract.getContractYear()+"]"+contract.getContractCode()+"号");
			String userAccount=PrincipalUtil.getCurrentUserAccount();
			contract.setLastEditor(userAccount);
			contract.setLastEditTime(new Date());
			
			this.landContractDao.save(contract);
			
			List<ContractRegion> regionList=regionVo.getRegionList(contract);
			this.contractRegionDao.save(regionList);
			
			List<ContractAttach> attachList=attachVo.getAttachList(contract, request);
			this.contractAttachDao.save(attachList);
			
			for(Long delId : delIdArray){
				this.contractRegionDao.delete(delId);
			}
			
			for(Long delId:delAttachIdArray){
				this.contractAttachDao.delete(delId);
			}
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 注销合同状态，正式状态才能注销
	 * @param updatedState 更新后的状态
	 * @param ids 数据ID，多个ID以逗号隔开
	 * @return
	 */
	public int cancelContractStates(int updateState,int updatedBefo,String ids){
		String[] idArray=ids.split(",");
		//int cancelNum = 0;
		List<Long> idList=new ArrayList<Long>();
		for(String id:idArray){
			idList.add(Long.parseLong(id));
			/*LandContract lc = landContractDao.findOne(Long.parseLong(id));
			if(lc != null && lc.getState() !=null && lc.getState() == updatedBefo ){
				landContractDao.updateCancelState(updateState,Long.parseLong(id));
				cancelNum+=1;
			}*/
			
		}
		//return cancelNum;
		return landContractDao.updateContractStates(updateState,updatedBefo, idList);
	}
	
	/**
	 * 删除草稿的合同，只有草稿状态的合同才能删除
	 * @param draftState 草稿状态
	 * @return
	 */
	public int deleteContracts(int draftState,String ids){
		String[] idArray=ids.split(",");
		int delNum = 0;
		for(String id:idArray){
			LandContract lc = landContractDao.findOne(Long.parseLong(id));
			if(lc != null && lc.getState() !=null && lc.getState() == draftState ){
				landContractDao.delete(Long.parseLong(id));
				delNum+=1;
			}
		}
		return delNum;
	}
	
	/**
	 * 保存上传的附件
	 * @param file
	 * @param request
	 * @return
	 */
	public ContractAttach uploadAttach(MultipartFile file,HttpServletRequest request){
		ContractAttach attach=new ContractAttach();
		String suffix = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf("."));
		String absoluteDir=request.getSession().getServletContext().getRealPath(UPLOAD_DIR_TMP);
		File saveDir=new File(absoluteDir);
		if(!saveDir.exists()){
			saveDir.mkdirs();
		}
		String fileName=sdf.format(new Date())+suffix;
		File ufile=new File(saveDir,fileName);
		try {
			file.transferTo(ufile);
			attach.setFileName(fileName);
			attach.setOriginFileName(file.getOriginalFilename());
			attach.setFileSrc(request.getContextPath()+UPLOAD_DIR_TMP);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return attach;
	}


	public LandContractDao getLandContractDao() {
		return landContractDao;
	}

	public ContractRegionDao getContractRegionDao() {
		return contractRegionDao;
	}

	public ContractAttachDao getContractAttachDao() {
		return contractAttachDao;
	}
	

}
