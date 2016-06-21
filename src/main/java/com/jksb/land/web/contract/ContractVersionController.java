package com.jksb.land.web.contract;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jksb.land.entity.contract.ContractVersion;
import com.jksb.land.service.contract.ContractVersionService;
import com.jksb.land.web.BaseController;
/**
 * 合同版本Controller
 * 
 * @author Willian Chan
 *
 */
/**
 * 合同版本Controller
 * 
 * @author Willian Chan
 *
 */
@Controller
@RequestMapping("/contractVersion")
public class ContractVersionController extends BaseController {
	@Autowired
	private ContractVersionService contractVersionService;
	/**
	 * 合同版本管理界面<br/>
	 * 权限编码 005001006
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractVersion")
	@RequiresPermissions("005001006")
	public String  contractVersion(Model model){		 
		return "/contract/contractVersion";
	}
	
	/**
	 * 查询所有合同模板<br/>
	 * @param model
	 * @return
	 * 
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractVersions")
	public Map<String,Object> getContractVersions(HttpServletRequest request){
		Page<ContractVersion> contractVersions=contractVersionService.getVersionByPage(buildPageRequest(request));
		return convertToResult(contractVersions);
	}
	
	/**
	 * 新增合同版本
	 * 权限编码005001006001
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/create")
	@RequiresPermissions("005001006001")
	public Map<String,Object> createContractVersion(@Valid ContractVersion cv,@RequestParam MultipartFile contractVersionTemplate){
		
		System.out.println("file:"+contractVersionTemplate.getName() +"——>"+ contractVersionTemplate.getOriginalFilename());
		Date date = new Date();
		cv.setCreateDate(date);
		cv.setUpdateDate(date);
		cv.setCreator(this.getCurrentUser().getName()); 
		contractVersionService.saveContractVersion(cv);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 修改合同版本信息
	 * 权限编码005001006003
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/update")
	@RequiresPermissions("005001006003")
	public Map<String,Object> updateContractVersion(@Valid ContractVersion cv){
		Date date=new Date();
		cv.setUpdateDate(date);
		cv.setCreator(this.getCurrentUser().getName());
		contractVersionService.saveContractVersion(cv);
		return convertToResult("message","更新成功");
	}
	
	/**
	 * 删除合同版本
	 * 权限编码005001006002
	 */
	@ResponseBody
	@RequestMapping(method=RequestMethod.GET,value="/deleteContractVersion")
	@RequiresPermissions("005001006002")
	public Map<String,Object> deleteContractVersion(@Valid String ids){
		String [] idArray=ids.split(",");
		List<Long> idlist=new ArrayList<Long>();
		for(String id:idArray){
			idlist.add(Long.valueOf(id));
		}
		contractVersionService.deleConVersion(idlist);
		return convertToResult("message","删除成功");
	}
}
