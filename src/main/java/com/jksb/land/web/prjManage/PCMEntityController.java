/**
 * 
 */
package com.jksb.land.web.prjManage;

import java.text.ParseException;
import java.util.Date;
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
import com.jksb.land.entity.prjCntManage.PCMEntity;
import com.jksb.land.entity.prjCntManage.PrjAttachmentEntity;
import com.jksb.land.repository.prjManage.PCMEntityDao;
import com.jksb.land.service.prjManage.PCMService;
import com.jksb.land.web.BaseController;

/**
 * @author Willian Chan
 *
 */
@Controller
@RequestMapping("/projectManage")
public class PCMEntityController extends BaseController {
	
	@Autowired
	private PCMService pcmService;
	@Autowired
	private PCMEntityDao pcmEntityDao;
	
	/**
	 * 项目建设申请表页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/prjApplication")
	@RequiresPermissions("010001001")
	public String prjApplication(Long id,Model model){
		return  "/ProjectManage/prjApplication";
	}
	
	/**
	 * 我的建设项目页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/myApplication")
	@RequiresPermissions("010001003")
	public String myApplication(Long id,Model model){
		return  "/ProjectManage/myApplication";
	}
	
	/**
	 * 待审核页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/auditingPrj")
	@RequiresPermissions("010001004")
	public String auditingPrj(Long id,Model model){
		return  "/ProjectManage/auditingPrj";
	}
	
	/**
	 * 已审核页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/passedPrj")
	@RequiresPermissions("010001005")
	public String passedPrj(Long id,Model model){
		return  "/ProjectManage/passedPrj";
	}
	
	/**
	 * 保存项目管理申请表
	 * @param pcmEntity
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/savePCM", method = RequestMethod.POST)
	@RequiresPermissions("010001002")
	public Map<String,Object> savePCM(PCMEntity pcmEntity){
		Date date=new Date();
		
		pcmEntity.setCreateTime(date);
		pcmEntity.setUpdateTime(date);
		pcmEntity.setApplier(PrincipalUtil.getCurrentUserAccount());
		
		//项目附件，一个项目多个附件
		List<PrjAttachmentEntity> paes=pcmEntity.getPrjAttachmentEntitis();
		pcmEntity.setPrjAttachmentEntitis(paes);
		
		pcmService.savePCMEntity(pcmEntity);
		return convertToResult("message","保存成功");
	}

	/**
	 * 验证项目编码是否已经存在
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/validprojectCode", method = RequestMethod.GET)
	public Map<String,Object> validProjectCode(HttpServletRequest request){
		String projectCode=request.getParameter("id");
		int pcmEntity=pcmService.getPCMNumByProjectCodee(projectCode);
		if(pcmEntity>0){
			return convertToResult("exist","true");
		}else{
			return convertToResult("exist","false");
		}
	}
	/**
	 * 验证项目名称是否已经存在
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/validprojectName", method = RequestMethod.GET)
	public Map<String,Object> validProjectName(HttpServletRequest request){
		String projectName=request.getParameter("id");
		int pcmEntity=pcmService.getPCMNumByProjectName(projectName);
		if(pcmEntity>0){
			return convertToResult("exist","true");
		}else{
			return convertToResult("exist","false");
		}
	}
	
	/**
	 * 审批前项目查询
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/listPrj")
	public Map<String,Object> listPrj(HttpServletRequest request){
		SpecificationFactory<PCMEntity> specf = new SpecificationFactory<PCMEntity>();
		specf.addSearchParam("projectName", Operator.LIKE,
				request.getParameter("projectName"));
		specf.addSearchParam("projectCode", Operator.LIKE,
				request.getParameter("projectCode"));
		specf.addSearchParam("applier", Operator.LIKE,
				PrincipalUtil.getCurrentUserAccount());
		specf.addSearchParam("useTotalArea", Operator.GTE,
				request.getParameter("useTotalArea_low"));
		specf.addSearchParam("useTotalArea", Operator.LTE,
				request.getParameter("useTotalArea_high"));
		specf.addSearchParam("prjStatus", Operator.LT,"4");
		Page<PCMEntity> pcmEntities = pcmService.queryPrj(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(pcmEntities);
	}
	
	/**
	 * 待审核项目查询
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/listAuditPrj")
	public Map<String,Object> listAuditPrj(HttpServletRequest request){
		SpecificationFactory<PCMEntity> specf = new SpecificationFactory<PCMEntity>();
		specf.addSearchParam("projectName", Operator.LIKE,
				request.getParameter("projectName"));
		specf.addSearchParam("projectCode", Operator.LIKE,
				request.getParameter("projectCode"));
		specf.addSearchParam("applier", Operator.LIKE,
				PrincipalUtil.getCurrentUserAccount());
		specf.addSearchParam("useTotalArea", Operator.GTE,
				request.getParameter("useTotalArea_low"));
		specf.addSearchParam("useTotalArea", Operator.LTE,
				request.getParameter("useTotalArea_high"));
		specf.addSearchParam("prjStatus", Operator.GT,"1");
		specf.addSearchParam("prjStatus", Operator.LT,"4");
		Page<PCMEntity> pcmEntities = pcmService.queryPrj(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(pcmEntities);
	}
	
	/**
	 * 已审核项目查询
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/listPassPrj")
	public Map<String,Object> listPassPrj(HttpServletRequest request){
		SpecificationFactory<PCMEntity> specf = new SpecificationFactory<PCMEntity>();
		specf.addSearchParam("projectName", Operator.LIKE,
				request.getParameter("projectName"));
		specf.addSearchParam("projectCode", Operator.LIKE,
				request.getParameter("projectCode"));
		specf.addSearchParam("applier", Operator.LIKE,
				PrincipalUtil.getCurrentUserAccount());
		specf.addSearchParam("useTotalArea", Operator.GTE,
				request.getParameter("useTotalArea_low"));
		specf.addSearchParam("useTotalArea", Operator.LTE,
				request.getParameter("useTotalArea_high"));
		specf.addSearchParam("prjStatus", Operator.GT,"3");
		Page<PCMEntity> pcmEntities = pcmService.queryPrj(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(pcmEntities);
	}
	
	/**
	 * 更新项目
	 * @param pcmEntity
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/updatePCM")
	public Map<String,Object> updatePCM(PCMEntity pcmEntity){
		PCMEntity origPCM=pcmEntityDao.findOne(pcmEntity.getId());
		pcmEntity.setCreateTime(origPCM.getCreateTime());
		pcmEntity.setApplier(origPCM.getApplier());
		pcmEntity.setAuditOpinion(origPCM.getAuditOpinion());
		pcmEntity.setAuditer(origPCM.getAuditer());
		Date updateTime=new Date();
		pcmEntity.setOperator(PrincipalUtil.getCurrentUserAccount());
		pcmEntity.setUpdateTime(updateTime);
		pcmService.savePCMEntity(pcmEntity);
		return convertToResult("message","修改成功"	);
	}
	
	/**
	 * 删除项目
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/deleteDraft")
	public Map<String,Object> deleteDraft(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		pcmEntityDao.delete(id);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 提交审核
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/audit")
	public Map<String,Object> audit(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		PCMEntity pcmEntity=pcmEntityDao.findOne(id);
		pcmEntity.setPrjStatus("2");
		this.updatePCM(pcmEntity);
		return convertToResult("message","提交审核成功！");
	}
	
	/**
	 * 取消审核
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/cancelAudit")
	public Map<String,Object> cancelAudit(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		PCMEntity pcmEntity=pcmEntityDao.findOne(id);
		pcmEntity.setPrjStatus("0");
		this.updatePCM(pcmEntity);
		return convertToResult("message","提交审核成功！");
	}
	
	/**
	 * 受理审批
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/acceptAudit")
	public Map<String,Object> acceptAudit(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		
		PCMEntity pcmEntity=pcmEntityDao.findOne(id);
		pcmEntity.setPrjStatus("3");
		
		pcmService.savePCMEntity(pcmEntity);
		return convertToResult("message","请尽快审理，并确定审核结果。");
	}
	
	/**
	 * 审核通过
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/prjpass")
	public Map<String,Object> prjpass(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		String auditOpinion=request.getParameter("auditOpinion");
		
		PCMEntity pcmEntity=pcmEntityDao.findOne(id);
		pcmEntity.setAuditOpinion(auditOpinion);
		pcmEntity.setPrjStatus("4");
		pcmEntity.setAuditer(PrincipalUtil.getCurrentUserAccount());
		
		pcmService.savePCMEntity(pcmEntity);
		return convertToResult("message","该合同通过审核！");
	}
	
	/**
	 * 审核通过
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/prjdeny")
	public Map<String,Object> prjdeny(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		String auditOpinion=request.getParameter("auditOpinion");
		
		PCMEntity pcmEntity=pcmEntityDao.findOne(id);
		pcmEntity.setAuditOpinion(auditOpinion);
		pcmEntity.setPrjStatus("1");
		pcmEntity.setAuditer(PrincipalUtil.getCurrentUserAccount());
		
		pcmService.savePCMEntity(pcmEntity);
		return convertToResult("message","该合同不通过审核！");
	}
	
	/**
	 * 注销审核
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/unregister")
	public Map<String,Object> unregister(HttpServletRequest request) throws ParseException{
		Long id=Long.valueOf(request.getParameter("id"));
		
		PCMEntity pcmEntity=pcmEntityDao.findOne(id);
		pcmEntity.setPrjStatus("5");
		
		pcmService.savePCMEntity(pcmEntity);
		return convertToResult("message","该合同已注销");
	}
}
