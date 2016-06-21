package com.jksb.land.web.landContract;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jksb.land.constant.LandContractState;
import com.jksb.land.constant.LandContractType;
import com.jksb.land.entity.landContract.ContractAttach;
import com.jksb.land.entity.landContract.LandContract;
import com.jksb.land.common.easyui.DataGridModel;
import com.jksb.land.common.util.PrincipalUtil;
import com.jksb.land.service.landContract.ContractConfig;
import com.jksb.land.service.landContract.LandContractService;
import com.jksb.land.view.landContract.AttachView;
import com.jksb.land.view.landContract.ContractInnerView;
import com.jksb.land.view.landContract.LandRegionView;

@Controller
@RequestMapping("/landContract")
public class ContractsController {
	
	private final static Logger log = LoggerFactory.getLogger(ContractsController.class);
	
	@PersistenceContext(unitName="landJpa")
	private EntityManager entityManager;
	@Autowired
	private LandContractService landContractService;
	
	@Autowired
	private ContractConfig contractConfig;
	
	private SimpleDateFormat sdfYear=new SimpleDateFormat("yyyy");
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String addForm(){
		return "/landContract/contractSelect";
	}
	
	@RequestMapping(value="/addInner",method=RequestMethod.GET)
	public String addInnerForm(Model model){
		String year=sdfYear.format(new Date());
		model.addAttribute("year", year);
		
		String farmName=PrincipalUtil.getCurrentUserDepartmentName();
		model.addAttribute("farmName", farmName);
		
		String farmCode=PrincipalUtil.getCurrentUserDepartmentCode();
		String representativeA=this.contractConfig.getFarmMap().get(farmCode);
		model.addAttribute("representativeA", representativeA);
		
		return "/landContract/contractInnerAdd";
	}
	
	@RequestMapping(value="/addInner",method=RequestMethod.POST)
	public String addInner(ContractInnerView vo,LandRegionView regionVo,AttachView attachVo,Integer operation,HttpServletRequest request,RedirectAttributes redirectAttributes){
		long id=landContractService.saveContract(vo,regionVo,attachVo,operation==1?LandContractState.LEGAL:LandContractState.DRAFT,LandContractType.INNER,request);
		redirectAttributes.addFlashAttribute("msg", "添加成功");
		return "redirect:/landContract/editInner/"+id;
	}
	
	@RequestMapping(value="/editInner/{id}",method=RequestMethod.GET)
	public String editInnerForm(@PathVariable("id")long id,Model model){
		LandContract contract = landContractService.getLandContractDao().findOne(id);
		model.addAttribute("contract", contract);
		if(contract.getState()!=LandContractState.DRAFT){
			model.addAttribute("preview", true);
		}
		return "/landContract/contractInnerEdit";
	}
	
	@RequestMapping(value="/editInner/{id}",method=RequestMethod.POST)
	public String editInner(@PathVariable("id")long id,ContractInnerView vo,LandRegionView regionVo,AttachView attachVo,Long[] delIdArray,Long[] delAttachIdArray,Integer operation,HttpServletRequest request,RedirectAttributes redirectAttributes){
		this.landContractService.editContract(vo,regionVo,attachVo,operation==1?LandContractState.LEGAL:LandContractState.DRAFT, id,delIdArray,delAttachIdArray,request);
		redirectAttributes.addFlashAttribute("msg", "修改成功");
		return "redirect:/landContract/editInner/"+id;
	}
	
	@RequestMapping(value="/preview/{contractType}/{id}",method=RequestMethod.GET)
	public String previewForm(@PathVariable("contractType")int contractType,@PathVariable("id")long id,Model model){
		LandContract contract = landContractService.getLandContractDao().findOne(id);
		model.addAttribute("contract", contract);
		model.addAttribute("preview", true);
		model.addAttribute("hideBar", true);
		switch(contractType){
			case LandContractType.INNER:return "/landContract/contractInnerEdit";
			case LandContractType.OUTER:return "/landContract/contractInnerEdit";
			case LandContractType.TEMPORARY:return "/landContract/contractInnerEdit";
			case LandContractType.OCCUPY:return "/landContract/contractInnerEdit";
		}
		return "/landContract/contractInnerEdit";
	}
	
	@RequestMapping("/checkRegion")
	@ResponseBody
	public Map<String,Integer> checkRegion(Long dataId,String regionId){
		Map<String,Integer> map=new HashMap<String,Integer>();
		String key="code";
		int count=0;
		if(regionId==null||"".equals(regionId.trim())){
			
		}else{
			if(dataId!=null){
				count=this.landContractService.getContractRegionDao().countByRegionIdAndLandContractStateAndNotLandContractId(regionId, LandContractState.LEGAL, dataId);
			}else{
				count=this.landContractService.getContractRegionDao().countByRegionIdAndLandContractState(regionId, LandContractState.LEGAL);
			}
		}
		map.put(key, count>0?0:1);
		return map;
	}
	
	@RequestMapping(value="/uploadAttach",method=RequestMethod.POST)
	@ResponseBody
	public ContractAttach uploadAttach(@RequestParam(value="file",required=false)MultipartFile file,HttpServletRequest request){
		ContractAttach attach=this.landContractService.uploadAttach(file, request);
		return attach; 
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView("/landContract/list");
		String farmCode = PrincipalUtil.getCurrentUserDepartmentCode();
		String farmName = PrincipalUtil.getCurrentUserDepartmentName();
		if(PrincipalUtil.isSenior() == false){
			mv.addObject("farmCode",farmCode);
			mv.addObject("farmName",farmName);
		}else if(PrincipalUtil.isSenior() == true){
			mv.addObject("farmCode","1");
		}
		return mv;
	}
	
	@RequestMapping("/ajaxTable")
	@ResponseBody
	public DataGridModel<LandContract> ajaxTable(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("rows") int size, @RequestParam("page") int page, String sort, String order){
		DataGridModel<LandContract> result = new DataGridModel<LandContract>();
		try {
			//RkxxRecordSearchView sv = (RkxxRecordSearchView)ParamsUtil.initObj(request, RkxxRecordSearchView.class);
			String farmCode = PrincipalUtil.getCurrentUserDepartmentCode();
			
			String code = request.getParameter("code");
			String contractNumber = request.getParameter("contractNumber");
			String timeLimit = request.getParameter("timeLimit");
			String state = request.getParameter("state");
			String contractType = request.getParameter("contractType");
			String partyB = request.getParameter("partyB");
			String contractYear = request.getParameter("contractYear");
			String areaOfLandGe = request.getParameter("areaOfLandGe");
			String areaOfLandLe = request.getParameter("areaOfLandLe");
			
			StringBuffer sb = new StringBuffer();
			sb.append(" FROM LandContract lc where 1=1 ");
			if(PrincipalUtil.isSenior() == false){
				sb.append(" and lc.farmCode = ("+farmCode+") ");
			}
			if(!code.equals("") && !code.equals("1")){
				sb.append(" and lc.farmCode = ("+code+") ");
			}
			if(!contractNumber.equals("null") && !contractNumber.equals("")){
				sb.append(" and lc.contractNumber like '%"+contractNumber+"%' ");
			}
			if(!timeLimit.equals("null") && !timeLimit.equals("")){
				sb.append(" and lc.timeLimit = ("+timeLimit+") ");
			}
			if(!state.equals("null") && !state.equals("")){
				sb.append(" and lc.state = ("+state+") ");
			}
			if(!contractType.equals("null") && !contractType.equals("")){
				sb.append(" and lc.contractType = ("+contractType+") ");
			}
			if(!partyB.equals("null") && !partyB.equals("")){
				sb.append(" and lc.partyB like '%"+partyB+"%' ");
			}
			if(!contractYear.equals("null") && !contractYear.equals("")){
				sb.append(" and lc.contractYear = ("+contractYear+") ");
			}
			if(!areaOfLandGe.equals("null") && !areaOfLandGe.equals("")){
				sb.append(" and lc.areaOfLand >= ("+areaOfLandGe+") ");
			}
			if(!areaOfLandLe.equals("null") && !areaOfLandLe.equals("")){
				sb.append(" and lc.areaOfLand <= ("+areaOfLandLe+") ");
			}
			
			/*String parser = QueryParser.conditionParser(sv);
			if (parser.length() > 0) {
				sb.append(" and ").append(parser);
			}*/
			
			if(order != null){
				sb.append(" order by " + sort + " " + order);
			}
			//sb.append(" order by id desc ");
			Query qr = entityManager.createQuery("select lc " + sb + " order by lc.id desc ");
			qr.setFirstResult((page - 1) * size);
			qr.setMaxResults(size);
			List<LandContract> lcList = qr.getResultList();
			qr = entityManager.createQuery("select count(*) " + sb);
			Long lcListNum = (Long)qr.getSingleResult();
			result.setRows(lcList);
			result.setTotal(lcListNum);
		} catch (Exception e) {
			e.printStackTrace();  
		}
		return result; 
	}
	
	@RequestMapping("/contractDetail")
	public ModelAndView contractDetail(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam("contractId") Long id){
		ModelAndView detailInnerMv = new ModelAndView("/landContract/detailInner");
		ModelAndView detailMv = new ModelAndView("/landContract/detail");
		LandContract lc = null;
		lc = landContractService.getLandContractDao().findOne(id);
		if(lc.getContractType() == LandContractType.INNER){
			detailInnerMv.addObject("lc", lc);
			return detailInnerMv;
		}else{
			detailMv.addObject("lc", lc);
			return detailMv;
		}
	}
	
	@RequestMapping("/cancelStates")
	@ResponseBody
	public Map<String, Object> cancelStates(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ids") String ids){
		Map<String, Object> m = new HashMap<String, Object>();
		try {
			if(ids!=null&&!"".equals(ids)){
				int concelNum = landContractService.cancelContractStates(LandContractState.CANCEL,LandContractState.LEGAL,ids);
				m.put("code", "1");
				if(concelNum == 0){
					m.put("message", "只有正式合同才能注销！");
				}else{
					m.put("message", concelNum+"条正式合同注销成功！");
				}
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			e.printStackTrace();
			m.put("code", "0");
			m.put("message", "注销失败");
		}
		
		return m;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ids") String ids){
		Map<String, Object> m = new HashMap<String, Object>();
		try {
			if(ids!=null&&!"".equals(ids)){
				int deleteNum = landContractService.deleteContracts(LandContractState.DRAFT,ids);
				m.put("code", "1");
				if(deleteNum == 0){
					m.put("message", "只有草稿合同才能删除！");
				}else{
					m.put("message", deleteNum+"条草稿合同删除成功！");
				}
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			e.printStackTrace();
			m.put("code", "0");
			m.put("message", "删除失败");
		}
		
		return m;
	}
}
