/*package com.jksb.land.service.contract;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.jksb.land.entity.contract.Contract;
import com.jksb.land.repository.contract.ContractInfoDao;
import com.jksb.land.view.ContractInfoView;

@Component
@Transactional
public class ContractInfoService {

	@Autowired
	private ContractInfoDao contractInfoDao;

	@PersistenceContext(unitName = "landJpa")
	private EntityManager entityManager;

	*//**
	 * @author chensheng 条件查询承包合同信息
	 * 
	 * *//*
	// public Page<Contract> getContractInfoByPage(Specification<Contract> spec,
	// PageRequest pageRequest) {
	// return contractInfoDao.findAll(spec, pageRequest);
	// }

	*//**
	 * @author chensheng 执行合同信息查询操作
	 * @param HttpServletRequest
	 *            request
	 * 
	 * *//*
	public List<ContractInfoView> getContractInfoList(HttpServletRequest request) {
		Query query = this.entityManager.createNativeQuery(this
				.getContractInfoSQL(request));
		query.setFirstResult((Integer.valueOf(request.getParameter("page")) - 1)
				* Integer.valueOf(request.getParameter("rows")));
		query.setMaxResults(Integer.valueOf(request.getParameter("rows")));
		List<Object[]> result = query.getResultList();
		List<ContractInfoView> ContractInfoViewlist = new ArrayList<ContractInfoView>();
		for (Object[] obj : result) {
			ContractInfoView contractInfoview = new ContractInfoView();
			contractInfoview.setId(Long.parseLong(String.valueOf(obj[0])));
			contractInfoview.setContractCode(String.valueOf(obj[1]));
			contractInfoview.setContractArea(Double.valueOf(String
					.valueOf(obj[2])));
			contractInfoview.setContractTime(Long.parseLong(String
					.valueOf(obj[3])));
			contractInfoview.setContractor(String.valueOf(obj[5]));
			ContractInfoViewlist.add(contractInfoview);
		}
		return ContractInfoViewlist;
	}

	*//**
	 * @author chensheng 合同信息查询SQL语句
	 * @param HttpServletRequest
	 *            request
	 * *//*
	public String getContractInfoSQL(HttpServletRequest request) {
		String contractorName = request.getParameter("contractorName");
		String contractorIDNO = request.getParameter("contractorIDNO");
		String contractCode = request.getParameter("contractCode");
		String startDate = request.getParameter("startDate");
		String expiredDate = request.getParameter("expiredDate");
		String compare_userArea = request.getParameter("compare_userArea");
		String use_Area = request.getParameter("useArea");
		String compare_leaseTerm = request.getParameter("compare_leaseTerm");
		String leaseTerm = request.getParameter("leaseTerm");
		String contractorType = request.getParameter("contractorType");
		String compare_contractPrice = request
				.getParameter("compare_contractPrice");
		String signing_price = request.getParameter("contractPrice");
		String is_affordableArea = request.getParameter("affordableArea");
		String isCadres = request.getParameter("isCadres");
		String community = request.getParameter("community");
		String residentsGroup = request.getParameter("residentsGroup");
		StringBuffer sb = new StringBuffer();
		sb.append(" select con.id,con.contract_code,con.use_area,con.lease_term,con.contract_status,con.second_pt_representative ");
		sb.append(" from busi_ctt_contract con,stat_residents_group res,stat_community com ");
		if (!isCadres.equals("null")) {
			sb.append(",busi_ctt_contractorpersonal cont ");
		} else {
			if (contractorType.equals("PERSONAL")) {
				sb.append(",busi_ctt_contractorpersonal cont ");
			}
			if (contractorType.equals("ENTERPRISE")) {
				sb.append(",busi_ctt_contractorenterprise cont ");
			}
		}
		sb.append(" WHERE con.residents_grp_code = res.residents_grp_code AND res.community_code = com.community_code ");
		if (contractorType.equals("ENTERPRISE")
				|| contractorType.equals("PERSONAL")) {
			sb.append(" AND con.contract_code = cont.contract_code ");
		}
		if (StringUtils.hasText(contractorName)) {
			sb.append(" AND cont.contractor_name ='" + contractorName + "'");
		}
		if (StringUtils.hasText(contractorIDNO)) {
			sb.append(" AND cont.contractoridno ='" + contractorIDNO + "'");
		}
		if (StringUtils.hasText(contractCode)) {
			sb.append(" AND con.contract_code ='" + contractCode + "'");
		}
		if (StringUtils.hasText(contractCode)) {
			sb.append(" AND con.contract_code ='" + contractCode + "'");
		}
		if (StringUtils.hasText(startDate)) {
			sb.append(" AND con.start_date ='" + startDate + "'");
		}
		if (StringUtils.hasText(expiredDate)) {
			sb.append(" AND con.expired_date ='" + expiredDate + "'");
		}
		if (StringUtils.hasText(use_Area)) {
			switch (this.getConditionMap().get(compare_userArea)) {
			case 1:
				sb.append(" AND con.use_area >'" + use_Area + "'");
				break;
			case 2:
				sb.append(" AND con.use_area <'" + use_Area + "'");
				break;
			case 3:
				sb.append(" AND con.use_area ='" + use_Area + "'");
				break;
			default:
				sb.append(" AND 1=1 ");
			}
		}
		if (StringUtils.hasText(leaseTerm)) {
			switch (this.getConditionMap().get(compare_leaseTerm)) {
			case 1:
				sb.append(" AND con.lease_term >'" + leaseTerm + "'");
				break;
			case 2:
				sb.append(" AND con.lease_term <'" + leaseTerm + "'");
				break;
			case 3:
				sb.append(" AND con.lease_term ='" + leaseTerm + "'");
				break;
			default:
				sb.append(" AND 1=1 ");
			}
		}
		if (StringUtils.hasText(signing_price)) {
			switch (this.getConditionMap().get(compare_contractPrice)) {
			case 1:
				sb.append(" AND con.signing_price >'" + signing_price + "'");
				break;
			case 2:
				sb.append(" AND con.signing_price <'" + signing_price + "'");
				break;
			case 3:
				sb.append(" AND con.signing_price ='" + signing_price + "'");
				break;
			default:
				sb.append(" AND 1=1 ");
			}
		}
		if (is_affordableArea != "null") {
			switch (this.getConditionMap().get(is_affordableArea)) {
			case 4:
				sb.append(" AND con.affordable_area >'" + 0 + "'");
				break;
			case 5:
				sb.append(" AND con.affordable_area ='" + 0 + "'");
				break;
			default:
				sb.append(" AND 1=1 ");
			}
		}
		if (isCadres != "null") {
			if (contractorType.equals("PERSONAL")) {
				switch (this.getConditionMap().get(isCadres)) {
				case 4:
					sb.append(" AND cont.is_cadres ='" + isCadres + "'");
					break;
				case 5:
					sb.append(" AND cont.is_cadres ='" + isCadres + "' ");
					break;
				default:
					sb.append(" AND 1=1 ");
				}
			}
		}
		if (community != null) {
			sb.append(" AND res.community_code ='" + community + "'");
		}
		if (residentsGroup != null) {
			sb.append(" AND res.residents_grp_code ='" + residentsGroup + "'");
		}
		return sb.toString();
	}

	*//**
	 * 
	 * @author chensheng
	 * @return Map<String,Integer>
	 * 
	 * *//*
	private Map<String, Integer> getConditionMap() {
		Map<String, Integer> conditionMap = new HashMap<String, Integer>();
		conditionMap.put("GT", 1);
		conditionMap.put("LT", 2);
		conditionMap.put("EQ", 3);
		conditionMap.put("Y", 4);
		conditionMap.put("N", 5);
		conditionMap.put("null", 6);
		return conditionMap;
	}

	*//**
	 * 返回合同信息
	 * 
	 * @author 陈升
	 * 
	 * *//*
	public Contract findContractInfoByContractCode(String code) {
		return this.contractInfoDao.findByContractCode(code);
	}

	public List<ContractInfoView> findContractInfo(String type,
			HttpServletRequest request, PageRequest pageRequest) {
		
		 * if (type.equals("null")) { SpecificationFactory<Contract> specf = new
		 * SpecificationFactory<Contract>(); Page<Contract> contracts =
		 * this.getPage(specf.getSpecification(), pageRequest);
		 * List<ContractInfoView> ContractInfoViewlist = new
		 * ArrayList<ContractInfoView>(); for (Contract contract : contracts) {
		 * ContractInfoView contractInfoView = new ContractInfoView(); String
		 * contractorName = contract.getSecondPtRepresentative();
		 * contractInfoView.setContractor(contractorName);
		 * contractInfoView.setContractCode(contract.getContractCode());
		 * contractInfoView.setFlag(contract.getContractStatus());
		 * contractInfoView.setContractTime(contract.getLeaseTerm());
		 * ContractInfoViewlist.add(contractInfoView); } return
		 * ContractInfoViewlist; } else {
		 
		return this.getContractInfoList(request);
		// }
	}

	public Page<Contract> getPage(Specification<Contract> spec,
			PageRequest pageRequest) {
		return this.contractInfoDao.findAll(spec, pageRequest);
	}
}
*/