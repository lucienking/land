/**
 * 
 */
package com.jksb.land.web.contract;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jksb.land.common.persistence.SpecificationFactory;
import com.jksb.land.entity.contract.ContractParcelInfo;
import com.jksb.land.entity.contract.PlantingRelationship;
import com.jksb.land.entity.staticData.PlantingCropsEntity;
import com.jksb.land.repository.staticData.PlantingCropsDao;
import com.jksb.land.service.common.ProcedureExecuteService;
import com.jksb.land.service.contract.ContractParcelInfoService;
import com.jksb.land.service.contract.PlantingRelationshipService;
import com.jksb.land.service.staticData.PlantingCropsService;
import com.jksb.land.web.BaseController;

/**
 * 地块-种植作物关系控制器
 * @author Willian Chan
 *
 */

@Controller
@RequestMapping(value = "/plantingCrops/")
public class PlantingRshController extends BaseController {

	@Autowired
	private PlantingRelationshipService plantingRelationshipService;
	
	@Autowired
	private PlantingCropsService plantingCropsService;
	
	@Autowired
	private PlantingCropsDao plantingCropsDao;
	
	@Autowired
	private ProcedureExecuteService procedureExecuteService;
	
	@Autowired
	private ContractParcelInfoService contractParcelInfoService;

	/**
	 * 获取所有地块
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getParcelList")
	public Map<String,Object> getParcelList(){
		SpecificationFactory<PlantingRelationship> specf = new SpecificationFactory<PlantingRelationship>();
		List<PlantingRelationship> list=plantingRelationshipService.getParcelList(specf.getSpecification());
		Map<String,Object> map= convertToResult(list);
		
		return map;
	}
	
	/**
	 * 获取所有种植作物
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method=RequestMethod.GET,value="/getAllPlantingCrops")
	public List<PlantingCropsEntity> getPlantingCrops(HttpServletRequest request){
		SpecificationFactory<PlantingCropsEntity> specf = new SpecificationFactory<PlantingCropsEntity>();
		List<PlantingCropsEntity> list= plantingCropsDao.findAll(specf.getSpecification());
//		Map<PlantingCropsEntity,String> map=new HashMap<PlantingCropsEntity,String>();
//		for(int i=0;i<list.size();i++){
//			map.put("id", list.get(i));
//		}
//		Map<PlantingCropsEntity,String> map=plantingCropsDao.getPlantsItems();

		return list;
	}
	
	/**
	 * 通过SQL语句获取所有种植作物
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method=RequestMethod.GET,value="/getParcelListBySQL")
	public Map<String,Object> getParcelListBySQL(HttpServletRequest request){		
		String sql="SELECT pr.id, pr.planted_acount,pr.planted_area,pr.planted_year"
				+ ",cp.contract_parcel_code,pc.pc_name FROM "+
	"busi_ctt_plantingrelationship pr,	busi_ctt_contractparcelinfo cp,	stat_plantingcrops pc WHERE pr.contract_parcel_code = cp.id "
	+ "AND pr.planting_crops_id = pc.id";
		String append="";
		String contract_code=request.getParameter("contract_code");
		String contractParcelCode=request.getParameter("contractParcelCode");
		
		if(contractParcelCode!=""&&contractParcelCode!=null){
			//通过地块编号获取地块实体
			ContractParcelInfo cpi=contractParcelInfoService.getContractParcelInfoByContractParcelCode(contractParcelCode);
			if(cpi==null){
				return convertToResult("message","查不到此地块编号。");
			}else{
				append=" AND pr.contract_parcel_code = '"+cpi.getId()+"'";
				sql+=append;
			}
		}
		
		
		if(contract_code!=""){
			append=" AND cp.contract_code like '"+contract_code+"%'";
			sql+=append;
		}
		Map<String,Object> map = procedureExecuteService.getLandQueryResult(sql,null,getPage(request));

		return map;
	}

	/**
	 * 更新种植作物
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method=RequestMethod.POST,value="/saveChangedParcels")
	public Map<String,Object> saveChangedParcels(HttpServletRequest request	) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		long id=Long.valueOf(request.getParameter("id"));
		Date plantedYear=sdf.parse(request.getParameter("planted_year"));
		String pcName=request.getParameter("pc_name");
		int plantedAccount=Integer.valueOf(request.getParameter("planted_acount"));
		float plantedArea=Float.parseFloat(request.getParameter("planted_area"));
		PlantingCropsEntity plantingCrops=plantingCropsService.findByPcName(pcName);
				
		PlantingRelationship updatePC=plantingRelationshipService.findByid(id);
		updatePC.setPlantedAcount(plantedAccount);
		updatePC.setPlantedArea(plantedArea);
		updatePC.setPlantingCrops(plantingCrops);
		updatePC.setPlantedYear(plantedYear);
		
		plantingRelationshipService.savePlantingRelationship(updatePC);
		
		return convertToResult("message","修改成功");
	}
	
	/**
	 * 新增地块种植作物关系
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method=RequestMethod.POST,value="/savePlantRelationship")
	public Map<String,Object> savePlantRelationship(HttpServletRequest request	) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String contractParcelCode=request.getParameter("contractParcelCode");
		ContractParcelInfo contractParcelInfo=contractParcelInfoService.getContractParcelInfoByContractParcelCode(contractParcelCode);
		
		String pc=request.getParameter("pcName");
		PlantingCropsEntity pce=plantingCropsService.findByPcName(pc);
		double area=Double.valueOf(request.getParameter("plantedArea"));
		String account=request.getParameter("plantedAcount");
		String date=request.getParameter("plantedYear");
		
		
		PlantingRelationship pr=new PlantingRelationship();
		if(account!=null){
			pr.setPlantedAcount(Integer.valueOf(account));
		}
		if(date!=null){
			Date plantedYear=sdf.parse(date);
			pr.setPlantedYear(plantedYear);
		}
		pr.setContractParcelInfo(contractParcelInfo);
		pr.setPlantedArea(area);
		pr.setPlantingCrops(pce);
		plantingRelationshipService.savePlantingRelationship(pr);
		
		return convertToResult("message","添加成功");
	}
	
	/**
	 * 删除地块种植作物关系
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(method=RequestMethod.POST,value="/deletePlantRelationship")
	public Map<String,Object> deletePlantRelationship(HttpServletRequest request) throws ParseException{
		String ids=request.getParameter("id");
		if(ids!=null&&ids!=""){
			Long id=Long.valueOf(ids);
			plantingRelationshipService.deleteById(id);
			return convertToResult("message","删除成功");
		}else{
			return convertToResult("message","未选择选项，或该项已不存在");
		}
		
	}
}
