package com.jksb.land.web.contract;


import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.common.persistence.SearchFilter.Operator;
import com.jksb.land.common.util.CommonUtil;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.ContractAttachment;
import com.jksb.land.entity.contract.ContractParcelInfo;
import com.jksb.land.entity.contract.ContractorEnterprise;
import com.jksb.land.entity.contract.ContractorPersonal;
import com.jksb.land.entity.staticData.CommunityEntity;
import com.jksb.land.entity.staticData.ResidentsGroup;
import com.jksb.land.rest.RestRemoteTransfer;
import com.jksb.land.service.ServiceException;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.service.contract.ContractParcelInfoService;
import com.jksb.land.service.contract.ContractService;
import com.jksb.land.service.contract.ContractorPersonalService;
import com.jksb.land.service.rent.RentCalculateService;
import com.jksb.land.service.staticData.ResidentsGroupService;
import com.jksb.land.web.BaseController;

/**
 * 合同Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping("/contract")
public class ContractController extends BaseController {
	
	@Autowired
	private ContractService contractService;
	
	@Autowired
	private ResidentsGroupService residentsGroupService;
	
	@Autowired
	private RentCalculateService rentCalculateService;
	
	@Autowired
	private RestRemoteTransfer restRemoteTransfer;
	
	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	@Autowired
	private ContractorPersonalService contractorPersonalService;
	
	@Autowired
	private ContractParcelInfoService contractParcelInfoService;
	
	private final static Logger logger = LoggerFactory.getLogger(ContractController.class);

	/**
	 * 承包合同申请界面<br/>
	 * 权限编码 005001001
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractApplication")
	@RequiresPermissions("005001001")
	public String  contractApplication(Model model){
		Contract contract = new Contract();
		contract.setContractCode(getContractCode());
		contract.setDateOfSigning(new Date());
		
		model.addAttribute("contract", contract);
		model.addAttribute("signDate", CommonUtil.getNowDateFormat("yyyy年MM月dd日"));
		model.addAttribute("startDate", CommonUtil.getNowDateFormat("yyyy-MM-dd"));
		model.addAttribute("endDate", CommonUtil.getNowDateFormat("yyyy-MM-dd"));
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/contract/contractApplication";
	}
	
	/**
	 * 合同申请提交
	 * @param contract
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("005001001001")
	public Map<String,Object>  createContract(@Valid Contract contract,
					@ModelAttribute("group")ResidentsGroup residentsGroup, 
					@RequestParam(value = "contractorInfo_contractorType", defaultValue = "1")
					String contractorType){
		Date date = new Date();
		contract.setCreateTime(date);
		contract.setUpdateTime(date);
		contract.setContractCode(residentsGroup.getResidentsGrpCode()+contract.getContractCode());
		contract.setOperator(PrincipalUtil.getCurrentUserAccount()); 
		
		contract.setResidentsGroup(residentsGroup);
		
		//承包人 个人
		List<ContractorPersonal> cps = contract.getContractorPersonal();
		contract.setContractorPersonal(cps);
		
		//承包人 企业
		List<ContractorEnterprise> ces = contract.getContractorEnterprise();
		contract.setContractorEnterprise(ces);
		
		//承包地
		List<ContractParcelInfo> cpi = contract.getContractParcelInfo();
		contract.setContractParcelInfo(cpi);
		
		//合同附件
		List<ContractAttachment> cas = contract.getContractAttachment();
		contract.setContractAttachment(cas);
				
		//初始化租金逻辑
		contract  = rentCalculateService.initPrePayingBuget(contract);
	 	
		contractService.saveContract(contract);
		return convertToResult("message","申请提交成功"); 
	}
	
	/**
	 * 生成合同编码
	 * @return
	 */
	private String getContractCode(){
		String date  = CommonUtil.getNowDateFormat("yyMMddHHmmssSSS");
		//int random  = (int) (Math.random()*9000+1000);
		return date;
	}
	
	/**
	 * 按农场和合同编号校验合同
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/validateContractNo")
	public Map<String,Object> getContractByNO(HttpServletRequest request) throws ParseException{
		String exist = "N";
		SpecificationFactory<Contract> specf = new SpecificationFactory<Contract>();
		specf.addSearchParam("contractNo", Operator.EQ ,getParameter("contractNo"));
		specf.addSearchParam("residentsGroup.communityEntity.farmCode", Operator.EQ , getParameter("farmCode"));
		
		long contractNum = contractService.getContractCount(specf.getSpecification());
		if(contractNum > 0){
			exist = "Y";
		}
		return convertToResult("exist",exist);
	}
	
	/**
	 * 人口信息
	 * @param idNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getPeopleInfo")
	public Map<String,Object> getPeopleInfo(String idNo){
		ContractorPersonal cp = new ContractorPersonal();
		Map<String, String> map = new HashMap<String,String>();
		try {
			map = restRemoteTransfer.getPeopleInfo(idNo);
			cp.setContractorIDNO(map.get("gmsfhm"));
			cp.setContractorName(map.get("xm"));
			cp.setContractorPhoneNumber(map.get("lxdh"));
			cp.setHuhao(map.get("hh"));
			cp.setContractorDepartment(map.get("gzdw"));
			cp.setContractorAddr(map.get("jtzz"));
			cp.setIsCadres(map.get("sfgb")== null?"N": (map.get("sfgb").equals("1")?"Y":"N"));
			cp.setResidentTypeName(map.get("jmlxmc"));
			cp.setResidentTypeCode(map.get("jmlxbm"));
			cp.setIsStaff("Y");
			logger.info("NO:{},Name:{}",map.get("gmsfhm"),map.get("xm"));
		} catch (Exception e) {
			logger.info("接口错误:{}",e.getMessage());
			throw new ServiceException("接口错误");
		}  
		return convertToResult("contractorPersonal",cp);
	}
	
	@ModelAttribute
	public void getResidentsGroup(@RequestParam(value = "residentsGrpCode", defaultValue = "-1") String code, Model model) {
		if (StringUtils.isNotBlank(code)) {
			model.addAttribute("group", residentsGroupService.getResidentsGroupByCode(code));
		}
	}
	
	/**
	 * 合同查询
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractQuery")
	@RequiresPermissions("005001002")
	public String  contractQuery(String farmCode,String placeCode,Model model){
		if(farmCode!= null &&farmCode != "" && placeCode !=null && placeCode!=""){
			model.addAttribute("farmCode",farmCode);
			model.addAttribute("placeCode",placeCode);
		}else{
			model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
			model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		}
		return "/contract/contractQuery";
	}
	
	/**
	 * 条件查询合同
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractsByCondition")
	public Map<String,Object> getContract(HttpServletRequest request) throws ParseException{
		Map<String,Object> param = new HashMap<String,Object>();
		
		param.put("secondPtRepresentative",getParameter("contractorName") );
		param.put("contractNo",getParameter("contractNo") );
		param.put("startDate",getParameter("startDate") );
		param.put("expiredDate",getParameter("expiredDate") );
		param.put("termStart",getParameter("termStart") );
		param.put("termEnd",getParameter("termEnd") );
		param.put("areaStart",getParameter("areaStart") );
		param.put("areaEnd",getParameter("areaEnd") );
		param.put("affordableArea",getParameter("affordableArea") );
		param.put("farmCode",getParameter("farmCode")=="1"?null:getParameter("farmCode") );
		param.put("communityCode",getParameter("communityCode") );
		param.put("residentsGrpCode",getParameter("residentsGrpCode") );
		param.put("isCadres",getParameter("isCadres") );
		param.put("dkbh",getParameter("dkbh") );
		
		StringBuilder sb = new StringBuilder();
		sb.append("land_proc_contract_query(:farmCode,:secondPtRepresentative,");
		sb.append(":contractNo,:startDate,:expiredDate,:termStart,:termEnd,:areaStart,");
		sb.append(":areaEnd,:affordableArea,:communityCode,:residentsGrpCode,:isCadres,");
		sb.append(":dkbh,");
		sb.append(":queryTotal,:pageSize,:pageNumber,:orderStr,:orderDerect)");
		Map<String,Object> list = procedureExecuteService
				.getLandResult(sb.toString(),param,getPage(request));
		return list;
	}
	
	/**
	 * 合同编辑详细页面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractEdit")
	@RequiresPermissions("005001003")
	public String contractEdit(Long id,Model model){
		model.addAttribute("contract",contractService.getContractById(id));
		return  "/contract/contractEdit";
	}
	
	/**
	 * 根据Id 查找合同详细信息展示页面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractDetailInfo")
	public String contractDetailInfo(Long id,Model model){
		model.addAttribute("contract",contractService.getContractById(id));
		return  "/contract/contractDetailInfo";
	}
	
	/**
	 * 合同批量上传
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/BantchUpload")
	@RequiresPermissions("005001009")
	public String BantchUpload(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		return "/contract/bantchUpload";
	}
	
	/**
	 * 初始化合同应缴金额，用于批量导入后初始化
	 * @param request
	 * @throws ParseException
	 */
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/initialPrepayingBudget")
	public Map<String,Object> initialPrepayingBudget(HttpServletRequest request) throws ParseException{
		logger.info("初始化租金查询合同");
		SpecificationFactory<Contract> specf = new SpecificationFactory<Contract>();
		specf.addSearchParam("residentsGroup.communityEntity.farmCode", Operator.EQ , getParameter("farmCode"));
		specf.addSearchParam("contractCode", Operator.EQ , getParameter("contractCode"));
		List<Contract> contracts =contractService.getAllContract(specf.getSpecification());
		logger.info("初始化租金开始：共"+contracts.size()+"条");
		Date odate=new Date();
		int i = 0;
		for(Contract contract:contracts){
			if(contract.getPrePayingBudget().size() == 0&&i<1){
				Date date=new Date();
				rentCalculateService.initPrePayingBuget(contract);
				Date temp=new Date();
				contractService.saveContract(contract);
			//	System.out.println(contract.getPrePayingBudget().size());
				Date end=new Date();
				logger.info("计算时间：{},保存时间：{}",(temp.getTime()-date.getTime()),(end.getTime()-temp.getTime()));
				//i++;
			}
		}
		Date oend=new Date();
		logger.info("初始化租金结束，共"+(oend.getTime()-odate.getTime())+"毫秒");
		return convertToResult("message","成功");
	}
	

	/**
	 * 承包人编辑
	 * @param contractorPersonal
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateContractor", method = RequestMethod.GET)
	public String updateContractor(@ModelAttribute("person") ContractorPersonal contractorPersonal){
		contractorPersonalService.save(contractorPersonal);
		return "success";
	}
	
	@ModelAttribute
	public void getContractorPersonal(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("person", contractorPersonalService.getContractorPersonalById(id));
		}
	}
	
	/**
	 * 合同编辑
	 * @param contract
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateContract", method = RequestMethod.POST)
	public String updateContract(@ModelAttribute("contract") Contract contract,
			String residentsGrpCode){
		ResidentsGroup residentsGroup =  residentsGroupService.getResidentsGroupByCode(residentsGrpCode);
		contract.setResidentsGroup(residentsGroup);
		contractService.saveContract(contract);
		return "success";
	}
	
	
	/**
	 * 地块编辑
	 * @param contractorPersonal
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateContractParcelInfo", method = RequestMethod.GET)
	public String updateContractParcelInfo(@ModelAttribute("parcelInfo") ContractParcelInfo contractParcelInfo){
		contractParcelInfoService.saveContractParcelInfo(contractParcelInfo);
		return "success";
	}
	
	@ModelAttribute
	public void getParcelInfo(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("parcelInfo", contractParcelInfoService.getContractParcelInfoById(id));
		}
	}
	
	@ModelAttribute
	public void getContract(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("contract", contractService.getContractById(id));
		}
	}

	/**
	 * 根据合同编码查询自营经济 跳转自营经济界面 根据id 获取地块编号 农场编号
	 * 
	 * @author tangweilong,zhaofangfang
	 * */
	@ResponseBody
	@RequestMapping("/ContractQuerytoselfEconomy")
	public Map<String,String> ContractQuerytoselfEconomy(Long id) {
		Contract contract = contractService.getContractById(id);

		CommunityEntity com = contract.getResidentsGroup().getCommunityEntity();
		String farmCode = com.getFarmCode();
		List<ContractParcelInfo> places = contract.getContractParcelInfo();
		String strPlace = "";

		for (int i = 0; i < places.size(); i++) {
			if (i != places.size() - 1) {
				strPlace += places.get(i).getContractParcelCode() + ",";
			} else {
				strPlace += places.get(i).getContractParcelCode();
			}
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("farmCode",farmCode);
		map.put("strPlace",strPlace); 
		return map; 
	}
}
