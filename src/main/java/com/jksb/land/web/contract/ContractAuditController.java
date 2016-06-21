/**
 * 
 */
package com.jksb.land.web.contract;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SearchFilter.Operator;
import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.ContractorPersonal;
import com.jksb.land.service.contract.ContractService;
import com.jksb.land.web.BaseController;

/**
 * 合同审核
 * @author Willian Chan
 *
 */

@Controller
@RequestMapping("/contractAudit")
public class ContractAuditController extends BaseController {
	
	@Autowired
	private ContractService contractService;
	
	/**
	 * 合同审核界面
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/contractAuditPanel")
	@RequiresPermissions("005001003")
	public String contractAuditPanel(Model model){
		return "contract/contractAuditing";
	}
	
	/**
	 * 查询所有待审核合同
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/listAuditingContract")
	@RequiresPermissions("005001003")
	public Map<String,Object> getAuditContract(HttpServletRequest request){
//		查询条件
		SpecificationFactory<Contract> specf = new SpecificationFactory<Contract>();
		specf.addSearchParam("secondParty", Operator.LIKE, request.getParameter("secondParty"));
		specf.addSearchParam("useArea", Operator.GTE, request.getParameter("lowA"));
		specf.addSearchParam("useArea", Operator.LTE, request.getParameter("highA"));
		specf.addSearchParam("signingPrice", Operator.GTE, request.getParameter("lowP"));
		specf.addSearchParam("signingPrice", Operator.LTE, request.getParameter("highP"));
		//指定农场编码
		specf.addSearchParam("residentsGroup.communityEntity.farmCode", Operator.EQ, PrincipalUtil.getCurrentUserDepartmentCode());
		specf.addSearchParam("contractStatus", Operator.EQ, "1");
		Page<Contract> contracts=contractService.getAllContract(specf.getSpecification(), buildPageRequest(request));
		return convertToResult(contracts);
	}
	
	/**
	 * 根据承包合同编号查询承包人
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/showContractors")
	public List<ContractorPersonal> getContractorsByContractCode(HttpServletRequest request){
		String code=request.getParameter("code");
		Contract contract = contractService.getContractByCode(code);
		List<ContractorPersonal> cps = contract.getContractorPersonal();
		return cps;
	}
	
	/**
	 * 审核不通过
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/deny")
	public Map<String,Object> setDenyStatus(HttpServletRequest request){
		String ids=request.getParameter("contractIds");
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		//将所有合同状态设为4：审核不通过
		contractService.changeStatus(idlist,request.getParameter("auditOpinions"),"4");
		return convertToResult("message","审核成功");
	}
	
	/**
	 * 审核通过
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/pass")
	public Map<String,Object> setPassStatus(HttpServletRequest request){
		String ids=request.getParameter("ids");
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();		
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		contractService.passStatus(idlist,"3");
		return convertToResult("message","审核成功");
	}
}
