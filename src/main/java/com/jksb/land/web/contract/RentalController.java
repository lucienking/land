package com.jksb.land.web.contract;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.common.persistence.SearchFilter.Operator;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.PrePayingBudget;
import com.jksb.land.service.contract.ContractService;
import com.jksb.land.service.contract.PrePayingBudgetService;
import com.jksb.land.service.contract.RentalService;
import com.jksb.land.web.BaseController;

/**
 * 租金管理模块
 * @author wangxj
 *
 */
@Controller
@RequestMapping("/rental")
public class RentalController extends BaseController {
	
	@Autowired
	private RentalService rentalService;
	
	@Autowired
	private PrePayingBudgetService prePayingBudgetService;
	
	@Autowired
	private ContractService contractService;

	/**
	 * 租金管理界面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/rentalManager")
	@RequiresPermissions("005002001")
	public String rentalManager(Model model){
		model.addAttribute("farmName", PrincipalUtil.getCurrentUserDepartmentName());
		model.addAttribute("farmCode", PrincipalUtil.getCurrentUserDepartmentCode());
		return "/contract/rentalManager";
	}
	

	/**
	 * 根据合同状态查询合同
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractByStatus")
	public Map<String,Object> getContract(HttpServletRequest request) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//查询条件
		SpecificationFactory<Contract> specf = new SpecificationFactory<Contract>();
		specf.addSearchParam("residentsGroup.communityEntity.farmCode", Operator.EQ , PrincipalUtil.getCurrentUserDepartmentCode());
		specf.addSearchParam("secondPtRepresentative", Operator.LIKE ,request.getParameter("contractorName"));
		specf.addSearchParam("contractCode", Operator.LIKE ,request.getParameter("contractCode"));
		specf.addSearchParam("startDate", Operator.GTE ,request.getParameter("startDate")== null? null:sdf.parse(request.getParameter("startDate")));
		specf.addSearchParam("expiredDate", Operator.LTE ,request.getParameter("endDate")== null? null:sdf.parse(request.getParameter("endDate")));
		//分页排序信息
		Page<Contract> contract = contractService.getAllContract(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(contract);
	}
	
	/**
	 * 根据合同查询租金信息
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getRentalByContractId")
	public Map<String,Object> getRental(Long id,HttpServletRequest request){
		PageRequest pr = buildPageRequest(request);
		
		//分页排序信息
		Contract contract = contractService.getContractById(id);
		List<PrePayingBudget> budgets = (contract == null? null:contract.getPrePayingBudget());
		Map<String, Object> result = new HashMap<String, Object>();
		int size = budgets == null ? 0:budgets.size();
		int start = pr.getPageNumber()*pr.getPageSize();
		int end = (pr.getPageNumber()+1)*pr.getPageSize()>  size ? size :(pr.getPageNumber()+1)*pr.getPageSize();
		result.put("total",budgets == null? 0:budgets.size());
		result.put("rows", budgets == null?null:budgets.subList(start, end));
		return result;
	}
	
	/**
	 * 根据Id 查找合同信息
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getContractById")
	public Map<String,Object> getContractById(Long id){
		return convertToResult("contract",contractService.getContractById(id));
	}
	
	/**
	 * 修改合同租金项
	 * @param contract
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/editRental", method = RequestMethod.POST)
	public Map<String,Object> editRental(@ModelAttribute("contract") Contract contract){
		contractService.saveContract(contract);
		return convertToResult("message","修改成功");
	}
	
	/**
	 * 按ID查询租金明细
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getRentalById", method = RequestMethod.GET)
	public Map<String,Object> getRentalById(Long id){
		return convertToResult("budget",prePayingBudgetService.getPrePayingBudgetById(id));
	}
	
	@ResponseBody
	@RequestMapping(value = "/editRentalDetail", method = RequestMethod.POST)
	public Map<String,Object> editRentalDetail(@ModelAttribute("budget") PrePayingBudget prePayingBudget){
		prePayingBudgetService.savePrePayingBudget(prePayingBudget);
		return convertToResult("message","修改成功");
	}
	
	@ModelAttribute
	public void getContract(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
			model.addAttribute("contract", contractService.getContractById(id));
	}
	
	@ModelAttribute
	public void getBudget(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
			model.addAttribute("budget", prePayingBudgetService.getPrePayingBudgetById(id));
	}
}
	
