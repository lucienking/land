/*package com.jksb.land.web.contract;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.easyui.DataGridModel;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.ContractParcelInfo;
import com.jksb.land.entity.staticData.CommunityEntity;
import com.jksb.land.entity.staticData.ResidentsGroup;
import com.jksb.land.repository.contract.ContractParcelInfoDao;
import com.jksb.land.service.contract.ContractInfoService;
import com.jksb.land.service.staticData.ResidentsGroupService;
import com.jksb.land.view.ContractInfoView;
import com.jksb.land.web.BaseController;

*//**
 * 合同查询Controller
 * 
 * @author chensheng
 * 
 * *//*
@Controller
@RequestMapping("/contractInfo")
public class ContractInfoController extends BaseController {

	@Autowired
	private ContractInfoService ContractService;
	
	@Autowired
	private ResidentsGroupService residentsGroupService;
	
	@Autowired
	private ContractParcelInfoDao contractParcelInfoDao;

	*//**
	 * @author chensheng  
	 * 跳转至承包合同信息查询界面
	 * 
	 * *//*
	@RequestMapping("/contractInfo")
	public String contractApplication(Model model) {
		try {
			model.addAttribute("farmCode",
					PrincipalUtil.getCurrentUserDepartmentCode());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/contract/contractInfo";
	}

	*//**
	 * @author chensheng 合同信息查询
	 * @param HttpServletRequest
	 *            request
	 * 
	 * *//*
	@ResponseBody
	@RequestMapping("/getContractInfo")
	public DataGridModel<ContractInfoView> getByPage(HttpServletRequest request) {
		DataGridModel<ContractInfoView> model = new DataGridModel<ContractInfoView>();
		PageRequest pageRequest = this.buildPageRequest(request);
		List<ContractInfoView> ContractInfoViewlist = this.ContractService
				.findContractInfo(request.getParameter("contractorType"), request,pageRequest);
		model.setRows(ContractInfoViewlist);
		model.setTotal(ContractInfoViewlist.size());
		return model;
	}

	*//**
	 * @author 陈升 初始化居民小组下拉框
	 * 
	 * *//*
	@ResponseBody
	@RequestMapping("/getResidentsGroupByCommunity")
	public List<Map<String, Object>> getResidentsGroupByCommunity(
			@RequestParam(value = "communityCode", defaultValue = "0") String code) {
		List<ResidentsGroup> groups = residentsGroupService
				.getResidentsGroupByCommunityCode(code);
		List<Map<String, Object>> select = new ArrayList<Map<String, Object>>();
		Map<String, Object> defau = new HashMap<String, Object>();
		defau.put("id", "");
		defau.put("text", "--请选择--");
		defau.put("selected", true);
		select.add(defau);
		for (ResidentsGroup group : groups) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", group.getResidentsGrpCode());
			map.put("text", group.getResidentsGrpName());
			select.add(map);
		}
		return select;
	}

	*//**
	 * 根据合同编码查询合同信息
	 * 打开合同编辑界面
	 * @author chensheng
	 * *//*
	@RequestMapping("/getContractInfoByContractCode")
	public String getContractInfoByContractCode(Model model, String code) {
		Contract contract = this.ContractService
				.findContractInfoByContractCode(code);
		String farmName = PrincipalUtil.getCurrentUserDepartmentName();
		ResidentsGroup res = contract.getResidentsGroup();
		CommunityEntity com = contract.getResidentsGroup().getCommunityEntity();
		String farmCode = PrincipalUtil.getCurrentUserDepartmentCode();
		model.addAttribute("contract", contract);
		model.addAttribute("farmName", farmName);
		model.addAttribute("ResidentsGroup", res);
		model.addAttribute("community", com);
		model.addAttribute("farmCode", farmCode);
		return "/contract/edit";
	}
	*//**
	 * 根据合同编码查询自营经济
	 * 跳转自营经济界面
	 * @author zhaofangfang
	 * *//*
	@ResponseBody
	@RequestMapping("/getContractInfoByContractCodeMAP")	
	public List<String>  getContractInfoByContractCodeMAP( String code) {
		Contract contract = this.ContractService.findContractInfoByContractCode(code);
	
		//ResidentsGroup res = contract.getResidentsGroup();
		CommunityEntity com = contract.getResidentsGroup().getCommunityEntity();
		String farmCode = com.getFarmCode();
		String farmName = PrincipalUtil.getCurrentUserDepartmentName();
		List<ContractParcelInfo> places= contract.getContractParcelInfo();
		String strPlace="";
		for (ContractParcelInfo place : places)
		{
			strPlace+=place.getContractParcelCode()+",";
		}
		List<String> list = new ArrayList<String>();  
		list.add(farmCode);
		list.add(farmName);
		list.add(strPlace);
		return list;//farmName+";"+farmCode+";"+
	}
	*//**
	 * 根据地块编号查找合同
	 * 跳转合同界面
	 * @author zhaofangfang
	 * *//*
	@ResponseBody
	@RequestMapping("/getContractByMAP")	///根据地块编号查找合同
	public DataGridModel<ContractInfoView> getContractByMAP(HttpServletRequest request) {
		PageRequest pageRequest = this.buildPageRequest(request);
		List<ContractInfoView> ContractInfoViewlist= new ArrayList<ContractInfoView>();
		DataGridModel<ContractInfoView> model = new DataGridModel<ContractInfoView>();
		
		//此处修改 删除了自营经济地实体  自营经济编号即为 承包地编号
		ContractParcelInfo listconPinfo = this.contractParcelInfoDao.findContractParcelInfoByContractParcelCode(request.getParameter("zdCode"));
		//	List<Contract> listcon= new ArrayList<Contract>();  
		String farmno= request.getParameter("ncCode");
		Contract con=  null;  //modify
		CommunityEntity com = con.getResidentsGroup().getCommunityEntity();
		String farmCode = com.getFarmCode();
	//	listcon.add(con);
		if(farmno.equals(farmCode))
		{
		ContractInfoView contractInfoview = new ContractInfoView();			
		contractInfoview.setId(con.getId());
		contractInfoview.setContractCode(con.getContractCode());
		contractInfoview.setContractArea(con.getUseArea());
		contractInfoview.setContractTime(con.getLeaseTerm());
		contractInfoview.setContractor(con.getSecondPtRepresentative());
		ContractInfoViewlist.add(contractInfoview);
		}
		
	
		
     	int siz=ContractInfoViewlist.size();
		model.setRows(ContractInfoViewlist);
		model.setTotal(ContractInfoViewlist.size());
		return model;
	}


}
*/