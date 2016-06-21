/**
 * 
 */
package com.jksb.land.web.contract;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SearchFilter.Operator;
import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.common.util.CommonUtil;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.PrePayingBudget;
import com.jksb.land.entity.contract.RentalRecords;
import com.jksb.land.service.contract.ContractService;
import com.jksb.land.service.contract.PrePayingBudgetService;
import com.jksb.land.service.contract.RentalRecordsService;
import com.jksb.land.service.rent.RentCalculateService;
import com.jksb.land.web.BaseController;

/**
 * 租金登记
 * @author Willian Chan
 *
 */


@Controller
@RequestMapping("/rentalRegister")
public class RentalRegisterController extends BaseController {
	/**
	 * 显示租金登记页面
	 * @param model
	 * @return
	 */
	
	@Autowired
	private ContractService contractService;
	
	@Autowired
	private PrePayingBudgetService prePayingBudgetService;
	
	@Autowired
	private RentalRecordsService rentalRecordsService;
	
	@Autowired
	private RentCalculateService rentCalculateService;
	
	@RequestMapping(method = RequestMethod.GET,value = "/rentalRegister")
	@RequiresPermissions("005003001")	
	public String registerWeb(Model model){
		model.addAttribute("nowDate", CommonUtil.getNowDateFormat("yyyy-MM-dd"));
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "rentalRegister/rentalRegister";
	}
	
	/**
	 * 合同列表
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getcontractList")
	public Map<String,Object> getcontractList(HttpServletRequest request){
//		查询条件
		SpecificationFactory<Contract> specf = new SpecificationFactory<Contract>();
		specf.addSearchParam("contractNo", Operator.LIKE, request.getParameter("contractNo"));		//模糊查询合同编号
		specf.addSearchParam("secondParty", Operator.LIKE, request.getParameter("secondParty"));	//模糊查询承包人（乙方）
		specf.addSearchParam("residentsGroup.residentsGrpCode", Operator.EQ, request.getParameter("residentsGrpCode"));		//根据居民小组编号查询
		specf.addSearchParam("residentsGroup.communityEntity.communityCode", Operator.EQ, request.getParameter("communityCode"));	//根据社区查询
		specf.addSearchParam("residentsGroup.communityEntity.farmCode", Operator.EQ, PrincipalUtil.getCurrentUserDepartmentCode());		//设置农场编号过滤结果
		specf.addSearchParam("contractStatus", Operator.LT, "6");	//过滤无效合同，排除已注销、已到期合同
		Page<Contract> contracts=contractService.getAllContract(specf.getSpecification(), buildPageRequest(request));
		return convertToResult(contracts);
	}
	
	/**
	 * 获取应缴金额明细
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/getBudget")
	public List<PrePayingBudget> getBudget(HttpServletRequest request){
		String contractCode=request.getParameter("contractCode");
		Contract contract = contractService.getContractByCode(contractCode);
		return contract.getPrePayingBudget();
		//return prePayingBudgetService.getPrePayingBudgetByCode(contractCode);
	}
	
	/**
	 * 登记租金
	 * @param rentalRecords
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/pay")
	public Map<String,Object> registerRental(@Valid RentalRecords rentalRecords){
		Date date=new Date();
		rentalRecords.setPayDate(date);
		rentalRecordsService.saveRentalRecords(rentalRecords);
		rentalRecordsService.fixOwnship(rentalRecords);
		return convertToResult("message","登记成功");
	}
	
	/**
	 * 根据合同获取租金的缴费记录
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/getRecordsByContract")
	public Map<String,Object> getRentalRecords(HttpServletRequest request){
		String contractCode=request.getParameter("contractCode");
		Contract contract=contractService.getContractByCode(contractCode);
		List<PrePayingBudget> prePayingBudgets=contract.getPrePayingBudget();
		List<RentalRecords> rr=new ArrayList<RentalRecords>();
		for(PrePayingBudget pb:prePayingBudgets){
			rr.addAll(pb.getRentalRecords());
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("total",rr.size());
		result.put("rows", rr);
		return result;
	}
	
	/**
	 * 计算参考应缴
	 * 
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/getSysPaidBudget")
	public Map<String, Object> getSysPaidBudget(@ModelAttribute("contract") Contract contract,
			@ModelAttribute("prePayingBudget") PrePayingBudget prePayingBudget){
		prePayingBudget = rentCalculateService.initPrePayingBuget(contract,prePayingBudget);
		prePayingBudgetService.savePrePayingBudget(prePayingBudget);
		return convertToResult("info","success");
	}
	
	@ModelAttribute
	public void getContract(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("contract", contractService.getContractById(id));
		}
	}
	
	@ModelAttribute
	public void getPrePayingBudget(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("prePayingBudget", prePayingBudgetService.getPrePayingBudgetById(id));
		}
	}
}
